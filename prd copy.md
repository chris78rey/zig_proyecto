Actúa como un **Arquitecto de Software Senior y especialista en sistemas de alto rendimiento**, con experiencia avanzada en **Zig, Oracle Database 11gR2, Oracle RAC, OCI, ODPI-C, Apache Parquet, procesamiento masivo de datos y diseño de interfaces web locales**.

Tu misión es **diseñar y posteriormente implementar una solución profesional que permita conectarse desde Zig a una base de datos Oracle 11gR2, extraer millones de registros de tablas seleccionadas por el usuario y convertirlos eficientemente a archivos Apache Parquet**, manteniendo bajo consumo de memoria, alto rendimiento y una arquitectura simple, robusta y mantenible.

## 1. Contexto técnico

La base de datos origen es:

- Motor: **Oracle Database 11gR2**
- Arquitectura: **Oracle RAC**
- Nodo inicial de conexión: **Nodo 2**
- Protocolo: TCP
- Host: `[ORACLE_HOST]`
- Puerto: `1521`
- SID: `prdsgh2`
- Modo: `SERVER=dedicated`

Descriptor equivalente:

```text
RAC_NODO2=
  (DESCRIPTION=
    (ADDRESS=
      (PROTOCOL=TCP)
      (HOST=[ORACLE_HOST])
      (PORT=1521)
    )
    (CONNECT_DATA=
      (SERVER=dedicated)
      (SID=prdsgh2)
    )
  )
```

Como caso inicial de prueba existe la tabla:

```text
TABLEAU.ANALISISLABORATORIO
```

Esta tabla puede contener **millones de registros**.

Sin embargo, la solución final no debe quedar limitada a esta tabla. Debe permitir posteriormente seleccionar otras tablas Oracle desde una interfaz.

## 2. Arquitectura definida

La aplicación debe utilizar:

```text
Interfaz web local
        │
        ▼
Backend / motor desarrollado en Zig
        │
        ▼
OCI / ODPI-C
        │
        ▼
Oracle Database 11gR2 RAC
        │
        ▼
Lectura mediante cursor + Array Fetch
        │
        ▼
Conversión
        │
        ▼
Apache Parquet
```

Zig debe constituir el **núcleo de procesamiento de la aplicación**.

Para acceder a Oracle, utilizar interoperabilidad mediante **OCI y preferentemente ODPI-C**, evitando desarrollar un protocolo Oracle propio.

La aplicación debe conectarse inicialmente directamente al nodo:

```text
[ORACLE_HOST]:1521/prdsgh2
```

La arquitectura debe quedar preparada para que posteriormente pueda utilizarse una cadena TNS, SERVICE_NAME o SCAN de Oracle RAC si fuese necesario.

## 3. Estrategia de extracción

No se debe cargar la tabla completa en memoria.

Implementar una consulta Oracle mediante cursor y recuperar los resultados utilizando **Array Fetch / Fetch por lotes**.

El tamaño del lote debe ser configurable.

Tomar como rango inicial recomendado:

```text
10.000 – 50.000 registros
```

El proceso conceptual debe ser:

```text
Abrir conexión
↓
Ejecutar SELECT
↓
Abrir cursor
↓
Fetch de N registros
↓
Convertir lote
↓
Escribir Parquet
↓
Liberar/reutilizar memoria
↓
Fetch siguiente
↓
Repetir hasta finalizar
```

Debe priorizarse un consumo de memoria **estable y predecible**, incluso cuando se procesen decenas o cientos de millones de registros.

No utilizar `OFFSET/FETCH` como mecanismo principal de paginación.

No utilizar `ROW_NUMBER()` para recorrer toda la tabla salvo que exista una justificación técnica específica.

## 4. Política inicial de lectura

En la primera versión, cada ejecución debe poder realizar una **lectura completa de la tabla seleccionada**.

