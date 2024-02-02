import 'package:coffee_shop/src/models/order.dart';

class Purchase {
  const Purchase({
    required this.orderId,
    required this.orderDate,
  });
  final OrderID orderId;
  final DateTime orderDate;
}
