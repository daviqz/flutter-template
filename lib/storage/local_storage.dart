import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:mobiletemplate/models/account_model.dart';

class LocalStorage {
  static const String _authKey = 'AUTH_KEY';
  static const String _themeKey = 'THEME_KEY';
  static const String _appLanguageKey = 'APP_LANGUAGE_KEY';

  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  //------------------------------------ Auth
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

  //------------------------------------ Theme
  static Future<void> setThemeName(String themeName) async {
    await _prefs.setString(_themeKey, themeName);
  }

  static Future<String?> getThemeName() async {
    return _prefs.getString(_themeKey);
  }

  //------------------------------------ Language
  static Future<void> setAppLanguageName(String appLanguageName) async {
    await _prefs.setString(_appLanguageKey, appLanguageName);
  }

  static Future<String?> getAppLanguageName() async {
    return _prefs.getString(_appLanguageKey);
  }
}
