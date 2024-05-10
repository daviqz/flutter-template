import 'package:auto_route/auto_route.dart';
import 'package:mobiletemplate/config/location-texts.config.dart';
import 'package:mobiletemplate/enums/toast.enum.dart';
import 'package:flutter/material.dart';
import 'package:mobiletemplate/service/service.dart';
import 'package:mobiletemplate/widgets/input_form.dart';
import 'package:mobiletemplate/storage/global_state.dart';
import 'package:mobiletemplate/models/account_model.dart';
import 'package:http/http.dart' as http;
import 'package:mobiletemplate/widgets/system_toast.dart';

@RoutePage()
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
                  AutoRouter.of(context).pushNamed('/register');
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
                    _login(_emailController.text, _passwordController.text, localizedTexts);
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

void _login(String email, String password, LocalizedTexts localizedTexts) async {
  try {
    final response = await Service.post('/auth/login', {'email': email, 'password': password});
    if (response['account'] != null && response['token'] != null) {
      Account account = Account.fromJson(response['account']);
      String token = response['token'];
      GlobalState globalState = GlobalState();
      globalState.updateAuth(token, account);
    }
  } catch (e) {
    var message = localizedTexts.unknownError;
    if (e is http.ClientException) {
      message = e.message;
    }
    SystemToast.show(message, ToastEnum.error);
  }
}
