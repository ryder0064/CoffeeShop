import 'package:coffee_shop/src/common_widgets/custom_image.dart';
import 'package:coffee_shop/src/constants/app_sizes.dart';
import 'package:coffee_shop/src/features/products/presentation/product_screen/product_average_rating.dart';
import 'package:coffee_shop/src/features/products/domain/product.dart';
import 'package:coffee_shop/src/utils/currency_formatter.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product, this.onPressed});
  final Product product;
  final VoidCallback? onPressed;

  static const productCardKey = Key('product-card');

  @override
  Widget build(BuildContext context) {
    // TODO: Inject formatter
    final priceFormatted = kCurrencyFormatter.format(product.price);
    return Card(
      child: InkWell(
        key: productCardKey,
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(Sizes.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomImage(imageUrl: product.imageUrl),
              gapH8,
              const Divider(),
              gapH8,
              Text(product.title, style: Theme.of(context).textTheme.titleLarge),
              if (product.numRatings >= 1) ...[
                gapH8,
                ProductAverageRating(product: product),
              ],
              gapH24,
              Text(priceFormatted,
                  style: Theme.of(context).textTheme.headlineSmall),
            ],
          ),
        ),
      ),
    );
  }
}
