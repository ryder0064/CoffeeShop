import 'package:coffee_shop/src/features/cart/data/local/sembast_cart_repository.dart';
import 'package:coffee_shop/src/features/cart/domain/cart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// API for reading, watching and writing local cart data (guest user)
abstract class LocalCartRepository {
  Future<Cart> fetchCart();

  Stream<Cart> watchCart();

  Future<void> setCart(Cart cart);
}

final localCartRepositoryProvider = FutureProvider<LocalCartRepository>((ref) {
  // Declare it inside a FutureProvider
  return SembastCartRepository.makeDefault();
});
