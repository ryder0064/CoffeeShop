import 'package:coffee_shop/src/features/cart/data/local/local_cart_repository.dart';
import 'package:coffee_shop/src/features/cart/domain/cart.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast_web/sembast_web.dart';

class SembastCartRepository implements LocalCartRepository {
  SembastCartRepository(this.db);
  final Database db;

  static Future<Database> createDatabase(String filename) async {
    if (!kIsWeb) {
      final appDocDir = await getApplicationDocumentsDirectory();
      return databaseFactoryIo.openDatabase('${appDocDir.path}/$filename');
    } else {
      return databaseFactoryWeb.openDatabase(filename);
    }
  }

  // How to initialize an async dependency during app startup, and use it synchronously afterwards.
  // https://github.com/bizz84/flutter-tips-and-tricks/blob/main/tips/0131-future-provider-require-value/index.md
  // With Riverpod, this is done in 3 simple steps:
  // Declare it inside a FutureProvider
  // Initialize it inside main()
  // Use requireValue afterwards
  static Future<SembastCartRepository> makeDefault() async {
    return SembastCartRepository(await createDatabase('default.db'));
  }

  @override
  Future<Cart> fetchCart() {
    // TODO: implement fetchCart
    throw UnimplementedError();
  }

  @override
  Future<void> setCart(Cart cart) {
    // TODO: implement setCart
    throw UnimplementedError();
  }

  @override
  Stream<Cart> watchCart() {
    // TODO: implement watchCart
    throw UnimplementedError();
  }
}