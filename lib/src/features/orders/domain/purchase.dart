import 'package:coffee_shop/src/features/orders/domain/order.dart';

class Purchase {
  const Purchase({
    required this.orderId,
    required this.orderDate,
  });
  final OrderID orderId;
  final DateTime orderDate;
}
