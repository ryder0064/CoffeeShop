import 'package:coffee_shop/src/features/products/domain/product.dart';

class Item {
  const Item({
    required this.productId,
    required this.quantity,
  });

  final ProductID productId;
  final int quantity;
}
