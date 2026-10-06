# Investigación: GPS tracker embebido para trailers de hotshot (Towit Houston)

**Nota metodológica:** este post es principalmente un relato técnico de primera
mano del equipo de Nitza Develop. Los hechos centrales (cliente, decisiones de
diseño, resultados obtenidos) son experiencia propia y no requieren fuente
externa — se marcan explícitamente como tal abajo. La investigación se enfocó
en el contexto técnico y de mercado que sí necesita respaldo verificable.

## Hallazgos por idea clave

### Cliente Towit Houston, problema real: trailers robados/abandonados, pérdida de negocio.
- Relato interno del equipo, no requiere fuente externa (identidad del
  cliente, casos concretos de robo/abandono que motivaron el proyecto).
- Contexto de mercado que sí es verificable: el robo de cargo/trailers es un
  problema documentado y en crecimiento en EEUU. En 2024 hubo 3,625 incidentes
  de robo de cargo reportados en Norteamérica (+27% interanual), con pérdidas
  reportadas de más de $455M y una pérdida promedio por incidente de
  $202,364. Texas está entre los tres estados más afectados (junto a
  California e Illinois), concentrando el 46% de los robos reportados en 2024.
  Fuente: https://www.freightwaves.com/news/cargo-thefts-spiked-68-in-q4-led-by-food-and-beverage-freight y https://gethapn.com/blog/cargo-theft-statistics/
- Dato adicional sobre recuperación de equipo rentado: la tasa de recuperación
  de equipo rentado por parte de las autoridades es de solo 10-15%, muy por
  debajo del ~60% de recuperación de vehículos robados en general — esto
  respalda la lógica de negocio de invertir en tracking propio en vez de
  depender de la policía.
  Fuente: https://www.gpsinsight.com/blog/best-rental-equipment-trackers-for-your-fleet/
- Sobre "hotshot trucking" como categoría: es transporte de carga con
  camionetas de servicio pesado y trailers (no tractocamiones tradicionales),
  usado para cargas urgentes/tamaño reducido — encaja con el perfil de
  trailers pequeños, rentados, dispersos geográficamente que describe el brief.
  Fuente: https://matrackinc.com/hot-shot-trucking/

### Iteración de hardware: Arduino Nano (binario no cupo) → ESP32 + SIM7020G → LilyGo SIM7000G.
- Arduino Nano usa un ATmega328(P) con 32 KB de flash total, de los cuales
  ~2 KB están reservados para el bootloader, dejando ~30 KB utilizables para
  el sketch. Esto confirma técnicamente por qué un firmware con lógica GPS +
  GSM/red + lógica de negocio puede no caber: es un límite real y bajo
  comparado con microcontroladores más modernos.
  Fuente: https://en.wikipedia.org/wiki/Arduino_Nano
- ESP32 (variante WROOM-32 típica) integra 520 KB de SRAM y 4 MB de flash —
  órdenes de magnitud más que el Nano, lo que explica por qué resolvió el
  problema de espacio de forma inmediata.
  Fuente: https://www.espressif.com/sites/default/files/documentation/esp32_datasheet_en.pdf
- SIM7020G (SIMCom) es un módulo NB-IoT Cat-NB2 de banda global, tamaño
  17.6×15.7mm, rango de alimentación 2.1–3.6V, consumo de 3.4µA en PSM y
  0.4mA en modo sleep — diseñado para IoT de bajo consumo con soporte nativo
  de PSM/eDRX.
  Fuente: https://www.alldatasheet.net/html-pdf/1266610/ETC1/SIM7020G/112/1/SIM7020G.html
- No se encontró un dev-board todo-en-uno de LilyGo llamado "T-SIM7020G": lo
  que existe es el LILYGO PCIE-SIM7020G, un módulo de expansión (no una placa
  integrada), lo que es consistente con que en esta segunda iteración el
  equipo tuvo que integrar manualmente ESP32 + módulo SIM7020G por separado
  (mayor esfuerzo de integración de hardware) antes de pasar a una placa
  todo-en-uno.
  Fuente: https://www.amazon.com/LILYGO-PCIE-SIM7020G-Development-Wireless-Module/dp/B0HC1GHWW4
