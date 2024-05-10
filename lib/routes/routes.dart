import 'package:mobiletemplate/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobiletemplate/storage/global_state.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Routes extends StatelessWidget {
  const Routes({super.key});

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
  // ignore: library_private_types_in_public_api
  _AppThemeState createState() => _AppThemeState();
}

class _AppThemeState extends State<AppTheme> {
  @override
  Widget build(BuildContext context) {
    GlobalState globalState = Provider.of<GlobalState>(context, listen: true);
    AppRouter appRouter = AppRouter();

    return MaterialApp.router(
      routerConfig: appRouter.config(
        reevaluateListenable: globalState,
      ),
      title: 'Meu Aplicativo',
      debugShowCheckedModeBanner: false,
      locale: const Locale('en'),
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
        colorSchemeSeed: const Color.fromARGB(167, 214, 214, 214),
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: const Color.fromRGBO(86, 80, 14, 171),
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
