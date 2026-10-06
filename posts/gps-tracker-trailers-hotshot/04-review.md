# Revisión crítica: Iteración de hardware de un GPS tracker para trailers de hotshot (Towit Houston)

## Resumen
Resuelto (ver nota de resolución abajo)

## Bloqueos

- [BLOQUEO — RESUELTO 2026-10-05] El párrafo de apertura afirmaba: "el robo de
  carga en Estados Unidos alcanzó 3,625 incidentes en 2024, un 27% más que el
  año anterior, con una pérdida promedio de $202,364 por incidente", y lo
  reforzaba dos frases después con "Texas está entre los tres estados más
  golpeados del país". `03-draft-es.md` ya fue corregido: ahora dice
  "Norteamérica (Estados Unidos y Canadá)" y "del continente", consistente con
  el alcance real de la fuente CargoNet/Verisk citada en `01-research.md`. La
  cifra en
  sí (3,625 / +27% / $202,364) es correcta, pero el alcance geográfico no lo
  es: es el propio `01-research.md`, en su sección "Datos y cifras
  verificables", el que titula este dato como "Robo de cargo en **Norteamérica**
  2024" (no solo EEUU). Confirmé de forma independiente por WebSearch que la
  cifra proviene del reporte de CargoNet/Verisk, que cubre **Estados Unidos y
  Canadá combinados**, no EEUU en solitario. El borrador toma un dato de
  Norteamérica y lo presenta como si fuera exclusivamente estadounidense, en
  el hook de apertura del post — el lugar de mayor peso retórico del artículo.
  Razón: veracidad (alcance geográfico de la fuente citada no coincide con la
  afirmación del borrador).
  Sugerencia: ajustar a "en Norteamérica" o "en EEUU y Canadá", o buscar/pedir
  un desglose exclusivo de EEUU si existe, antes de mantener "en Estados
  Unidos" como está. Nota aparte para el humano: `01-research.md` es
  internamente inconsistente en esto (su propio texto narrativo dice "en EEUU"
  en un punto y luego cita la cifra de "Norteamérica" en la tabla de datos), lo
  cual probablemente originó el error en la curación/redacción — vale la pena
  corregirlo también en la investigación si se reutiliza este dato en otro
  post.

## Advertencias

- [ADVERTENCIA] El `marca.recurso_narrativo` de `blogs.yaml` para
  nitza-develop pide analogías de cocina "tanto en el título... como a lo
  largo del post", y el propio agente redactor (`.claude/agents/redactor.md`)
  instruye explícitamente aplicarlo "de forma sostenida a lo largo del post
  (no solo en la intro) — es un recurso de marca, no un adorno puntual". El
  borrador usa la metáfora culinaria solo en 4 anclas puntuales (título,
  apertura, un punto medio, cierre) y lo justifica en su nota final como
  "según instrucción explícita del humano". Esa instrucción de moderar el
  recurso no está registrada en `00-config.md` ni en `02-curated.md`, así que
  no puedo verificarla de forma independiente — es una afirmación del
  redactor sobre sí mismo, no un dato trazable.
  Razón: editorial.
  Sugerencia: el humano confirma si efectivamente autorizó esa moderación
  (y conviene dejarlo registrado en `00-config.md` para trazabilidad futura),
  o el redactor sostiene la analogía culinaria en más puntos del cuerpo.

- [ADVERTENCIA] El borrador introduce una segunda familia de analogías —
  arquitectura de software (monolito con demasiadas dependencias en un
  contenedor con límite de imagen fijo, consolidación de microservicios,
  proceso que se activa solo bajo demanda, code review antes de escalar una
  prueba de concepto) — que corre en paralelo a la metáfora de cocina sin
  fusionarse con ella. El `marca.recurso_narrativo` declarado pide
  específicamente "analogías **entre** desarrollo de software y alta
  cocina" (un cruce), no dos recursos narrativos independientes conviviendo
  en el mismo post.
  Razón: editorial.
  Sugerencia: el humano decide si esto diluye el recurso de marca declarado o
  si es una variación aceptable dado que el público (`marca.publico`:
  desarrolladores y arquitectos de software) responde bien a ambas.

