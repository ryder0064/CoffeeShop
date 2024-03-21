import 'package:coffee_shop/src/app.dart';
import 'package:coffee_shop/src/constants/test_products.dart';
import 'package:coffee_shop/src/features/authentication/data/fake_auth_repository.dart';
import 'package:coffee_shop/src/features/products/data/fake_products_repository.dart';
import 'package:coffee_shop/src/features/products/presentation/home_app_bar/more_menu_button.dart';
import 'package:coffee_shop/src/features/products/presentation/product_list/product_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'features/authentication/auth_robot.dart';

class Robot {
  Robot(this.tester) : auth = AuthRobot(tester);
  final WidgetTester tester;
  final AuthRobot auth;

  Future<void> pumpMyApp() async {
    // Since our widget tests rely on GoRouter when navigating between screens, they should be configured in the same way as the main app.
    // As a result, we should set GoRouter.optionURLReflectsImperativeAPIs = true
    GoRouter.optionURLReflectsImperativeAPIs = true;

    // create new repositories with addDelay: false
    final authRepository = FakeAuthRepository(addDelay: false);
    final productsRepository = FakeProductsRepository(addDelay: false);
    await tester.pumpWidget(ProviderScope(
      overrides: [
        // use them via provider overrides:
        authRepositoryProvider.overrideWithValue(authRepository),
        productsRepositoryProvider.overrideWithValue(productsRepository),
      ],
      child: const MyApp(),
    ));

    // When any animations are in progress (for example, during a page transition), calling pump() is insufficient as this will not render all the frames that are scheduled.
    // In such cases, it's advisable to call pumpAndSettle(), which repeatedly calls pump() with the given duration until there are no longer any frames scheduled.
    // This can be necessary when testing the entire app or a widget that loads data asynchronously (such as the products list).
    await tester.pumpAndSettle();
  }

  Future<void> openPopupMenu() async {
    final finder = find.byType(MoreMenuButton);

    // Sometimes, we want to only interact with a certain widget if it can be found, and do nothing otherwise.
    // In this case, we can call finder.evaluate() and only use the tester if at least one widget is found.
    final matches = finder.evaluate();

    // if an item is found, it means that we're running
    // on a small window and can tap to reveal the menu
    if (matches.isNotEmpty) {
      await tester.tap(finder);
      await tester.pumpAndSettle();
    }
    // else no-op, as the items are already visible
  }

  void expectFindAllProductCards() {
    final finder = find.byType(ProductCard);
    expect(finder, findsNWidgets(kTestProducts.length));
  }
}