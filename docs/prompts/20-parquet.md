# Rama `work/parquet` — destino Parquet

Trabaja en el worktree de la rama `work/parquet`. Lee `prd.md`, `prd copy.md`, `README.md`, `docs/WORKTREES.md` y los contratos aprobados en `src/models/**` y `docs/architecture/**`.

## Objetivo

Implementar un destino de escritura por streaming que convierta los lotes compartidos a archivos Parquet `part-xxxxx.parquet` sin acumular la tabla completa en memoria.

## Alcance exclusivo

- `src/parquet/**`
- documentación técnica específica de Parquet bajo `docs/architecture/parquet/**`

No edites contratos compartidos, `src/export/**`, `src/oracle/**`, `src/web/**`, `web/**`, `build.zig` ni `build.zig.zon`. Si necesitas un cambio compartido, descríbelo y espera a que se integre en la rama base.

## Requisitos

- Usa los contratos aprobados; no dupliques modelos ni alteres la vida útil de los buffers compartidos.
- Evalúa una biblioteca o interoperabilidad adecuada para Zig y documenta compatibilidad de versión, licencia y dependencias nativas antes de incorporarla.
- Escribe por lotes y cierra archivos según un límite configurable razonable; contempla Row Groups y compresión.
- Define conversión y política explícita para NULL, NUMBER, VARCHAR2, CHAR, DATE, TIMESTAMP, CLOB, BLOB y tipos no soportados.
- Trata errores de escritura y evita dejar archivos parciales presentados como completos.
- No edites rutas fuera del alcance ni guardes datos reales o credenciales.

## Entrega

Informa la biblioteca elegida y sus requisitos, el esquema de conversión, límites de memoria/archivos, archivos cambiados y el punto de integración con `src/export`. No hagas commit ni push.
