import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:authorspace/service/service.dart';
import 'package:authorspace/widgets/input_form.dart';
import 'package:authorspace/storage/global_state.dart';
import 'package:authorspace/models/account_model.dart';
import 'package:http/http.dart' as http;
import 'package:authorspace/widgets/system_toast.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
          alignment: Alignment.center,
          child: const Text(
            'Login',
            style: TextStyle(
              fontSize: 20, // Tamanho do texto
              fontWeight: FontWeight.bold, // Peso da fonte
            ),
          ),
        ),
      ),
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
              const SizedBox(height: 30),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text(
                  'Registre-se',
                ),
              ),
              const SizedBox(height: 50),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
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
    final response = await Service.post('/auth/login', {'email': email, 'password': password});
    if (response['account'] != null && response['token'] != null) {
      Account account = Account.fromJson(response['account']);
      String token = response['token'];
      GlobalState globalState = Provider.of<GlobalState>(context, listen: false);
      globalState.updateAuth(token, account);
    }
  } catch (e) {
    print(e);
    var message = 'Erro desconhecido';
    if (e is http.ClientException) {
      message = e.message;
    }
    SystemToast.show(message, 'error');
  }
}
