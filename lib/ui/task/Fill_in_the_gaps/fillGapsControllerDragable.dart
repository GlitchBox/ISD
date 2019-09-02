import 'package:flutter/material.dart';
import 'dart:async';
import '../Fill_in_the_gaps/draggableFbButton.dart';
import 'package:Dimik/databaseChange/FBGapData.dart';

class dragableFG extends StatefulWidget {
  bool isDisAbled = false;
  FbGap title;
  final Function getFunc;
  final bool isLoaded;
  dragableFG({this.title, this.getFunc, this.isLoaded});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return dragableFGStats(title: title, getFunc: getFunc);
  }
}

class dragableFGStats extends State<dragableFG> {
  FbGap title;
  final Function getFunc;
  dragableFGStats({this.title, this.getFunc});
  Color buttonColor = Colors.white;
  List<String> quesPart = new List();
  //String question = "String String String # String String # String String";
  String question;
  //int partition = 5;

  // List<String> Option = [
  //   'Honululu',
  //   'Madagaskar',
  //   'South Africa',
  //   'Bangladesh',
  //   'West Indies',
  //   'Pakistan'
  // ];
  List<String> Option = new List();
  List<String> CorrectAns = new List();
  List<int> correctButtonPosition = new List();

  void getElement() {
    question = title.getQuestion;
    Option = title.getOption;
    for (int i = 0; i < Option.length; i++) correctButtonPosition.add(0);
    CorrectAns = title.getCorrect;
  }

  void makeCorrectPositionSaved(int pos) {
    correctButtonPosition[pos] = 1;
    print("in");
    print(pos);
    //drawButton(context);
  }

  void questionPartitioning() {
    List<String> temp = new List();
    int i = 0;

    while (i < question.length) {
      if (question[i] != '#') {
        String t = "";
        while (question[i] != '#') {
          t += question[i];
          i++;
          if (i >= question.length) break;
          //print(t);
        }
        temp.add(t);
      } else {
        temp.add('#');
        i++;
      }
    }

    int tempCount = 0;
    for (int i = 0; i < Option.length; i++) {
      if (Option.elementAt(i).length > tempCount) {
        tempCount = Option.elementAt(i).length;
      }
    }

    for (int i = 0; i < temp.length; i++) {
      if (temp.elementAt(i).contains("#")) {
        String str = "";
        for (int j = 0; j < tempCount; j++) {
          str += '_';
        }
        for (int j = 0; j < tempCount; j++) {
          str += '_';
        }
        quesPart.add(str);
        //print(temp.elementAt(i));
      } else {
        quesPart.add(temp.elementAt(i));
        //print(temp.elementAt(i));
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getElement();
    questionPartitioning();
  }

  //List<String> CorrectAns = ['Madagaskar', 'South Africa'];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (widget.isLoaded == true) {
      return CircularProgressIndicator(
        strokeWidth: 3.0,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
      );
    }
    return Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        child: Stack(
          children: <Widget>[
            Positioned(
                 top: MediaQuery.of(context).size.height * (40 / 453),
                    //bottom: 270,
                    left: MediaQuery.of(context).size.width * (7 / 320),
                    right: MediaQuery.of(context).size.width * (.1 / 320),
                child: Container(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * (18 / 320),
                        right: MediaQuery.of(context).size.width * (18 / 320)),
                    width: MediaQuery.of(context).size.width,
                    child: Wrap(
                      // spacing: 8.0,
                      //runSpacing: 4.0,
                      //children: drawQuestion(context)

                      children: drawQuestion(context),
                    )
                    //Text("data")

                    )),
            Positioned(
                top: MediaQuery.of(context).size.width * (150 / 453),
                      left: MediaQuery.of(context).size.width * (.1 / 320),
                      right: MediaQuery.of(context).size.width * (.1 / 320),
                child: Container(
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * (15 / 320), 
                                  right: MediaQuery.of(context).size.width * (15 / 320), 
                                    top: MediaQuery.of(context).size.height * (300/Option.length / 320)),
                  child: Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: drawButton(context),
                  ),
                ))
          ],
        ));
  }

  Color colorChange(int pos) {
    List<Color> colorList = [Colors.white, Colors.green, Colors.red];
    return colorList.elementAt(pos);
  }

  List<Widget> drawQuestion(BuildContext context) {
    //getElement();
    //questionPartitioning();
    List<Widget> tiles = new List();
    List<int> gapsNumber = new List();
    List<Key> keyList = new List();
    Map<int, String> answerPos = new Map();

    for (int i = 0; i < CorrectAns.length; i++) {
      keyList.add(UniqueKey());
    }
    int pos = 0;
    print("Question part " + quesPart.length.toString());
    for (int i = 0; i < quesPart.length; i++) {
      if (quesPart.elementAt(i).contains('_')) {
        gapsNumber.add(1);
        answerPos[i] = CorrectAns.elementAt(pos);
        pos++;
      } else {
        gapsNumber.add(0);
      }
    }

    List<List<Color>> colorList = new List();

    for (int i = 0; i < quesPart.length; i++) {
      if (quesPart.elementAt(i).contains('_')) {
        tiles.add(DragGapsView(quesPart.elementAt(i) + " ", answerPos[i], 0,
            getFunc, makeCorrectPositionSaved));
      } else {
        tiles.add(new Container(
            padding: EdgeInsets.only(top: 5),
            //width: MediaQuery.of(context).size.width,
            child: Wrap(children: <Widget>[
              Wrap(
                children: <Widget>[
                  Text(
                    quesPart.elementAt(i) + " ",
                    style: TextStyle(fontSize: 20),
                  )
                ],
              )
            ])));
      }
    }
    return List<Widget>.generate(quesPart.length, (i) {
      return tiles.elementAt(i);
    });
  }

  List<Widget> drawButton(BuildContext context) {
    List<Widget> tiles = new List();

    for (int i = 0; i < Option.length; i++) {
      if (correctButtonPosition.elementAt(i) == 0) {
        tiles.add(Draggable(
          data: Option.elementAt(i) + "#" + i.toString(),
          child: RaisedButton(
            onPressed: () {},
            //disabledColor: Colors.red,
            key: UniqueKey(),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
            child: Text(Option.elementAt(i)),
          ),
          feedback: Container(
              child: RaisedButton(
                  onPressed: () {},
                  //disabledColor: Colors.green,
                  child: Text(
                    Option.elementAt(i),
                    style: TextStyle(
                      fontSize: 15, /*color: Color(0x2E303E)*/
                    ),
                    textAlign: TextAlign.center,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  //textColor: Colors.white,
                  //highlightColor: Colors.red,
                  color: Colors.white,
                  elevation: 1
                  //highlightElevation: 0.5,
                  )),
        ));
      } else {
        tiles.add(
          RaisedButton(
              onPressed: () {},
              //disabledColor: Colors.green,
              child: Text(
                Option.elementAt(i),
                style: TextStyle(
                  fontSize: 15, /*color: Color(0x2E303E)*/
                ),
                textAlign: TextAlign.center,
              ),
              //disabledColor: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              //textColor: Colors.white,
              //highlightColor: Colors.red,
              color: Colors.blue,
              elevation: 1

              //highlightElevation: 0.5,
              ),
        );
      }
    }
    return List<Widget>.generate(Option.length, (i) {
      return tiles.elementAt(i);
    });
  }
}
