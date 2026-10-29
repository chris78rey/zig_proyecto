# Destino Parquet: decisión de backend y contrato de conversión

## Estado

`src/parquet/destination.zig` implementa `Destination` sobre un puente C ABI a
Arrow C++. El build usa las bibliotecas compartidas incluidas con PyArrow,
descubiertas por `scripts/oracle-read-probe.sh`. Se comprobó una exportación real
acotada de 1.000 filas Oracle y la lectura del archivo con PyArrow (60 columnas).
La prueba escribe un único `part-00001.parquet` temporal y lo elimina al acabar.
La aplicación web aún no está conectada al runner; `src/main.zig` sigue siendo
un sondeo Oracle → Parquet con límite fijo de 1.000 filas.

## Evaluación de bibliotecas

Se evaluó `akeating/zig-parquet` v0.2.0. Declara licencia dual Apache-2.0/MIT,
sin dependencia nativa por defecto y soporte de lectura/escritura, codecs,
row groups y compresión. Su README declara Zig 0.16, pero el build local del
paquete falla tanto con Zig 0.16.0 como con Zig 0.17.0. Con 0.16.0 falla por
referencias incompatibles con `std.fs`, `std.meta.intToEnum` y `std.io.Writer`;
con 0.17.0 falla por cambios sintácticos (`**`) y el builtin `@cImport`. No se
incorporó ni vendorizó. Los módulos Oracle, mapeo Parquet y runner del proyecto
sí compilan aisladamente con ambas versiones.

Apache Arrow C++ ofrece escritura por `RecordBatch`, row groups y compresión.
En este equipo se integra mediante los headers y bibliotecas versionadas de
PyArrow; el puente se compila con `g++` y C++20 para conservar la ABI
`libstdc++` de esas bibliotecas. El script descubre sus rutas desde Python.

Fuentes primarias: [zig-parquet v0.2.0](https://github.com/akeating/zig-parquet/tree/v0.2.0)
y [escritura Parquet de Arrow C++](https://arrow.apache.org/docs/cpp/parquet.html).

## Conversión prevista

`src/parquet/mapping.zig` define el esquema lógico sin depender del backend:

| Tipo compartido | Parquet previsto | Política |
|---|---|---|
| boolean | BOOLEAN | Conserva NULL según `Column.nullable`. |
| int64 | INT64 | Conserva NULL. |
| float64 | DOUBLE | Conserva NULL. |
| decimal / Oracle NUMBER | BYTE_ARRAY STRING | Se conserva el decimal textual tal como llega del adaptador, sin pasar por punto flotante. No se publica aún como DECIMAL lógico porque Oracle NUMBER puede no tener precisión/escala Parquet representables. |
| utf8 / VARCHAR2 / CHAR / CLOB | BYTE_ARRAY STRING | CLOB solo cuando la fuente lo exponga como `utf8`; la fuente Oracle actual no lo mapea aún. |
| binary / BLOB | BYTE_ARRAY | BLOB solo cuando la fuente lo exponga como `binary`; la fuente Oracle actual no lo mapea aún. |
| date | INT32 DATE | Días desde epoch, calculados por el backend. |
| timestamp | INT64 TIMESTAMP(NANOS, UTC) | Codificar instante UTC; sin zona, se interpreta con la política de sesión de la fuente, que debe quedar definida antes de integración. |
| timestamp_with_timezone | INT64 TIMESTAMP(NANOS, UTC) | Aplicar el desplazamiento del valor y almacenar el instante UTC; Parquet no conserva el identificador/zona original. |
| otro tipo | — | Rechazar antes de publicar cualquier archivo. |

SQL NULL se representa con la definición de nulabilidad de la columna y el
bitmap de validez del backend. Un NULL en columna requerida debe causar error.
Las filas, slices y buffers del lote son prestados: el escritor debe consumir
cada lote síncronamente antes de retornar de `writeBatch`.

## Límites y publicación segura requeridos

- Mantener en memoria el lote actual, el buffer interno acotado del escritor y
  como máximo el Row Group configurado; nunca retener la tabla completa.
- La versión de sondeo escribe un solo archivo; rotación secuencial a
  `part-00001.parquet`, `part-00002.parquet`, etc. por límite configurable de
  filas o bytes sigue pendiente.
- Cerrar el writer para completar footer y renombrar cada archivo temporal a su
  nombre final solo después del cierre exitoso.
- En error o cancelación, cerrar y retirar el temporal actual y no incluirlo en
  la lista de partes completas. `finish` solo se usa tras EOF normal; `abort`
  invalida toda salida temporal aún no finalizada.
- El tamaño de Row Group se configura en el destino (8192 por defecto); usa
  compresión Snappy. Los límites de rotación deben completarse para exportar
  tablas grandes.

## Punto de integración

El adaptador implementa `models.interfaces.Destination` (`begin`,
`write_batch`, `finish`, `abort`) y consume cada lote de forma síncrona. El
runner y build raíz están conectados. Faltan la rotación multiparte, límites de
bytes, integración HTTP/UI y una política completa para tipos Oracle LOB.