- LilyGo T-SIM7000G integra ESP32-WROVER-B + módulo SIM7000G (2G/LTE
  Cat-M1/NB-IoT) + GNSS + soporte de batería 18650 + carga solar en una sola
  placa, lo cual respalda la idea de "simplificó todo" al eliminar trabajo de
  integración de hardware discreto.
  Fuente: https://makeradvisor.com/lilygo-t-sim7000g-esp32/

### Diseño propio de placa reguladora 3.3V eficiente para modo sleep, ahorro de batería.
- Relato interno del equipo en cuanto al diseño específico de su placa, no
  requiere fuente externa.
- Contexto técnico verificable que respalda por qué esto importa: un
  regulador LDO genérico común en placas de desarrollo (ej. AMS1117, muy usado
  en boards Arduino/ESP32 chinas) consume entre 5–10 mA de corriente en
  reposo (quiescent current) incluso sin carga — esto por sí solo puede
  dominar el consumo total de un dispositivo en deep sleep, arruinando la
  autonomía de batería. Reguladores de bajo consumo (ej. MCP1700) bajan esto a
  ~1.6 µA, un orden de magnitud (~1000x) menor.
  Fuente: https://www.lcsc.com/blog/ams1117-voltage-regulator-complete-guide/
- Reportes públicos de usuarios en el repositorio oficial de GitHub de LilyGo
  T-SIM7000G documentan que el consumo real en deep sleep varía muchísimo
  según la placa/versión — desde ~300µA (el valor "ideal" citado por LilyGo)
  hasta 30-450mA reportados por distintos usuarios, e incluso 200mA en
  algunos casos — evidenciando que lograr bajo consumo real en estas placas
  no es trivial y suele requerir intervención de hardware (justo el tipo de
  problema que un regulador bien diseñado ataca).
  Fuentes: https://github.com/Xinyuan-LilyGO/LilyGO-T-SIM7000G/issues/247 ,
  https://github.com/Xinyuan-LilyGO/LilyGO-T-SIM7000G/issues/143 ,
  https://github.com/Xinyuan-LilyGO/LilyGO-T-SIM7000G/issues/57
- Las placas LilyGo de esta familia (T-Call-SIM800, T-SIM7000G) suelen usar el
  PMU AXP192 (X-Powers) para gestión de energía y regulación de 3.3V — dato
  de contexto sobre el ecosistema de hardware, no verificado como el chip
  exacto usado por el equipo (serían ellos quienes confirman si el diseño
  propio reemplazó o complementó a este PMU).
  Fuente: https://github.com/Xinyuan-LilyGO/LilyGo-T-Call-SIM800/blob/master/doc/SIM800L_AXP192.MD

### Doble fondo en caja de conexiones (FreeCAD) para monitoreo discreto sin que el rentador lo supiera.
- Relato interno del equipo (diseño mecánico específico), no requiere fuente
  externa.
- Advertencia de contexto relevante (no pedida, pero importante para el
  redactor/crítico): la instalación de GPS trackers en equipo propio que se
  renta a terceros es legal en EEUU en general, pero varios estados exigen
  divulgación explícita en el contrato de renta o consentimiento previo del
  arrendatario (p. ej. California, Nueva Jersey, Luisiana exigen consentimiento
  explícito; otros como Illinois o Missouri lo eximen si la empresa es dueña
  titular del equipo). Si el post da a entender que el tracking se ocultó
  deliberadamente del cliente rentador (no solo que fue discreto físicamente),
  esto podría generar una lectura de "vigilancia oculta" con implicaciones
  legales/reputacionales según el estado. Vale la pena que el redactor sea
  cuidadoso con el framing: "discreto para no interferir con el mecanismo" es
  distinto de "oculto para evitar que el rentador supiera que había
  tracking".
