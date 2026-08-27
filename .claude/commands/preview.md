---
description: Renderiza el borrador final (es/en) como HTML local para revisar antes de publicar.
---

Este comando no invoca ningún subagente ni cambia `status` — es una
utilidad de lectura para el humano, no un paso del pipeline con gate.

Toda la lógica vive en `scripts/preview.sh` (bash + pandoc, sin LLM).
Preferible correrlo directo desde la terminal — `./scripts/preview.sh
[slug]` — sin pasar por Claude Code, para no gastar tokens en algo
puramente mecánico.

## Qué hacer

1. Corre `scripts/preview.sh` con el slug si el humano lo dio como
   argumento, o sin argumento si solo hay un post en `posts/`.
2. Muestra la salida del script tal cual (rutas generadas y
   advertencias de `[VERIFICAR]` o imágenes pendientes). No
   reprocesar ni resumir con reasoning propio — el script ya hace esa
   lógica.
3. Si el script falla (falta `03-draft-es.md`, falta `pandoc`, slug
   ambiguo, etc.), repite el mensaje de error del script y no
   intentes generar el HTML manualmente en su lugar.
