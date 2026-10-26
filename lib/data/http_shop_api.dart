import 'dart:convert';
import 'package:http/http.dart' as http;
import '../domain/product.dart';
import '../domain/shop_api.dart';
class ShopApiException implements Exception {
  final String message;
  const ShopApiException(this.message);

  @override
  String toString() => 'ShopApiException: $message';
}

class HttpShopApi implements ShopApi {
  final http.Client client;
  final String baseUrl;

  HttpShopApi(this.client, {this.baseUrl = 'https://api.shop.local'});

  @override
  Future<List<Product>> fetchCart() async {
    final response = await client.get(Uri.parse('$baseUrl/cart'));
    if (response.statusCode != 200) {
      throw ShopApiException('HTTP ${response.statusCode}');
    }
    final data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((e) => e as Map<String, dynamic>)
        .map((e) => Product(e['name'] as String, e['price'] as int))
        .toList();
  }
}