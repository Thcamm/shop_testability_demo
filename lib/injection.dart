import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'data/http_shop_api.dart';
import 'domain/shop_api.dart';
import 'presentation/cart_cubit.dart';

final getIt = GetIt.instance;

void setupLocator({http.Client? client}) {
  getIt.registerLazySingleton<http.Client>(() => client ?? http.Client());
  getIt.registerLazySingleton<ShopApi>(() => HttpShopApi(getIt<http.Client>()));
  getIt.registerFactory<CartCubit>(() => CartCubit(getIt<ShopApi>()));
}