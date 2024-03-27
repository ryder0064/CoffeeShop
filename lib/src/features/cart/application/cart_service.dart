import 'package:coffee_shop/src/features/authentication/data/fake_auth_repository.dart';
import 'package:coffee_shop/src/features/cart/data/local/local_cart_repository.dart';
import 'package:coffee_shop/src/features/cart/data/remote/remote_cart_repository.dart';
import 'package:coffee_shop/src/features/cart/domain/cart.dart';
import 'package:coffee_shop/src/features/cart/domain/item.dart';
import 'package:coffee_shop/src/features/cart/domain/mutable_cart.dart';
import 'package:coffee_shop/src/features/products/domain/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartService {
  CartService(this.ref);

  final Ref ref;

  /// fetch the cart from the local or remote repository
  /// depending on the user auth state
  Future<Cart> _fetchCart() {
    final user = ref.read(authRepositoryProvider).currentUser;
    if (user != null) {
      return ref.read(remoteCartRepositoryProvider).fetchCart(user.uid);
    } else {
      return ref.read(localCartRepositoryProvider).requireValue.fetchCart();
    }
  }

  /// save the cart to the local or remote repository
  /// depending on the user auth state
  Future<void> _setCart(Cart cart) async {
    final user = ref.read(authRepositoryProvider).currentUser;
    if (user != null) {
      await ref.read(remoteCartRepositoryProvider).setCart(user.uid, cart);
    } else {
      await ref.read(localCartRepositoryProvider).requireValue.setCart(cart);
    }
  }

  /// sets an item in the local or remote cart depending on the user auth state
  Future<void> setItem(Item item) async {
    final cart = await _fetchCart();
    final updated = cart.setItem(item);
    await _setCart(updated);
  }

  /// adds an item in the local or remote cart depending on the user auth state
  Future<void> addItem(Item item) async {
    final cart = await _fetchCart();
    final updated = cart.addItem(item);
    await _setCart(updated);
  }

  /// removes an item from the local or remote cart depending on the user auth
  /// state
  Future<void> removeItemById(ProductID productId) async {
    final cart = await _fetchCart();
    final updated = cart.removeItemById(productId);
    await _setCart(updated);
  }
}

// Using ref makes our dependencies implicit and it’s not so easy to see what the CartService class depends on.
// On the other hand, declaring dependencies as instance properties makes them explicit.
// And the CartService class now depends directly on the Riverpod package.
final cartServiceProvider = Provider<CartService>((ref) {
  return CartService(ref);
});
