# Plan de trabajo paralelo con worktrees

## Regla de integración

Primero se acuerdan y consolidan los tipos y contratos compartidos en `src/models`. Los worktrees de Oracle y Parquet parten de esa base. La interfaz puede avanzar con respuestas simuladas hasta que el contrato HTTP quede definido.

## Responsabilidades

| Rama / worktree | Alcance exclusivo | Depende de |
|---|---|---|
| `work/oracle` | `src/oracle/**`: conexión OCI/ODPI-C, catálogo y fetch por lotes de solo lectura | Contratos de `src/models` |
| `work/parquet` | `src/parquet/**`: mapeo de tipos y escritura Parquet por partes | Contratos de `src/models` |
| `work/web` | `src/web/**`, `web/**`: API local y UI; primero con datos simulados | Contrato HTTP compartido |
| Rama base | `src/export/**`, `src/main.zig`, contratos, integración y configuración final | Oracle, Parquet y web |

Los prompts listos para entregar a cada agente están en `docs/prompts/`. El prompt `00` se ejecuta primero en la rama base; los tres prompts de adaptadores se usan en los worktrees; `40` se usa al consolidar.

Evitar que dos worktrees editen los mismos archivos. Cambios a `src/models` o al contrato HTTP se acuerdan y consolidan en la rama base antes de depender de ellos.

## Orden propuesto

1. Definir `Column`, `Value`, `Batch`, errores y estados de exportación en `src/models`.
2. Definir contrato HTTP para listar esquemas/tablas, iniciar una exportación, consultar progreso y cancelar.
3. Crear worktrees `work/oracle`, `work/parquet` y `work/web` desde el mismo commit de base.
4. Integrar primero adaptadores; después conectarlos en `src/export` y probar el flujo completo.

## Creación de worktrees

Git necesita al menos un commit de base. Una vez autorizado y creado ese commit, desde la rama base:

```bash
git worktree add -b work/oracle ../zig_proyecto-wt-oracle main
git worktree add -b work/parquet ../zig_proyecto-wt-parquet main
git worktree add -b work/web ../zig_proyecto-wt-web main
```

Cada ruta podrá abrirse como un workspace separado en herdr. La integración se hace en la rama base con merges revisables, sin compartir directorios de trabajo.

