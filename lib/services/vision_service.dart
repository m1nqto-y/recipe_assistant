import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:recipe_assistant/models/ingredient.dart';
import 'package:recipe_assistant/utils/constants.dart';

class VisionService {
  final Dio _dio = Dio();

  Future<List<Ingredient>> detectIngredients(String imagePath) async {
    try {
      final bytes = await File(imagePath).readAsBytes();
      final base64Image = base64Encode(bytes);

      final response = await _dio.post(
        '${Constants.visionEndpoint}?key=${Constants.visionApiKey}',
        data: {
          'requests': [
            {
              'image': {'content': base64Image},
              'features': [
                {'type': 'LABEL_DETECTION', 'maxResults': 10}
              ]
            }
          ]
        },
      );

      if (response.statusCode == 200) {
        final data = response.data['responses'][0];
        if (data['labelAnnotations'] == null) {
          return [];
        }
        final labels = data['labelAnnotations'] as List;
        return labels.map((item) => Ingredient.fromJson(item)).toList();
      } else {
        throw Exception('Vision API error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to detect ingredients: $e');
    }
  }
}