No implementar todavía obligatoriamente checkpoints incrementales, estados procesados ni modificaciones en la tabla Oracle.

Sin embargo, diseña la arquitectura de manera que en futuras versiones pueda añadirse:

- lectura incremental;
- checkpoint;
- filtrado por fecha;
- filtrado por identificador;
- extracción mediante rangos;
- paralelización controlada.

## 5. Generación de archivos Parquet

No generar necesariamente un único archivo gigantesco.

La estrategia preferida es producir múltiples archivos:

```text
part-000001.parquet
part-000002.parquet
part-000003.parquet
...
```

El sistema debe permitir definir criterios razonables para cerrar cada archivo, por ejemplo:

- número máximo de registros;
- tamaño aproximado;
- número determinado de lotes;
- tamaño objetivo del archivo.

Los archivos deben formar un dataset Parquet compatible con herramientas analíticas modernas.

Debes evaluar y recomendar una estrategia apropiada para:

- Row Groups;
- compresión;
- tamaño objetivo de archivo;
- tipos de datos;
- valores NULL;
- NUMBER;
- VARCHAR2;
- CHAR;
- DATE;
- TIMESTAMP;
- CLOB;
- BLOB, si existieran.

La solución debe preservar correctamente los tipos de Oracle en su representación Parquet.

## 6. Interfaz visual

La aplicación debe disponer de una **interfaz web local sencilla**, evitando inicialmente frameworks pesados si no son necesarios.

Puede utilizar:

- HTML5;
- CSS;
- JavaScript.

Zig actuará como backend local.

La pantalla principal debe permitir como mínimo:

```text
Conexión Oracle
      ↓
Seleccionar esquema
      ↓
Seleccionar tabla
      ↓
Seleccionar directorio destino
      ↓
Configurar tamaño del lote
      ↓
Iniciar exportación
```

La aplicación debe consultar Oracle dinámicamente para obtener los esquemas y tablas que el usuario tenga permiso de consultar.

Evitar colocar manualmente en el código la lista de tablas.

## 7. Información de progreso

Mientras se realiza una exportación, la interfaz debe mostrar al menos:

- tabla seleccionada;
- estado de la conexión;
- registros procesados;
- registros procesados por segundo;
- cantidad de archivos Parquet generados;
- tamaño de datos generado;
- tiempo transcurrido;
- lote actual;
- estado del proceso;
- errores producidos.

Ejemplo conceptual:

```text
Exportando: TABLEAU.ANALISISLABORATORIO

Registros procesados: 12.450.000
Velocidad: 185.000 registros/s
Archivos Parquet: 8
Datos escritos: 3.4 GB
Tiempo: 00:01:12

Estado: EXPORTANDO
```

## 8. Seguridad

No almacenar credenciales Oracle directamente en el código fuente.

Separar:

- usuario;
- contraseña;
- host;
- puerto;
- SID/SERVICE_NAME;
- configuración.

Evaluar mecanismos apropiados como variables de entorno, archivo de configuración protegido o entrada mediante la interfaz.

Evitar registrar contraseñas en logs.

## 9. Robustez

El sistema debe gestionar correctamente:

- pérdida de conexión Oracle;
- consultas interrumpidas;
- errores OCI/ODPI-C;
- errores de conversión;
- falta de espacio en disco;
- permisos insuficientes;
- tipos Oracle no soportados;
- archivos Parquet incompletos;
- cancelación manual del proceso.

Una falla en un lote no debe provocar silenciosamente corrupción en el dataset generado.

## 10. Rendimiento

El objetivo principal es conseguir una solución de **streaming ETL de alto rendimiento**:

```text
Oracle → RAM limitada → Parquet
```

Evitar almacenamiento temporal innecesario.

Evitar copiar datos múltiples veces en memoria.

Reutilizar buffers cuando sea técnicamente conveniente.

Analizar cuidadosamente la interacción entre:

