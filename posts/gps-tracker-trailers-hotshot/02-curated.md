# Elementos seleccionados para el post

- Robo de cargo EEUU 2024: 3,625 incidentes (+27% interanual), pérdida promedio $202,364/incidente, Texas entre los tres estados más afectados — Fuente: https://gethapn.com/blog/cargo-theft-statistics/ , https://www.freightwaves.com/news/cargo-thefts-spiked-68-in-q4-led-by-food-and-beverage-freight
- Recuperación de equipo rentado robado por autoridades: solo 10-15%, frente a ~60% de recuperación de vehículos robados en general — Fuente: https://www.gpsinsight.com/blog/best-rental-equipment-trackers-for-your-fleet/
- Arduino Nano (ATmega328): 32KB flash total, ~2KB para bootloader, ~30KB utilizables — límite real que explica por qué el binario no cupo — Fuente: https://en.wikipedia.org/wiki/Arduino_Nano
- ESP32-WROOM-32: 520KB SRAM, 4MB flash — resolvió el problema de espacio de forma inmediata — Fuente: https://www.espressif.com/sites/default/files/documentation/esp32_datasheet_en.pdf
- AMS1117 (LDO genérico común en boards baratas) consume 5-10mA en reposo, vs ~1.6µA de un LDO de bajo consumo (ej. MCP1700) — respalda por qué diseñar un regulador propio importó para la autonomía de batería — Fuente: https://www.lcsc.com/blog/ams1117-voltage-regulator-complete-guide/
- NEO-6M GPS: 45mA en operación normal vs 11mA en Power Save Mode — ilustra por qué cada mA contaba sin alimentación eléctrica externa constante — Fuente: https://circuitdigest.com/microcontroller-projects/interfacing-neo6m-gps-module-with-esp32 , https://content.u-blox.com/sites/default/files/products/documents/NEO-6_ProductSummary_(GPS.G6-HW-09003).pdf
- Advertencia legal (ya resuelta en framing): varios estados de EEUU exigen divulgación de GPS tracking en contrato de renta de equipo. El post debe usar "discreto" (no interferir con el mecanismo/estética del trailer), nunca "oculto" (para que el rentador no supiera que había tracking).

# Ángulo o énfasis indicado por el humano
Ninguno adicional — seguir el relato tal como fue narrado por el humano en el brief, sin ángulo extra.
