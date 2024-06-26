import 'package:mobiletemplate/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobiletemplate/storage/global_state.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GlobalState(),
      child: const AppTheme(),
    );
  }
}

class AppTheme extends StatefulWidget {
  const AppTheme({super.key});

  @override
  AppThemeState createState() => AppThemeState();
}

class AppThemeState extends State<AppTheme> {
  AppRouter appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    GlobalState globalState = Provider.of<GlobalState>(context, listen: true);
    return MaterialApp.router(
      routerConfig: appRouter.config(reevaluateListenable: globalState),
      title: 'Meu Aplicativo',
      debugShowCheckedModeBanner: false,
      locale: Locale(globalState.appLanguageName),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('pt'), // Portuguese
      ],
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color.fromARGB(255, 146, 141, 141),
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: const Color.fromARGB(255, 21, 23, 136),
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      themeMode: _getTheme(globalState.themeName),
    );
  }
}

ThemeMode _getTheme(themeName) {
  //case 'default'
  ThemeMode themeMode = ThemeMode.system;
  switch (themeName) {
    case 'light':
      themeMode = ThemeMode.light;
      break;
    case 'dark':
      themeMode = ThemeMode.dark;
      break;
  }

  return themeMode;
}
