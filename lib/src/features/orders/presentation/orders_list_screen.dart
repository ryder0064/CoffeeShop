import 'package:coffee_shop/src/common_widgets/responsive_center.dart';
import 'package:coffee_shop/src/constants/app_sizes.dart';
import 'package:coffee_shop/src/features/orders/presentation/order_card.dart';
import 'package:coffee_shop/src/localization/string_hardcoded.dart';
import 'package:coffee_shop/src/features/orders/domain/order.dart';
import 'package:flutter/material.dart';

class OrdersListScreen extends StatelessWidget {
  const OrdersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Read from data source
    final orders = [
      Order(
        id: 'abc',
        userId: '123',
        items: {
          '1': 1,
          '2': 2,
          '3': 3,
        },
        orderStatus: OrderStatus.confirmed,
        orderDate: DateTime.now(),
        total: 104,
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'.hardcoded),
      ),
      body: orders.isEmpty
          ? Center(
              child: Text(
                'No previous orders'.hardcoded,
                style: Theme.of(context).textTheme.displaySmall,
                textAlign: TextAlign.center,
              ),
            )
          : CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) => ResponsiveCenter(
                      padding: const EdgeInsets.all(Sizes.p8),
                      child: OrderCard(
                        order: orders[index],
                      ),
                    ),
                    childCount: orders.length,
                  ),
                ),
              ],
            ),
    );
  }
}
