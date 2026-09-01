# Investigación: Migrando un sistema de suscripciones legacy a Killbill sin downtime

Nota metodológica: la mayoría de las ideas clave de este brief son la crónica interna
del propio proyecto del cliente (decisiones, cronología, plugin a la medida, scripts
de cobro, etc.). Esos detalles **no son investigables externamente** — son fuente
primaria del equipo y quedan fuera del alcance de este documento; se marcan
explícitamente como tales abajo. La investigación externa aplica solo a las piezas
verificables sobre las plataformas involucradas: Killbill, BigCommerce, Braintree y
Avalara, más contexto general sobre por qué construir un motor de suscripciones
propio es difícil.

## Hallazgos por idea clave

### Migración de un sistema grande sin downtime (apagar el motor legacy y arrancar el nuevo el mismo día)
- Hallazgo: Killbill tiene una guía oficial de migración que asume explícitamente un
  escenario de "zero-downtime migration en un sistema vivo". El enfoque no es un corte
  único de todo el sistema, sino una migración **cuenta por cuenta**, cada una con su
  propio `cutOverDate` (fecha en la que esa cuenta específica pasa a ser gestionada por
  Killbill). Las cuentas nuevas migran primero vía `newAccountCutOverDate`, y el sistema
  legacy sigue operando en paralelo para las cuentas aún no migradas.
  Fuente: https://docs.killbill.io/latest/migration_guide
- Hallazgo: el flujo recomendado por Killbill es: (1) transferir datos de cuenta, (2)
  recrear las suscripciones activas en Killbill, (3) deshabilitar el auto-invoicing
  durante la transición, (4) cancelar las suscripciones legacy una vez Killbill toma el
  control, (5) reactivar el auto-invoicing. Además, recomienda migrar solo el **estado
  actual** de la suscripción (plan vigente y próxima fecha de cobro), no todo el
  historial de fases pasadas, dejando ese historial en el sistema legacy.
  Fuente: https://docs.killbill.io/latest/migration_guide
- Hallazgo: la guía distingue dos fechas clave por suscripción — la fecha de
  "entitlement" (cuándo arrancó el servicio, para preservar historial) y la fecha de
  "billing" (cuándo retoma el cobro, alineada al próximo ciclo de facturación) — para
  evitar tanto huecos de servicio como doble cobro en el intervalo entre el cutover de
  la cuenta y el siguiente evento de facturación.
  Fuente: https://docs.killbill.io/latest/migration_guide
- Confirma que el enfoque cuenta-por-cuenta / cutover incremental descrito en el brief
  (en vez de un big-bang total) coincide con el patrón que el propio proyecto de
  Killbill documenta y recomienda para este tipo de migración.

### Experiencia previa con motor de suscripciones propio (cliente de renta de trailers): crear/cobrar es fácil, lo difícil son cancelaciones, cambios de plan y atrasos de pago
- Esta idea es una anécdota/experiencia previa del propio equipo con otro cliente — no
  es investigable externamente como caso puntual. Sin embargo, hay respaldo general de
  la industria sobre por qué ese patrón (fácil crear, difícil todo lo demás) es
  consistente y bien documentado:
- Hallazgo: la proración en cambios de plan (upgrades/downgrades) es señalada como "la
  parte de la facturación por suscripción que nadie explica hasta que el equipo de
  finanzas empieza a preguntar por qué el MRR no cuadra"; el aspecto más complejo de
  modificar suscripciones existentes es justamente la proración.
  Fuente: https://dodopayments.com/blogs/subscription-upgrade-downgrade-proration
- Hallazgo: los cambios de plan a mitad de ciclo "suenan simples hasta que los haces
  para 500 clientes a la vez", que es el punto donde la mayoría de los sistemas de
  facturación caseros empiezan a romperse; si un cargo prorrateado de un upgrade falla,
  hay que decidir si el usuario conserva el acceso al plan superior mientras se
  resuelve — un caso borde que rara vez se contempla en el diseño inicial.
  Fuente: https://www.kinde.com/learn/billing/plans/proration-explained-how-to-handle-subscription-upgrades-and-downgrades-fairly-and-efficiently/
