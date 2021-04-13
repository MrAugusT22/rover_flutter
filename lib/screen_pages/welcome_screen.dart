import 'package:be_extc/utilities/car_data.dart';
import 'package:be_extc/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:be_extc/models/authentication_buttons.dart';
import 'package:provider/provider.dart';
import 'package:be_extc/screen_pages/wifi_chat_screen.dart';
import 'package:be_extc/models/message_bubble.dart';
import 'package:be_extc/models/blob.dart';

enum connectivityMode { bluetooth, wifi }

class WelcomePage extends StatefulWidget {
  static const String id = 'welcome_page';

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with TickerProviderStateMixin {
  static const _kToggleDuration = Duration(milliseconds: 300);
  static const _kRotationDuration = Duration(seconds: 5);

  AnimationController _rotationController;
  AnimationController _scaleController;

  double _rotation = 0;
  double _scale = 0.85;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _rotationController =
        AnimationController(vsync: this, duration: _kRotationDuration);
    _rotationController.addListener(() {
      setState(() {
        _updateRotation();
      });
    });
    _rotationController.forward();
    _rotationController.repeat();

    _scaleController =
        AnimationController(vsync: this, duration: _kToggleDuration);
    _scaleController.addListener(() {
      setState(() {
        _updateScale();
      });
    });
    _scaleController.forward();
  }

  double pi = 22 / 7;

  void _updateRotation() => _rotation = _rotationController.value * pi;
  void _updateScale() => _scale = (_scaleController.value * 20) + 0.85;

  @override
  void dispose() {
    // TODO: implement dispose
    _scaleController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  void greetUser(CarData carData) {
    if (DateTime.now().hour < 12) {
      carData.addMessage(
        MessageBubble(
          messageText: 'Good Morning Chief. Hope you have a nice day ahead.',
          isVoice: false,
          sender: 'rov3R',
          isMe: false,
          time: formatTimestamp(DateTime.now()),
        ),
      );
    } else if (DateTime.now().hour < 16) {
      carData.addMessage(
        MessageBubble(
          messageText: 'Good Afternoon Chief. Let\'s get going.',
          isVoice: false,
          sender: 'rov3R',
          isMe: false,
          time: formatTimestamp(DateTime.now()),
        ),
      );
    } else {
      carData.addMessage(
        MessageBubble(
          messageText: 'Good Evening Chief. Hope you had a nice day.',
          isVoice: false,
          sender: 'rov3R',
          isMe: false,
          time: formatTimestamp(DateTime.now()),
        ),
      );
    }
  }

  void addMessage(CarData carData, String msg) {
    carData.addMessage(MessageBubble(
      messageText: '$msg',
      isVoice: false,
      sender: 'rov3R',
      isMe: false,
      time: formatTimestamp(DateTime.now()),
    ));
  }

  void getStarted(CarData carData) {
    greetUser(carData);
    addMessage(carData,
        'Chief, please make sure you\'re connected to the appropriate WiFi network.');
    Provider.of<CarData>(context, listen: false).updateConnectivity(true);
    Navigator.pushNamed(context, WifiChatScreen.id);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CarData>(builder: (context, carData, child) {
      return Scaffold(
        backgroundColor: kMyDarkBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              // Blob(
              //   color: Color(0xff4ac7b7), // color green
              //   scale: _scale,
              //   rotation: _rotation * 2 - 30, // offset angle from _rotation
              // ),
              // Blob(
              //   color: Color(0xffa4a6f6), // color purple
              //   scale: _scale,
              //   rotation: _rotation * 3 - 45, // offset angle from _rotation
              // ),
              Blob(
                color: Color(0xff0092ff), // color blue
                scale: _scale,
                rotation: _rotation,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration:
                        BoxDecoration(shape: BoxShape.circle, boxShadow: [
                      BoxShadow(
                        color: Colors.blue,
                        blurRadius: 10,
                        spreadRadius: 0.0,
                      ),
                    ]),
                    child: Hero(
                      tag: 'logo',
                      child: CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.blue,
                        child: CircleAvatar(
                          radius: 78,
                          backgroundImage: AssetImage(kMyImage),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      '$kMyProjectName',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'RobotoMono',
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: AuthenticationButtons(
                  gradient: kOfflineGradient,
                  buttonText:
                      Text('GET STARTED', style: kWelcomePageButtonTextStyle),
                  onPressed: () {
                    getStarted(carData);
                  },
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
