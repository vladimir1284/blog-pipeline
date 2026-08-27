---
description: Ensambla el post final con imágenes y lo publica vía repo-manager.
---

Confirma que `00-config.md` tiene `status: imagenes_subidas` (o
`traducido` si el blog no requiere imágenes) — `/subir-imagenes` ya
insertó las imágenes en los borradores, no requiere paso manual.

Ensambla `posts/<slug>/99-final/<slug>.es.md` y, si aplica,
`<slug>.en.md` combinando el texto aprobado con las imágenes.

Invoca al subagente `repo-manager` con la ruta `posts/<slug>/` para
que publique en el repo correspondiente según `blogs.yaml`.

Actualiza `status: publicado` en `00-config.md` y reporta al humano la
rama creada y los próximos pasos (abrir PR si no fue automático).
