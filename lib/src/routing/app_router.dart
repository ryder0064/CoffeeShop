import 'package:coffee_shop/src/features/products_list/product_list_screen.dart';
import 'package:coffee_shop/src/features/shopping_cart/shopping_cart_screen.dart';
import 'package:go_router/go_router.dart';

final goRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const ProductsListScreen(),
      routes: [
        GoRoute(
          path: 'cart',
          builder: (context, state) => const ShoppingCartScreen(),
        )
      ],
    ),
  ],
);
