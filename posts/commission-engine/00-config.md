---
blog_slug: nitza-develop
tipo_post: A
status: publicado
---

# Tema
commission-engine: migración de un sistema legacy de comisiones (20 años) a
un sistema nuevo, sin plan B, y la ingeniería inversa del cálculo de
comisiones más complejo del negocio.

# Ideas clave a abordar
- Migración de sistema legacy de comisiones (20 años) a sistema nuevo, corte
  total sin plan B (apagón a las 23:59 del día 20)
- Convivencia de dos sistemas para el mismo mes (quincenas calculadas por
  sistemas distintos, comisiones pagadas por ambos)
- 4 meses de ciclos de comisiones con bugs, trabajo conjunto con
  departamento de economía/finanzas
- Concepto de "pago por generación de directores" (recursivo tipo MLM), sin
  datos históricos suficientes ni persona experta disponible
- Decisión del líder de proyecto: entender negocio y matemáticas ANTES de
  tocar el código fuente (que siempre estuvo disponible)
- Código legacy como laberinto SQL de 20 años, con parámetros que cambian
  toda la lógica según el año
- Error residual aceptado (~$100 USD sobre pagos de cientos de miles,
  repartido entre miles de consultores)
- Resultado: cliente satisfecho, la empresa les entrega otras tareas del ecosistema tecnológico
