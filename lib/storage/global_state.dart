import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:mobiletemplate/models/account_model.dart';
import 'package:mobiletemplate/storage/local_storage.dart';

class GlobalState extends ChangeNotifier {
  String? token;
  Account? loggedUser;
  String themeName = 'default';
  String appLanguageName = 'pt';

  static final GlobalState _globalStateSingleton = GlobalState._internal();

  factory GlobalState() {
    return _globalStateSingleton;
  }

  GlobalState._internal() {
    initFromLocalStorage();
  }

  void initFromLocalStorage() async {
    final authDataLocal = await LocalStorage.getAuth();
    final themeNameLocal = await LocalStorage.getThemeName();
    final appLanguageNameLocal = await LocalStorage.getAppLanguageName();
    if (authDataLocal != null) {
      final auth = json.decode(authDataLocal);
      final token = auth['token'];
      final userData = auth['loggedUser'];
      final loggedUser = Account.fromJson(userData);
      updateAuth(token, loggedUser);
    }
    if (themeNameLocal != null) {
      updateTheme(themeNameLocal);
    }
    if (appLanguageNameLocal != null) {
      updateAppLanguage(appLanguageNameLocal);
    }
  }

  //------------------------------------ Auth
  void updateAuth(String newToken, Account newUser) async {
    await LocalStorage.setAuth(newToken, newUser);
    token = newToken;
    loggedUser = newUser;
    notifyListeners();
  }

  void clearAuth() async {
    await LocalStorage.clearAuth();
    token = null;
    loggedUser = null;
    notifyListeners();
  }

  Future<void> checkTokenAndLogoutIfExpired() async {
    String? localStorageToken = await LocalStorage.getAuthToken();
    if (localStorageToken == null && (token != null || loggedUser != null)) {
      token = null;
      loggedUser = null;
      notifyListeners();
    }
  }

  //------------------------------------ Theme
  void updateTheme(String newThemeName) async {
    await LocalStorage.setThemeName(newThemeName);
    themeName = newThemeName;
    notifyListeners();
  }

  //------------------------------------ Language
  void updateAppLanguage(String newAppLanguage) async {
    await LocalStorage.setAppLanguageName(newAppLanguage);
    appLanguageName = newAppLanguage;
    notifyListeners();
  }
}
