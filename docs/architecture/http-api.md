# API HTTP local v1

Contrato para `src/web` y la interfaz. JSON UTF-8; todas las rutas se sirven
desde el mismo origen local. El servidor escucha en `127.0.0.1` por defecto.
No habilitar CORS general. Los nombres Oracle se validan como identificadores y
se pasan al adaptador mediante parámetros/quoting seguro, nunca interpolación
SQL sin validar.

## Esquemas y tablas

`GET /api/v1/schemas` responde `200`:

```json
{"items":[{"name":"TABLEAU"}]}
```

`GET /api/v1/schemas/{schema}/tables` responde `200`:

```json
{"items":[{"schema":"TABLEAU","name":"ANALISISLABORATORIO"}]}
```

`GET /api/v1/schemas/{schema}/tables/{table}` responde `200` con metadatos:

```json
{"schema":"TABLEAU","name":"ANALISISLABORATORIO","columns":[{"name":"ID","type":"int64","nullable":false,"precision":10,"scale":0}]}
```

Los tipos admitidos en el campo `type` son `boolean`, `int64`, `float64`,
`decimal`, `utf8`, `binary`, `date`, `timestamp` y
`timestamp_with_timezone`. `precision`, `scale` y `byte_length` pueden ser
`null` cuando se desconocen.

## Iniciar exportación

`POST /api/v1/exports`, `Content-Type: application/json`:

```json
{"schema":"TABLEAU","table":"ANALISISLABORATORIO","destination":"/data/export","batch_size":20000}
```

`batch_size` es un entero entre 1 y 50000; el valor predeterminado es 10000.
El backend debe restringir `destination` a un directorio de exportación
configurado por el operador (o validar una selección explícita desde la UI),
resolver rutas canónicas y rechazar traversal/symlinks que escapen de esa raíz.
No aceptar rutas arbitrarias sin política local. Responde `202 Accepted`:

```json
{"id":"exp_01J...","state":"queued","status_url":"/api/v1/exports/exp_01J..."}
```

Una exportación completa lee la tabla elegida secuencialmente por cursor/fetch
por lotes. No implica una transacción de snapshot ni un orden estable salvo que
se defina explícitamente en una decisión posterior.

## Consultar progreso

`GET /api/v1/exports/{id}` responde `200`:

```json
{"id":"exp_01J...","schema":"TABLEAU","table":"ANALISISLABORATORIO","state":"reading","rows_processed":12450000,"rows_per_second":185000.0,"files_completed":8,"bytes_written":3650722201,"elapsed_ms":72000,"current_batch":623,"error":null}
```

Estados: `queued`, `connecting`, `reading`, `writing`, `cancelling`,
`completed`, `cancelled`, `failed`. `error` es `null` salvo en `failed` y
contiene `code`, `message` y `retryable`. Los contadores son acumulados y no
disminuyen. `rows_per_second` puede ser `0` al inicio o si no hay avance.

## Cancelar

`DELETE /api/v1/exports/{id}` solicita cancelación. Responde `202 Accepted`
con el progreso en estado `cancelling`; `GET` posterior termina en `cancelled`
cuando los recursos se hayan cerrado. Responde `404` si el ID no existe y
`409` si ya está en estado terminal. Cancelar no borra archivos completos
previos; cualquier archivo parcial debe retirarse o identificarse como
incompleto.

## Errores HTTP

Forma común:

```json
{"error":{"code":"invalid_argument","message":"Tamaño de lote fuera de rango","retryable":false}}
```

Usar `400` para JSON/campos inválidos, `404` para recurso inexistente, `409`
para conflicto de estado, `422` para tabla/tipo no exportable, `500` para error
interno y `503` para dependencia temporalmente no disponible. No devolver
stack traces, SQL con datos, credenciales ni detalles sensibles del host.

## Transporte de progreso

La primera versión usa polling de `GET` por simplicidad; los clientes pueden
consultar cada 1–2 segundos y detener el polling en estado terminal. SSE puede
añadirse después sin cambiar el recurso de progreso.
