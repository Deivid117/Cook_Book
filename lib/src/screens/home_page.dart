import 'package:cook_book_app/src/components/my_drawer.dart';
import 'package:cook_book_app/src/components/recipe_widget.dart';
import 'package:cook_book_app/src/connection/server_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modulo1_fake_backend/recipe.dart';

class HomePage extends StatefulWidget {
  final ServerController serverController;

  const HomePage({super.key, required this.serverController});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("My Cookbook"),
      ),
      drawer: MyDrawer(serverController: widget.serverController),
      body: FutureBuilder<List<Recipe>>(
        future: widget.serverController.getRecipeList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final list = snapshot.data;
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
            return Center(
              child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/add_recipe");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
