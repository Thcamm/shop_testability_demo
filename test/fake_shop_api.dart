import 'package:shop_testability_demo/domain/product.dart';
import 'package:shop_testability_demo/domain/shop_api.dart';

class FakeShopApi implements ShopApi {
  @override
  Future<List<Product>> fetchCart() async => const [Product('A', 10)];
}