<h1 align="center"> :man_cook: COOK BOOK :hamburger: </h1>

## Descripción :open_book:

El proyecto es una aplicación móvil Dart diseñada con Flutter, la cual fue realizada durante el [Curso de Flutter y Dart](https://videocursos.co/linea/curso-de-flutter-y-dart/.). La aplicación trata de un manual de cocina donde diferentes usuarios almacenan sus recetas de diversos platillos, con la posibilidad de gestionar sus recetas o modificar la información de su perfil, de igual manera se pueden registrar nuevos usuarios y compartir sus deliciosas recetas.

La aplicación funciona mediante un fake backend proporcionado por el curso e inyectado directamente en el proyecto como una ruta de archivo para poder acceder a los datos de los usuarios y recetas. El backend es necesario para que la aplicación funcione ya que consume de este proyecto toda la información que se muestra en la app.

### Características clave

* **Recetas personalizadas**:<br>

Cada usuario puede crear su propia receta o editar las que ya tiene. ¡Comparte con tus amigos tus mejores platillos y sorpréndelos con tu sazón! :cook: :yum:.

* **Recetas favoritas**:<br>

* **Gestión de perfil**:<br>

Ten la posibilidad de personalizar tu perfil con una foto de tu galería o tómate una selfie con la cámara de tu dispositivo.

## Tecnologías utilizadas :iphone:

* **Flutter**: Es un framework que permite crear aplicaciones nativas para Android, iOS, web y escritorio desde un solo código base. Utiliza un sistema de widgets personalizables para diseñar interfaces modernas y rápidas. 
* **Dart**: Es el lenguaje de programación utilizado por Flutter. Dart se caracteriza por ser simple, eficiente y flexible, ideal para desarrollar interfaces de usuario y aplicaciones de alta velocidad. 
* **Image Picker**: Es un plugin de Flutter que permite a acceder fácilmente a la cámara o galería de imágenes del dispositivo para seleccionar o capturar fotos y videos.

## Estructura del proyecto :hammer_and_wrench:

El proyecto cuenta con una estructura bastante básica de acuerdo a la complejidad del curso: Assets, Components, Connection, Screens, son los módulos con los que cuenta el proyecto.

### Organización modular

* **Assets**: Contiene las imágenes a usar en el proyecto: fotos de perfil de los usuarios, platillos de las recetas y logo de la app.
* **Components**: Son todos los widgets reutilizables en la app.
* **Connection**: Se trata del controlador del facke backend, el cual inicializa la los datos que se mostrarán en la apliación (recetas y usuarios), permite el login, registro, ver las recetas del usuario, así como también editarlas o crear nuevas, etc.
* **Screens**: Son todas las pantallas a las que el usuario puede navegar.

## Requisitos :bookmark_tabs:

1. Android Studio Jellyfish | 2023.3.1 o superior
2. Gradle Version 7.5
3. Kotlin 1.8.10
4. Android API 24 o superior (Android 7+)
5. API Key

## Instalación :arrow_down:

1. Clona el repositorio:
   ```
    git clone https://github.com/Deivid117/Games-App.git
2. Obtén tu API Key :key: registrándote en la siguiente página
https://rawg.io/apidocs

3. Agrega tu API Key en el archivo ***local.properties*** de esta manera<br>
***API_KEY="tu api key"***

4. Ejecuta el proyecto :rocket:

## Capturas :camera:

## Video demostrativo :movie_camera:

## Autor :man_technologist:

*David Huerta* :copyright:	2024

email :email:: deivid.was.here117@gmail.com<br>
linkedin :man_office_worker:: [Perfil LinkedIn](https://www.linkedin.com/in/david-de-jes%C3%BAs-ju%C3%A1rez-huerta-159695241/)
