import 'package:be_extc/screen_pages/wifi_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:be_extc/screen_pages/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'package:be_extc/utilities/car_data.dart';
import 'package:be_extc/utilities/constants.dart';

void main() {
  runApp(
    BEApp(),
  );
}

class BEApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CarData>(
      create: (context) => CarData(),
      child: MaterialApp(
        theme: kMyDarkTheme,
        initialRoute: WelcomePage.id,
        routes: {
          WelcomePage.id: (context) => WelcomePage(),
          WifiChatScreen.id: (context) => WifiChatScreen(),
        },
      ),
    );
  }
}
