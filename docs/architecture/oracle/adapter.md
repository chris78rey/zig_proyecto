# Adaptador Oracle

## Dependencia

El adaptador usa ODPI-C 26.0.0, fijado al commit `11ff9c50c2debb0684f7612ef537b54b042699d8`, con los directorios `include/` y `src/` bajo `src/oracle/vendor/odpi-c/`. Se conserva `LICENSE.txt` y `NOTICE.txt` del proyecto. ODPI-C es la capa C mantenida por Oracle sobre OCI; carga dinámicamente las bibliotecas del cliente Oracle.

Zig 0.17 ya no incluye `@cImport`; el binding se genera desde el header público con:

```bash
zig translate-c -I src/oracle/vendor/odpi-c/include src/oracle/odpi_wrapper.h > src/oracle/odpi_bindings.zig
```

La traducción debe usar el mismo target y los mismos flags que la compilación final. Al integrar el build raíz, se puede mover este paso a la configuración de módulos si conviene regenerarlo por target.

En este equipo se detectó Oracle Instant Client 19.10 (`libclntsh.so`). La guía de ODPI-C documenta interoperabilidad entre cliente Oracle 19 y base Oracle 11.2. Debe confirmarse en el entorno de destino antes de declarar la conexión productiva validada. La compilación final debe incluir los C de ODPI-C y `src/oracle/vendor/odpi-c/include` en la configuración raíz; esta tarea no modifica `build.zig`.

## Configuración y conexión

`src/oracle/config.zig` crea un descriptor completo y configurable para `SID` o `SERVICE_NAME`. El valor predeterminado reproduce el nodo RAC 2 del PRD: host, puerto 1521, SID `prdsgh2` y servidor dedicado. El usuario/contraseña son parámetros obligatorios entregados por la capa superior; no se almacenan ni imprimen aquí. `oracle_client_lib_dir` permite indicar dónde carga ODPI-C el cliente nativo.

El fetch array predeterminado es 10.000 filas, configurable entre 1 y 50.000. ODPI-C llena su buffer interno con ese tamaño; `Source.next` expone como máximo un lote y copia sus datos a buffers prestados por el contrato compartido antes del siguiente fetch.

## Catálogo y SQL

- `listSchemas`: propietarios presentes en `ALL_TABLES`.
- `listTables`: tablas accesibles del propietario solicitado, leídas de `ALL_TABLES`.
- `open`: consulta `SELECT * ... WHERE 1 = 0` sobre identificadores entrecomillados para obtener metadatos sin leer filas. La exportación puede añadir un filtro opcional de igualdad textual; columna y valor se escapan antes de construir la consulta.
- `next`: cursor de consulta de solo lectura. La configuración no acepta SQL del usuario.

Los identificadores se citan duplicando comillas y se limitan a 30 bytes para servidores 11gR2. El filtro de propietario se escapa como literal SQL; no se concatena entrada sin escapar.

El sondeo CLI acepta `ORACLE_FILTER_COLUMN` junto con `ORACLE_FILTER_VALUE` para filtrar una columna por igualdad. Deben configurarse ambos valores. Por ejemplo, `ORACLE_FILTER_COLUMN=TIPO` y `ORACLE_FILTER_VALUE=I` seleccionan artículos de tipo I; `ORACLE_MAX_ROWS=all` quita el límite de muestra. El filtro no acepta fragmentos SQL.

## Conversión inicial

| Oracle | Modelo compartido | Política |
|---|---|---|
| `NUMBER` | `decimal` | Bytes/texto decimal para conservar precisión |
| `VARCHAR2`, `NVARCHAR2`, `CHAR`, `NCHAR`, `LONG` | `utf8` | Se valida UTF-8 al copiar |
| `RAW`, `LONG RAW` | `binary` | Copia de bytes al lote |
| `DATE`, `TIMESTAMP` | `timestamp` | `DATE` conserva hora, minuto y segundo |
| `TIMESTAMP WITH TIME ZONE`, `TIMESTAMP WITH LOCAL TIME ZONE` | `timestamp_with_timezone` | Conserva componentes y offset entregados por ODPI-C |
| `BOOLEAN` | `boolean` | Solo cuando el servidor/consulta lo exponga |

Los tipos no mapeados fallan en `open` con `SourceFailure`; `lastDiagnostic()` devuelve el número Oracle no soportado. CLOB/NCLOB/BLOB/BFILE, intervalos, ROWID, JSON, XMLTYPE, objetos y vectores quedan pendientes. Los LOB requieren una estrategia de lectura incremental propia para no romper el límite de memoria del lote.

## Integración y límites actuales

El adaptador implementa `models.interfaces.Source` y no depende de `src/export`, Parquet ni API HTTP. `close` libera cursor, conexión y contexto ODPI-C; `destroy` libera la memoria Zig del objeto. No se conectó a Oracle real. Tampoco se modificó `build.zig`; la integración de compilación pertenece a la rama base. La cancelación se consulta entre filas; una llamada nativa bloqueada no se interrumpe desde esta interfaz síncrona.

