import 'package:coffee_shop/src/constants/test_products.dart';
import 'package:coffee_shop/src/features/products/data/fake_products_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('getProductsList returns global list', () {
    final productsRepository = FakeProductsRepository();
    expect(
      productsRepository.getProductsList(),
      kTestProducts,
    );
  });
}
