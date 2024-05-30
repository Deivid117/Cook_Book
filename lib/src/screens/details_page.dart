// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:cook_book_app/src/components/tab_ingredients_widget.dart';
import 'package:cook_book_app/src/components/tab_preparation_widget.dart';
import 'package:cook_book_app/src/connection/server_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modulo1_fake_backend/recipe.dart';

class DetailsPage extends StatefulWidget {
  Recipe recipe;
  final ServerController serverController;

  DetailsPage(
      {super.key, required this.recipe, required this.serverController});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool? isFavorite;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                title: Text(widget.recipe.name),
                expandedHeight: 320,
                backgroundColor: Theme.of(context).primaryColor,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: _buildImageProvider(
                              widget.recipe.photo.path, widget.recipe.photo),
                          fit: BoxFit.cover)),
                  child: Container(color: Colors.black.withOpacity(.5)),
                ),
                pinned: true,
                bottom: TabBar(
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.grey[600],
                    indicatorColor: Theme.of(context).primaryColor,
                    indicatorWeight: 4,
                    tabs: const [
                      Tab(
                          child: Text(
                        "Ingredientes",
                        style: TextStyle(fontSize: 18),
                      )),
                      Tab(
                        child: Text(
                          "Preparación",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ]),
                actions: [
                  if (widget.recipe.user.id ==
                      widget.serverController.loggedUser!.id)
                    IconButton(
                        onPressed: () async {
                          final nRecipe = await Navigator.of(context).pushNamed(
                              "/edit_recipe",
                              arguments: widget.recipe);
                          setState(() {
                            widget.recipe = nRecipe as Recipe;
                          });
                        },
                        icon: Icon(Icons.edit)),

                  getFavoriteWidget(),
                  
                  IconButton(
                      onPressed: () {
                        _showAboutIt(context);
                      },
                      icon: Icon(Icons.help_outline))
                ],
              )
            ];
          },
          body: TabBarView(
            children: [
              TabIngredienstWidget(recipe: widget.recipe),
              TabPreparationWidget(recipe: widget.recipe)
            ],
          ),
        ),
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

  Widget getFavoriteWidget() {
    if (isFavorite != null) {
      if (isFavorite == true) {
        return IconButton(
          onPressed: () async {
            await widget.serverController.deleteFavorite(widget.recipe);
            setState(() {
              isFavorite = false;
            });
          },
          icon: const Icon(Icons.favorite),
          color: Colors.red,
        );
      } else {
        return IconButton(
          onPressed: () async {
            await widget.serverController.addFavorite(widget.recipe);
            setState(() {
              isFavorite = true;
            });
          },
          icon: const Icon(Icons.favorite_border),
          color: Colors.white,
        );
      }
    } else {
      return Container(
          margin: const EdgeInsets.all(15),
          width: 25,
          child:
              CircularProgressIndicator(color: Theme.of(context).primaryColor));
    }
  }

  void _showAboutIt(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Acerca de la receta"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Expanded(
                    child: Text(
                      "Nombre: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(widget.recipe.name),
                ],
              ),
              const Divider(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Expanded(
                      child: Text(
                    "Usuario: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                  Text(widget.recipe.user.nickname),
                ],
              ),
              const Divider(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Expanded(
                    child: Text(
                      "Fecha de publicación: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                      "${widget.recipe.date.day}/${widget.recipe.date.month}/${widget.recipe.date.year}"),
                ],
              )
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Cerrar"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    loadState();
  }

  void loadState() async {
    final state = await widget.serverController.getIsFavorite(widget.recipe);
    setState(() {
      isFavorite = state;
    });
  }
}
