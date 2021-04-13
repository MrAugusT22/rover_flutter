import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:be_extc/utilities/car_data.dart';

class RecogniseMessage {
  final BuildContext context;
  RecogniseMessage({@required this.context});

  String defaultDist = '5';

  void recogniseMessage({String input}) {
    List f = Provider.of<CarData>(context, listen: false).getCmdList('f');
    List b = Provider.of<CarData>(context, listen: false).getCmdList('b');
    List r = Provider.of<CarData>(context, listen: false).getCmdList('r');
    List l = Provider.of<CarData>(context, listen: false).getCmdList('l');
    List h1 = Provider.of<CarData>(context, listen: false).getCmdList('h1');
    List h2 = Provider.of<CarData>(context, listen: false).getCmdList('h2');
    List a = Provider.of<CarData>(context, listen: false).getCmdList('a');
    List c = Provider.of<CarData>(context, listen: false).getCmdList('c');
    List s = Provider.of<CarData>(context, listen: false).getCmdList('s');
    List u = Provider.of<CarData>(context, listen: false).getCmdList('u');
    List re = Provider.of<CarData>(context, listen: false).getCmdList('re');
    List res = Provider.of<CarData>(context, listen: false).getCmdList('res');

    final String headlightsOnRegEx = '(${h1.join('|')})';
    final String headlightsOffRegEx = '(${h2.join('|')})';
    final String autoModeRegEx = '(${a.join('|')})';
    final String controlModeRegEx = '(${c.join('|')})';
    final String frontRegEx = '(${f.join('|')})';
    final String backRegEx = '(${b.join('|')})';
    final String leftRegEx = '(${l.join('|')})';
    final String rightRegEx = '(${r.join('|')})';
    final String stopRegEx = '(${s.join('|')})';
    final String uTurnRegEx = '(${u.join('|')})';
    final String recallRegex = '(${re.join('|')})';
    final String resetRegex = '(${res.join('|')})';
    final String dist = r'\d{1,}';

    final RegExp headlightOn = RegExp(headlightsOnRegEx);
    final RegExp headlightOff = RegExp(headlightsOffRegEx);
    final RegExp autoMode = RegExp(autoModeRegEx);
    final RegExp controlMode = RegExp(controlModeRegEx);
    final RegExp front = RegExp(frontRegEx);
    final RegExp back = RegExp(backRegEx);
    final RegExp left = RegExp(leftRegEx);
    final RegExp right = RegExp(rightRegEx);
    final RegExp stop = RegExp(stopRegEx);
    final RegExp uTurn = RegExp(uTurnRegEx);
    final RegExp recall = RegExp(recallRegex);
    final RegExp reset = RegExp(resetRegex);
    final RegExp distance = RegExp(dist);

    bool isDist = distance.hasMatch(input);
    Provider.of<CarData>(context, listen: false).toggleDistance(isDist);

    if (headlightOff.hasMatch(input)) {
      //Headlights Off
      print('off');
      Provider.of<CarData>(context, listen: false).move(
        fb: -2,
        lr: -2,
        dist: isDist ? distance.stringMatch(input).toString() : defaultDist,
        move: false,
      );
      Provider.of<CarData>(context, listen: false).toggleHeadLight(false);
      Provider.of<CarData>(context, listen: false).toggleMovement('h2');
    } else if (headlightOn.hasMatch(input)) {
      //Headlights On
      Provider.of<CarData>(context, listen: false).move(
        fb: -2,
        lr: -2,
        dist: isDist ? distance.stringMatch(input).toString() : defaultDist,
        move: false,
      );
      Provider.of<CarData>(context, listen: false).toggleHeadLight(true);
      Provider.of<CarData>(context, listen: false).toggleMovement('h1');
    } else if (autoMode.hasMatch(input)) {
      //AutoMode
      Provider.of<CarData>(context, listen: false).move(
        fb: -2,
        lr: -2,
        dist: isDist ? distance.stringMatch(input).toString() : defaultDist,
        move: false,
      );
      Provider.of<CarData>(context, listen: false).toggleAutoMode(true);
      Provider.of<CarData>(context, listen: false).toggleMovement('a');
    } else if (controlMode.hasMatch(input)) {
      //ControlMode
      Provider.of<CarData>(context, listen: false).move(
        fb: -2,
        lr: -2,
        dist: isDist ? distance.stringMatch(input).toString() : defaultDist,
        move: false,
      );
      Provider.of<CarData>(context, listen: false).toggleAutoMode(false);
      Provider.of<CarData>(context, listen: false).toggleMovement('c');
    } else if (front.hasMatch(input)) {
      // Front
      Provider.of<CarData>(context, listen: false).move(
        fb: 1,
        lr: 0,
        dist: isDist ? distance.stringMatch(input).toString() : defaultDist,
        move: true,
      );
      Provider.of<CarData>(context, listen: false).toggleMovement('f');
    } else if (back.hasMatch(input)) {
      //Back
      Provider.of<CarData>(context, listen: false).move(
        fb: -1,
        lr: 0,
        dist: isDist ? distance.stringMatch(input).toString() : defaultDist,
        move: true,
      );
      Provider.of<CarData>(context, listen: false).toggleMovement('b');
    } else if (left.hasMatch(input)) {
      //Left
      Provider.of<CarData>(context, listen: false).move(
        fb: 0,
        lr: -1,
        dist: isDist ? distance.stringMatch(input).toString() : defaultDist,
        move: true,
      );
      Provider.of<CarData>(context, listen: false).toggleMovement('l');
    } else if (right.hasMatch(input)) {
      //Right
      Provider.of<CarData>(context, listen: false).move(
        fb: 0,
        lr: 1,
        dist: isDist ? distance.stringMatch(input).toString() : defaultDist,
        move: true,
      );
      Provider.of<CarData>(context, listen: false).toggleMovement('r');
    } else if (stop.hasMatch(input)) {
      //Stop
      Provider.of<CarData>(context, listen: false).move(
        fb: 0,
        lr: 0,
        dist: isDist ? distance.stringMatch(input).toString() : '0',
        move: false,
      );
      Provider.of<CarData>(context, listen: false).toggleMovement('s');
    } else if (uTurn.hasMatch(input)) {
      // U turn
      Provider.of<CarData>(context, listen: false).move(
        fb: 0,
        lr: 0,
        dist: isDist ? distance.stringMatch(input).toString() : defaultDist,
        move: true,
      );
      Provider.of<CarData>(context, listen: false).toggleMovement('u');
    } else if (recall.hasMatch(input)) {
      // Recall
      Provider.of<CarData>(context, listen: false).toggleMovement('re');
      print('recall detected');
    } else if (reset.hasMatch(input)) {
      // Reset
      Provider.of<CarData>(context, listen: false).move(
        fb: 0,
        lr: 0,
        dist: '0',
        move: false,
      );
      Provider.of<CarData>(context, listen: false).reset();
      Provider.of<CarData>(context, listen: false).toggleMovement('res');
      print('reset detected');
    } else {
      // Not recognized
      print('e');
      Provider.of<CarData>(context, listen: false).move(
        fb: 0,
        lr: 0,
        dist: '0',
        move: false,
      );
      Provider.of<CarData>(context, listen: false).toggleMovement('e');
    }
  }

  // Future buildBottomSheet(BuildContext context) {
  //   return showModalBottomSheet(
  //     backgroundColor: Colors.transparent,
  //     shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.only(
  //             topLeft: Radius.circular(30), topRight: Radius.circular(30))),
  //     isScrollControlled: true,
  //     context: context,
  //     builder: (context) => SingleChildScrollView(
  //       child: Container(
  //         padding:
  //             EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
  //         child: ExitBottomSheet(),
  //       ),
  //     ),
  //   );
  // }
}
