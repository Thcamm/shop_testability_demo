import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shop_testability_demo/data/http_shop_api.dart';
import 'package:shop_testability_demo/domain/shop_api.dart';
import 'package:shop_testability_demo/injection.dart';
import 'package:shop_testability_demo/presentation/cart_cubit.dart';

import 'fake_shop_api.dart';

void main() {
  setUp(() async {
    await getIt.reset();
  });

  test('đăng ký mặc định: ShopApi là HttpShopApi', () {
    setupLocator(client: MockClient((_) async => http.Response('[]', 200)));

    expect(getIt<ShopApi>(), isA<HttpShopApi>());
    expect(getIt<CartCubit>(), isA<CartCubit>());
  });

  test('khi test có thể thay ShopApi bằng Fake', () async {
    setupLocator();
    getIt.unregister<ShopApi>();
    getIt.registerLazySingleton<ShopApi>(() => FakeShopApi());

    final cubit = getIt<CartCubit>();
    await cubit.load();

    expect(cubit.state.items.length, 1);
  });
}