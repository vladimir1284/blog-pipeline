---
description: Ejecuta el agente de imágenes sobre el borrador final.
---

Invoca al subagente `imagenes` con la ruta `posts/<slug>/`. Muestra al
humano cada imagen recomendada con su justificación y, si aplica, el
prompt para nano banana en un bloque de código aparte para que sea
fácil de copiar.

Pregunta cuáles recomendaciones acepta, cuáles descarta, y espera a
que el humano indique las rutas finales de las imágenes ya
buscadas/generadas antes de insertarlas en el markdown final.

Actualiza `status: imagenes_planificadas` en `00-config.md`.