- **Decisión editorial (humano, confirmada):** el borrador debe usar
  "discreto" en el sentido de "no interferir con el mecanismo/estética del
  trailer", nunca "oculto para que el rentador no supiera que había
  tracking". Redactor y crítico deben respetar este framing.
  Fuente: https://www.bouncie.com/blog/gps-tracking-laws-by-state y https://konnectgps.com/blogs/news/gps-tracking-laws-in-the-usa

### Restricciones reales: trailers sin alimentación eléctrica constante, batería limitada por espacio.
- Relato interno del equipo, no requiere fuente externa.
- Dato de contexto técnico verificable: el propio módulo GPS NEO-6M consume
  ~45mA en operación normal (111mW @ 3.0V) y puede bajar a ~11mA en Power
  Save Mode (33mW @ 3.0V) — esto ilustra por qué, sin alimentación externa
  constante, cada mA cuenta y el diseño de bajo consumo (deep sleep,
  regulador eficiente) es central al proyecto y no un detalle opcional.
  Fuente: https://circuitdigest.com/microcontroller-projects/interfacing-neo6m-gps-module-with-esp32 y https://content.u-blox.com/sites/default/files/products/documents/NEO-6_ProductSummary_(GPS.G6-HW-09003).pdf

### Backend simple (Django en PythonAnywhere) para visualizar ubicación.
- PythonAnywhere es un hosting orientado específicamente a Python/Django, sin
  necesidad de configurar servidor, SSH o Docker — entorno preconfigurado con
  Python, pip, virtualenvs, y un plan gratuito viable para prototipos de bajo
  tráfico (1 web app, 512MB de almacenamiento, CPU limitada). Esto respalda la
  elección como "backend simple" para una primera versión funcional, más que
  como solución de escala.
  Fuente: https://www.pythonanywhere.com/details/django_hosting y https://help.pythonanywhere.com/pages/DeployExistingDjangoProject/

### Giro clave: mirada externa (cliente pregunta "¿por qué no esa placa?") destapa que nunca reevaluaron opción obvia por inercia de diseño.
- Relato interno del equipo (la anécdota puntual de la pregunta del cliente),
  no requiere fuente externa. Es el corazón narrativo del post (patrón C:
  anécdota → lección de negocio) y no necesita ni admite respaldo externo.

### Resultado: +20 dispositivos en producción, 75% uptime, recuperación tras +1 mes sin señal.
- Relato interno del equipo / dato propio de producción, no requiere fuente
  externa. No existe (ni debería buscarse) una fuente pública que verifique
  cifras operativas internas de un cliente privado.

### Lección de negocio: iterar rápido con lo conocido (Arduino) sirve para validar, pero hay que parar a reevaluar supuestos técnicos con ojos frescos.
- Es una conclusión/interpretación del propio equipo sobre su experiencia, no
  un hecho verificable externamente. No requiere fuente.

## Datos y cifras verificables

- Arduino Nano / ATmega328: 32 KB flash total, ~2 KB reservados a bootloader,
  ~30 KB utilizables. — Fuente: https://en.wikipedia.org/wiki/Arduino_Nano
- ESP32-WROOM-32: 520 KB SRAM, 4 MB flash, dual-core hasta 240MHz. — Fuente: https://www.espressif.com/sites/default/files/documentation/esp32_datasheet_en.pdf
- SIM800L: cuádruple banda GSM/GPRS (850/900/1800/1900MHz), 0.7mA en sleep,
  requiere 3.8-4.2V / hasta 2A en pico. — Fuente: https://www.makerhero.com/img/files/download/Datasheet_SIM800L.pdf
- SIM7020G: NB-IoT Cat-NB2, 2.1-3.6V, 3.4µA en PSM, 0.4mA en sleep, 5.6mA en
  idle. — Fuente: https://www.alldatasheet.net/html-pdf/1266610/ETC1/SIM7020G/112/1/SIM7020G.html
- NEO-6M GPS: 45mA operación normal, 11mA en Power Save Mode, 2.7-3.6V. —
  Fuente: https://content.u-blox.com/sites/default/files/products/documents/NEO-6_ProductSummary_(GPS.G6-HW-09003).pdf
