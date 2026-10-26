import 'product.dart';

class CalculateCartTotal {
  const CalculateCartTotal();

  int call(List<Product> items) => items.fold(0, (sum, p) => sum + p.price);
}
