import 'dart:io';

import 'package:cook_book_app/src/connection/server_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modulo1_fake_backend/recipe.dart';

class RecipeWidget extends StatelessWidget {
  final Recipe recipe;
  final ServerController serverController;
  final VoidCallback onChange;

  RecipeWidget({super.key, required this.recipe, required this.serverController, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
      child: GestureDetector(
        onTap: () => _showDetails(context),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Card(
            child: Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: _buildImageProvider(recipe.photo.path, recipe.photo), //AssetImage(recipe.photo.path),
                  fit: BoxFit.cover,
                ),
              ),
              alignment: Alignment.bottomLeft,
              child: Container(
                color: Colors.black.withOpacity(0.35),
                child: ListTile(
                  title: Text(
                    recipe.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    recipe.user.nickname,
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: _getFavoriteWidget(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getFavoriteWidget() {
    return FutureBuilder<bool>(
      future: serverController.getIsFavorite(recipe),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final isFavorite = snapshot.data;
          if (isFavorite == true) {
            return IconButton(
              icon: Icon(Icons.favorite),
              color: Colors.red,
              onPressed: () async {
                await serverController.deleteFavorite(recipe);
                onChange();
              },
              iconSize: 32,
            );
          } else {
            return IconButton(
              icon: Icon(Icons.favorite_border),
              color: Colors.white,
              onPressed: () async {
                await serverController.addFavorite(recipe);
                onChange();
              },
              iconSize: 32,
            );
          }
        } else {
          return CircularProgressIndicator(color: Theme.of(context).primaryColor);
        }
      },
    );
  }
  
  _showDetails(BuildContext context) {
    Navigator.pushNamed(context, "/details", arguments: recipe);
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
