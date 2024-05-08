import 'package:authorspace/screens/settings/settings.dart';
import 'package:authorspace/utils/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:authorspace/screens/home/home.dart';
import 'package:authorspace/screens/login/login.dart';
import 'package:authorspace/storage/global_state.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalState globalState = Provider.of<GlobalState>(context);
    globalState.checkTokenAndLogoutIfExpired();
    bool isLoggedIn = globalState.loggedUser != null;
    return isLoggedIn ? const TabController() : const Login();
  }
}

class TabController extends StatelessWidget {
  const TabController({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        body: const TabBarView(
          children: [
            Home(),
            Icon(Icons.directions_bike),
            Icon(Icons.directions_bike),
            Icon(Icons.directions_bike),
            Settings(),
          ],
        ),
        bottomNavigationBar: TabBar(
          tabs: [
            _buildTab(Icons.home, "Home"),
            _buildTab(Icons.travel_explore, "Explore"),
            _buildTab(Icons.favorite_border, "Favorites"),
            _buildTab(Icons.update, "Updates"),
            _buildTab(Icons.settings, "Settings"),
          ],
          unselectedLabelColor: ColorsUtils.grey,
          labelColor: ColorsUtils.lightBlue,
        ),
      ),
    );
  }
}

Widget _buildTab(IconData icon, String text) {
  return Tab(
    icon: Icon(icon),
    text: text,
  );
}
