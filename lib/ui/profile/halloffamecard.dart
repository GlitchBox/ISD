import 'dart:math';
import 'package:flutter/material.dart';

class HallofFameCard extends StatelessWidget {
  final String title;
  int r, g, b;
  HallofFameCard({@required this.title});

  @override
  Widget build(BuildContext context) {
    r = Random().nextInt(255);
    g = Random().nextInt(255);
    b = Random().nextInt(255);

    return SizedBox(
        width: 90,
        child: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                // Where the linear gradient begins and ends
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                // Add one stop for each color. Stops should increase from 0 to 1
                stops: [
                  0.3,
                  0.3,
                  0.3,
                ],
                colors: [
                  // Colors are easy thanks to Flutter's Colors class.
                  Color.fromRGBO(r, g, b, 1),
                  Color.fromRGBO(g, r, b, 1),
                  Color.fromRGBO(g, b, r, 1),
                ],
              ),
              borderRadius: new BorderRadius.all(const Radius.circular(15))),
          child: Center(
            child: Text(
              title,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ));
  }
}
