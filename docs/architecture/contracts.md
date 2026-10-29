# Contratos compartidos

Estos contratos son el límite entre la fuente Oracle, la orquestación, el
destino Parquet y la API local. No seleccionan ni incorporan dependencias para
OCI/ODPI-C o Parquet.

## Modelo de datos

`src/models/types.zig` define columnas, referencias de tabla, valores, NULL,
estados y progreso. `NUMBER` se transporta como `decimal` textual canónico para
evitar pérdida de precisión al convertirlo a `f64`. Tipos temporales llevan
componentes explícitos y timestamps con zona conservan el desplazamiento
recibido. Los tipos Oracle que no puedan mapearse deben producir un error de
fuente/destino con diagnóstico seguro; no se convierten silenciosamente.

Cada fila conserva el orden declarado en `columns`; su longitud debe coincidir
con el número de columnas. `null` es SQL NULL. El valor no nulo debe coincidir
con el `logical_type` de su columna. Las cadenas `utf8` deben ser UTF-8 válido.

## Propiedad y memoria

- Los adaptadores son dueños de sus estructuras y memoria interna.
- Metadatos, filas y slices de un `Batch` son prestados por `Source`; quedan
  inválidos al pedir el siguiente lote o cerrar la fuente.
- `Destination.writeBatch` es síncrono y no retiene el lote al retornar. Así la
  orquestación puede liberar/reutilizar el buffer antes del siguiente fetch.
- El llamador de `Source.open` debe consumir los metadatos mientras sean
  válidos; su duración mínima cubre la vida de la fuente abierta. Si el destino
  necesita conservarlos, debe copiarlos en memoria propia y contabilizarla.
- Mensajes y slices de API también tienen propietario definido por quien los
  crea; no se devuelven slices temporales de stack.
- La memoria de filas debe estar acotada al lote configurado más buffers
  internos documentados de los adaptadores. No se acumula la tabla completa.

## Interfaces

`Source.listSchemas` y `Source.listTables` exponen solo objetos visibles para
la conexión. `Source.open` prepara una tabla y devuelve su esquema.
`Source.next` devuelve un lote o `null` al finalizar. El orden de filas es el orden entregado por Oracle;
no promete orden relacional si la consulta no lo especifica. `Source.close` se
llama siempre, incluso tras error o cancelación.

La orquestación llama `Destination.begin` una vez, `writeBatch` por cada lote y
`finish` solo tras EOF normal. Ante error/cancelación llama `abort`; el destino
debe retirar los archivos incompletos o mantenerlos marcados como parciales.
`writeBatch` debe completar el consumo antes de retornar.

`Cancellation` se comparte entre componentes. Debe revisarse entre lotes y
antes de pasos bloqueantes; una operación nativa ya bloqueada puede cancelar
solo cuando la biblioteca lo permita. El cierre de recursos es obligatorio en
cualquier ruta.

## Errores

`ModelError` categoriza el punto de fallo. El borde HTTP lo traduce a un código
estable (`ErrorCode`) y a texto seguro para usuario. No incluir credenciales,
descriptores de conexión con secretos ni SQL sensible en logs o respuestas.
Solo `unavailable` y errores explícitamente marcados reintentables deben
presentarse como reintentables.

## Uso mínimo

```zig
const models = @import("models/root.zig");

fn consume(source: models.interfaces.Source, destination: models.interfaces.Destination, table: models.types.TableRef, cancel: models.interfaces.Cancellation) !void {
    const columns = try source.open(table, cancel);
    defer source.close();
    errdefer destination.abort();
    try destination.begin(table, columns, cancel);
    while (try source.next(cancel)) |value| {
        try destination.writeBatch(value, cancel);
    }
    try destination.finish(cancel);
}
```

El ejemplo resume el ciclo de vida. La orquestación final deberá asegurar que
también se invoque `abort` ante error en `begin` o `finish`, y convertir
`ModelError` en el progreso/diagnóstico que corresponda.

## Versionado del contrato

Los tipos de Zig son internos al proceso. El contrato HTTP externo está en
[`http-api.md`](http-api.md) y usa `/api/v1`; cambios incompatibles requieren
una nueva versión del prefijo o una migración coordinada de los consumidores.
