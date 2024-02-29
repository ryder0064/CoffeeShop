typedef ProductID = String;

class Product {
  const Product({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.price,
    this.avgRating = 0,
    this.numRatings = 0,
  });

  final ProductID id;
  final String imageUrl;
  final String title;
  final String description;
  final double price;
  final double avgRating;
  final int numRatings;
}
