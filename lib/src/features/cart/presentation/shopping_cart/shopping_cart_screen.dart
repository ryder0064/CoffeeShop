import 'package:coffee_shop/src/common_widgets/async_value_widget.dart';
import 'package:coffee_shop/src/common_widgets/primary_button.dart';
import 'package:coffee_shop/src/features/cart/application/cart_service.dart';
import 'package:coffee_shop/src/features/cart/domain/cart.dart';
import 'package:coffee_shop/src/features/cart/presentation/shopping_cart/shopping_cart_item.dart';
import 'package:coffee_shop/src/features/cart/presentation/shopping_cart/shopping_cart_items_builder.dart';
import 'package:coffee_shop/src/features/cart/presentation/shopping_cart/shopping_cart_screen_controller.dart';
import 'package:coffee_shop/src/localization/string_hardcoded.dart';
import 'package:coffee_shop/src/routing/app_router.dart';
import 'package:coffee_shop/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ShoppingCartScreen extends ConsumerWidget {
  const ShoppingCartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<void>>(
      shoppingCartScreenControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final state = ref.watch(shoppingCartScreenControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'.hardcoded),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final cartValue = ref.watch(cartProvider);
          return AsyncValueWidget(
            value: cartValue,
            data: (cart) => ShoppingCartItemsBuilder(
              items: cart.toItemsList(),
              itemBuilder: (_, item, index) => ShoppingCartItem(
                item: item,
                itemIndex: index,
              ),
              ctaBuilder: (_) => PrimaryButton(
                text: 'Checkout'.hardcoded,
                isLoading: state.isLoading,
                onPressed: () => context.goNamed(AppRoute.checkout.name),
              ),
            ),
          );
        },
      ),
    );
  }
}
