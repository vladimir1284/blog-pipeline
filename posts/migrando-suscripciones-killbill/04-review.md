# Revisión crítica: Migrando un sistema de suscripciones legacy a Killbill sin downtime

## Resumen
Aprobado con advertencias

(Nota: esta es una re-revisión sobre la versión corregida de `03-draft-es.md`. La
revisión anterior tenía 1 BLOQUEO y 3 ADVERTENCIAS; las cuatro correcciones descritas
en la nota HTML al final del borrador y en la sección "Correcciones post-revisión
crítica" de `02-curated.md` fueron verificadas una por una — ver detalle abajo — y las
cuatro quedan resueltas correctamente. No se encontraron problemas nuevos que
constituyan bloqueo; se deja una advertencia operativa menor.)

## Verificación de las 4 correcciones previas

1. **BLOQUEO ("Killbill no gestiona productos") — RESUELTO.**
   El párrafo de la sección "Cuando la cocina no sabe qué llevaba cada plato" ahora
   dice explícitamente: *"Killbill sí gestiona productos y planes como parte de su
   catálogo, pero en este proyecto los ítems de cada orden de BigCommerce no se
   modelaron como productos o planes dentro de Killbill"*, y remata con *"no porque no
   pudiera tenerla, sino porque nunca llegaron a existir como tales dentro de su
   catálogo"*. Esto ya no contradice `01-research.md` (que confirma que el catálogo de
   Killbill gestiona productos, planes y fases como conceptos centrales) — al
   contrario, ahora es consistente con esa fuente. Además la responsabilidad queda
   correctamente atribuida a una decisión de modelado del proyecto, no a una carencia
   de la plataforma, tal como pedía la corrección en `02-curated.md`. La metáfora
   también se ajustó ("llevar la cuenta por comensal en vez de por plato") de forma
   que ya no insinúa que Killbill/la cocina sea incapaz de llevar el detalle por
   plato. Verificado — sin residuo del problema original.

2. **ADVERTENCIA ("por defecto" sobre pagos multi-factura) — RESUELTA.**
   La frase actual es *"Killbill no soporte que un solo pago cubra varias facturas a
   la vez"*, sin calificarla de "por defecto". Ya no insinúa que exista un modo
   configurable alterno que permita lo contrario, alineado con la limitación
   documentada en `01-research.md`. (Nota aparte: en otro punto del post sí aparece la
   frase "no el que trae la plataforma por defecto" al hablar del calendario de
   reintentos de pago — pero ahí "por defecto" es correcto porque el calendario de
   reintentos sí es configurable y sí tiene un valor por defecto real, 8/8/8 días, según
   `01-research.md`; no es el mismo caso que el corregido.)

3. **ADVERTENCIA ("años cobrando suscripciones") — RESUELTA.**
   El texto ya no menciona antigüedad. Ahora dice únicamente que el cliente *"ya
   cobraba suscripciones con su sistema legacy"*, un hecho ya establecido en el post y
   coherente con `02-curated.md`, sin la elaboración no autorizada sobre "años".

