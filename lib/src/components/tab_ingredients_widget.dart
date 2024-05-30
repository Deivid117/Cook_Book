import 'package:flutter/material.dart';
import 'package:flutter_modulo1_fake_backend/recipe.dart';

class TabIngredienstWidget extends StatelessWidget {
  final Recipe recipe;

  const TabIngredienstWidget({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          recipe.name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(recipe.description, style: const TextStyle(fontSize: 16)),
        const SizedBox(
          height: 20,
        ),
        const Text("Ingredientes",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 15,
        ),
        Column(
          children: List.generate(recipe.ingredients.length, (int index) {
            
            final String ingredient = recipe.ingredients[index];

            return ListTile(
              leading: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor,
                ),
                height: 15,
                width: 15,
              ),
              title: Text(ingredient),
            );
          }),
        ),
      ],
    );
  }
}
