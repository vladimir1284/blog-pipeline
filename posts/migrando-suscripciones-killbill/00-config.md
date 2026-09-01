---
blog_slug: nitza-develop
tipo_post: A
status: publicado
---

# Tema
Migrando un sistema de suscripciones legacy a Killbill sin downtime

# Ideas clave a abordar
- Migración de un sistema grande para un cliente: había que sustituir el motor de suscripciones legacy sin downtime — apagar cobros del sistema viejo y arrancar el nuevo el mismo día, con las suscripciones representando un porcentaje grande de las ventas de la empresa.
- Experiencia previa con un motor de suscripciones propio (cliente de renta de trailers): crear y cobrar órdenes es fácil; los problemas reales llegan con cancelaciones anticipadas, cambios de plan y atrasos de pago — el escenario real, no el ideal de desarrollo.
- Decisión de usar Killbill (motor open source) tras validar que cubría los requerimientos del cliente; esta tarea se pactó primero pero se pausó para atender otras prioridades del proyecto de migración.
- Requisito clave: Killbill no gestiona los métodos de pago directamente — crea órdenes en la tienda en línea basada en BigCommerce. El cliente migró los métodos de pago del sistema legacy a Braintree por su cuenta.
- Elementos críticos no documentados ni probados de antemano, a pesar de que el cliente tenía visión clara del sistema deseado. Se lograron probar cargos automatizados con saldo de tienda y tarjetas de regalo, pero no con métodos de pago guardados hasta ya avanzado el proyecto.
- Requerimiento tardío (casi en producción): cálculo y cobro correcto de impuestos por suscripción, con variedad de estados/países — resuelto con Avalara (mencionar que merece su propia historia aparte).
- Migración de suscripciones a la nueva estructura de base de datos; para el día cero ya existían scripts para cobrar una por una o en lote.
- Una semana cobrando y depurando en caliente con scripts manuales; luego scripts para cobrar todas las suscripciones del día en una sola corrida (con planificación previa).
- Varios meses de cautela antes de dejar que Killbill disparara los cobros automáticamente — el riesgo era detectar un error con "la bestia andando" y tener que resincronizar Killbill con los cobros reales. Casi tres meses hasta que Killbill gestionó todos los cobros.
- Desarrollo de un plugin a la medida para que Killbill se comunicara con un proxy propio, que a su vez crea la orden y cobra en BigCommerce.
- Requerimientos específicos y complicaciones reales: pagos parciales de una orden, políticas específicas de cancelación.
- Estado actual: tantos ajustes se han implementado sobre el manejo de Killbill que en la práctica se usa casi como un cronjob — pero todo el sistema de suscripciones sigue llamándose "Killbill" internamente, aunque en próximas versiones se gestionarán las suscripciones sin él.
</content>
