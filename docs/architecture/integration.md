# Estado de integración

## Flujo que ya puede ensamblarse

`src/export/runner.zig` implementa el ciclo síncrono de los contratos
compartidos: abre metadatos, llama `Destination.begin`, lee un `Batch`, lo
entrega sin retenerlo a `writeBatch` y repite hasta EOF. Mantiene el conteo de
filas y lote actual, calcula velocidad/tiempo con un reloj inyectable, publica
estados al observador y cierra siempre la fuente. Cualquier error o cancelación
invoca `Destination.abort`; solo EOF normal llega a `finish`.

Los errores se traducen a códigos del modelo sin añadir SQL, conexión ni
credenciales. La función no crea memoria proporcional al tamaño de la tabla.

## Integración actual y límites

`build.zig` compila la aplicación, ODPI-C y el puente Arrow C++. El adaptador
`src/parquet/destination.zig` publica un archivo temporal solo tras cerrar
correctamente el footer. `scripts/oracle-read-probe.sh` carga `.env`, detecta
PyArrow y limita la lectura Oracle a 1.000 filas. El sondeo CLI elimina el
temporal al terminar; la pantalla web lo conserva hasta una descarga de una
sola vez o durante 15 minutos.

Se verificó contra Oracle `TABLEAU.ANALISISLABORATORIO`: 1.000 filas, 60
columnas y archivo Parquet legible. No se imprimieron valores. Esta prueba no
demuestra todavía una exportación completa, rotación en varios archivos, manejo
de todos los tipos/LOB, ni una conexión desde el dashboard. El dashboard conserva
modo demostración. Para probar en navegador se añadió `scripts/serve-web-probe.py`
y la pantalla `/probe`: escucha solo en `127.0.0.1:8765`, consulta los esquemas
y las tablas visibles de Oracle. Permite probar una muestra de hasta 1.000 filas
o exportar todas las filas de la tabla seleccionada a un único Parquet
persistente en `output/exports`. Antes de iniciar estima tamaño desde las
estadísticas Oracle y comprueba el espacio libre; el progreso se consulta por
polling. Se verificó una exportación completa de `SIS.PACIENTES`: 351.992 filas,
80 columnas, 33.412.316 bytes, abierta de nuevo con PyArrow. No es aún el API
general de trabajos descrito en `http-api.md`.

El writer actual usa un solo archivo y grupos de filas configurables, con
Snappy. La rotación por filas/bytes, telemetría de archivos en el runner,
cancelación y selección completa de tipos Oracle siguen pendientes. El
preflight rechaza exportaciones cuyo tamaño estimado no deja margen suficiente.
