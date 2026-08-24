---
description: Ejecuta el agente crítico sobre el borrador en español.
---

Invoca al subagente `critico` con la ruta `posts/<slug>/`. Al
terminar, muestra al humano el resumen de `04-review.md`: primero los
BLOQUEOS (si hay), luego las ADVERTENCIAS.

Si hay BLOQUEOS, no sugieras avanzar a `/traducir` — pregunta si el
humano quiere corregir manualmente el `03-draft-es.md` o volver a
invocar `/redactar` con instrucciones adicionales.

Si no hay bloqueos, pregunta si el humano quiere resolver alguna
advertencia antes de continuar, y solo entonces sugiere `/traducir`.

Actualiza `status: revisado` en `00-config.md`.
