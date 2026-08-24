---
description: Ejecuta el agente redactor para producir el borrador en español.
---

Confirma que `posts/<slug>/00-config.md` tiene `status: curado` antes
de continuar; si no, avisa y detente.

Invoca al subagente `redactor` con la ruta `posts/<slug>/`. Al
terminar, muestra el borrador completo al humano (esta etapa sí
conviene leerla entera, no un resumen) y pregunta si pasa directo a
`/revisar` o si quiere ajustes manuales primero.

Actualiza `status: redactado` en `00-config.md`.
