import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/demo_backend.dart';
import 'injection.dart';
import 'presentation/cart_cubit.dart';
import 'presentation/cart_page.dart';

void main() {
  setupLocator(client: createDemoClient());
  runApp(const ShopApp());
}

class ShopApp extends StatelessWidget {
  const ShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop Testability Demo',
      home: BlocProvider(
        create: (_) => getIt<CartCubit>()..load(),
        child: const CartPage(),
      ),
    );
  }
}