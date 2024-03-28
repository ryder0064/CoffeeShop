import 'package:coffee_shop/src/features/products/domain/product.dart';

class Item {
  const Item({
    required this.productId,
    required this.quantity,
  });

  final ProductID productId;
  final int quantity;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Item &&
          runtimeType == other.runtimeType &&
          productId == other.productId &&
          quantity == other.quantity;

  @override
  int get hashCode => productId.hashCode ^ quantity.hashCode;
}
