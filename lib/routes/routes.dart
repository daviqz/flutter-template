import 'package:authorspace/utils/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:authorspace/screens/home/home.dart';
import 'package:authorspace/screens/login/login.dart';
import 'package:authorspace/screens/register/register.dart';
import 'package:authorspace/storage/global_state.dart';

final Map<String, WidgetBuilder> systemRoutes = {
  '/login': (context) => const Login(),
  '/register': (context) => const Register(),
};

class Routes extends StatelessWidget {
  const Routes({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GlobalState(),
      child: MaterialApp(
        title: 'Meu Aplicativo',
        home: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            // scaffoldBackgroundColor: ColorsUtils.blackLessDark,
            textTheme: TextTheme(
              displayLarge: const TextStyle(
                fontSize: 72,
                fontWeight: FontWeight.bold,
              ),
              titleLarge: GoogleFonts.oswald(
                fontSize: 30,
                fontStyle: FontStyle.italic,
              ),
              bodyMedium: GoogleFonts.merriweather(),
              displaySmall: GoogleFonts.pacifico(),
            ),
          ),
          routes: systemRoutes,
          home: const AuthenticationScreen(),
        ),
      ),
    );
  }
}

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalState globalState = Provider.of<GlobalState>(context);
    bool isLoggedIn = globalState.loggedUser != null;

    if (isLoggedIn) {
      return DefaultTabController(
        length: 5,
        child: Scaffold(
          body: const TabBarView(
            children: [
              Home(),
              Icon(Icons.directions_bike),
              Icon(Icons.directions_bike),
              Icon(Icons.directions_bike),
              Icon(Icons.directions_bike),
            ],
          ),
          bottomNavigationBar: TabBar(
            tabs: [
              _buildTab(Icons.home, "Home", ColorsUtils.white),
              _buildTab(Icons.travel_explore, "Explore", ColorsUtils.white),
              _buildTab(Icons.favorite_border, "Favorites", ColorsUtils.white),
              _buildTab(Icons.update, "Updates", ColorsUtils.white),
              _buildTab(Icons.settings, "Settings", ColorsUtils.white),
            ],
            unselectedLabelColor: ColorsUtils.grey,
            labelColor: ColorsUtils.lightBlue,
          ),
        ),
      );
    } else {
      return const Login();
    }
  }
}

Widget _buildTab(IconData icon, String text, Color color) {
  return Tab(
    icon: Icon(icon, color: color),
    text: text,
  );
}
