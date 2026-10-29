# Prompts para trabajo paralelo

Entrega un prompt por pane/worktree. Conserva el alcance de archivos que indica cada uno.

1. `00-contratos-base.md`: ejecutar primero y consolidar los contratos compartidos en la rama base.
2. `10-oracle.md`, `20-parquet.md` y `30-web.md`: ejecutar en paralelo desde worktrees creados a partir de la base que ya contiene esos contratos.
3. `40-integracion.md`: ejecutar en la rama base después de revisar e integrar los adaptadores.

No arranques los prompts de adaptadores antes de aceptar los contratos. Así evitas que cada rama invente tipos o APIs incompatibles.
