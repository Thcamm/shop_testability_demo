import 'product.dart';
import 'shop_api.dart';

class HttpShopApi implements ShopApi {
  @override
  Future<List<Product>> fetchCart() async {
    await Future.delayed(const Duration(seconds: 2)); // giả lập gọi mạng
    return const [Product('Áo thun', 150000), Product('Giày', 900000)];
  }
}