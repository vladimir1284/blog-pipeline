---
name: guia-editorial
description: >
  Límites editoriales y éticos aplicables a todos los posts, sin
  importar el blog o el patrón narrativo. La consulta principalmente
  el agente crítico al revisar un borrador, y de forma secundaria el
  redactor y el traductor mientras producen texto.
---

# Guía editorial

## Veracidad

- Toda afirmación cuantitativa, comparativa o de rendimiento
  ("X% más rápido", "el hosting más confiable", "reduce costos en Y")
  debe tener respaldo explícito en `01-research.md`. Si no lo tiene:
  - Se reformula como afirmación cualitativa sin número, o
  - Se marca `[VERIFICAR: <qué falta confirmar>]` para el humano.
- No se citan estudios, encuestas o "según expertos" sin fuente
  verificable y trazable en la investigación.
- No se inventan anécdotas de clientes ni casos de uso. Si el post usa
  un caso real, debe venir señalado como tal desde la curación
  (`02-curated.md`), no aparecer por primera vez en el borrador.

## Similitud y originalidad

- El crítico compara estructura y frases del borrador contra las
  fuentes citadas en `01-research.md`. Esto es una revisión de
  **similitud con fuentes conocidas**, no una detección de plagio en
  sentido estricto (no hay comparación contra un índice global de
  internet). Debe reportarse como tal en `04-review.md`.
- Parafrasear una fuente no es suficiente si se copia su estructura
  argumentativa punto por punto; el crítico debe señalar ese patrón
  aunque las palabras exactas cambien.

## Ética comercial

- No se hacen afirmaciones negativas ni comparaciones directas contra
  competidores nombrados, salvo que el blog lo autorice explícitamente
  (ninguno de los tres blogs actuales lo autoriza).
- No se exagera el problema que resuelve el servicio para generar
  urgencia artificial (ej. dramatizar riesgos de seguridad o pérdidas
  económicas sin base real).
- Si el post menciona una funcionalidad, precio, o alcance de servicio,
  debe coincidir con lo que el negocio ofrece actualmente. El crítico
  no puede verificar esto por sí mismo — debe marcarlo como
  `[VERIFICAR CON EL NEGOCIO]` salvo que la fuente esté en la
  investigación.

## Disclosure de IA

- No es necesario declarar en el post que fue asistido por IA, salvo
  que la política del negocio correspondiente lo requiera. Si en el
  futuro algún blog lo requiere, se añade como campo en `blogs.yaml`.

## Bloqueos vs advertencias

El crítico debe clasificar cada hallazgo en `04-review.md` como:

- **BLOQUEO**: impide pasar a traducción/publicación sin corrección
  (afirmación falsa o no verificable presentada como hecho, similitud
  estructural alta con una fuente, violación de "qué evitar" del
  blog).
- **ADVERTENCIA**: el humano decide si corregir o aceptar tal cual
  (frase mejorable, tono levemente distinto al esperado, CTA duplicado).

Nunca se debe autorizar el avance automático del pipeline si hay
BLOQUEOS sin resolver.
