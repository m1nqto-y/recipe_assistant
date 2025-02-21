import 'package:flutter/material.dart';
import 'package:recipe_assistant/models/ingredient.dart';

class IngredientList extends StatelessWidget {
  final List<Ingredient> ingredients;

  const IngredientList({super.key, required this.ingredients});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Detected Ingredients:', style: TextStyle(fontSize: 18)),
        if (ingredients.isEmpty)
          const Text('None detected.')
        else
          ...ingredients
              .map((ingredient) => ListTile(
                    title: Text(ingredient.name),
                    subtitle: Text('Confidence: ${(ingredient.confidence * 100).toStringAsFixed(2)}%'),
                  ))
              .toList(),
      ],
    );
  }
}