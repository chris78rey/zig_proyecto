# Interfaz web local

## Estado actual

`web/` implementa la pantalla de selección y seguimiento del contrato
[`http-api.md`](../http-api.md). El dashboard principal usa respuestas
simuladas (`API_MODE = "mock"`). Además, `web/probe.html` permite una prueba
real Oracle → Parquet a través de `scripts/serve-web-probe.py`. La pantalla
carga esquemas y tablas visibles en Oracle; deja elegir el esquema (incluido
`SIS`, si la cuenta tiene acceso) y después una tabla. La prueba lee como
máximo 1.000 filas de la selección, no acepta un directorio desde el navegador
y escucha solo en loopback. Tras validar Parquet, ofrece descargarlo una vez;
el temporal se elimina después de la descarga o al cumplir 15 minutos.
También ofrece exportar todas las filas a un único Parquet persistente en
`output/exports`. Consulta estadísticas de Oracle y el espacio local libre
antes de iniciar, y muestra el avance por lotes. El dashboard principal sigue
en modo de demostración.

## Pantallas y estados

- Carga inicial: obtiene esquemas y después tablas y columnas; cada carga tiene
  estados deshabilitados y errores visibles.
- Configuración: esquema, tabla, directorio como ruta escrita por el usuario y
  tamaño de lote de 1 a 50.000 (predeterminado 10.000).
- Progreso: estados queued, connecting, reading, writing, cancelling,
  completed, cancelled y failed; contadores, velocidad, archivos, bytes,
  tiempo, lote y error del contrato.
- Cancelación: envía `DELETE`, muestra cancelling y continúa consultando hasta
  el estado terminal.
- Para ver el estado de error en modo demostración, usa `demo-error` en el
  directorio destino. Esto solo modifica la respuesta simulada del navegador.

El destino es texto porque el navegador no puede entregar una ruta absoluta del
sistema de archivos al servidor a través de un selector web. El servidor Zig
debe validar la ruta canónica contra la raíz autorizada definida en el contrato
antes de iniciar cualquier escritura.

## Conectar el backend real

1. Servir `web/` desde el mismo origen que la API local.
2. Cambiar `API_MODE` a `"http"` en `web/js/api.js`.
3. Mantener las rutas y formas JSON de `docs/architecture/http-api.md`.
4. El backend debe escuchar solo en loopback, devolver mensajes de error
   seguros y no exponer credenciales. No se debe añadir conexión Oracle desde
   JavaScript.

La interfaz usa HTML, CSS y JavaScript nativos, sin dependencias de runtime,
framework ni recursos remotos. El API general de catálogo, exportaciones
asíncronas y cancelación sigue pendiente; la prueba real no cambia el dashboard
principal a modo HTTP.
