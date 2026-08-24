---
description: Ejecuta el agente investigador sobre un post existente.
---

Recibe el slug del post. Invoca al subagente `investigador` pasándole
la ruta `posts/<slug>/`. Al terminar, actualiza `status: investigado`
en `00-config.md` y muestra al humano un resumen breve (no el archivo
completo) de cuántos hallazgos se encontraron por idea clave, y cuáles
ideas clave quedaron sin soporte, para que decida si continuar a
`/curar` o pedir una segunda pasada de investigación.
