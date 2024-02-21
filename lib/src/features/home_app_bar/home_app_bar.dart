import 'package:coffee_shop/src/common_widgets/action_text_button.dart';
import 'package:coffee_shop/src/constants/breakpoints.dart';
import 'package:coffee_shop/src/features/account/account_screen.dart';
import 'package:coffee_shop/src/features/home_app_bar/more_menu_button.dart';
import 'package:coffee_shop/src/features/home_app_bar/shopping_cart_icon.dart';
import 'package:coffee_shop/src/features/order_list/orders_list_screen.dart';
import 'package:coffee_shop/src/features/sign_in/email_password_sign_in_screen.dart';
import 'package:coffee_shop/src/features/sign_in/email_password_sign_in_state.dart';
import 'package:coffee_shop/src/localization/string_hardcoded.dart';
import 'package:coffee_shop/src/models/app_user.dart';
import 'package:coffee_shop/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    const user = AppUser(uid: '123', email: 'test@test.com');
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < Breakpoint.tablet) {
      return AppBar(
        title: Text('Coffee Shop'.hardcoded),
        actions: const [
          ShoppingCartIcon(),
          MoreMenuButton(user: user),
        ],
      );
    } else {
      return AppBar(
        title: Text('Coffee Shop'.hardcoded),
        actions: [
          const ShoppingCartIcon(),
          if (user != null) ...[
            ActionTextButton(
              key: MoreMenuButton.ordersKey,
              text: 'Orders'.hardcoded,
              onPressed: () => context.goNamed(AppRoute.orders.name),
            ),
            ActionTextButton(
              key: MoreMenuButton.accountKey,
              text: 'Account'.hardcoded,
              onPressed: () => context.goNamed(AppRoute.account.name),
            ),
          ] else
            ActionTextButton(
              key: MoreMenuButton.signInKey,
              text: 'Sign In'.hardcoded,
              onPressed: () => context.goNamed(AppRoute.signIn.name),
            )
        ],
      );
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
