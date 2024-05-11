import 'package:auto_route/annotations.dart';
import 'package:mobiletemplate/screens/tab_controller_screens/home/home.dart';
import 'package:mobiletemplate/screens/tab_controller_screens/settings/settings.dart';
import 'package:flutter/material.dart';

@RoutePage()
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
            _buildTab(Icons.home),
            _buildTab(Icons.travel_explore),
            _buildTab(Icons.favorite_border),
            _buildTab(Icons.update),
            _buildTab(Icons.settings),
          ],
        ),
      ),
    );
  }
}

Widget _buildTab(IconData icon) {
  return Tab(
    icon: Icon(icon),
  );
}
