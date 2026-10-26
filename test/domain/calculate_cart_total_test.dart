import 'package:flutter_test/flutter_test.dart';
import 'package:shop_testability_demo/domain/calculate_cart_total.dart';
import 'package:shop_testability_demo/domain/product.dart';

void main() {
  const calculate = CalculateCartTotal();

  test('giỏ rỗng có tổng bằng 0', () {
    expect(calculate(const []), 0);
  });

  test('cộng giá của tất cả sản phẩm', () {
    final total = calculate(const [Product('A', 10), Product('B', 25)]);
    expect(total, 35);
  });
}