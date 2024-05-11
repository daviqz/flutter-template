import 'package:auto_route/annotations.dart';
import 'package:mobiletemplate/screens/tab_controller_screens/home/home.dart';
import 'package:mobiletemplate/screens/tab_controller_screens/settings/settings.dart';
import 'package:mobiletemplate/utils/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:mobiletemplate/config/location-texts.config.dart';

@RoutePage()
class TabControllerRoutes extends StatelessWidget {
  const TabControllerRoutes({super.key});

  @override
  Widget build(BuildContext context) {
    final localizedTexts = LocalizedTexts(context);

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
            _buildTab(Icons.home, localizedTexts.home),
            _buildTab(Icons.travel_explore, localizedTexts.explore),
            _buildTab(Icons.favorite_border, localizedTexts.favorites),
            _buildTab(Icons.update, localizedTexts.updates),
            _buildTab(Icons.settings, localizedTexts.settings),
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
