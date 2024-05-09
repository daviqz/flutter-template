import 'package:mobiletemplate/routes/tab_controller_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobiletemplate/screens/login/login.dart';
import 'package:mobiletemplate/storage/global_state.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalState globalState = Provider.of<GlobalState>(context);
    globalState.checkTokenAndLogoutIfExpired();
    bool isLoggedIn = globalState.loggedUser != null;
    return isLoggedIn ? const TabControllerRoutes() : const Login();
  }
}
