# Rama base — integración del flujo completo

Trabaja en la rama base después de revisar los cambios de `work/oracle`, `work/parquet` y `work/web`. Lee los dos PRD, `README.md`, `docs/WORKTREES.md`, los contratos y los informes de entrega de cada rama.

## Objetivo

Conectar la API web, la orquestación de exportación, la fuente Oracle y el escritor Parquet en un flujo de lotes con memoria acotada, progreso y cancelación.

## Alcance

- `src/main.zig`
- `src/export/**`
- `src/config/**`, `src/logging/**`, `src/utils/**` cuando sean necesarios para la integración
- `build.zig`, `build.zig.zon` y `README.md` para ensamblaje y dependencias acordadas
- `docs/architecture/**` para decisiones finales

Respeta los límites de propiedad de los adaptadores. Si hay incompatibilidad, adapta primero la orquestación o propone un cambio acotado para revisión; no reescribas módulos enteros sin justificarlo.

## Requisitos

- Un solo flujo: abrir conexión, describir columnas, leer un lote, escribirlo, liberar/reutilizar buffers y continuar.
- Memoria limitada por lote y buffers; tamaño de lote configurable.
- Progreso coherente, cancelación, errores visibles y cierre seguro de recursos/archivos.
- Consultas Oracle de solo lectura. No conectes a la base productiva ni uses credenciales reales.
- Mantén el backend local en loopback y no registres credenciales.
- No cambies los PRD ni hagas commit/push.

## Entrega

Resume el flujo conectado, los archivos modificados, decisiones de ensamblaje, dependencias y limitaciones pendientes. Si una integración no compila por una dependencia externa ausente, identifica el requisito exacto y no simules éxito.
