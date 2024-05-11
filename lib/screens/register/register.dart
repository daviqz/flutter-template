import 'package:auto_route/auto_route.dart';
import 'package:mobiletemplate/config/location-texts.config.dart';
import 'package:mobiletemplate/enums/toast.enum.dart';
import 'package:flutter/material.dart';
import 'package:mobiletemplate/service/service.dart';
import 'package:mobiletemplate/widgets/input_form.dart';
import 'package:http/http.dart' as http;
import 'package:mobiletemplate/widgets/system_toast.dart';

@RoutePage()
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
  final TextEditingController _confirmPasswordController = TextEditingController();
  Map<String, dynamic>? fieldErrors;

  @override
  Widget build(BuildContext context) {
    final localizedTexts = LocalizedTexts(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          localizedTexts.goBackToLogin,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width * 0.08, //left
          MediaQuery.of(context).size.height * 0.03, //top
          MediaQuery.of(context).size.width * 0.08, //right
          MediaQuery.of(context).size.height * 0.08, //bottom
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Column(
                  children: <Widget>[
                    Icon(Icons.login, size: MediaQuery.of(context).size.height * 0.05),
                    Text(localizedTexts.registerYourAccount, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              InputForm(
                inputFieldValueController: _usernameController,
                labelText: localizedTexts.username,
                hintText: localizedTexts.enterYourUsername,
                icon: Icons.person,
                keyboardType: TextInputType.text,
                obscureText: false,
                errorText: fieldErrors?['username'],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.025),
              InputForm(
                inputFieldValueController: _emailController,
                labelText: localizedTexts.email,
                hintText: localizedTexts.enterYourEmail,
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
                errorText: fieldErrors?['email'],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.025),
              InputForm(
                inputFieldValueController: _passwordController,
                labelText: localizedTexts.password,
                hintText: localizedTexts.enterYourPassword,
                icon: Icons.lock,
                keyboardType: TextInputType.text,
                obscureText: true,
                errorText: fieldErrors?['password'],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.025),
              InputForm(
                inputFieldValueController: _confirmPasswordController,
                labelText: localizedTexts.passwordConfirmation,
                hintText: localizedTexts.confirmPassword,
                icon: Icons.lock,
                keyboardType: TextInputType.text,
                obscureText: true,
                errorText: fieldErrors?['confirmPassword'],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.07),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(MediaQuery.of(context).size.height * 0.4, MediaQuery.of(context).size.height * 0.1),
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.025, horizontal: MediaQuery.of(context).size.height * 0.04),
                ),
                onPressed: () {
                  _register(
                      _usernameController.text, _emailController.text, _passwordController.text, _confirmPasswordController.text, localizedTexts);
                },
                child: Text(localizedTexts.register, style: const TextStyle(fontSize: 17)),
              ),
              const SizedBox(height: 50),
              // TextButton(
              //   onPressed: () {
              //     AutoRouter.of(context).pushNamed('/login');
              //   },
              //   child: Text(localizedTexts.goBackToLogin),
              // )
            ],
          ),
        ),
      ),
    );
  }

  void _register(String username, String email, String password, String confirmPassword, LocalizedTexts localizedTexts) async {
    try {
      final response = await Service.post(
        '/auth/register',
        {'username': username, 'email': email, 'password': password, 'confirmPassword': confirmPassword},
      );

      if (response['fieldErrors'] != null) {
        setState(() {
          fieldErrors = response['fieldErrors'];
        });
      } else {
        SystemToast.show(response['message'], toastEnumFromString(response['type']));
        // ignore: use_build_context_synchronously
        AutoRouter.of(context).pushNamed('/login');
      }
    } catch (e) {
      var message = localizedTexts.unknownError;
      if (e is http.ClientException) {
        message = e.message;
      }
      SystemToast.show(message, ToastEnum.error);
    }
  }
}

void fetchData() async {}