- Hallazgo: el dunning (la secuencia de reintentos, recordatorios y escalamiento tras
  un pago fallido) se describe como "una de las cosas de mayor retorno que se pueden
  automatizar" en sistemas de suscripción, precisamente porque a mano es propenso a
  fugas de ingreso.
  Fuente: https://flexprice.io/blog/subscription-management-guide
- Killbill mismo resuelve esto de forma nativa vía su módulo de Overdue: reintentos
  automáticos de pago con calendario configurable (por defecto 8, 8, 8 días) y estados
  configurables de mora (ej. WARNING, BLOCKED, CANCELLATION) que se integran con la
  gestión de entitlements.
  Fuente: https://docs.killbill.io/0.20/overdue ; https://blog.killbill.io/blog/automated-dunning-for-overdue-payments/

### Decisión de usar Killbill tras validar que cubría los requerimientos del cliente
- Hallazgo (soporte de capacidades, no de la decisión en sí, que es interna): Killbill
  es un motor de facturación/suscripción open source y autohospedable. Su núcleo
  gestiona catálogo (productos, planes, fases, precios), el ciclo de vida de la
  suscripción (alta, renovación, upgrade, downgrade, pausa, cancelación), el motor de
  invoicing (facturas, reparaciones, créditos, ajustes) y el motor de pagos (intentos
  de cobro, estado del pago).
  Fuente: https://killbill.io/overview ; https://killbill.io/platform/plugin-integrations
- La decisión concreta de "esto cubre los requerimientos del cliente" y la pausa por
  otras prioridades del proyecto son hechos internos del proyecto — no verificables
  externamente.

### Killbill no gestiona los métodos de pago directamente — crea órdenes en BigCommerce; el cliente migró métodos de pago a Braintree
- Hallazgo: por diseño, Killbill **no almacena datos de métodos de pago**; eso lo
  maneja el gateway. Cuando se añade un método de pago, Killbill invoca
  `addPaymentMethod` en el plugin de pago correspondiente, y ese plugin hace la llamada
  específica al gateway para guardar el token del método de pago. Killbill guarda
  referencias/metadatos; el gateway (vía el plugin) guarda los datos sensibles reales.
  Esto es una decisión explícita de diseño para simplificar el cumplimiento PCI.
  Fuente: https://docs.killbill.io/0.20/payment_plugin ; https://docs.killbill.io/0.18/faq
- Hallazgo: Braintree almacena los métodos de pago del cliente en su "Vault"; al
  guardar un método de pago se genera un `paymentMethodToken` que la aplicación puede
  guardar en su propia base de datos y reutilizar para crear transacciones futuras sin
  volver a tocar el número de tarjeta real. El flujo típico usa un
  `payment method nonce` de un solo uso (expira a las 3 horas o al primer uso) que el
  servidor intercambia por un token permanente; un mismo `customer id` de Braintree
  puede tener múltiples métodos de pago asociados.
  Fuente: https://developer.paypal.com/braintree/articles/control-panel/vault/overview ; https://developer.paypal.com/braintree/graphql/guides/payment_methods/
- Esto confirma la arquitectura descrita en el brief: Killbill orquesta el ciclo de
  suscripción pero delega el manejo real del dinero/tarjeta a un plugin que habla con
  el gateway (en este caso, indirectamente, con BigCommerce/Braintree vía el proxy
  propio del proyecto).
- El detalle de que "el cliente migró los métodos de pago del sistema legacy a
  Braintree por su cuenta" es un hecho interno del proyecto, no verificable
  externamente.

