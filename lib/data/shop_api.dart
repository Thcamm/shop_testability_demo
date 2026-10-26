import 'product.dart';

abstract class ShopApi {
  Future<List<Product>> fetchCart();
}