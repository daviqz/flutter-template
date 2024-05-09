import 'package:authorspace/routes/routes_config.dart';
import 'package:authorspace/routes/tab_controller_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:authorspace/screens/login/login.dart';
import 'package:authorspace/screens/register/register.dart';
import 'package:authorspace/storage/global_state.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final List<Map<String, dynamic>> systemRoutes = [
  {'path': '/login', 'screen': (context) => const Login(), 'isPrivate': false, 'canAccessAfterLogin': false},
  {'path': '/register', 'screen': (context) => const Register(), 'isPrivate': false, 'canAccessAfterLogin': false},
  {'path': '/home', 'screen': (context) => const TabControllerRoutes(), 'isPrivate': true, 'canAccessAfterLogin': true},
];

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Routes extends StatelessWidget {
  const Routes({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GlobalState(),
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
    return MaterialApp(
      title: 'Meu Aplicativo',
      navigatorKey: navigatorKey,
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
      home: const AuthenticationScreen(),
      onGenerateRoute: (settings) {
        final userToken = globalState.token;
        final route = systemRoutes.firstWhere(
          (route) => route['path'] == settings.name,
          orElse: () => {'path': '/login', 'screen': (context) => const Login(), 'isPrivate': false, 'canAccessAfterLogin': false},
        );
        if ((route['isPrivate'] && userToken == null)) {
          return MaterialPageRoute(builder: (context) => const Login());
        }
        if (!route['canAccessAfterLogin'] && userToken != null) {
          return MaterialPageRoute(builder: (context) => const TabControllerRoutes());
        }
        return MaterialPageRoute(builder: (BuildContext context) => route['screen'](context));
      },
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
