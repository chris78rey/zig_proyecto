quiero conectarme con zig a mi base de datos oracle extraer los registros leidos de una tabla con millones de registros y luego transformarlo a partquet


1. Respecto a la conexión entre Zig y Oracle, ¿qué arquitectura técnica adoptamos?
b) Usar Zig + interoperabilidad con OCI/ODPI-C: aprovechar las librerías nativas y maduras de Oracle desde Zig. **(RECOMENDADA)**


2. Respecto a cómo extraer millones de registros de Oracle, ¿qué estrategia utilizamos?
b) Leer los registros mediante lotes configurables y procesarlos secuencialmente: consumo de memoria controlado y buena estabilidad. **(RECOMENDADA)**

3. Respecto a qué registros deben convertirse a Parquet, ¿cómo controlamos lo que ya fue procesado?
a) Leer nuevamente toda la tabla cada vez que se ejecute el proceso: arquitectura sencilla, pero muy costosa con millones de registros.


Este es el nodo 2 de mi base de datos 

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

La tabla es 

TABLEAU.ANALISISLABORATORIO esta en 11g r2 de oracle



--------


1. Respecto a la conexión desde Zig hacia Oracle RAC 11gR2, ¿cómo debemos conectarnos al nodo indicado?
a) Conectarnos directamente usando HOST=[ORACLE_HOST], PORT=1521 y SID=[ORACLE_SID] mediante OCI/ODPI-C. **(RECOMENDADA)**

2. Respecto a la lectura completa de TABLEAU.ANALISISLABORATORIO cada vez que se ejecute el proceso, ¿cómo recorreremos los millones de registros?

c) Abrir un cursor Oracle y recuperar bloques sucesivos mediante fetch arrays de 10.000–50.000 registros hasta terminar la tabla. **(RECOMENDADA)**

3. Respecto a la generación del archivo Parquet, ¿cómo debemos almacenar los millones de registros extraídos?
b) Generar varios archivos Parquet por bloques, por ejemplo part-000001.parquet, part-000002.parquet, etc. **(RECOMENDADA)**


no se si deba tener una interfaz visual que permita seleccionar la tabla


-----


1. Respecto a la forma de seleccionar qué tabla Oracle exportar a Parquet, ¿qué interfaz debería tener el proyecto?
b) Interfaz visual sencilla que liste esquemas y tablas disponibles y permita seleccionar cuál exportar. **(RECOMENDADA)**

2. Respecto al alcance inicial de la interfaz visual, ¿qué funcionalidades debería incluir?
b) Seleccionar esquema, tabla, carpeta destino, tamaño del lote y comenzar la exportación mostrando progreso. **(RECOMENDADA)**

3. Respecto a cómo debería construirse la interfaz visual manteniendo Zig como núcleo del proyecto, ¿qué arquitectura adoptamos?
b) Mantener Zig como motor de extracción y conversión, y usar una interfaz web local HTML/CSS/JavaScript que invoque al backend Zig. **(RECOMENDADA)**



-----