### Cargos automatizados probados primero con saldo de tienda y tarjetas de regalo, luego con métodos de pago guardados
- Hallazgo: la API de BigCommerce sí soporta gift certificates (tarjetas de regalo)
  programáticamente — crear, actualizar y eliminar vía la Gift Certificates API — y el
  Payments API soporta gift certificate como método de pago. También soporta store
  credit (saldo de tienda) como forma de pago en el checkout, con la particularidad de
  que el store credit **no está disponible para compradores invitados** (guest
  checkout) — solo para cuentas de cliente registradas.
  Fuente: https://developer.bigcommerce.com/docs/rest-content/marketing/gift-certificates ; https://developer.bigcommerce.com/docs/store-operations/payments
- Hallazgo: al crear una orden vía la Orders API de BigCommerce para luego cobrarla con
  la Payments API, la orden debe crearse con `status_id: 0` (Incomplete); si no se
  crea en ese estado, la Payments API devuelve error. Si el store credit y/o gift
  certificate cubren el monto completo de la orden, esta pasa directamente a estado
  "Awaiting Fulfillment" (sin necesidad de gateway de tarjeta).
  Fuente: https://developer.bigcommerce.com/docs/store-operations/payments
- Esto es consistente con por qué en el proyecto fue más simple/rápido validar cobros
  automatizados con saldo de tienda y tarjetas de regalo primero (flujos con soporte
  API directo y sin gateway externo de por medio) y más lento/riesgoso con métodos de
  pago guardados en Braintree (requiere el ciclo completo tokenización → nonce → token
  permanente → cargo, con más piezas moviéndose). El detalle de "hasta ya avanzado el
  proyecto" es un hecho interno del caso, no verificable externamente.

### Requerimiento tardío de impuestos por suscripción según estado/país — resuelto con Avalara
- Hallazgo: las reglas de sales tax para software y SaaS varían "considerablemente" de
  estado a estado en EE.UU.; según Avalara, estos productos/servicios se gravan de
  "450 formas distintas a lo largo de 45 categorías" (cifra propia de Avalara, no
  auditada por terceros en esta búsqueda — tratar como cifra de marketing propia del
  proveedor). Los modelos de suscripción para SaaS suelen basar el impuesto en la
  ubicación donde se **consume** el servicio, no necesariamente donde se emite la
  factura.
  Fuente: https://www.avalara.com/blog/en/north-america/2020/11/how-to-tax-recurring-subscription-sales-of-software-and-saas.html
- Hallazgo: AvaTax (el motor de Avalara) se integra con plataformas de recurring
  billing y calcula el impuesto aplicando reglas de "sourcing" (origen) automáticas
  según la dirección del vendedor y la dirección de envío/consumo del comprador.
  Fuente: https://www.avalara.com/blog/en/north-america/2026/07/5-subscription-sales-tax-risks-for-growing-businesses.html
- Hallazgo: Avalara señala como riesgo específico de negocios de suscripción que
  cambios en productos, precios, ubicación del cliente, reglas fiscales o estatus de
  exención pueden alterar el cálculo de impuestos entre un ciclo de cobro y el
  siguiente — por lo que integrar el cálculo de impuestos directamente en el flujo de
  facturación (en vez de calcularlo una sola vez al inicio de la suscripción) reduce
  el riesgo de errores.
  Fuente: https://www.avalara.com/blog/en/north-america/2026/07/5-subscription-sales-tax-risks-for-growing-businesses.html
- El hecho de que este requerimiento llegó tarde en el proyecto del cliente y que
  "merece su propia historia aparte" es una decisión editorial/hecho interno, no
  investigable externamente.

### Migración de suscripciones a la nueva estructura de base de datos; scripts de cobro uno por uno o en lote para el día cero
- No aplica a investigación externa: es la ejecución técnica interna del propio
  proyecto (scripts propios, estructura de datos propia). No hay fuente pública sobre
  la implementación específica de este cliente.
