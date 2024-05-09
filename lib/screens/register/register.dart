import 'package:mobiletemplate/config/location-texts.config.dart';
import 'package:mobiletemplate/enums/toast.enum.dart';
import 'package:flutter/material.dart';
import 'package:mobiletemplate/service/service.dart';
import 'package:mobiletemplate/widgets/input_form.dart';
import 'package:http/http.dart' as http;
import 'package:mobiletemplate/widgets/system_toast.dart';

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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          alignment: Alignment.center,
          child: Text(
            localizedTexts.registerYourAccount,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InputForm(
                inputFieldValueController: _usernameController,
                labelText: localizedTexts.username,
                hintText: localizedTexts.enterYourUsername,
                icon: Icons.person,
                keyboardType: TextInputType.text,
                obscureText: false,
                errorText: fieldErrors?['username'],
              ),
              const SizedBox(height: 25),
              InputForm(
                inputFieldValueController: _emailController,
                labelText: localizedTexts.email,
                hintText: localizedTexts.enterYourEmail,
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
                errorText: fieldErrors?['email'],
              ),
              const SizedBox(height: 35),
              InputForm(
                inputFieldValueController: _passwordController,
                labelText: localizedTexts.password,
                hintText: localizedTexts.enterYourPassword,
                icon: Icons.lock,
                keyboardType: TextInputType.text,
                obscureText: true,
                errorText: fieldErrors?['password'],
              ),
              const SizedBox(height: 25),
              InputForm(
                inputFieldValueController: _confirmPasswordController,
                labelText: localizedTexts.passwordConfirmation,
                hintText: localizedTexts.confirmPassword,
                icon: Icons.lock,
                keyboardType: TextInputType.text,
                obscureText: true,
                errorText: fieldErrors?['confirmPassword'],
              ),
              const SizedBox(height: 70),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                  padding: const EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 40.0,
                  ),
                ),
                onPressed: () {
                  _register(
                      _usernameController.text, _emailController.text, _passwordController.text, _confirmPasswordController.text, localizedTexts);
                },
                child: Text(localizedTexts.register, style: const TextStyle(fontSize: 17)),
              ),
              const SizedBox(height: 50),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: Text(localizedTexts.alreadyAUserLogin),
              )
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
        Navigator.pushReplacementNamed(context, '/login');
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
}

void fetchData() async {}
