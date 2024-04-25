import 'package:authorspace/models/account_model.dart';
import 'package:authorspace/storage/global_state.dart';
import 'package:flutter/material.dart';
import 'package:authorspace/utils/colors_utils.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:authorspace/service/service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    const String appTitle = 'Flutter HOME';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  GlobalState globalState =
                      Provider.of<GlobalState>(context, listen: false);
                  globalState.clearAuth();
                },
                child: const Text(
                  'Deslogar',
                  style: TextStyle(
                    color: ColorsUtils.blackLessDark,
                  ), // Define a cor do texto do botão
                ),
              ),
              TextButton(
                onPressed: () {
                  _handleClickGetUserAccount();
                },
                child: const Text(
                  'Buscar perfil (rota autenticada)',
                  style: TextStyle(
                    color: ColorsUtils.blackLessDark,
                  ), // Define a cor do texto do botão
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _handleClickGetUserAccount() async {
  try {
    final response = await Service.get('/account/get-user-account');

    if (response.statusCode == 200) {
      dynamic responseBody = jsonDecode(response.body);
      Account account = Account.fromJson(responseBody);
      print(account);
    } else {
      print('Erro na requisição: ${response.statusCode}');
      Fluttertoast.showToast(
        msg: 'Erro na requisição: ${response.statusCode}',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  } catch (e) {
    print('Erro ao fazer a requisição: $e');
    Fluttertoast.showToast(
      msg: 'Erro ao fazer a requisição: $e',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }
}
