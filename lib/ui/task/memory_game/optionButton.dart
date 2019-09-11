import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class OptionButton extends StatefulWidget {
  String text;
  Color col;
  int index;
  Function func;

  OptionButton({this.text, this.col, this.index, this.func});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OptionButtonStat(text: text, col: col, index: index, func: func);
  }
}

class OptionButtonStat extends State<OptionButton> {
  String text;
  Color col;
  Function func;
  int index;

  OptionButtonStat({this.text, this.col, this.index, this.func});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (col == Colors.grey) {
      return RaisedButton(
          onPressed: () {
            setState(() {
              print(text);
              if (func(text, index))
                col = Colors.green;
              else
                col = Colors.red;
            });
          },
          child: Text(
            text,
            style: TextStyle(
              fontSize: 15, /*color: Color(0x2E303E)*/
            ),
            textAlign: TextAlign.center,
          ),
          //disabledColor: Colors.blue,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          //textColor: Colors.white,
          //highlightColor: Colors.red,
          color: col,
          elevation: 1);
    }
    return RaisedButton(
          onPressed: () {
            setState(() {
             
            });
          },
          child: Text(
            text,
            style: TextStyle(
              fontSize: 15, /*color: Color(0x2E303E)*/
            ),
            textAlign: TextAlign.center,
          ),
          //disabledColor: Colors.blue,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          //textColor: Colors.white,
          //highlightColor: Colors.red,
          color: col,
          elevation: 1);
  }
  //return
}
