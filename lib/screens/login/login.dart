import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:authorspace/utils/colors_utils.dart';
import 'package:authorspace/service/service.dart';
import 'package:authorspace/widgets/input_form.dart';
import 'package:authorspace/storage/global_state.dart';
import 'package:authorspace/models/account_model.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          color: ColorsUtils.lightBlue, // Cor de fundo da AppBar
          alignment: Alignment.center,
          child: const Text(
            'Login',
            style: TextStyle(
              color: ColorsUtils.whitePrimary, // Cor do texto
              fontSize: 20, // Tamanho do texto
              fontWeight: FontWeight.bold, // Peso da fonte
            ),
          ),
        ),
      ),
      backgroundColor: ColorsUtils.whitePrimary,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InputForm(
                inputFieldValueController: _emailController,
                labelText: 'Email',
                hintText: 'Digite seu email',
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
              ),
              const SizedBox(height: 30),
              InputForm(
                inputFieldValueController: _passwordController,
                labelText: 'Senha',
                hintText: 'Digite sua senha',
                icon: Icons.lock,
                keyboardType: TextInputType.text,
                obscureText: true,
              ),
              const SizedBox(height: 50),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text(
                  'Login com Google',
                  style: TextStyle(
                    color: ColorsUtils.blackLessDark,
                  ), // Define a cor do texto do botão
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text(
                  'Registre-se',
                  style: TextStyle(
                    color: ColorsUtils.blackLessDark,
                  ), // Define a cor do texto do botão
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: ColorsUtils.whiteSecondary, // text color
                    backgroundColor: ColorsUtils.blue,
                    minimumSize: const Size(200, 50),
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 40.0,
                    ),
                  ),
                  onPressed: () {
                    _login(
                      context,
                      _emailController.text,
                      _passwordController.text,
                    );
                  },
                  child: const Text(
                    'Entrar',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _login(context, email, password) async {
  try {
    final response = await Service.post('/account/login', {
      'email': email,
      'password': password,
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      Account account = Account.fromJson(responseBody['account']);
      print(account);
      String token = responseBody['access_token'];
      GlobalState globalState =
          Provider.of<GlobalState>(context, listen: false);
      globalState.updateAuth(token, account);
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
