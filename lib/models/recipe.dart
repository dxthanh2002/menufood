class Recipe {
  final String id;
  final String title;
  final String imageUrl;
  final String duration;
  final String difficulty;
  final double rating;
  final bool isPopular;

  Recipe({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.duration,
    required this.difficulty,
    required this.rating,
    this.isPopular = false,
  });
}