- Contexto de soporte (parcial): la guía oficial de migración de Killbill sí
  contempla el concepto de recrear suscripciones activas en Killbill preservando plan
  vigente y próxima fecha de cobro (ver hallazgo en la sección de migración sin
  downtime arriba), que es el tipo de trabajo que estos scripts probablemente
  alimentaban — pero el diseño concreto de los scripts es interno.

### Una semana de cobro/depuración manual, luego corrida diaria en lote; meses de cautela antes de automatizar con Killbill; casi tres meses hasta gestión completa
- No aplica a investigación externa: es cronología y decisiones operativas internas
  del proyecto (cuánto tiempo se esperó, por qué, cuántos meses). No existe fuente
  pública verificable sobre los tiempos internos de este cliente específico.

### Plugin a la medida para que Killbill hable con un proxy propio que crea la orden y cobra en BigCommerce
- Hallazgo (arquitectura general que hace esto posible, no el plugin específico del
  cliente): los plugins de Killbill se desarrollan sobre el framework OSGi (Java),
  empaquetados como bundles con su propio classloader y ciclo de vida — se pueden
  desplegar, actualizar o revertir sin tocar el núcleo. Un plugin que falla no derriba
  el core de Killbill; los errores quedan aislados y pueden disparar alertas.
  Fuente: https://blog.killbill.io/blog/kill-bill-plugins-architecture/ ; https://docs.killbill.io/latest/plugin_development
- Hallazgo: además de plugins Java/OSGi, Killbill soporta plugins en Ruby (apps
  Rack/Sinatra) que el propio contenedor de Killbill proxea automáticamente, y la
  documentación recomienda usar NGINX como proxy para reenviar notificaciones externas
  hacia Killbill.
  Fuente: https://docs.killbill.io/latest/plugin_development
- Hallazgo: existen plugins de pago pre-construidos de referencia (Stripe, Adyen,
  PayPal) que sirven como punto de partida arquitectónico para plugins de pago a la
  medida, aunque ninguno es específico a BigCommerce/Braintree combinados de la forma
  en que este proyecto los integró.
  Fuente: https://github.com/killbill/killbill-stripe-plugin ; https://blog.killbill.io/blog/open-source-plugins-to-extend-kill-bills-functionality/
- El diseño específico del plugin del cliente (comunicación con su proxy propio, que
  a su vez crea la orden y cobra en BigCommerce) es un desarrollo interno del
  proyecto — no hay fuente pública sobre ese plugin en particular.

### Pagos parciales de una orden; políticas específicas de cancelación
- Hallazgo: Killbill sí soporta pagos parciales contra una factura (invoice) — por
  defecto un pago cubre una factura completa, pero Killbill permite múltiples pagos
  parciales contra una misma factura pendiente o parcialmente pagada. Limitación
  documentada: **no** soporta (a la fecha de la documentación revisada) un solo pago
  que cubra múltiples facturas distintas.
  Fuente: https://killbill.github.io/slate/invoice-payment.html ; https://docs.killbill.io/0.24/userguide_payment
- Hallazgo: sobre políticas de cancelación, Killbill distingue cancelación
  **inmediata** (genera crédito prorrateado, salvo que coincida exactamente con la
  fecha "charged through" de la suscripción) de cancelación **end-of-term/EOT**
  (`entitlementPolicy=END_OF_TERM` y `billingPolicy=END_OF_TERM`), que no genera
  proración y mantiene el servicio activo hasta el fin del periodo ya pagado.
  Fuente: https://docs.killbill.io/0.20/overdue ; https://killbill.github.io/slate/subscription.html
- Las "políticas específicas de cancelación" concretas que pidió el cliente
  (reglas de negocio propias más allá de las opciones nativas de Killbill) son un
  requerimiento interno del proyecto, no verificable externamente — pero la
  limitación de "un pago no puede cubrir múltiples facturas" es un dato objetivo de la
  plataforma que probablemente explica por qué el escenario de pagos parciales exigió
  trabajo adicional (a nivel de plugin/proxy) para encajar con las políticas del
  cliente.

