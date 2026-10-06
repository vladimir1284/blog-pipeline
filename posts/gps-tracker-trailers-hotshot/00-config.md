---
blog_slug: nitza-develop
tipo_post: A
status: publicado
---

# Tema
Diseño e iteración de un GPS tracker embebido (Arduino Nano → ESP32+SIM7020G → LilyGo SIM7000G) para monitorear trailers de hotshot de un cliente en EEUU (Towit Houston), y la lección de negocio detrás del giro final de diseño.

# Ideas clave a abordar
- Cliente Towit Houston, problema real: trailers robados/abandonados, pérdida de negocio.
- Iteración de hardware: Arduino Nano (binario no cupo) → ESP32 + SIM7020G → LilyGo SIM7000G (simplificó todo).
- Diseño propio de placa reguladora 3.3V eficiente para modo sleep, ahorro de batería.
- Doble fondo en caja de conexiones (FreeCAD) para monitoreo discreto sin que el rentador lo supiera.
- Restricciones reales: trailers sin alimentación eléctrica constante, batería limitada por espacio.
- Backend simple (Django en PythonAnywhere) para visualizar ubicación.
- Giro clave: mirada externa (cliente pregunta "¿por qué no esa placa?") destapa que nunca reevaluaron opción obvia por inercia de diseño.
- Resultado: +20 dispositivos en producción, 75% uptime, recuperación tras +1 mes sin señal.
- Lección de negocio: iterar rápido con lo conocido (Arduino) sirve para validar, pero hay que parar a reevaluar supuestos técnicos con ojos frescos.
