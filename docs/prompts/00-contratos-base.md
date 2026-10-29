# Rama base — contratos compartidos

Trabaja en el repositorio `zig_proyecto`, en la rama base. Lee `prd.md`, `prd copy.md`, `README.md` y `docs/WORKTREES.md`.

## Objetivo

Definir e implementar la capa mínima compartida que permita desarrollar en paralelo los adaptadores Oracle, Parquet y la interfaz.

## Alcance exclusivo

- `src/models/**`
- `docs/architecture/**`
- `docs/WORKTREES.md`, solo para registrar decisiones aprobadas

No implementes todavía OCI/ODPI-C, escritura Parquet, API HTTP ni interfaz.

## Trabajo

1. Define tipos compartidos para columnas Oracle, valores tipados/NULL, lotes, errores y estados/progreso de exportación.
2. Documenta propiedad y vida útil de buffers para evitar copias y uso accidental de memoria sin límite.
3. Define interfaces de fuente de datos y destino Parquet que permitan un flujo por lotes y cancelación.
4. Define el contrato HTTP mínimo para listar esquemas/tablas, iniciar una exportación, consultar su progreso y cancelarla. Mantén el backend local ligado a loopback por defecto.
5. Investiga y registra las decisiones pendientes de compatibilidad Zig ↔ ODPI-C/OCI y Zig ↔ Parquet; no agregues dependencias hasta justificar su compatibilidad, licencia y forma de integración.

## Límites

- El origen Oracle es de solo lectura. No te conectes a la base real ni ejecutes SQL en ella.
- No guardes credenciales, tokens ni contraseñas en el repositorio, logs o ejemplos; usa nombres de variables y valores ficticios.
- No cambies los PRD ni los archivos fuera del alcance.
- No hagas commit ni push.

## Entrega

Deja interfaces pequeñas, documentación de los contratos y ejemplos mínimos de uso. Al finalizar, informa archivos cambiados, decisiones tomadas, asuntos abiertos y cómo deben usarse los contratos desde cada rama. No declares implementados los adaptadores.
