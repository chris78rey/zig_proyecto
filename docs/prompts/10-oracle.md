# Rama `work/oracle` — fuente Oracle

Trabaja en el worktree de la rama `work/oracle`. Lee `prd.md`, `prd copy.md`, `README.md`, `docs/WORKTREES.md` y los contratos aprobados en `src/models/**` y `docs/architecture/**`.

## Objetivo

Implementar el adaptador Oracle que descubre los esquemas/tablas visibles para el usuario y entrega filas por lotes a la capa de exportación usando OCI/ODPI-C.

## Alcance exclusivo

- `src/oracle/**`
- documentación técnica específica de Oracle bajo `docs/architecture/oracle/**`

No edites contratos compartidos, `src/export/**`, `src/parquet/**`, `src/web/**`, `web/**`, `build.zig` ni `build.zig.zon`. Si necesitas un cambio compartido, descríbelo y espera a que se integre en la rama base.

## Requisitos

- Usa los contratos ya aprobados; no crees tipos paralelos para lotes, columnas, errores o progreso.
- Implementa conexión configurable y lectura mediante cursor/fetch por lotes, con tamaño ajustable y memoria acotada.
- Incluye descubrimiento dinámico de esquemas y tablas y descripción de columnas.
- Emite consultas de solo lectura y limita la carga sobre Oracle.
- No codifiques credenciales. Nunca registres contraseñas.
- No te conectes al Oracle real ni ejecutes consultas en la base productiva; usa interfaces sustituibles y documentación para validar el adaptador.

## Entrega

Deja clara la dependencia nativa necesaria, la configuración requerida, los tipos Oracle soportados y cómo se notifican los tipos no soportados. Informa archivos cambiados, decisiones, limitaciones y el punto de integración con `src/export`. No hagas commit ni push.
