import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:authorspace/models/account_model.dart';

class LocalStorage {
  static const String _authKey = 'AUTH_KEY';
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> setAuth(String token, Account loggedUser) async {
    final data = {'token': token, 'loggedUser': loggedUser.toJson()};
    final jsonData = json.encode(data); // Serialize o mapa para uma string JSON
    await _prefs.setString(_authKey, jsonData);
  }

  static Future<String?> getAuth() async {
    return _prefs.getString(_authKey);
  }

  static Future<String?> getAuthToken() async {
    String? authObjectJson = _prefs.getString(_authKey);
    if (authObjectJson != null) {
      Map<String, dynamic> authObjectMap = json.decode(authObjectJson);
      return authObjectMap['token'];
    }

    return null; // Retorna null se a string JSON estiver vazia ou nula
  }

  static Future<void> clearAuth() async {
    await _prefs.remove(_authKey);
  }
}
