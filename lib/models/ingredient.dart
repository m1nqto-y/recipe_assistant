class Ingredient {
  final String name;
  final double confidence;

  Ingredient({required this.name, required this.confidence});

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      name: json['description'],
      confidence: json['score'].toDouble(),
    );
  }
}