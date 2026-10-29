# Oracle a Parquet en Zig

Aplicación local para explorar tablas Oracle, extraer filas por lotes y escribir archivos Apache Parquet sin cargar la tabla completa en memoria.

## Estado

El proyecto está en fase de estructura. La arquitectura y las dependencias de OCI/ODPI-C y Parquet deben quedar acordadas antes de implementar los adaptadores.

## Flujo previsto

Interfaz web local → API local en Zig → orquestador de exportación → fuente Oracle (OCI/ODPI-C) → lotes de filas → escritor Parquet.

La conexión Oracle será de solo lectura. Las credenciales y la configuración local no se guardarán en Git.

## Módulos

- `src/models`: tipos compartidos para esquemas, lotes, errores y progreso.
- `src/oracle`: conexión, catálogo y lectura Oracle por lotes.
- `src/parquet`: conversión de tipos y escritura de archivos Parquet.
- `src/export`: coordinación, límites de memoria, progreso y cancelación.
- `src/web` y `web`: API local y archivos de la interfaz.
- `src/config`, `src/logging`, `src/utils`: configuración, registro y utilidades.

## Requisitos y decisiones pendientes

Consultar `prd.md`, `prd copy.md` y `docs/WORKTREES.md`. Antes de fijar dependencias, validar compatibilidad entre la versión Zig seleccionada, ODPI-C/OCI y el escritor Parquet elegido.

