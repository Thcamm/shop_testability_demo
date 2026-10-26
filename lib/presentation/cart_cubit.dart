import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/calculate_cart_total.dart';
import '../domain/product.dart';
import '../domain/shop_api.dart';

class CartState {
  final List<Product> items;
  final int total;
  final bool loading;
  final String? error;

  const CartState({
    this.items = const [],
    this.total = 0,
    this.loading = false,
    this.error,
  });
}

class CartCubit extends Cubit<CartState> {
  final ShopApi api;
  final CalculateCartTotal calculateTotal;

  CartCubit(this.api, {this.calculateTotal = const CalculateCartTotal()})
      : super(const CartState());

  Future<void> load() async {
    emit(const CartState(loading: true));
    try {
      final items = await api.fetchCart();
      emit(CartState(items: items, total: calculateTotal(items)));
    } catch (e) {
      emit(CartState(error: e.toString()));
    }
  }
}