import 'package:authorspace/config/location-texts.config.dart';
import 'package:authorspace/enums/toast.enum.dart';
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
    final localizedTexts = LocalizedTexts(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          alignment: Alignment.center,
          child: Text(localizedTexts.login, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                labelText: localizedTexts.email,
                hintText: localizedTexts.enterYourEmail,
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
              ),
              const SizedBox(height: 30),
              InputForm(
                inputFieldValueController: _passwordController,
                labelText: localizedTexts.password,
                hintText: localizedTexts.enterYourPassword,
                icon: Icons.lock,
                keyboardType: TextInputType.text,
                obscureText: true,
              ),
              const SizedBox(height: 30),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/register');
                },
                child: Text(localizedTexts.register),
              ),
              const SizedBox(height: 50),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 50),
                    padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
                  ),
                  onPressed: () {
                    _login(context, _emailController.text, _passwordController.text, localizedTexts);
                  },
                  child: Text(localizedTexts.enter, style: const TextStyle(fontSize: 17)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _login(BuildContext context, String email, String password, LocalizedTexts localizedTexts) async {
  try {
    final response = await Service.post('/auth/login', {'email': email, 'password': password});
    if (response['account'] != null && response['token'] != null) {
      Account account = Account.fromJson(response['account']);
      String token = response['token'];
      // ignore: use_build_context_synchronously
      GlobalState globalState = Provider.of<GlobalState>(context, listen: false);
      globalState.updateAuth(token, account);
    }
  } catch (e) {
    print(e);
    var message = localizedTexts.unknownError;
    if (e is http.ClientException) {
      message = e.message;
    }
    SystemToast.show(message, ToastEnum.error);
  }
}
