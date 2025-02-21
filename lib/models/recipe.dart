class Recipe {
  final String title;
  final String link;

  Recipe({required this.title, required this.link});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      title: json['title'],
      link: json['link'],
    );
  }
}