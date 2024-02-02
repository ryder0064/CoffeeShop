import 'package:coffee_shop/src/features/account/account_screen.dart';
import 'package:coffee_shop/src/features/order_list/orders_list_screen.dart';
import 'package:coffee_shop/src/features/sign_in/email_password_sign_in_screen.dart';
import 'package:coffee_shop/src/features/sign_in/email_password_sign_in_state.dart';
import 'package:coffee_shop/src/localization/string_hardcoded.dart';
import 'package:coffee_shop/src/models/app_user.dart';
import 'package:flutter/material.dart';

enum PopupMenuOption {
  signIn,
  orders,
  account,
}

class MoreMenuButton extends StatelessWidget {
  const MoreMenuButton({super.key, this.user});
  final AppUser? user;

  static const signInKey = Key('menuSignIn');
  static const ordersKey = Key('menuOrders');
  static const accountKey = Key('menuAccount');

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(Icons.more_vert),
      itemBuilder: (_) {
        return user != null
            ? <PopupMenuEntry<PopupMenuOption>>[
                PopupMenuItem(
                  key: ordersKey,
                  value: PopupMenuOption.orders,
                  child: Text('Orders'.hardcoded),
                ),
                PopupMenuItem(
                  key: accountKey,
                  value: PopupMenuOption.account,
                  child: Text('Account'.hardcoded),
                ),
              ]
            : <PopupMenuEntry<PopupMenuOption>>[
                PopupMenuItem(
                  key: signInKey,
                  value: PopupMenuOption.signIn,
                  child: Text('Sign In'.hardcoded),
                ),
              ];
      },
      onSelected: (option) {
        switch (option) {
          case PopupMenuOption.signIn:
            Navigator.of(context).push(
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (_) => const EmailPasswordSignInScreen(
                  formType: EmailPasswordSignInFormType.signIn,
                ),
              ),
            );
            break;
          case PopupMenuOption.orders:
            Navigator.of(context).push(
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (_) => const OrdersListScreen(),
              ),
            );
            break;
          case PopupMenuOption.account:
            Navigator.of(context).push(
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (_) => const AccountScreen(),
              ),
            );
            break;
        }
      },
    );
  }
}
