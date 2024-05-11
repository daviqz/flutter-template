import 'package:mobiletemplate/config/location-texts.config.dart';
import 'package:mobiletemplate/storage/global_state.dart';
import 'package:flutter/material.dart';
import 'package:mobiletemplate/service/service.dart';
import 'package:http/http.dart' as http;

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final localizedTexts = LocalizedTexts(context);
    String appTitle = localizedTexts.home;

    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                GlobalState globalState = GlobalState();
                globalState.clearAuth();
              },
              child: Text(localizedTexts.logout),
            ),
            TextButton(
              onPressed: () {
                _handleClickGetUserAccount(localizedTexts);
              },
              child: Text(
                localizedTexts.testAuthEndpoint,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _handleClickGetUserAccount(localizedTexts) async {
  try {
    final response = await Service.get('/account/protected');
    print(response);
  } catch (e) {
    var message = localizedTexts.unknownError;
    if (e is http.ClientException) {
      message = e.message;
    }
    print(message);
  }
}
