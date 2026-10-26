import 'package:flutter_test/flutter_test.dart';
import 'package:shop_testability_demo/logic/cart_cubit.dart';
import 'fake_shop_api.dart';

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
}