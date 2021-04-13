import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'car_data.dart';
import 'package:be_extc/screen_pages/welcome_screen.dart';

class ShowDialogBox {
  final BuildContext context;
  final String title;
  final String msg;
  final String actionButtonText;
  final bool exit;

  ShowDialogBox(
      {@required this.context,
      @required this.actionButtonText,
      @required this.msg,
      @required this.title,
      @required this.exit});

  void exitToWelcomePage(BuildContext context) {
    Provider.of<CarData>(context, listen: false).deleteMessages(index: -1);
    Provider.of<CarData>(context, listen: false).updateTextControllerText('');
    Provider.of<CarData>(context, listen: false).reset();
    Navigator.pushNamedAndRemoveUntil(
        context, WelcomePage.id, (route) => false);
  }

  Future showDialogBox() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.grey[900],
          title: Text(
            '/$title',
            style: TextStyle(
                fontFamily: 'RobotoMono',
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
          content: Text(
            msg,
            style: TextStyle(
              fontFamily: 'RobotoMono',
              fontStyle: FontStyle.italic,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => exit
                  ? exitToWelcomePage(context)
                  : Navigator.of(context).pop(true),
              child: Text(
                actionButtonText,
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("CANCEL"),
            ),
          ],
        );
      },
    );
  }
}
