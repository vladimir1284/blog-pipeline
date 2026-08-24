---
name: guia-de-estilo
description: >
  Guía narrativa compartida para redactar y traducir posts de blog de
  promoción de servicios tecnológicos (desarrollo de software, hosting,
  y afines). Se usa junto con la entrada correspondiente del blog en
  blogs.yaml (marca, público, voz) para producir el borrador. Aplica
  siempre que el comando /redactar o /traducir esté en ejecución.
---

# Guía de estilo

Esta skill define **cómo se cuenta** un post. La identidad de marca de
cada blog (público, tono, límites, sector) vive en `blogs.yaml` y debe
combinarse con esta guía, no reemplazarla.

## Selección de patrón

El comando de redacción recibe un parámetro `tipo_post` con tres
valores posibles. Si no se especifica, usar **A**.

---

### Patrón A — "Problema real → principio → aplicación" (default)

Uso: posts de fondo, contenido de autoridad, la mayoría de los casos.

- **Apertura**: una situación concreta y específica, con números o un
  caso real (anonimizado si hace falta). Prohibido abrir con frases
  genéricas tipo "en el mundo actual de la tecnología...".
- **Cuerpo**: de esa situación se extrae un principio generalizable,
  sostenido por 2-3 ejemplos o datos verificables (deben venir de
  `01-research.md`, no inventarse).
- **Cierre**: el lector debe poder aplicar el principio a su propio
  caso. El llamado a la acción es implícito ("si esto te suena
  familiar, así lo resolvimos"), nunca un CTA forzado tipo banner.
- **Longitud objetivo**: 1000-1800 palabras.
- **Errores a evitar**: convertir el principio en una lista genérica de
  consejos; perder la anécdota concreta a mitad de artículo.

### Patrón B — "Nota corta con un solo gancho"

Uso: anuncios, notas técnicas breves, actualizaciones de producto.

- **Apertura**: la idea central va en la primera o segunda oración, sin
  preámbulo.
- **Cuerpo**: una sola idea desarrollada. Si aparece una segunda idea
  relevante, se separa en otro post — no se mete aquí.
- **Cierre**: una frase memorable, sin CTA explícito. La autoridad se
  construye por frecuencia y precisión, no por conversión inmediata.
- **Longitud objetivo**: 300-600 palabras.
- **Errores a evitar**: alargar con contexto innecesario; diluir el
  gancho inicial con matices.

### Patrón C — "Anécdota → lección de negocio"

Uso: posts de postura/filosofía de trabajo, decisiones poco comunes.

- **Apertura**: anécdota concreta, idealmente contraintuitiva
  ("todos dicen que hay que hacer X, nosotros hicimos lo contrario").
- **Cuerpo**: se conecta la anécdota a una decisión de negocio o
  técnica, explicando el razonamiento — no solo el resultado.
- **Cierre**: una lección formulada como principio de trabajo, en
  primera persona (refuerza identidad de marca).
- **Longitud objetivo**: 600-1000 palabras.
- **Errores a evitar**: que la lección final sea una moraleja vacía sin
  conexión clara con la anécdota.

---

## Reglas comunes a los tres patrones

1. **Ninguna afirmación cuantitativa o comparativa sin fuente** en
   `01-research.md`. Si no hay fuente, se omite o se marca como
   `[VERIFICAR]` para que el crítico y el humano lo revisen.
2. **Sin superlativos de autoridad no sustentados** ("el mejor",
   "líder del mercado", "el más rápido") salvo que vengan citados de la
   investigación.
3. **Subtítulos solo si el post supera 800 palabras**; por debajo de
   eso, el texto corrido con buena transición basta.
4. **Un solo llamado a la acción por post como máximo**, y coherente
   con `marca.cta_tipica` del blog en `blogs.yaml`. Nunca más de uno.
5. **Frases cortas por defecto**; frases largas solo cuando conectan
   una idea causal ("porque", "lo que significa que"), no por relleno.
6. **Nada de jerga de marketing genérica** ("solución integral",
   "revolucionario", "de vanguardia") salvo que sea coherente con
   `marca.voz` y esté justificado por el contenido.
7. **Aplicar `marca.voz`, `marca.publico` y respetar `marca.evitar`**
   del blog correspondiente en `blogs.yaml` en todo momento — esta
   guía define estructura, la marca define tono y límites.

## Para el traductor (variante en inglés)

- No traducir literalmente modismos o referencias culturales locales;
  sustituir por un equivalente que preserve la función narrativa
  (ejemplo, la especificidad de la anécdota), no solo el significado.
- Si `blogs.yaml` define `marca_en` para ese blog, usar esos valores de
  público/tono en lugar de los de `marca` en español.
- Reportar explícitamente qué adaptaciones culturales se hicieron
  (no solo entregar el texto final) para que el humano las apruebe.
