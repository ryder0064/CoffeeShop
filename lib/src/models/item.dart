import 'package:coffee_shop/src/models/product.dart';

class Item {
  const Item({
    required this.productId,
    required this.quantity,
  });

  final ProductID productId;
  final int quantity;
}
