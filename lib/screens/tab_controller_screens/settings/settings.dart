import 'package:mobiletemplate/config/location-texts.config.dart';
import 'package:mobiletemplate/storage/global_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final localizedTexts = LocalizedTexts(context);
    String appTitle = localizedTexts.settings;

    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
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
                'Light/dark',
              ),
            ),
            const SelectLanguage()
          ],
        ),
      ),
    );
  }
}

class SelectLanguage extends StatefulWidget {
  const SelectLanguage({
    super.key,
  });

  @override
  SelectLanguageState createState() => SelectLanguageState();
}

class SelectLanguageState extends State<SelectLanguage> {
  @override
  Widget build(BuildContext context) {
    GlobalState globalState = Provider.of<GlobalState>(context, listen: true);
    return DropdownButton<String>(
      value: globalState.appLanguageName,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      underline: Container(
        height: 2,
      ),
      onChanged: (String? newValue) {
        globalState.updateAppLanguage(newValue!);
      },
      items: <String>['en', 'pt'].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
