import 'package:coffee_shop/src/common_widgets/item_quantity_selector.dart';
import 'package:coffee_shop/src/common_widgets/primary_button.dart';
import 'package:coffee_shop/src/constants/app_sizes.dart';
import 'package:coffee_shop/src/features/cart/presentation/add_to_cart/add_to_cart_controller.dart';
import 'package:coffee_shop/src/features/products/domain/product.dart';
import 'package:coffee_shop/src/localization/string_hardcoded.dart';
import 'package:coffee_shop/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddToCartWidget extends ConsumerWidget {
  const AddToCartWidget({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<int>>(
      addToCartControllerProvider,
          (_, state) => state.showAlertDialogOnError(context),
    );
    final availableQuantity = product.availableQuantity;
    final state = ref.watch(addToCartControllerProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Quantity:'.hardcoded),
            ItemQuantitySelector(
              quantity: state.value!,
              onChanged: state.isLoading
                  ? null
                  : (quantity) => ref
                      .read(addToCartControllerProvider.notifier)
                      .updateQuantity(quantity),
            ),
          ],
        ),
        gapH8,
        const Divider(),
        gapH8,
        PrimaryButton(
          isLoading: state.isLoading,
          // only enable the button if there is enough stock
          onPressed: availableQuantity > 0
              ? () => ref
                  .read(addToCartControllerProvider.notifier)
                  .addItem(product.id)
              : null,
          text: availableQuantity > 0
              ? 'Add to Cart'.hardcoded
              : 'Out of Stock'.hardcoded,
        ),
        if (product.availableQuantity > 0 && availableQuantity == 0) ...[
          gapH8,
          Text(
            'Already added to cart'.hardcoded,
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ]
      ],
    );
  }
}
