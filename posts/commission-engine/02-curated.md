# Elementos seleccionados para el post

- TSB Bank (2018): migración big-bang bancaria sin plan B, terminó en multa de £62M, más de £32M en compensaciones y renuncia del CEO — respaldo conceptual del riesgo de "no vuelta atrás" (no es paralelo directo: banco, no comisiones/MLM). Fuente: https://www.itpro.com/business-strategy/digital-transformation/354155/tsbs-it-disaster-pinned-on-big-bang-approach-to / https://www.henricodolfing.ch/en/case-study-2-the-epic-meltdown-of-tsb-bank/
- Parallel run sin reconciliación estricta genera falsa sensación de confianza; discrepancias en finanzas/pagos generan confusión sobre en cuál sistema confiar — explica técnicamente por qué los 4 meses de ciclos con bugs eran esperables. Fuente: https://www.shinetechsoftware.com/insights/why-dual-running-needs-reconciliation-in-legacy-migration/
- "Legacy blindness" (Eric Evans, autor de Domain-Driven Design): la familiaridad con el modelo de dominio actual es un obstáculo para pensar diferente sobre el problema — encaja con la decisión del líder de proyecto de entender negocio y matemáticas antes de tocar el código. Fuente: https://gojko.net/2010/06/11/eric-evans-domain-driven-design-redefined/
- CTEs recursivas en SQL como mecanismo estándar para recorrer jerarquías organizacionales, y la dificultad reconocida de modelar jerarquías que cambian en el tiempo (problema documentado en slowly changing dimensions tipo 2) — respaldo técnico de por qué el "pago por generación de directores" era difícil de modelar. Fuente: https://learnsql.com/blog/sql-recursive-cte/ / https://www.certlibrary.com/blog/understanding-and-managing-slowly-changing-dimensions-in-data-modeling/
- Planes binarios/multinivel: un bug pequeño en la lógica de comisiones suele afectar a toda la base de distribuidores a la vez, no a una cuenta aislada — refuerza la tensión narrativa del riesgo. Fuente: https://www.hybridmlm.io/blogs/binary-vs-unilevel-mlm-plan-which-one-is-better/ (fuente de proveedor MLM, usar como apoyo conceptual, no como autoridad citable con peso)
- Spaghetti code / acumulación de lógica condicional por parámetros como deuda técnica documentada empíricamente: estudio arXiv muestra que 2+ ocurrencias de estos anti-patrones aumentan medible mente el tiempo de trabajo y el esfuerzo cognitivo de los desarrolladores — respaldo del "laberinto SQL de 20 años". Fuente: https://arxiv.org/pdf/2009.02438 / https://www.growthbook.io/blog/engineering-guide-feature-flag-technical-debt

# Descartado explícitamente
- Strangler fig pattern (Martin Fowler) — no usar.
- IRS Form 941 línea 7 (redondeo residual en nómina) — no usar.

# Ángulo o énfasis indicado por el humano
Ninguno adicional indicado.
