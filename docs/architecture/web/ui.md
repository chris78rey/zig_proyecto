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
en modo de demostración. La portada incluye una descarga local del archivo
preparado `SIS.ITEMS` con `TIPO='I'` (9.864 registros y 50 campos), servido por
una ruta fija accesible solo desde loopback. El enlace «Consultar SIS.ITEMS por
tipo» abre una página aparte que carga los tipos y sus cantidades desde Oracle;
la exportación del tipo seleccionado pasa por Zig/ODPI-C y produce un Excel con
todos sus campos.

La página `/items/compare` ejecuta el flujo Zig para un solo `TIPO`, normaliza
mayúsculas, acentos y puntuación, recupera hasta ocho candidatos por descripción
con RapidFuzz y puntúa cada par combinando similitud de caracteres (65 %) y de
palabras ordenadas (35 %). El umbral inicial es 85/100; retiene hasta 10.000
candidatos y agrupa los artículos conectados por similitud. Cada tarjeta muestra
la clave primaria `TIPO`, `SBS_SCC_CODIGO`, `SBS_CODIGO`, `CODIGO`. La vista de
revisión permite crear varios subgrupos dentro de un grupo o marcar artículos
como «No empatar». Las decisiones y su auditoría quedan en
`output/items-review/review.sqlite3`; Oracle no se modifica.

El servidor muestra `/login` para las páginas y APIs protegidas. El formulario
valida usuario y contraseña con Oracle. La cookie de sesión es `HttpOnly`, la
sesión y credenciales viven solo en memoria del servidor, y SQLite conserva las
decisiones con usuario y fecha, nunca la contraseña.

Cada corrida de comparación se guarda en SQLite con su creador, tipo, umbral,
candidatos y estado. La lista «Corridas guardadas» permite que otros usuarios
Oracle abran la corrida después de reiniciar el servidor. Los cambios se
conservan como eventos de auditoría con responsable y fecha.
`/items/compare` es la ventana de ejecución; por defecto, solo `christian_ruiz`
puede iniciar corridas. El usuario se configura mediante
`ITEMS_COMPARE_RUNNER_USER`. Al terminar, la corrida ofrece abrir `/items/review`
en otra pestaña. Esa vista muestra los grupos guardados a lo ancho de la ventana.
Christian puede ver todos los grupos y retirar corridas. El retiro las oculta del
historial activo y guarda responsable y fecha; conserva candidatos y auditoría
en SQLite.

Christian descarga una plantilla Excel con una fila por grupo y asigna cada
grupo mediante la primera columna `USUARIO_ORACLE`, que ofrece una lista de
cuentas Oracle. La hoja incluye los cuatro campos de clave primaria del primer
artículo como referencia visual para identificar cada grupo. Los demás campos y
las hojas de consulta están protegidos para evitar cambios accidentales. Al
cargar el archivo, el servidor valida la corrida y los grupos, guarda las
asignaciones de grupo y sus relaciones en SQLite con
usuario y fecha. Si la celda de asignación queda vacía, la asignación actual se
conserva. Cada experto ve sus grupos asignados. Christian puede ver todos, pero
solo el usuario asignado puede mover artículos, guardar subgrupos, omitirlos o
reabrirlos; el servidor verifica esta regla al guardar. La paginación muestra
botones numerados para saltar directamente a una página. Los precios de venta
se destacan en cada artículo; los valores cero aparecen en rojo. La diferencia
porcentual superior al 15 % se marca en rojo.

En cada subgrupo confirmado como mismo artículo, el experto asignado hace clic
en la tarjeta que conservará la clave maestra. La selección queda en SQLite con
usuario, fecha y evento de auditoría; solo se admite una clave que pertenezca
al subgrupo. Para guardar un subgrupo nuevo, primero debe elegir una tarjeta
maestra; sin esa selección, la confirmación permanece deshabilitada. Los
subgrupos guardados se muestran colapsados con su cantidad de artículos y el
maestro actual; al desplegarlos se pueden cambiar el maestro o reabrir artículos.
Christian puede descargar el reporte Excel de empates. La hoja `Empates a
realizar` relaciona cada clave origen que se absorberá con la clave maestra,
presenta por separado los campos `TIPO`, `SBS_SCC_CODIGO`, `SBS_CODIGO` y
`CODIGO` del origen y del maestro, con columnas ampliadas para leer los códigos;
la hoja `Pendientes de maestro` enumera subgrupos confirmados que aún requieren
esa elección. El archivo es un plan de trabajo y no ejecuta cambios en Oracle.

Christian configura por corrida el porcentaje mínimo para sugerir «Mismo
artículo» (predeterminado 94 %, rango desde la similitud mínima hasta 100 %).
El control no permite usar una sugerencia por debajo del mínimo de similitud y
el servidor valida la misma regla. El umbral queda guardado con la corrida. Los
grupos y sus relaciones se ordenan por puntaje descendente; los artículos
dentro del grupo se ordenan por su vínculo más fuerte.

La página usa `GET /api/v1/items/types` para cargar los valores distintos de
`TIPO` y su cantidad. `POST /api/v1/items/exports` acepta `{"tipo":"I"}`;
devuelve un ID para consultar el progreso con `GET
/api/v1/items/exports/{id}` y descargar el `.xlsx` terminado desde
`GET /api/v1/items/exports/{id}/download`. El servidor limita a una exportación
activa a la vez y guarda temporalmente el Parquet intermedio, que elimina al
terminar la conversión.

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
