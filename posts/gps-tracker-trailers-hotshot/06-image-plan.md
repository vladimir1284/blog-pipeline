# Plan de imágenes: GPS tracker para trailers de hotshot (Towit Houston)

> Nota de alcance (actualizado por decisión explícita del humano): se usan
> TODAS las imágenes reales provistas en `images/raw/GPS/` (22 archivos) más
> una imagen de portada generada por IA que el humano proveyó directamente
> (no generada por el agente `imagenes`, que nunca genera/busca imágenes).
> Esto excede ampliamente el tope habitual de 2-3 imágenes del patrón A —
> es una decisión consciente del humano, no un defecto del plan: el post
> narra una iteración de hardware en 5 pasos y cada paso tiene respaldo
> fotográfico real.
>
> Todas las rutas son relativas a `images/raw/` (la portada está suelta en
> `images/raw/portada_ia.png`; el resto vive bajo `images/raw/GPS/<carpeta>/`).
>
> Corrección de alcance heredada de la versión anterior de este plan: la
> carpeta `V4/` no corresponde a la placa comercial LilyGo (quinta
> iteración) sino a la PCB propia a la medida con serigrafía "TWT" (cuarta
> iteración) — confirmado por serigrafía, MiniSIM y conectores u.FL visibles
> en los renders/fotos. Las fotos reales de la LilyGo comercial (quinta
> iteración) las agregó el humano después, sueltas en la raíz de `GPS/`
> (`16.png`, `17.png` — placa con serigrafía "LILYGO" y módulo SIM7000G
> visible).

## Portada
Ubicación: después de la introducción (antes de "Primera iteración")
Archivo: `portada_ia.png`
Origen: imagen generada por IA, provista directamente por el humano (no
banco de archivo, no generada por el agente `imagenes`).
Descripción: ilustración isométrica que resume el recorrido completo —
placas con cableado enredado a la izquierda, capas de PCB consolidándose al
centro (MCU + celular + GPS), lupa sobre un chip, y a la derecha el
resultado final: un tracker dentro de su caja viajando con un trailer.
Alt-text/caption sugerido: "De varias placas separadas y cableadas a mano a
una sola PCB integrada: el recorrido de iteración del GPS tracker para
trailers de hotshot."

## Primera iteración — Arduino Nano (carpeta `GPS/V1/`)
Ubicación: dentro de "Primera iteración: Arduino Nano y componentes en placas separadas", después del primer párrafo
- `GPS/V1/IMG-20211226-WA0001.jpg` — principal. Stack de shield celular apilado sobre el Arduino Nano (etiqueta "NANO" visible).
  Alt-text: "Primer prototipo: módulo celular apilado sobre un Arduino Nano en protoboard."
- `GPS/V1/IMG-20211206-WA0001_preview.jpeg` — detalle. Módulo GPS NEO-6M (placa azul "GY-GPSV3-NEO") conectado en la misma protoboard, con el módulo celular visible al fondo.
  Alt-text: "Módulo GPS NEO-6M conectado en protoboard junto al módulo celular, primera iteración."

## Segunda iteración — ESP32 con módulos externos (carpeta `GPS/V2/`)
Ubicación: dentro de "Segunda iteración: ESP32 con módulos externos (SIM7020G + GPS)", después del primer párrafo
- `GPS/V2/IMG-20220109-WA0011.jpg` — principal. Toma cenital del ESP32 conectado al módulo GPS NEO-6M y su antena externa.
  Alt-text: "ESP32 conectado al módulo GPS NEO-6M y a la antena GPS externa, segunda iteración."
- `GPS/V2/IMG-20220120-WA0011.png` — detalle. ESP32 en protoboard cableado a un shield celular (módulo SIM7000-series marca Botletics) usado durante las pruebas de conectividad de esta etapa.
  Alt-text: "ESP32 cableado a un shield celular durante las pruebas de conectividad de la segunda iteración."
- `GPS/V2/IMG-20220131-WA0011.png` — detalle. Misma protoboard en otra sesión de prueba, con un módulo regulador/boost adicional conectado.
  Alt-text: "Banco de pruebas de la segunda iteración con el módulo regulador de energía conectado."

## Tercera iteración — placa reguladora LDO propia (carpeta `GPS/V3/`)
Ubicación: dentro de "Tercera iteración: Placa propia para regulación LDO de bajo consumo", después del párrafo que menciona la placa diseñada
- `GPS/V3/IMG-20220221-WA0055.jpg` — principal. Foto de producto de la placa adaptadora propia terminada, con el ESP32-WROOM-32D soldado encima.
  Alt-text: "Placa reguladora de bajo consumo diseñada a medida para alimentar el ESP32, con el módulo soldado sobre ella."
- `GPS/V3/Captura de pantalla de 2022-02-08 10-11-39.png` — detalle de diseño. Render 3D del diseño de la placa reguladora (etiquetas VBR, SWT, TX/RX/3.3/GND/IO0).
  Alt-text: "Render 3D del diseño de la placa reguladora propia antes de fabricarla."
