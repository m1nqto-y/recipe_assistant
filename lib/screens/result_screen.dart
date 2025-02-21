import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_assistant/providers/app_provider.dart';
import 'package:recipe_assistant/widgets/ingredient_list.dart';
import 'package:recipe_assistant/widgets/recipe_card.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Results')),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (provider.errorMessage != null) ...[
                    Text(
                      provider.errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 16),
                  ],
                  IngredientList(ingredients: provider.ingredients),
                  const Divider(),
                  const Text('Recipes:', style: TextStyle(fontSize: 18)),
                  if (provider.recipes.isEmpty)
                    const Text('No recipes found.')
                  else
                    ...provider.recipes.map((recipe) => RecipeCard(recipe: recipe)).toList(),
                ],
              ),
            ),
    );
  }
}