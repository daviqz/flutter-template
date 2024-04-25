import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:authorspace/models/account_model.dart';
import 'package:authorspace/storage/local_storage.dart';

class GlobalState extends ChangeNotifier {
  String? token;
  Account? loggedUser;

  GlobalState() {
    initFromLocalStorage();
  }

  void initFromLocalStorage() async {
    final authData = await LocalStorage.getAuth();
    if (authData != null) {
      final auth = json.decode(authData);
      final token = auth['token'];
      final userData = auth['loggedUser'];
      final loggedUser = Account.fromJson(userData);
      updateAuth(token, loggedUser);
    }
  }

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
}
