import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

http.Client createDemoClient() {
  return MockClient((request) async {
    return http.Response(
      '[{"name":"Áo thun","price":150000},{"name":"Giày","price":900000}]',
      200,
      headers: {'content-type': 'application/json; charset=utf-8'},
    );
  });
}