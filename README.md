Este proyecto fue creado con Flutter 3.3.10, utilizando la versión estable del canal. Puedes encontrar más información sobre Flutter en el repositorio oficial: https://github.com/flutter/flutter.git

Detalles del Framework:
- Versión: 3.3.10
- Canal: Stable
- Última revisión del Framework: 135454af32 (hace 7 meses)
- Fecha de la última revisión: 2022-12-15 07:36:55 -0800

Detalles del Engine:
- Última revisión del Engine: 3316dd8728

Herramientas utilizadas:
- Dart 2.18.6
- DevTools 2.15.0

Configuración adicional para la app de Android:
Asegúrate de agregar la siguiente línea en el archivo build.gradle del módulo de la app:
compileSdkVersion 33

Configuración adicional para la app de iOS:
Asegúrate de agregar el siguiente código en el archivo Info.plist de la app:
<key>LSApplicationQueriesSchemes</key>
	<array>
		<string>sms</string>
		<string>tel</string>
	</array>

Paquetes utilizados:
- flutter_screenutil: ^5.7.0
  Descripción: Proporciona utilidades para manejar y ajustar el tamaño de la pantalla de manera consistente en diferentes dispositivos y resoluciones en Flutter.

- flutter_svg: ^1.1.6
  Descripción: Permite la representación y visualización de archivos SVG (Scalable Vector Graphics) en aplicaciones Flutter.

- url_launcher: ^6.1.11
  Descripción: Permite el lanzamiento de URLs y números de teléfono desde la aplicación Flutter, abriendo el navegador web o la aplicación de llamadas telefónicas correspondiente.

- dio: ^5.2.1+1
  Descripción: Un poderoso paquete de manejo de solicitudes HTTP en Flutter, que proporciona un cliente HTTP completo y fácil de usar.

- animate_do: ^3.0.2
  Descripción: Proporciona una amplia variedad de animaciones predefinidas y efectos visuales para mejorar la apariencia y la interacción en aplicaciones Flutter.

