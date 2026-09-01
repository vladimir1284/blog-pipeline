# Plan de imágenes: Migrando un sistema de suscripciones legacy a Killbill sin downtime

Revisión del plan anterior a pedido del humano: de las 2 imágenes, una debe
tratar sobre Killbill mismo (el producto/proyecto), y solo una debe conservar
la referencia culinaria que sostiene la metáfora del post. Post patrón A,
largo (~1800 palabras), con seis subtítulos bajo una misma metáfora (chef,
cocina, estaciones, sazón, receta) — se mantienen 2 imágenes: portada y una
imagen de transición en la sección técnica.

## Imagen 1 — Portada
Ubicación: antes del título / como imagen de cabecera del post
Recomendación: banco de archivo
Justificación: esta es la única imagen del post que conserva la referencia
culinaria, y por eso tiene sentido que sea la portada — es la pieza que más
fija de inmediato el tono de marca de nitza-develop ("la receta de Killbill y
la cocina real..."), sin necesidad de ilustrar aún ningún concepto técnico
(eso lo hace el cuerpo del post). Una foto de stock de cocina profesional real
transmite más autenticidad editorial que una escena generada, y el sector
tiene abundante material de stock de alta calidad para esto.
- Términos de búsqueda sugeridos: "professional kitchen chef service in
  progress", "restaurant kitchen line cooks working", "commercial kitchen
  service rush", "chef plating dish professional kitchen"
- Preferir tomas donde no se reconozcan rostros con claridad (vista de
  espaldas, manos, plano medio de la estación) para evitar dependencia de
  personas identificables; evitar fotos con logos de marcas de utensilios,
  restaurantes o cadenas visibles.

## Imagen 2 — antes de la sección "Estaciones aisladas, no una sola llama"
Ubicación: como imagen de transición, justo antes del subtítulo "## Estaciones
aisladas, no una sola llama" (aprox. mitad del post, sección que describe que
los plugins de Killbill corren aislados en contenedores OSGi, cada uno con su
propio ciclo de vida)
Recomendación: captura de pantalla real (banco/fuente propia, no generar)
Decisión del humano: usar captura real de la consola de administración de
Killbill (Kaui) o de un diagrama de su documentación pública (killbill.io /
GitHub wiki), en vez de una ilustración generada. El humano indicó
explícitamente que no hay preocupación de IP/marca para este blog, así que se
descarta la alternativa de ilustración abstracta evaluada antes.
- Fuente: captura literal y sin alterar de la documentación pública real de
  Killbill (killbill.io, kaui, o el repo/wiki de GitHub) — el humano debe
  indicar la URL o pantalla específica a capturar antes de `/subir-imagenes`,
  y colocar el archivo en `images/raw/` como cualquier otra imagen del post.
- Justificación de la ubicación (sin cambios): es la única parte del post
  donde se describe con precisión técnica un rasgo real y específico de la
  arquitectura de Killbill (aislamiento de plugins en contenedores OSGi), no
  una metáfora genérica — coherente con que esta sea la imagen "sobre Killbill
  mismo" y la portada quede como única referencia culinaria.

## Nota sobre imágenes adicionales
No se recomienda ilustrar cada subtítulo con su propia imagen. Los otros
cuatro encabezados ("El mismo sazón, aunque cambie de chef", "Quien cocina no
necesariamente cobra en caja", "Cuando la cocina no sabe qué llevaba cada
plato", "El sazón fiscal cambia entre servicio y servicio") son variaciones de
la misma metáfora culinaria ya fijada por la portada; añadir más imágenes ahí
diluiría el impacto de las dos imágenes elegidas y alargaría innecesariamente
el tiempo de carga del post sin aportar comprensión adicional.
