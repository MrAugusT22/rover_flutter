import 'package:flutter/material.dart';

class AuthenticationButtons extends StatelessWidget {
  final Color color;
  final Gradient gradient;
  final Text buttonText;
  final Function onPressed;

  AuthenticationButtons(
      {@required this.buttonText,
      this.color,
      this.gradient,
      @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: color,
            gradient: gradient),
        child: RawMaterialButton(
          padding: EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 5,
          onPressed: onPressed,
          child: buttonText,
        ),
      ),
    );
  }
}
