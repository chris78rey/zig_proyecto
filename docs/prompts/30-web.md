# Rama `work/web` — API local e interfaz

Trabaja en el worktree de la rama `work/web`. Lee `prd.md`, `prd copy.md`, `README.md`, `docs/WORKTREES.md` y el contrato HTTP aprobado en `docs/architecture/**`.

## Objetivo

Implementar la interfaz local para seleccionar esquema, tabla, directorio destino y tamaño del lote, iniciar la exportación y observar progreso/errores.

## Alcance exclusivo

- `src/web/**`
- `web/**`
- documentación HTTP/UI específica bajo `docs/architecture/web/**`

No edites contratos compartidos, `src/export/**`, `src/oracle/**`, `src/parquet/**`, `build.zig` ni `build.zig.zon`. Si necesitas cambiar el contrato HTTP, descríbelo y espera a que se integre en la rama base.

## Requisitos

- Sigue exactamente el contrato HTTP aprobado. Si el backend todavía no existe, trabaja contra respuestas simuladas que respeten ese contrato.
- Mantén HTML/CSS/JavaScript sencillos salvo que exista una razón documentada para añadir un framework.
- Muestra esquema, tabla, progreso, velocidad, cantidad de archivos, tiempo, lote, estado y errores según lo que entregue el backend.
- El backend debe escuchar solo en loopback por defecto; la UI no debe conectarse directamente a Oracle.
- No guardes ni expongas contraseñas; evita incluirlas en mensajes de error o logs.
- No edites archivos fuera del alcance.

## Entrega

Informa rutas, estados de carga/error/cancelación cubiertos, archivos cambiados y cómo sustituir los datos simulados por el backend real. No hagas commit ni push.
