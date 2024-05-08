import 'package:authorspace/routes/routes_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:authorspace/screens/login/login.dart';
import 'package:authorspace/screens/register/register.dart';
import 'package:authorspace/storage/global_state.dart';

final Map<String, WidgetBuilder> systemRoutes = {
  '/login': (context) => const Login(),
  '/register': (context) => const Register(),
};
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
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color.fromARGB(167, 214, 214, 214),
        // textTheme: TextTheme(
        //   displayLarge: const TextStyle(
        //     fontSize: 72,
        //     fontWeight: FontWeight.bold,
        //   ),
        //   titleLarge: GoogleFonts.oswald(
        //     fontSize: 30,
        //     fontStyle: FontStyle.italic,
        //   ),
        //   bodyMedium: GoogleFonts.merriweather(),
        //   displaySmall: GoogleFonts.pacifico(),
        // ),
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: const Color.fromRGBO(86, 80, 14, 171),
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      themeMode: _getTheme(globalState.themeName),
      routes: systemRoutes,
      home: const AuthenticationScreen(),
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
