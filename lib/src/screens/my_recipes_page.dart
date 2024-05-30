import 'package:cook_book_app/src/components/recipe_widget.dart';
import 'package:cook_book_app/src/connection/server_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modulo1_fake_backend/recipe.dart';

class MyRecipesPage extends StatefulWidget {
  final ServerController serverController;

  const MyRecipesPage({super.key, required this.serverController});

  @override
  State<MyRecipesPage> createState() => _MyRecipesPageState();
}

class _MyRecipesPageState extends State<MyRecipesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Mis Recetas"),
      ),
      body: FutureBuilder<List<Recipe>>(
        future: widget.serverController.getUserRecipesList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final list = snapshot.data;

            if (list?.isNotEmpty == true) {
              return ListView.builder(
                  itemCount: list!.length,
                  itemBuilder: (context, index) {
                    Recipe recipe = list[index];

                    return RecipeWidget(
                        recipe: recipe,
                        serverController: widget.serverController,
                        onChange: () {
                          setState(() {});
                        });
                  });
            } else {
              return SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.info,
                        size: 120,
                        color: Colors.grey[300],
                      ),
                      const Text("No hay información por mostrar",
                          textAlign: TextAlign.center)
                    ],
                  ),
                ),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor),
            );
          }
        },
      ),
    );
  }
}
