import 'package:mobiletemplate/storage/global_state.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    const String appTitle = 'Flutter Settings';
    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            GlobalState globalState = GlobalState();
            String newTheme = globalState.themeName;
            if (globalState.themeName == 'light') {
              newTheme = 'dark';
            } else {
              newTheme = 'light';
            }
            globalState.updateTheme(newTheme);
          },
          child: const Text(
            'Trocar light/dark',
          ),
        ),
      ),
    );
  }
}
