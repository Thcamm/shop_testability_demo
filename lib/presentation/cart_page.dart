import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cart_cubit.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Giỏ hàng')),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.error != null) {
            return Center(child: Text('Lỗi: ${state.error}'));
          }
          return Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    for (final p in state.items)
                      ListTile(
                        title: Text(p.name),
                        trailing: Text('${p.price}'),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text('Tổng: ${state.total}'),
              ),
            ],
          );
        },
      ),
    );
  }
}