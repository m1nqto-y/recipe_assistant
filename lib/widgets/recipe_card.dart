import 'package:flutter/material.dart';
import 'package:recipe_assistant/models/recipe.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:recipe_assistant/utils/helpers.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  const RecipeCard({super.key, required this.recipe}); // const を追加

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(recipe.title),
        subtitle: const Text('Tap to open'),
        onTap: () async {
          final url = Uri.parse(recipe.link);
          if (await canLaunchUrl(url)) {
            await launchUrl(url);
          } else {
            if (!context.mounted) return; // mounted チェックを追加
            Helpers.showErrorSnackBar(context, 'Cannot open URL');
          }
        },
      ),
    );
  }
}