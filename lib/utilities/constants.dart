import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const String kMyProjectName = '/rov3R';
const kMyImage = 'images/rover.jpg';

const IconData kMyBluetoothIcon = Icons.bluetooth_rounded;
const IconData kMyWifiIcon = Icons.wifi_rounded;

ThemeData kMyDarkTheme = ThemeData.dark().copyWith(accentColor: Colors.blue);
ThemeData kMyLightTheme = ThemeData.light().copyWith(
  accentColor: Colors.blue,
);

Color kMyOfflineColor = Colors.lightBlue;
Color kMyOnlineColor = Colors.green;

Color kMyDarkBackgroundColor = Colors.grey[900];
Color kMyOfflineTextMessageColor = kMyOfflineColor;
Color kMyOnlineTextMessageColor = kMyOnlineColor;
Color kUserTextMessageColor = Colors.grey[800];

List<Color> kOfflineGradientColor = [Colors.blue, Colors.blue[900]];
List<Color> kOnlineGradientColor = [Colors.green, Colors.green[900]];
List<Color> kOnlineUserMessageGradientColor = [
  Colors.grey[800],
  Colors.grey[850]
];
List<Color> kCancelButtonGradientColor = [Colors.red, Colors.red[900]];

final LinearGradient kNegativeButtonGradient = LinearGradient(
  colors: kCancelButtonGradientColor,
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

final LinearGradient kPositiveButtonGradient = LinearGradient(
  colors: kOnlineGradientColor,
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

final LinearGradient kOnlineUserMessageGradient = LinearGradient(
  colors: kOnlineUserMessageGradientColor,
  begin: Alignment.bottomRight,
  end: Alignment.topLeft,
);

final LinearGradient kOnlineGradient = LinearGradient(
  colors: kOnlineGradientColor,
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

final LinearGradient kOfflineGradient = LinearGradient(
  colors: kOfflineGradientColor,
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

final LinearGradient kCancelButtonGradient = LinearGradient(
  colors: kCancelButtonGradientColor,
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const kWelcomePageButtonTextStyle = TextStyle(
    fontFamily: 'RobotoMono',
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontSize: 30);
const kButtonTextStyle =
    TextStyle(fontFamily: 'RobotoMono', color: Colors.white, fontSize: 20);
Text kButtonText = Text(
  '',
  style: kButtonTextStyle,
  textAlign: TextAlign.center,
);

InputDecoration kTextMessageInputDecoration = InputDecoration(
  enabledBorder: InputBorder.none,
  focusedBorder: InputBorder.none,
  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  hintText: 'Type a message...',
  hintStyle: TextStyle(color: Colors.grey),
);

InputDecoration kTextFieldDecoration = InputDecoration(
  hintStyle: TextStyle(fontFamily: "RobotoMono"),
  hintText: '',
  contentPadding: EdgeInsets.all(20),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey, width: 1),
    borderRadius: BorderRadius.circular(20),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue, width: 2),
    borderRadius: BorderRadius.circular(20),
  ),
);

Map movement = {0: 'forward', 90: 'right', 180: 'backward', 270: 'left'};
List nonMovement = [
  'Did\'nt got your message 😕',
  'Pardon Chief',
  'Too heavy to decode the COMMAND 😕',
  'Heavy to process the message 😕',
  'Chief, new to english, please use simple words 😉'
];

String getDate(timestamp) {
  var format = DateFormat.yMMMd('en_US');
  String date = format.format(timestamp);
  return date;
}

String formatTimestamp(timestamp) {
  var format = DateFormat('hh:mm a');
  return format.format(timestamp);
}

String capitalize(String s) {
  return '${s[0].toUpperCase()}${s.substring(1)}';
}
