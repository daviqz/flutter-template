import 'dart:convert';
import 'package:authorspace/enums/toast.enum.dart';
import 'package:authorspace/storage/global_state.dart';
import 'package:http/http.dart' as http;
import 'package:authorspace/widgets/system_toast.dart';
import 'package:authorspace/storage/local_storage.dart';
import 'package:authorspace/config/config.dart';

const String apiBaseUrl = apiBaseUrlLocal;

class Service {
  static const String baseUrl = apiBaseUrl;
  final GlobalState globalState;

  Service({required this.globalState});

  static Future<dynamic> get(String route, {Map<String, String>? headers}) async {
    final url = Uri.parse('$baseUrl$route');

    String? token = await LocalStorage.getAuthToken();
    final defaultHeaders = {'Authorization': 'Bearer $token'};
    final mergedHeaders = {...defaultHeaders, ...?headers};

    final data = await http.get(url, headers: mergedHeaders);
    final decodedData = jsonDecode(data.body);
    if (decodedData is Map && decodedData['toast'] != null) {
      SystemToast.show(decodedData['toast']['message'], toastEnumFromString(decodedData['toast']['type']));
    }
    if (decodedData['isExpiredToken'] != null) {
      LocalStorage.clearAuth();
    }
    return decodedData;
  }

  static Future<dynamic> post(String route, dynamic body, {Map<String, String>? headers}) async {
    final url = Uri.parse('$baseUrl$route');

    String? token = await LocalStorage.getAuthToken();
    final defaultHeaders = {'Authorization': 'Bearer $token'};
    final mergedHeaders = {...defaultHeaders, ...?headers};

    final data = await http.post(url, body: body, headers: mergedHeaders);
    final decodedData = jsonDecode(data.body);
    if (decodedData is Map && decodedData['toast'] != null) {
      SystemToast.show(decodedData['toast']['message'], toastEnumFromString(decodedData['toast']['type']));
    }
    if (decodedData['isExpiredToken'] != null) {
      LocalStorage.clearAuth();
    }

    return decodedData;
  }
}
