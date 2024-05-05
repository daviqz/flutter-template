import 'package:authorspace/storage/global_state.dart';
import 'package:flutter/material.dart';
import 'package:authorspace/utils/colors_utils.dart';
import 'package:provider/provider.dart';
import 'package:authorspace/service/service.dart';
import 'package:http/http.dart' as http;

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
                  GlobalState globalState = Provider.of<GlobalState>(context, listen: false);
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
    final response = await Service.get('/account/protected');
    print(response);
  } catch (e) {
    var message = 'Erro desconhecido';
    if (e is http.ClientException) {
      message = e.message;
    }
  }
}
