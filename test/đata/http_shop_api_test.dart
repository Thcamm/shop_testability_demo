import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shop_testability_demo/data/http_shop_api.dart';

void main() {
  test('parse JSON thành danh sách Product', () async {
    final client = MockClient((request) async {
      expect(request.url.path, '/cart');
      return http.Response(
        '[{"name":"A","price":10},{"name":"B","price":20}]',
        200,
      );
    });
    final api = HttpShopApi(client);

    final items = await api.fetchCart();

    expect(items.length, 2);
    expect(items.first.name, 'A');
    expect(items.last.price, 20);
  });

  test('ném ShopApiException khi server trả lỗi', () async {
    final client = MockClient((request) async => http.Response('oops', 500));
    final api = HttpShopApi(client);

    await expectLater(api.fetchCart(), throwsA(isA<ShopApiException>()));
  });
}