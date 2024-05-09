import 'package:mobiletemplate/screens/home/home.dart';
import 'package:mobiletemplate/screens/settings/settings.dart';
import 'package:mobiletemplate/utils/colors_utils.dart';
import 'package:flutter/material.dart';

class TabControllerRoutes extends StatelessWidget {
  const TabControllerRoutes({super.key});

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
