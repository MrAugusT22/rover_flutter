import 'package:flutter/material.dart';

class Blob extends StatelessWidget {
  final color;
  final scale;
  final rotation;

  Blob({@required this.color, @required this.rotation, @required this.scale});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale,
      child: Transform.rotate(
        angle: rotation,
        child: Container(
          constraints: BoxConstraints(maxHeight: 50, maxWidth: 50),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(150),
              topRight: Radius.circular(240),
              bottomLeft: Radius.circular(220),
              bottomRight: Radius.circular(180),
            ),
            // boxShadow: [
            //   BoxShadow(
            //     color: color,
            //     blurRadius: 0.05,
            //     // spreadRadius: 0.25,
            //   ),
            // ],
            // border: Border.all(
            //   color: color,
            //   width: 2,
            // ),
          ),
        ),
      ),
    );
  }
}
