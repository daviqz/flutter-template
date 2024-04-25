import 'package:http/http.dart' as http;
import 'package:authorspace/storage/local_storage.dart';
import 'package:authorspace/config/config.dart';

const String apiBaseUrl = apiBaseUrlLocal;

class Service {
  static const String baseUrl = apiBaseUrl;

  static Future<http.Response> get(String route,
      {Map<String, String>? headers}) async {
    final url = Uri.parse('$baseUrl$route');

    String? token = await LocalStorage.getAuthToken();

    final defaultHeaders = {'Authorization': 'Bearer $token'};
    final mergedHeaders = {...defaultHeaders, ...?headers};
    return await http.get(url, headers: mergedHeaders);
  }

  static Future<http.Response> post(String route, dynamic body,
      {Map<String, String>? headers}) async {
    final url = Uri.parse('$baseUrl$route');
    return await http.post(url, body: body);
  }
}
