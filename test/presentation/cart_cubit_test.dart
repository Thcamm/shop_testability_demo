import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop_testability_demo/domain/product.dart';
import 'package:shop_testability_demo/domain/shop_api.dart';
import 'package:shop_testability_demo/presentation/cart_cubit.dart';

import '../fake_shop_api.dart';

class MockShopApi extends Mock implements ShopApi {}

void main() {
  test('giỏ hàng có 1 sản phẩm sau khi load', () async {
    // Arrange
    final cubit = CartCubit(FakeShopApi());
    // Act
    await cubit.load();
    // Assert
    expect(cubit.state.items.length, 1);
    expect(cubit.state.loading, false);
  });

  test('load phát ra trạng thái loading rồi dữ liệu', () async {
    final cubit = CartCubit(FakeShopApi());
    final states = <CartState>[];
    final sub = cubit.stream.listen(states.add);

    await cubit.load();
    await Future<void>.delayed(Duration.zero);
    await sub.cancel();

    expect(states.first.loading, true);
    expect(states.last.items.length, 1);
    expect(states.last.total, 10);
  });

  test('Mock: tính tổng và gọi API đúng 1 lần', () async {
    final api = MockShopApi();
    when(() => api.fetchCart()).thenAnswer(
          (_) async => const [Product('A', 10), Product('B', 5)],
    );
    final cubit = CartCubit(api);

    await cubit.load();

    expect(cubit.state.total, 15);
    verify(() => api.fetchCart()).called(1);
  });

  test('API lỗi thì state có error', () async {
    final api = MockShopApi();
    when(() => api.fetchCart())
        .thenAnswer((_) => Future.error(Exception('mat mang')));
    final cubit = CartCubit(api);

    await cubit.load();

    expect(cubit.state.error, isNotNull);
    expect(cubit.state.items, isEmpty);
  });
}