### Estado actual: Killbill usado casi como cronjob; en próximas versiones se gestionarán suscripciones sin él
- No aplica a investigación externa: es una valoración/decisión de arquitectura futura
  interna del equipo sobre su propio sistema. No hay fuente pública sobre el estado
  interno de este sistema del cliente.

## Datos y cifras verificables
- Retry schedule por defecto de Killbill ante pago fallido: 8, 8, 8 (días) — Fuente: https://docs.killbill.io/0.20/overdue
- Killbill soporta múltiples pagos parciales contra una misma factura, pero no un pago único contra múltiples facturas — Fuente: https://killbill.github.io/slate/invoice-payment.html
- BigCommerce: para cobrar una orden creada vía Orders API con la Payments API, la orden debe crearse con `status_id: 0` (Incomplete) — Fuente: https://developer.bigcommerce.com/docs/store-operations/payments
- BigCommerce: el store credit no está disponible para compradores invitados (guest checkout), solo cuentas registradas — Fuente: https://developer.bigcommerce.com/docs/store-operations/payments
- Braintree: el payment method nonce expira a las 3 horas o al primer uso, lo que ocurra primero — Fuente: https://developer.paypal.com/braintree/graphql/guides/payment_methods/
- Cifra citada por Avalara (fuente propia del proveedor, no verificada por terceros): software/SaaS gravado de "450 formas distintas en 45 categorías" en EE.UU. — Fuente: https://www.avalara.com/blog/en/north-america/2020/11/how-to-tax-recurring-subscription-sales-of-software-and-saas.html

## Anécdotas o casos reales encontrados
- No se encontró un caso público documentado de una migración a Killbill equivalente a la de este proyecto (integración con BigCommerce + Braintree + Avalara, sin downtime). La búsqueda arrojó un caso de migración de billing (Brightspeed, 2M+ cuentas) pero corresponde a una migración a SAP BRIM, no a Killbill — no es una fuente aplicable a este post y no debe citarse como precedente de Killbill.
  Fuente (descartada, no usar como precedente de Killbill): mencionada en resultados de búsqueda sin URL verificable directa a un case study oficial.

## Ideas clave sin soporte encontrado
- Ninguna de las ideas clave verificables externamente quedó sin soporte: se encontró documentación oficial aplicable a cada una (Killbill, BigCommerce, Braintree, Avalara). Las ideas puramente anecdóticas/internas del caso del cliente (cronología exacta, decisiones de priorización, plugin específico, estado interno actual del sistema) no aplican a este documento de investigación externa por definición del brief — son fuente primaria que el redactor debe tomar de la curación humana, no de esta investigación.

## Ángulos adicionales relevantes (no pedidos, pero útiles)
- Killbill aísla sus plugins en contenedores OSGi independientes: un plugin que falla no derriba el core ni bloquea el procesamiento general — dato útil si el post quiere explicar por qué el plugin a la medida no puso en riesgo el resto del sistema durante el desarrollo. Fuente: https://blog.killbill.io/blog/kill-bill-plugins-architecture/
- La guía oficial de migración de Killbill recomienda explícitamente NO migrar el historial completo de fases/facturas pasadas, solo el estado vigente — un ángulo útil para contrastar con lo que el equipo del cliente decidió hacer en la práctica (si aplicó el mismo criterio o no, es pregunta para la curación humana). Fuente: https://docs.killbill.io/latest/migration_guide
- Avalara documenta como riesgo específico de negocios de suscripción que un cambio de dirección del cliente, de producto o de precio entre un ciclo de cobro y otro puede alterar el impuesto aplicable — relevante para explicar por qué el requerimiento de impuestos "llegó tarde" no es solo un descuido de alcance, sino un problema estructural de este tipo de negocio. Fuente: https://www.avalara.com/blog/en/north-america/2026/07/5-subscription-sales-tax-risks-for-growing-businesses.html
