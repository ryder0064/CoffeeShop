import 'package:coffee_shop/src/common_widgets/primary_button.dart';
import 'package:coffee_shop/src/constants/app_sizes.dart';
import 'package:coffee_shop/src/localization/string_hardcoded.dart';
import 'package:flutter/material.dart';

class EmptyPlaceholderWidget extends StatelessWidget {
  const EmptyPlaceholderWidget({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.p16),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              message,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            gapH32,
            PrimaryButton(
              onPressed: () =>
                  // * Pop all routes in the navigation stack until the home
                  // * screen is reached.
                  Navigator.of(context).popUntil((route) => route.isFirst),
              text: 'Go Home'.hardcoded,
            )
          ],
        ),
      ),
    );
  }
}