- `GPS/V3/pcb.png` — detalle de diseño. Vista de ruteo de pistas de la misma placa reguladora.
  Alt-text: "Vista de ruteo de pistas de la placa reguladora de bajo consumo."
- `GPS/V3/photo1654209078.jpeg` — detalle. Primer plano del ESP32-WROOM-32 soldado sobre la placa física ya fabricada.
  Alt-text: "Primer plano del ESP32-WROOM-32 soldado sobre la placa reguladora ya fabricada."
- `GPS/V3/IMG-20220221-WA0054.jpg` — detalle de banco de pruebas. ESP32 + placa reguladora + shield celular conectados para prueba conjunta.
  Alt-text: "Banco de pruebas de la placa reguladora propia junto al módulo celular, tercera iteración."
- `GPS/V3/IMG-20220222-WA0092.jpg` — detalle de banco de pruebas. Otra sesión de prueba del mismo conjunto.
  Alt-text: "Segunda sesión de pruebas de la placa reguladora propia con el módulo celular conectado."

## Cuarta iteración — PCB a la medida (carpeta `GPS/V4/`)
Ubicación: dentro de "Cuarta iteración: PCB a la medida (ESP32 + chip SIM7020G soldados)", después del segundo párrafo
- `GPS/V4/aa90745a-6639-45c7-abfa-55279f0d92c8.jpeg` — principal. Toma general de la PCB a la medida terminada, serigrafía "TWT", con ESP32, módem celular, zócalo MiniSIM y conectores GPS/LTE.
  Alt-text: "PCB a la medida con el ESP32 y el módem celular soldados directamente, eliminando los cables sueltos entre componentes."
- `GPS/V4/front_3d.png` — detalle de diseño. Render 3D del diseño completo de la placa (cara frontal).
  Alt-text: "Render 3D de la PCB a la medida, con los conectores GPS/LTE, zócalo MiniSIM y etapa de carga."
- `GPS/V4/front_2d.png` — detalle de diseño. Vista 2D plana de la misma cara.
  Alt-text: "Vista de diseño 2D de la cara frontal de la PCB a la medida."
- `GPS/V4/back_2d.png` — detalle de diseño. Vista 2D de la cara posterior.
  Alt-text: "Vista de diseño 2D de la cara posterior de la PCB a la medida."
- `GPS/V4/photo1654209507.jpeg` — detalle. Primer plano del ESP32-WROOM-32 soldado directamente sobre la placa.
  Alt-text: "Primer plano del módulo ESP32-WROOM-32 soldado directamente sobre la PCB a la medida."
- `GPS/V4/photo1654209507 (1).jpeg` — detalle. Primer plano del módem celular SIM7000H soldado en la misma placa.
  Alt-text: "Primer plano del módem celular soldado directamente sobre la PCB a la medida."

## LilyGo SIM7000G (carpeta `GPS/`, archivos sueltos)
Ubicación: dentro de "El giro: una pregunta desde afuera", después del primer párrafo (donde el texto nombra explícitamente la LilyGo). La sección "Quinta iteración: La consolidación en LilyGo SIM7000G" ya no existe como encabezado propio — su contenido de valor (motivo de la migración, analogía de microservicios) se fusionó dentro de "El giro", por pedido explícito del humano.
- `GPS/17.png` — principal. Placa LilyGo comercial con el módulo SIM7000G claramente identificado por su etiqueta.
  Alt-text: "Placa comercial LilyGo con módulo celular SIM7000G integrado, quinta y última iteración."
- `GPS/16.png` — detalle. Vista lateral de la misma placa mostrando el serigrafiado "LILYGO" y el portapilas integrado.
  Alt-text: "Detalle de la placa LilyGo mostrando el portapilas integrado y las etiquetas de pines."

## Diseño mecánico — doble fondo discreto en FreeCAD (carpeta `GPS/Caja/`)
Ubicación: dentro de "El diseño mecánico: un doble fondo discreto en FreeCAD", después del primer párrafo
- `GPS/Caja/IMG-20211213-WA0022.jpg` — principal. Compartimento interior impreso en 3D, armado, sostenido en mano.
  Alt-text: "Compartimento interior impreso en 3D que aloja la placa y la antena dentro de la caja de conexiones del trailer."
- `GPS/Caja/IMG-20211213-WA0026.jpg` — detalle. Piezas impresas en 3D del doble fondo desarmadas sobre un escritorio.
  Alt-text: "Piezas impresas en 3D del compartimento de doble fondo, antes de ensamblar."
- `GPS/Caja/IMG-20211213-WA0039.jpg` — detalle. Pieza del compartimento con sus puntos de fijación (tornillos) sostenida en mano.
  Alt-text: "Detalle de los puntos de fijación del compartimento de doble fondo."

## Resumen de conteo
1 portada + 2 (V1) + 3 (V2) + 6 (V3) + 6 (V4) + 2 (Quinta/LilyGo) + 3 (Caja) = 23 imágenes totales.
