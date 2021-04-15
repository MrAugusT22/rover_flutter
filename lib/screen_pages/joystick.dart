import 'package:be_extc/utilities/car_data.dart';
import 'package:be_extc/utilities/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class Joystick extends StatefulWidget {
  final Function sendState;
  final Function recall;
  Joystick({@required this.sendState, @required this.recall});

  @override
  _JoystickState createState() => _JoystickState();
}

class _JoystickState extends State<Joystick> {
  bool f = false;
  bool b = false;
  bool l = false;
  bool r = false;
  bool re = false;
  bool u = false;
  bool autoMode;
  bool hl;
  bool s = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp
    ]);
    super.dispose();
  }

  void init(CarData carData) {
    hl = carData.getHeadlightToggle;
    autoMode = carData.getMode;
  }

  void sendMessage(bool b) {
    while (b) {
      print('sending');
      Future.delayed(Duration(seconds: 1));
      if (s) {
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CarData>(
      builder: (context, carData, child) {
        init(carData);
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    JoystickButtons(
                      iconData: Icons.sync_rounded,
                      onPressedDown: (value) {
                        print('pressed');
                        setState(() {
                          re = true;
                        });
                        widget.recall(carData);
                      },
                      onPressedUp: (value) {
                        print('removed');
                        setState(() {
                          re = false;
                        });
                      },
                      isPressed: re,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //forward
                        JoystickButtons(
                          iconData: Icons.arrow_upward_rounded,
                          onPressedDown: (value) {
                            print('pressed');
                            setState(() {
                              f = true;
                            });
                            carData.move(
                              fb: 1,
                              lr: 0,
                              dist: 1000,
                              move: true,
                            );
                            String state = carData.getState;
                            widget.sendState(state);
                          },
                          onPressedUp: (value) {
                            print('removed');
                            setState(() {
                              f = false;
                            });
                            carData.move(
                              fb: 0,
                              lr: 0,
                              dist: 0,
                              move: false,
                            );
                            String state = carData.getState;
                            widget.sendState(state);
                          },
                          isPressed: f,
                        ),
                        SizedBox(height: 70),
                        JoystickButtons(
                          iconData: Icons.arrow_downward_rounded,
                          onPressedDown: (value) {
                            print('pressed');
                            setState(() {
                              b = true;
                            });
                            carData.move(
                              fb: -1,
                              lr: 0,
                              dist: 1000,
                              move: true,
                            );
                            String state = carData.getState;
                            widget.sendState(state);
                          },
                          onPressedUp: (value) {
                            print('removed');
                            setState(() {
                              b = false;
                            });
                            carData.move(
                              fb: 0,
                              lr: 0,
                              dist: 0,
                              move: false,
                            );
                            String state = carData.getState;
                            widget.sendState(state);
                          },
                          isPressed: b,
                        ),
                      ],
                    ),
                    JoystickButtons(
                      iconData: Icons.refresh_rounded,
                      onPressedDown: (value) {
                        print('u turn pressed');
                        setState(() {
                          u = true;
                        });
                        carData.move(
                          fb: 0,
                          lr: 0,
                          dist: -1,
                          move: true,
                        );
                        String state = carData.getState;
                        widget.sendState(state);
                      },
                      onPressedUp: (value) {
                        print('removed');
                        setState(() {
                          u = false;
                        });
                        carData.move(
                          fb: 0,
                          lr: 0,
                          dist: 0,
                          move: false,
                        );
                        String state = carData.getState;
                        widget.sendState(state);
                      },
                      isPressed: u,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    JoystickButtons(
                      iconData: Icons.arrow_back_rounded,
                      onPressedDown: (value) {
                        print('pressed');
                        setState(() {
                          l = true;
                        });
                        carData.move(
                          fb: 0,
                          lr: -1,
                          dist: 1000,
                          move: true,
                        );
                        String state = carData.getState;
                        widget.sendState(state);
                      },
                      onPressedUp: (value) {
                        print('removed');
                        setState(() {
                          l = false;
                        });
                        carData.move(
                          fb: 0,
                          lr: 0,
                          dist: 0,
                          move: false,
                        );
                        String state = carData.getState;
                        widget.sendState(state);
                      },
                      isPressed: l,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        JoystickButtons(
                          iconData: autoMode
                              ? Icons.alt_route_rounded
                              : Icons.trending_up_rounded,
                          onPressedDown: (value) {
                            print('pressed');
                            setState(() {
                              autoMode = !autoMode;
                            });
                            carData.toggleAutoMode(autoMode);
                            carData.move(
                              fb: -2,
                              lr: -2,
                              dist: 5,
                              move: false,
                            );
                            String state = carData.getState;
                            widget.sendState(state);
                          },
                          isPressed: autoMode,
                        ),
                        SizedBox(height: 70),
                        JoystickButtons(
                          iconData: Icons.flash_on_rounded,
                          onPressedDown: (value) {
                            print('pressed');
                            setState(() {
                              hl = !hl;
                            });
                            carData.toggleHeadLight(hl);
                            carData.move(
                              fb: -2,
                              lr: -2,
                              dist: 5,
                              move: false,
                            );
                            String state = carData.getState;
                            widget.sendState(state);
                          },
                          onPressedUp: (value) {},
                          isPressed: carData.getHeadlightToggle,
                        ),
                      ],
                    ),
                    JoystickButtons(
                      iconData: Icons.arrow_forward_rounded,
                      onPressedDown: (value) {
                        print('pressed');
                        setState(() {
                          r = true;
                        });
                        carData.move(
                          fb: 0,
                          lr: 1,
                          dist: 1000,
                          move: true,
                        );
                        String state = carData.getState;
                        widget.sendState(state);
                      },
                      onPressedUp: (value) {
                        print('removed');
                        setState(() {
                          r = false;
                        });
                        carData.move(
                          fb: 0,
                          lr: 0,
                          dist: 0,
                          move: false,
                        );
                        String state = carData.getState;
                        widget.sendState(state);
                      },
                      isPressed: r,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class JoystickButtons extends StatelessWidget {
  final Function onPressedDown;
  final Function onPressedUp;
  final IconData iconData;
  final bool isPressed;
  JoystickButtons({
    this.onPressedUp,
    this.onPressedDown,
    this.iconData,
    this.isPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: onPressedDown,
      onPointerUp: onPressedUp,
      child: Material(
        elevation: 5,
        shape: CircleBorder(),
        child: Container(
          constraints: BoxConstraints(minWidth: 100, minHeight: 100),
          decoration: BoxDecoration(
            gradient: isPressed ? kOfflineGradient : kOnlineUserMessageGradient,
            shape: BoxShape.circle,
          ),
          child: Icon(iconData),
        ),
      ),
    );
  }
}
