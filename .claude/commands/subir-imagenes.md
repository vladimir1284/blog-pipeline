---
description: Convierte y sube al bucket R2 las imágenes que el humano colocó en images/raw/, según el plan aprobado.
---

Confirma que `00-config.md` tiene `status: imagenes_planificadas`. Si
no, detente y pide al humano que corra `/planificar-imagenes` primero
y coloque los archivos originales en `posts/<slug>/images/raw/` según
lo recomendado en `06-image-plan.md`.

Invoca al subagente `medios` con la ruta `posts/<slug>/`. Este agente
sube las imágenes a R2 y además las inserta directamente en
`03-draft-es.md` y `05-draft-en.md` — no requiere que el humano pegue
nada.

Muestra al humano el contenido de `07-images-final.md` (ubicación,
archivo original, dimensiones finales y URL pública de cada imagen) y
un resumen de dónde quedó insertada cada una en los borradores, para
que el humano lo revise antes de `/publicar`.

Actualiza `status: imagenes_subidas` en `00-config.md`.
