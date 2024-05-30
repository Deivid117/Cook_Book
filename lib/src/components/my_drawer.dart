import 'dart:io';

import 'package:cook_book_app/src/connection/server_controller.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  final ServerController serverController;

  const MyDrawer({super.key, required this.serverController});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://th.bing.com/th/id/R.648094e8a0cec92c3206a1e1e804ee77?rik=W2LLBbJ%2bL3MX%2bQ&riu=http%3a%2f%2f4.bp.blogspot.com%2f-u8JRA428uAs%2fTgBqB7L8vNI%2fAAAAAAAAAGk%2fvnAkOo9JlLg%2fw1200-h630-p-k-no-nu%2ffeature_01.jpg&ehk=00jFwhEO7%2f1YedYf9DHlHWl%2f5aRGAFyi%2ffWOQyfXv20%3d&risl=&pid=ImgRaw&r=0"),
                    fit: BoxFit.cover)),
            accountName: Text(
              serverController.loggedUser!.nickname,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            accountEmail: Text(""),
            currentAccountPicture: CircleAvatar(
              backgroundImage:
                _buildImageProvider(serverController.loggedUser!.photo.path, serverController.loggedUser!.photo)
            ),
            onDetailsPressed: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed("/register", arguments: serverController.loggedUser);
            },
          ),
          ListTile(
            title: Text(
              "Mis recetas",
              style: TextStyle(fontSize: 18),
            ),
            leading: Icon(
              Icons.book,
              color: Colors.green,
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed("/my_recipes");
            },
          ),
          ListTile(
            title: Text(
              "Mis favoritos",
              style: TextStyle(fontSize: 18),
            ),
            leading: Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed("/favorites");
            },
          ),
          ListTile(
            title: Text(
              "Cerrar sesión",
              style: TextStyle(fontSize: 18),
            ),
            leading: Icon(
              Icons.power_settings_new,
              color: Colors.cyan,
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, "/");
            },
          )
        ],
      ),
    );
  }

  ImageProvider _buildImageProvider(String path, File photo) {
    if (File(path).existsSync()) {
      // Si se toma una foto o de la galería entonces tomará ese archivo
      return FileImage(photo);
    } else {
      // Si aún no se toma una foto se muestra la foto original del backend fake.
      return AssetImage(path);
    }
  }
}