- [ADVERTENCIA] La cifra "10-15% de recuperación de equipo rentado... muy por
  debajo del ~60% que aplica para vehículos robados en general" proviene de
  una única fuente en `01-research.md` (gpsinsight.com), un blog comercial de
  una empresa que vende trackers GPS para flotas de renta — tiene incentivo
  directo en dramatizar esa brecha. Verifiqué por WebSearch de forma
  independiente: la cifra es plausible pero no está fuertemente corroborada
  con ese nivel de precisión — fuentes independientes muestran rangos algo
  distintos (7-25% de recuperación para equipo en general, 52-85% para
  vehículos según distintos reportes/años), que se solapan con lo citado pero
  no lo confirman punto por punto.
  Razón: veracidad (dependencia de fuente única con posible sesgo comercial
  para una cifra rectóricamente central del post).
  Sugerencia: aceptable tal cual si el humano juzga que el respaldo de
  `01-research.md` es suficiente (la cifra ya viene matizada con "~" y un
  rango), pero vale la pena que quede como decisión consciente y no por
  default.

## Verificaciones realizadas

- Robo de carga 2024: 3,625 incidentes, +27% interanual, $202,364 pérdida
  promedio — verificada (cifras correctas), pero alcance geográfico
  ("Estados Unidos") contradicho por búsqueda propia: la fuente cubre EEUU +
  Canadá (ver Bloqueo arriba).
- Texas entre los tres estados más golpeados — verificada, consistente con
  `01-research.md` (Texas, California e Illinois concentran el 46% de los
  casos en el reporte citado).
- Recuperación de equipo rentado 10-15% vs ~60% vehículos en general —
  verificada con matices; fuente única de origen comercial, rangos
  independientes se solapan pero no coinciden exactamente (ver Advertencia
  arriba).
- Arduino Nano / ATmega328: 32KB flash total, ~2KB bootloader, ~30KB
  utilizables — verificada, coincide con `01-research.md`.
- ESP32-WROOM-32: 520KB SRAM, 4MB flash — verificada, coincide con
  `01-research.md`.
- AMS1117 5-10mA en reposo vs MCP1700 ~1.6µA — verificada, coincide con
  `01-research.md`.
- NEO-6M: 45mA operación normal, 11mA en Power Save Mode — verificada,
  coincide con `01-research.md`.
- Cifra de resultado (+20 dispositivos, 75% uptime, recuperación tras +1 mes
  sin señal) — marcada `[VERIFICAR: cifra por recuerdo, proyecto ya no
  operativo, sin registro exacto]` correctamente en el borrador; es un dato
  interno del cliente sin fuente pública posible, y el tag ya resuelve
  apropiadamente la exigencia de trazabilidad de la guía editorial. No se
  trata como hallazgo nuevo, solo se confirma que el marcado es correcto.
- Framing legal del doble fondo ("discreto"/integración mecánica, nunca
  "oculto para que el rentador no supiera") — verificado en las tres menciones
  del borrador (título de sección, cuerpo, y la frase explícita "No se
  trataba de esconder nada"); cumple consistentemente con la decisión
  editorial ya resuelta por el humano.
- Similitud estructural con fuentes citadas — no se detectó: la investigación
  se basa en múltiples fuentes técnicas independientes (datasheets, blogs de
  hardware) usadas solo como respaldo puntual de cifras, no como plantilla
  narrativa; la estructura del post (Arduino → ESP32 → LilyGo → energía →
  mecánica → giro → lección) sigue el relato interno del equipo tal como está
  en `00-config.md`/`02-curated.md`, no la de ninguna fuente externa.
- CTA único, coherente con `marca.cta_tipica` ("Seguirnos en nuestras redes
  sociales, comentarnos sus opiniones") — verificado, un solo CTA al cierre.
- Longitud: ~1,390 palabras — dentro del rango 1000-1800 del patrón A.
- Sin superlativos ni comparativos no sustentados, sin jerga de marketing
  genérica, sin comparación/desprestigio de competidores nombrados —
  verificado, ninguno presente.
