# Oracle a Parquet en Zig

Aplicación local para explorar tablas Oracle, extraer filas por lotes y escribir archivos Apache Parquet sin cargar la tabla completa en memoria.

## Estado

Los contratos, el adaptador Oracle, el runner y un escritor Arrow/Parquet están
conectados en un sondeo local acotado. Se verificó la exportación de 1.000 filas
Oracle a un Parquet legible. La pantalla de prueba web local carga esquemas y
tablas visibles en Oracle (incluido SIS cuando hay acceso), probar una muestra
de hasta 1.000 filas y descargar el Parquet temporal, o exportar una tabla
completa a `output/exports`; el dashboard principal continúa en modo
demostración y la API general con exportación multiparte sigue pendiente.
Consulta [`docs/architecture/integration.md`](docs/architecture/integration.md)
para el estado y los límites actuales.

La aplicación web local está enfocada temporalmente en comparar descripciones
de `SIS.ITEMS` por tipo y revisar candidatos en grupos. La persona asignada puede
confirmar subgrupos de artículos iguales o marcar artículos como «No empatar».
Las decisiones y asignaciones quedan auditadas en
`output/items-review/review.sqlite3`; Oracle no se modifica. La aplicación
solicita iniciar sesión con una cuenta Oracle, valida sus datos contra Oracle y
mantiene la contraseña solo en memoria durante la sesión. Las pantallas y rutas
de exportación web están deshabilitadas mientras este sea el alcance de uso.

## Flujo previsto

Interfaz web local → API local en Zig → orquestador de exportación → fuente Oracle (OCI/ODPI-C) → lotes de filas → escritor Parquet.

La conexión Oracle será de solo lectura. Las credenciales y la configuración local no se guardarán en Git. Copia `.env.example` a `.env` y define el host, SID y credenciales de tu entorno antes de ejecutar la prueba local.

## Módulos

- `src/models`: tipos compartidos para esquemas, lotes, errores y progreso.
- `src/oracle`: conexión, catálogo y lectura Oracle por lotes.
- `src/parquet`: conversión de tipos y escritura de archivos Parquet.
- `src/export`: coordinación, límites de memoria, progreso y cancelación.
- `src/web` y `web`: API local y archivos de la interfaz.
- `src/config`, `src/logging`, `src/utils`: configuración, registro y utilidades.

## Requisitos y decisiones pendientes

Consultar `prd.md`, `prd copy.md` y `docs/WORKTREES.md`. Antes de fijar dependencias, validar compatibilidad entre la versión Zig seleccionada, ODPI-C/OCI y el escritor Parquet elegido.

