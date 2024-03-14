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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          imageUrl == other.imageUrl &&
          title == other.title &&
          description == other.description &&
          price == other.price &&
          avgRating == other.avgRating &&
          numRatings == other.numRatings;

  @override
  int get hashCode =>
      id.hashCode ^
      imageUrl.hashCode ^
      title.hashCode ^
      description.hashCode ^
      price.hashCode ^
      avgRating.hashCode ^
      numRatings.hashCode;

  @override
  String toString() {
    return 'Product{id: $id, imageUrl: $imageUrl, title: $title, description: $description, price: $price, avgRating: $avgRating, numRatings: $numRatings}';
  }
}
