import 'package:dio/dio.dart';
import 'package:recipe_assistant/models/recipe.dart';
import 'package:recipe_assistant/utils/constants.dart';

class SearchService {
  final Dio _dio = Dio();

  Future<List<Recipe>> searchRecipes(List<String> ingredients) async {
    try {
      final query = '${ingredients.join(' ')} レシピ site:cookpad.com';
      final response = await _dio.get(
        Constants.searchEndpoint,
        queryParameters: {
          'key': Constants.searchApiKey,
          'cx': Constants.searchEngineId,
          'q': query,
        },
      );

      if (response.statusCode == 200) {
        final items = response.data['items'] as List?;
        if (items == null || items.isEmpty) {
          return [];
        }
        return items.map((item) => Recipe.fromJson(item)).toList();
      } else {
        throw Exception('Search API error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to search recipes: $e');
    }
  }
}