import 'package:flutter/material.dart';
import 'package:recipe_assistant/models/ingredient.dart';
import 'package:recipe_assistant/models/recipe.dart';
import 'package:recipe_assistant/services/vision_service.dart';
import 'package:recipe_assistant/services/search_service.dart';

class AppProvider with ChangeNotifier {
  List<Ingredient> _ingredients = [];
  List<Recipe> _recipes = [];
  bool _isLoading = false;
  String? _errorMessage; // 追加済みのはずだが、確認のため再定義

  List<Ingredient> get ingredients => _ingredients;
  List<Recipe> get recipes => _recipes;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage; // ゲッターを明示的に追加

  final VisionService _visionService = VisionService();
  final SearchService _searchService = SearchService();

  Future<void> analyzeImage(String imagePath) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _ingredients = await _visionService.detectIngredients(imagePath);
      if (_ingredients.isEmpty) {
        _errorMessage = 'No ingredients detected.';
      } else {
        _recipes = await _searchService.searchRecipes(
          _ingredients.map((i) => i.name).toList(),
        );
        if (_recipes.isEmpty) {
          _errorMessage = 'No recipes found.';
        }
      }
    } catch (e) {
      _errorMessage = e.toString();
      _ingredients = [];
      _recipes = [];
    }

    _isLoading = false;
    notifyListeners();
  }
}