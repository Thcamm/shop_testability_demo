import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/product.dart';
import '../data/shop_api.dart';

class CartState {
  final List<Product> items;
  final bool loading;
  const CartState({this.items = const [], this.loading = false});
}

class CartCubit extends Cubit<CartState> {
  final ShopApi api;
  CartCubit(this.api) : super(const CartState());

  Future<void> load() async {
    emit(const CartState(loading: true));
    final items = await api.fetchCart();
    emit(CartState(items: items));
  }
}