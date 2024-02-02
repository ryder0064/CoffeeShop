import 'package:coffee_shop/src/common_widgets/responsive_center.dart';
import 'package:coffee_shop/src/constants/app_sizes.dart';
import 'package:coffee_shop/src/constants/breakpoints.dart';
import 'package:coffee_shop/src/features/product_page/product_reviews/product_review_card.dart';
import 'package:coffee_shop/src/models/review.dart';
import 'package:flutter/material.dart';

class ProductReviewsList extends StatelessWidget {
  const ProductReviewsList({super.key, required this.productId});
  final String productId;
  @override
  Widget build(BuildContext context) {
    // TODO: Read from data source
    final reviews = <Review>[
      Review(
        date: DateTime(2022, 2, 12),
        score: 4.5,
        comment: 'Delicious!',
      ),
      Review(
        date: DateTime(2022, 2, 10),
        score: 4.0,
        comment: 'It smells and tastes good.',
      ),
    ];
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) => ResponsiveCenter(
          maxContentWidth: Breakpoint.tablet,
          padding: const EdgeInsets.symmetric(
              horizontal: Sizes.p16, vertical: Sizes.p8),
          child: ProductReviewCard(reviews[index]),
        ),
        childCount: reviews.length,
      ),
    );
  }
}
