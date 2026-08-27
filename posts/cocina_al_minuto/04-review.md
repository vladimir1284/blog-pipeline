# Revisión crítica: Por qué nos llamamos Nitza Develop

(Segunda pasada — revisa los cambios hechos sobre la versión que motivó el
`04-review.md` anterior: reformulación de los dos párrafos finales y cambio
de `tipo_post` de A a C.)

## Resumen
Aprobado con advertencias

## Bloqueos

Ninguno. El BLOQUEO de la primera pasada queda resuelto.

Verificación del fix: los dos párrafos finales ("Así queremos trabajar el
desarrollo de software en Nitza Develop..." y "Por eso el nombre no es un
juego de palabras gratuito. Es una declaración de valores: así intentamos
trabajar...") ya no presentan la metodología de la empresa (documentar el
porqué de cada decisión, código legible con licencias claras, no entregar
"caja cerrada") como un hecho comprobado y consistente sobre cómo opera
Nitza Develop hoy. Están reformulados en primera persona plural como
intención/aspiración declarada ("queremos trabajar", "intentando
documentar", "nuestra intención de dejar código legible", "el estándar...
que nos proponemos seguir"). Esto es exactamente la salida que la
sugerencia del review anterior pedía (aspiración en vez de descripción
fáctica), y ya no coincide con el patrón de `marca.evitar: ["promesas sin
sustento"]` de nitza-develop en `blogs.yaml` de la misma forma directa que
antes. No se introdujo ningún hecho nuevo sobre la empresa, sus clientes o
sus servicios que requiera `[VERIFICAR CON EL NEGOCIO]`.

## Advertencias

- [ADVERTENCIA] Dentro del párrafo reformulado ("Así queremos trabajar..."),
  la frase "Es la misma lógica de 'cocinar con lo que hay' aplicada a
  decidir si se extiende un sistema legado o se reescribe un módulo, y la
  misma lógica de 'compartir la receta modificada' aplicada a nuestra
  intención de dejar código legible y documentado..." es una oración nueva,
  gramaticalmente separada de "Así queremos trabajar" por un punto. El
  primer tramo de esa oración (la decisión de extender un legado vs.
  reescribir un módulo) no lleva un verbo de intención propio pegado a él
  (a diferencia del segundo tramo, que sí dice explícitamente "nuestra
  intención de"). Leída de forma aislada, ese fragmento concreto podría
  interpretarse como una descripción de cómo la empresa efectivamente
  decide hoy, no como aspiración. En contexto de todo el párrafo se lee
  como continuación de "así queremos trabajar", pero no es una lectura
  forzosa.
  Razón: editorial (precisión), roza veracidad/ética por el mismo motivo
  que motivó el BLOQUEO original, aunque en grado mucho menor.
  Sugerencia: si se quiere blindar del todo, añadir un verbo de intención
  explícito también a ese primer tramo (algo equivalente a "nuestra forma
  de decidir" → "cómo intentamos decidir" o similar), igual que ya se hizo
  en el segundo tramo de la misma oración. Es un ajuste menor, no bloquea.

- [ADVERTENCIA] (se mantiene de la primera pasada, sin cambios en el texto
  afectado) El post usa la escasez de alimentos y el hambre real vividos
  durante el Período Especial cubano como punto de entrada y metáfora para
  justificar el nombre y la filosofía de trabajo de una empresa de
  software. El tratamiento sigue siendo respetuoso y no jocoso, pero el
  riesgo de que se lea como trivialización de un período de sufrimiento
  real por parte de lectores cubanos o con vínculos cercanos a Cuba no ha
  cambiado.
  Razón: ética. Queda a criterio humano si el tono encaja con
  `marca.voz: "Técnica y cercana"` y el público declarado en `blogs.yaml`.

- [ADVERTENCIA] (se mantiene de la primera pasada, sin cambios en el texto
  afectado) Discrepancia menor entre fuentes sobre el año en que "Cocina al
  Minuto" se estrenó o se consolidó como referente: el borrador usa el 3 de
  julio de 1951 (fuente directa y específica de cubanoticias360.com), pero
  `01-research.md` ya señalaba variabilidad entre medios sin resolverla del
  todo. No amerita bloqueo; el dato usado tiene fuente trazable y directa.
  Razón: veracidad (menor).

## Advertencias de la primera pasada que quedan resueltas / superadas

- Patrón A vs. C: resuelta. El frontmatter ahora indica `tipo_post: C`,
  confirmado por el humano en `00-config.md` (comentario del redactor y
  enunciado de la tarea). Conté manualmente el cuerpo del post (excluyendo
  título y subtítulos) y da aproximadamente 900-930 palabras, dentro del
  rango 600-1000 de Patrón C, aunque cerca del techo superior — no hay
  margen grande si en el futuro se quiere añadir contenido sin recortar
  otra parte.
- Déficit de palabras contra el piso de 1000 de Patrón A: superada, ya no
  aplica porque el patrón correcto es C.
- CTA "demasiado explícito para Patrón A": superada. Patrón C no exige el
  mismo grado de sutileza que A en el cierre ("lección formulada como
  principio de trabajo, en primera persona" — que el post cumple). El CTA
  sigue siendo uno solo y coincide con `marca.cta_tipica` de nitza-develop
  ("Seguirnos en nuestras redes sociales, comentarnos sus opiniones").
- Los `[VERIFICAR]` sobre las citas de Stallman: se mantienen intactos en
  el texto, tal como se confirmó en la primera pasada que debían quedar
  (postura conservadora razonable, ya corroborada de forma independiente
  por el crítico anterior vía WebSearch, sin necesidad de forzar su
  remoción).

## Verificaciones realizadas

- Resolución del BLOQUEO original (metodología presentada como hecho vs.
  como aspiración) — verificada por lectura directa del texto modificado;
  ver detalle arriba.
- Ausencia de hechos nuevos sobre la empresa, sus servicios o sus clientes
  en los párrafos reformulados — verificada; solo cambió el marco
  enunciativo (hecho → intención), no el contenido factual.
- Cumplimiento de `marca.evitar: ["promesas sin sustento"]` de
  nitza-develop — verificado como cumplido tras el fix; no encontré otras
  frases en el resto del post (sin cambios desde la primera pasada) que
  entren en ese patrón.
- Ausencia de superlativos no sustentados y de jerga de marketing genérica
  ("solución integral", "revolucionario", "de vanguardia") — verificada,
  no se encontraron instancias en el texto completo.
- Un solo CTA, coherente con `marca.cta_tipica` — verificado.
- Patrón C de guia-de-estilo (apertura con anécdota concreta y
  contraintuitiva, cuerpo que conecta la anécdota con una decisión de
  negocio explicando el razonamiento, cierre como principio de trabajo en
  primera persona) — verificado, el post cumple la estructura de Patrón C
  punto por punto.
- Longitud del cuerpo del post — conteo manual aproximado de ~900-930
  palabras (excluyendo título y subtítulos), dentro del rango 600-1000 de
  Patrón C.
- Subtítulos justificados solo si el post supera 800 palabras (regla común
  de guia-de-estilo) — verificado, el post los supera y usa 3 subtítulos.
- Resto de afirmaciones cuantitativas/biográficas/históricas del post
  (fechas de nacimiento y muerte de Villapol, doctorado en 1948, estreno
  del programa en 1951, publicación del libro en 1958, discurso de
  Stallman en NYU el 29 de mayo de 2001, anécdota de las raciones vía
  NPR/Oppenheimer con su caveat de fuente secundaria) — sin cambios desde
  la primera pasada; ya fueron verificadas contra `01-research.md` y, en
  varios casos, corroboradas de forma independiente por WebSearch en la
  revisión anterior. No fue necesario repetir esas búsquedas porque el
  texto correspondiente no cambió.
- Similitud estructural contra las fuentes citadas en `01-research.md` —
  sin cambios respecto a la primera pasada (los párrafos modificados no
  provienen de ninguna fuente citada, son síntesis propia); se mantiene la
  conclusión de que no hay similitud alta con ninguna fuente individual.
