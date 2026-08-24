---
description: Arranca un post nuevo a partir de tema, blog destino, e ideas clave.
---

Pide al humano, si no los dio ya en el mensaje: slug del post (para la
carpeta), `blog_slug` (debe existir en `blogs.yaml`), tema, tipo_post
(A/B/C, default A), e ideas clave que no deben faltar.

Crea `posts/<slug-del-post>/00-config.md` con:

```markdown
---
blog_slug: <slug>
tipo_post: <A|B|C>
status: config
---

# Tema
<tema>

# Ideas clave a abordar
- <idea 1>
- <idea 2>
...
```

No avances a investigación automáticamente — confirma con el humano
que el brief está completo antes de sugerir `/investigar`.
