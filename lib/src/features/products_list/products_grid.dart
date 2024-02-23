import 'dart:math';

import 'package:coffee_shop/src/constants/app_sizes.dart';
import 'package:coffee_shop/src/constants/test_products.dart';
import 'package:coffee_shop/src/features/product_page/product_screen.dart';
import 'package:coffee_shop/src/features/products_list/product_card.dart';
import 'package:coffee_shop/src/localization/string_hardcoded.dart';
import 'package:coffee_shop/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:go_router/go_router.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Read from data source
    const products = kTestProducts;
    return products.isEmpty
        ? Center(
            child: Text(
              'No products found'.hardcoded,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          )
        : ProductsLayoutGrid(
            itemCount: products.length,
            itemBuilder: (_, index) {
              final product = products[index];
              return ProductCard(
                product: product,
                onPressed: () => context.goNamed(
                  AppRoute.product.name,
                  pathParameters: {'id': product.id},
                ),
              );
            },
          );
  }
}

class ProductsLayoutGrid extends StatelessWidget {
  const ProductsLayoutGrid({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
  });

  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    // use a LayoutBuilder to determine the crossAxisCount
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      final crossAxisCount = max(1, width ~/ 250);
      final columnSizes = List.generate(crossAxisCount, (_) => 1.fr);
      final numRows = (itemCount / crossAxisCount).ceil();
      final rowSizes = List.generate(numRows, (_) => auto);

      return LayoutGrid(
        columnSizes: columnSizes,
        rowSizes: rowSizes,
        rowGap: Sizes.p24,
        columnGap: Sizes.p24,
        children: [
          for (var i = 0; i < itemCount; i++) itemBuilder(context, i),
        ],
      );
    });
  }
}