4. **ADVERTENCIA (apertura no sigue patrón A) — RESUELTA.**
   El primer párrafo ahora abre directamente con la anécdota concreta del cliente de
   renta de trailers (motor de suscripciones propio, cancelaciones anticipadas,
   cambios de plan, atrasos de pago) y solo hasta el segundo párrafo aparece la escena
   genérica de la analogía culinaria, entretejida con esa misma anécdota ("justo lo que
   ya le había quedado claro al equipo con aquel cliente de trailers"). Esto cumple el
   requisito de patrón A de abrir con "una situación concreta... o un caso real
   (anonimizado si hace falta)" en vez de una generalización.

## Bloqueos

Ninguno.

## Advertencias

- [ADVERTENCIA] El comentario HTML al final de `03-draft-es.md` (la nota que enumera
  las 4 correcciones aplicadas) es información útil para el humano y para esta
  revisión, pero es contenido operativo del pipeline, no parte del post. Debe
  eliminarse antes de `/traducir` y `/publicar` para que no se traduzca literalmente ni
  termine apareciendo en el HTML/markdown final publicado.
  Razón: editorial (higiene de contenido, no afecta veracidad ni estructura del post).

## Revisión del resto del post (no limitada a las 4 correcciones)

Se releyó el borrador completo contra `01-research.md`, `02-curated.md`,
`guia-editorial`, `guia-de-estilo` y `blogs.yaml` (`nitza-develop`), no solo los
fragmentos corregidos:

- Todas las afirmaciones verificables (guía de migración cuenta-por-cuenta de
  Killbill, calendario de dunning con estados WARNING/BLOCKED/CANCELLATION,
  Killbill no almacena métodos de pago por diseño PCI, orden en `status_id`
  Incomplete y restricción de store credit a cuentas registradas en BigCommerce,
  aislamiento de plugins en contenedores OSGi, cálculo de impuesto SaaS por
  ubicación de consumo con riesgo de variación entre ciclos) tienen respaldo directo
  en `01-research.md` y coinciden con lo aprobado en `02-curated.md`.
  Correctamente se omitió la cifra de Avalara ("450 formas/45 categorías"), tal como
  indicó el ángulo humano en la curación.
- Los hechos internos del proyecto (apagón único en vez de cutover incremental,
  calendario de dunning heredado del legacy, camino de cobro vía BigCommerce con
  token propio, falta de modelado de ítems como productos en Killbill, cronología
  del plugin) están todos señalados como tales desde `02-curated.md` antes de
  aparecer en el borrador — cumple con guia-editorial (no se inventan casos ni
  aparecen por primera vez en el borrador).
- Un solo CTA al cierre ("Cuéntanos en nuestras redes...") coherente con
  `marca.cta_tipica` de `nitza-develop`. No hay CTA duplicado en ningún otro punto
  del texto.
- `marca.evitar: ["promesas sin sustento"]` — no se encontraron promesas de
  resultado sin respaldo para el lector.
- `marca.voz: "Técnica y cercana"` y `recurso_narrativo` (analogías cocina/software
  en título y a lo largo del post) se respetan de forma consistente en las 7
  secciones y el título.
- Sin superlativos de autoridad no sustentados ni jerga de marketing genérica.
- Longitud estimada ~1450-1600 palabras (recuento aproximado tras los cambios),
  dentro del rango 1000-1800 de patrón A; uso de subtítulos correcto para un post
  de esta extensión.
- No se detecta similitud estructural alta con ninguna fuente externa individual:
  el orden de las secciones combina puntos de varias páginas de documentación
  distintas (migration_guide, overdue, payment_plugin, invoice-payment, arquitectura
  de plugins OSGi, BigCommerce payments, Avalara) sin replicar el orden argumentativo
  de ninguna de ellas en particular — esto es una comparación de similitud
  estructural contra las fuentes citadas, no una detección de plagio en sentido
  estricto.
- No se identificaron afirmaciones cuantitativas o comparativas nuevas sin
  respaldo ni pendientes de marcar `[VERIFICAR]`.

## Verificaciones realizadas

- Killbill: catálogo gestiona Productos, Planes y Fases como conceptos centrales —
  reconfirmado contra `01-research.md`; el borrador corregido ya no lo contradice.
- Killbill: no soporta un solo pago cubriendo múltiples facturas (sin calificarlo de
  "por defecto") — verificado en `01-research.md`, consistente en el borrador.
- Killbill: calendario de reintentos configurable con default real (8/8/8 días) —
  verificado en `01-research.md`; el uso de "por defecto" en este punto del borrador
  es correcto porque sí existe un valor por defecto real.
- Cliente ya cobraba suscripciones con su sistema legacy (sin cifra de antigüedad) —
  consistente con lo aprobado en `02-curated.md`, sin la elaboración "años" ya
  retirada.
- Apertura del post: anécdota concreta (cliente de renta de trailers) en el primer
  párrafo — cumple el requisito de patrón A verificado contra `guia-de-estilo`.
- Guía de migración de Killbill (cutover cuenta por cuenta, `cutOverDate`), diseño
  PCI de métodos de pago, restricciones de BigCommerce (Incomplete status, store
  credit solo cuentas registradas), aislamiento OSGi de plugins, cálculo de impuesto
  SaaS por ubicación de consumo — todas verificadas en `01-research.md`, sin cambios
  respecto a la revisión anterior.
- CTA único y coherente con `marca.cta_tipica` de `nitza-develop` en `blogs.yaml` —
  verificado, sin duplicados.
