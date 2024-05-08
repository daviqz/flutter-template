import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:authorspace/models/account_model.dart';
import 'package:authorspace/storage/local_storage.dart';

class GlobalState extends ChangeNotifier {
  String? token;
  Account? loggedUser;
  String themeName = 'default';

  GlobalState() {
    initFromLocalStorage();
  }

  void initFromLocalStorage() async {
    final authData = await LocalStorage.getAuth();
    final themeName = await LocalStorage.getThemeName();
    if (authData != null) {
      final auth = json.decode(authData);
      final token = auth['token'];
      final userData = auth['loggedUser'];
      final loggedUser = Account.fromJson(userData);
      updateAuth(token, loggedUser);
    }
    if (themeName != null) {
      updateTheme(themeName);
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
}
