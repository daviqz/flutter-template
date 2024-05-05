import 'package:flutter/material.dart';
import 'package:authorspace/utils/colors_utils.dart';
import 'package:authorspace/service/service.dart';
import 'package:authorspace/widgets/input_form.dart';
import 'package:http/http.dart' as http;
import 'package:authorspace/widgets/system_toast.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordControllerConfirm = TextEditingController();
  Map<String, dynamic>? fieldErrors;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          color: ColorsUtils.lightBlue, // Cor de fundo da AppBar
          alignment: Alignment.center,
          child: const Text(
            'Registrar sua conta',
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InputForm(
                inputFieldValueController: _usernameController,
                labelText: 'Nome de usuário',
                hintText: 'Digite o seu nome de usuário',
                icon: Icons.person,
                keyboardType: TextInputType.text,
                obscureText: false,
                errorText: fieldErrors?['username'],
              ),
              const SizedBox(height: 25),
              InputForm(
                inputFieldValueController: _emailController,
                labelText: 'Email',
                hintText: 'Digite seu email',
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
                errorText: fieldErrors?['email'],
              ),
              const SizedBox(height: 35),
              InputForm(
                inputFieldValueController: _passwordController,
                labelText: 'Senha',
                hintText: 'Digite sua senha',
                icon: Icons.lock,
                keyboardType: TextInputType.text,
                obscureText: true,
                errorText: fieldErrors?['password'],
              ),
              const SizedBox(height: 25),
              InputForm(
                inputFieldValueController: _passwordControllerConfirm,
                labelText: 'Confirmação de senha',
                hintText: 'Confirme a senha',
                icon: Icons.lock,
                keyboardType: TextInputType.text,
                obscureText: true,
                errorText: fieldErrors?['confirmPassword'],
              ),
              const SizedBox(height: 70),
              ElevatedButton(
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
                  _register(
                    _usernameController.text,
                    _emailController.text,
                    _passwordController.text,
                    _passwordControllerConfirm.text,
                  );
                },
                child: const Text(
                  'Registrar',
                  style: TextStyle(fontSize: 17),
                ),
              ),
              const SizedBox(height: 50),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text(
                  'Já é um usuário? Faça login',
                  style: TextStyle(
                    color: ColorsUtils.blackLessDark,
                  ), // Define a cor do texto do botão
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _register(String username, String email, String password, String confirmPassword) async {
    try {
      final response = await Service.post(
        '/auth/register',
        {'username': username, 'email': email, 'password': password, 'confirmPassword': confirmPassword},
      );

      if (response['fieldErrors'] != null) {
        print(response['fieldErrors']);
        setState(() {
          fieldErrors = response['fieldErrors'];
        });
      } else {
        print(response);
        SystemToast.show(response['message'], response['type']);
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, '/login');
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
}

void fetchData() async {}
