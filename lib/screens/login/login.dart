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
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final localizedTexts = LocalizedTexts(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.08),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Column(
                  children: <Widget>[
                    Icon(Icons.login, size: MediaQuery.of(context).size.height * 0.15),
                    Text(localizedTexts.placeholder, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              InputForm(
                inputFieldValueController: _emailController,
                labelText: localizedTexts.email,
                hintText: localizedTexts.enterYourEmail,
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              InputForm(
                inputFieldValueController: _passwordController,
                labelText: localizedTexts.password,
                hintText: localizedTexts.enterYourPassword,
                icon: Icons.lock,
                keyboardType: TextInputType.text,
                obscureText: true,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Center(
                child: Column(
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(MediaQuery.of(context).size.height * 0.4, MediaQuery.of(context).size.height * 0.1),
                        padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height * 0.025, horizontal: MediaQuery.of(context).size.height * 0.04),
                      ),
                      onPressed: () {
                        _login(_emailController.text, _passwordController.text, localizedTexts);
                      },
                      child: Text(localizedTexts.signIn, style: const TextStyle(fontSize: 17)),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    TextButton(
                      onPressed: () {
                        AutoRouter.of(context).pushNamed('/register');
                      },
                      child: Text(localizedTexts.dontHaveAnAccountSignUp),
                    ),
                  ],
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
