import 'package:coffee_shop/src/common_widgets/custom_text_button.dart';
import 'package:coffee_shop/src/common_widgets/responsive_two_column_layout.dart';
import 'package:coffee_shop/src/constants/app_sizes.dart';
import 'package:coffee_shop/src/localization/string_hardcoded.dart';
import 'package:coffee_shop/src/models/purchase.dart';
import 'package:coffee_shop/src/routing/app_router.dart';
import 'package:coffee_shop/src/utils/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LeaveReviewAction extends StatelessWidget {
  const LeaveReviewAction({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    // TODO: Read from data source
    final purchase = Purchase(orderId: 'abc', orderDate: DateTime.now());
    if (purchase != null) {
      // TODO: Inject date formatter
      final dateFormatted = kDateFormatter.format(purchase.orderDate);
      return Column(
        children: [
          const Divider(),
          gapH8,
          ResponsiveTwoColumnLayout(
            spacing: Sizes.p16,
            breakpoint: 300,
            startFlex: 3,
            endFlex: 2,
            rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
            rowCrossAxisAlignment: CrossAxisAlignment.center,
            columnCrossAxisAlignment: CrossAxisAlignment.center,
            startContent: Text('Purchased on $dateFormatted'.hardcoded),
            endContent: CustomTextButton(
              text: 'Leave a review'.hardcoded,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.green[700]),
              onPressed: () => context.goNamed(
                AppRoute.leaveReview.name,
                pathParameters: {'id': productId},
              ),
            ),
          ),
          gapH8,
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}
