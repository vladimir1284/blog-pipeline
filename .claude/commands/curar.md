---
description: Presenta los hallazgos de la investigación para que el humano seleccione qué usar.
---

Lee `posts/<slug>/01-research.md`. Presenta al humano una lista corta
y accionable (5-8 elementos máximo) de los hallazgos, datos y
anécdotas más relevantes, cada uno con su fuente en una línea. No
reproduzcas el archivo completo — resume para que la decisión sea
rápida.

Pregunta explícitamente cuáles elementos quiere incluir, cuáles
descartar, y si quiere agregar un ángulo propio no cubierto por la
investigación.

Con la respuesta, escribe `posts/<slug>/02-curated.md`:

```markdown
# Elementos seleccionados para el post

- <elemento 1> — Fuente: <...>
- <elemento 2> — Fuente: <...>

# Ángulo o énfasis indicado por el humano
<si aplica>
```

Actualiza `status: curado` en `00-config.md`.
