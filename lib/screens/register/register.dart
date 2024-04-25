import 'package:flutter/material.dart';
import 'package:authorspace/utils/colors_utils.dart';
import 'package:authorspace/service/service.dart';
import 'package:authorspace/widgets/input_form.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordControllerConfirm =
      TextEditingController();

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
              ),
              const SizedBox(height: 25),
              InputForm(
                inputFieldValueController: _emailController,
                labelText: 'Email',
                hintText: 'Digite seu email',
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
              ),
              const SizedBox(height: 35),
              InputForm(
                inputFieldValueController: _passwordController,
                labelText: 'Senha',
                hintText: 'Digite sua senha',
                icon: Icons.lock,
                keyboardType: TextInputType.text,
                obscureText: true,
              ),
              const SizedBox(height: 25),
              InputForm(
                inputFieldValueController: _passwordControllerConfirm,
                labelText: 'Confirmação de senha',
                hintText: 'Confirme a senha',
                icon: Icons.lock,
                keyboardType: TextInputType.text,
                obscureText: true,
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

  void _register(String username, String email, String password,
      String passwordConfirm) async {
    try {
      final response = await Service.post('/account/register', {
        'username': username,
        'email': email,
        'password': password,
        'passwordConfirm': passwordConfirm
      });
      if (response.statusCode == 200) {
        print('Conteúdo da resposta: ${response.body}');
        // Faça o que quiser com o conteúdo da resposta aqui
      } else {
        print('Erro na requisição: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao fazer a requisição: $e');
    }
  }
}

void fetchData() async {}
