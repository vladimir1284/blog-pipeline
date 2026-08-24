---
description: Ejecuta el agente traductor sobre el borrador aprobado.
---

Confirma que `00-config.md` tiene `status: revisado` y que no quedan
BLOQUEOS sin resolver en `04-review.md`. Si el blog no requiere inglés
según `blogs.yaml`, avisa y omite este paso.

Invoca al subagente `traductor` con la ruta `posts/<slug>/`. Al
terminar, muestra al humano el bloque de "ADAPTACIONES CULTURALES
REALIZADAS" de `05-draft-en.md` de forma destacada, separado del
cuerpo del post, para que apruebe o rechace cada adaptación antes de
continuar.

Actualiza `status: traducido` en `00-config.md`.
