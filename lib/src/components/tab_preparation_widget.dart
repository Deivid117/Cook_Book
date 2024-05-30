import 'package:flutter/material.dart';
import 'package:flutter_modulo1_fake_backend/recipe.dart';

class TabPreparationWidget extends StatelessWidget {
  final Recipe recipe;

  const TabPreparationWidget({super.key, required this.recipe});

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
        const Text("Preparación",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 15,
        ),
        Column(
          children: List.generate(recipe.steps.length, (int index) {
            final String step = recipe.steps[index];

            return ListTile(
              leading: Text(
                "${index + 1}",
                style: TextStyle(
                    fontSize: 25,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold),
              ),
              title: Text(step),
            );
          }),
        ),
      ],
    );
  }
}
