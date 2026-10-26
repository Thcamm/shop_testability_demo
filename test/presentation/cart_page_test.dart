import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shop_testability_demo/presentation/cart_cubit.dart';
import 'package:shop_testability_demo/presentation/cart_page.dart';

import '../fake_shop_api.dart';

void main() {
  testWidgets('hiện loading rồi hiện sản phẩm và tổng tiền', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (_) => CartCubit(FakeShopApi())..load(),
          child: const CartPage(),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pumpAndSettle();

    expect(find.text('A'), findsOneWidget);
    expect(find.text('Tổng: 10'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });
}