- AMS1117 (LDO genérico común en boards baratas): 5-10mA de corriente en
  reposo, vs ~1.6µA de un LDO de bajo consumo como el MCP1700. — Fuente: https://www.lcsc.com/blog/ams1117-voltage-regulator-complete-guide/
- Robo de cargo en Norteamérica 2024: 3,625 incidentes reportados (+27%
  interanual), pérdidas >$455M, pérdida promedio $202,364/incidente. Texas,
  California e Illinois concentran el 46% de los casos. — Fuente: https://gethapn.com/blog/cargo-theft-statistics/
- Recuperación de equipo rentado robado por autoridades: 10-15%, frente a
  ~60% de recuperación de vehículos robados en general. — Fuente: https://www.gpsinsight.com/blog/best-rental-equipment-trackers-for-your-fleet/
- Hologram ofrece cobertura celular IoT en 190+ países / 550+ redes (2G, 3G,
  4G LTE, CAT-M, NB-IoT), con planes pay-as-you-go y por volumen; no se
  encontraron tarifas exactas actuales por MB en fuentes públicas (la página
  de pricing oficial requiere selección de plan interactiva). — Fuente:
  https://www.hologram.io/coverage/ y https://www.hologram.io/pricing/

## Anécdotas o casos reales encontrados

- No se encontraron casos públicos de terceros directamente comparables (otra
  empresa haciendo un tracker IoT a medida para trailers de hotshot con la
  misma iteración de hardware). Es un caso de nicho suficientemente específico
  que no hay literatura pública equivalente — refuerza que el valor narrativo
  del post está en el relato propio, no en compararlo con casos externos.
- Reportes de usuarios en GitHub sobre consumo eléctrico inconsistente en
  deep sleep del LilyGo T-SIM7000G (issues #247, #143, #57 del repo oficial)
  sirven como evidencia indirecta de que el problema de consumo en esta
  familia de placas es real y ampliamente reportado por la comunidad, no una
  particularidad exclusiva del proyecto de Nitza Develop.
  Fuente: https://github.com/Xinyuan-LilyGO/LilyGO-T-SIM7000G/issues

## Ideas clave sin soporte encontrado

- Ninguna de las ideas clave del brief requería soporte externo que no se
  haya encontrado. Las que son relato interno del equipo se marcaron como
  tales arriba; las que son técnicas/de mercado sí tienen respaldo citado.
- Excepción parcial: no se encontraron tarifas exactas y actuales de
  Hologram por MB/mes para el mercado de EEUU en fuentes públicas (solo
  estructura general de planes) — si el borrador va a citar un precio
  específico de Hologram, debe marcarse `[VERIFICAR: precio exacto del plan
  de Hologram]` o confirmarse directamente en el dashboard de Hologram, ya que
  no está publicado en texto plano en su sitio.

## Ángulos adicionales relevantes (no pedidos, pero útiles)

- El diferencial de recuperación de equipo rentado (10-15%) vs vehículos en
  general (~60%) es un dato fuerte para reforzar el "por qué" de negocio del
  proyecto sin necesitar cifras internas del cliente.
  Fuente: https://www.gpsinsight.com/blog/best-rental-equipment-trackers-for-your-fleet/
- El ángulo legal sobre divulgación de tracking en contratos de renta (ver
  hallazgo de "doble fondo" arriba) es relevante para que el crítico revise
  el framing exacto que usa el borrador sobre "discreción" vs "ocultamiento".
  Fuente: https://www.bouncie.com/blog/gps-tracking-laws-by-state
- La práctica de la industria de bajo consumo IoT recomienda evitar dev-boards
  de fábrica en producción (LEDs de estado, conversores USB-serie, LDOs
  genéricos) y usar módulos "desnudos" con reguladores de bajo consumo
  seleccionados a medida — esto generaliza la lección técnica del proyecto
  (por qué migrar de una dev-board genérica a un diseño propio de regulador
  fue la jugada correcta) más allá del caso puntual.
  Fuente: https://www.sunfounder.com/blogs/news/how-to-build-an-esp32-low-power-sensor-node-for-long-life-battery-iot-projects