- `arraySize` de ODPI-C;
- tamaño del fetch;
- memoria disponible;
- tamaño de Row Group;
- compresión Parquet;
- rendimiento de disco;
- carga generada sobre Oracle.

No asumir que el mayor tamaño de lote produce siempre mayor rendimiento.

## 11. Restricción importante sobre Oracle

La base Oracle es un sistema existente y potencialmente productivo.

La solución debe priorizar consultas de solo lectura.

No ejecutar:

```sql
UPDATE
DELETE
INSERT
ALTER
```

sobre las tablas origen como parte del proceso normal de exportación.

Evitar diseños que generen carga excesiva sobre el RAC.

## 12. Organización esperada del proyecto

Propón una estructura modular similar a:

```text
oracle-parquet-zig/
│
├── build.zig
├── build.zig.zon
│
├── src/
│   ├── main.zig
│   ├── config/
│   ├── oracle/
│   ├── parquet/
│   ├── export/
│   ├── web/
│   ├── models/
│   ├── logging/
│   └── utils/
│
├── web/
│   ├── index.html
│   ├── css/
│   └── js/
│
├── config/
├── logs/
├── output/
└── README.md
```

Puedes modificarla si existe una arquitectura técnicamente superior.

## 13. Entregables que debes producir

Trabaja de forma progresiva.

Primero entrega:

### Fase 1 — Diseño

1. Arquitectura definitiva.
2. Componentes.
3. Flujo de datos.
4. Dependencias necesarias.
5. Librería recomendada para generar Parquet desde Zig.
6. Estrategia de interoperabilidad Zig ↔ ODPI-C.
7. Diseño del sistema de streaming.
8. Manejo de tipos Oracle → Parquet.
9. Estrategia de archivos y Row Groups.
10. Riesgos técnicos importantes.

Después continúa con:

### Fase 2 — Estructura

Genera la estructura completa del proyecto y explica brevemente la responsabilidad de cada módulo.

### Fase 3 — Prueba mínima

Construye primero una prueba funcional capaz de:

```text
Zig
↓
ODPI-C
↓
[ORACLE_HOST]:1521/prdsgh2
↓
SELECT sobre TABLEAU.ANALISISLABORATORIO
↓
Fetch por lotes
↓
Mostrar número de registros recuperados
```

Todavía sin interfaz si esto facilita validar primero la conexión y el rendimiento.

### Fase 4 — Parquet

Agregar escritura real de Parquet mediante streaming y archivos `part-xxxxx.parquet`.

### Fase 5 — Interfaz

Agregar la interfaz web local para seleccionar:

- esquema;
- tabla;
- directorio destino;
- tamaño del lote.

### Fase 6 — Observabilidad y optimización

Agregar:

- progreso;
- velocidad;
- métricas;
- logs;
- manejo de errores;
- cancelación;
- pruebas de rendimiento.

## 14. Forma de responder

No te limites a recomendaciones generales.

Cuando lleguemos a implementación, proporciona:

- código completo;
- archivos completos;
- nombres exactos;
- rutas exactas;
- comandos de compilación;
- comandos de instalación;
- configuración;
- consultas SQL;
- manejo de errores;
- instrucciones de prueba.

Evita pseudocódigo cuando sea posible escribir código real.

Si una librería o API propuesta puede haber cambiado recientemente, verifica su documentación actual antes de utilizarla.

Si detectas una decisión del diseño que pueda generar problemas graves de rendimiento, compatibilidad o estabilidad con **Oracle 11gR2**, indícalo antes de implementar y propón una alternativa concreta.

El objetivo final es obtener una herramienta profesional, reutilizable y de alto rendimiento para:

```text
Oracle 11gR2
      ↓
Zig + ODPI-C
      ↓
Streaming por lotes
      ↓
Apache Parquet
```

con una interfaz web local que permita utilizar posteriormente la misma aplicación para exportar distintas tablas de Oracle sin modificar el código fuente.
