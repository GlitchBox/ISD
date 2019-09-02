import 'package:flutter/material.dart';
import 'package:Dimik/databaseChange/mcqData.dart';

class controllerClass extends StatefulWidget {
  //Map<Map<String, String>, String> title = new Map();
  MCQ title;
  final Function getFunc;
  final bool isLoaded;
  String value="Solved";
  controllerClass({this.title,this.getFunc,this.isLoaded});
  @override
  State<StatefulWidget> createState() {
    return controllerCLassState(title: title,getFunc: getFunc,isLoaded: isLoaded);
  }
}

class controllerCLassState extends State<controllerClass> {
  MCQ title;
  final Function getFunc;
  final bool isLoaded;
  controllerCLassState({this.title,this.getFunc,this.isLoaded});
  String question = "";
  String options, correctAns;
  String option1, option2, option3, option4;

  //Color colo1,colo2,colo3,color4;
  Color colo1 = Colors.white;
  Color colo2 = Colors.white;
  Color colo3 = Colors.white;
  Color colo4 = Colors.white;
  Color Red = Color(0xFFFF8383);
  Color Green = Color(0xFF53C36F);

  bool isButtonDIsabled=true;

  TextEditingController txt=new TextEditingController();

  

  void makingTheFormation() {
    
    question = title.question;
    //print(question);

    
    correctAns = title.correctAns.elementAt(0);
    //print(correctAns);

  
    option1 = title.getOption.elementAt(0);
    option2 = title.getOption.elementAt(1);
    option3 = title.getOption.elementAt(2);
    option4 = title.getOption.elementAt(3);
  }

  

  void _onPressedButton(String value, String buttonNum) {
    if (value == correctAns && isButtonDIsabled) {
      String temp = "colo" + buttonNum;
      if (temp == "colo1") {
        setState(() {
          colo1 = Green;
        });
      } else if (temp == "colo2") {
        setState(() {
          colo2 = Green;
        });
      } else if (temp == "colo3") {
        setState(() {
          colo3 = Green;
        });
      } else if (temp == "colo4") {
        setState(() {
          colo4 = Green;
        });
      }
      isButtonDIsabled=false;
      print(temp);
      print("correctAns " + correctAns);
      print(value);
      //runCard();
      
     // widget.getFunc(true);
    }
    else{
      String temp = "colo" + buttonNum;

      if (temp == "colo1" && isButtonDIsabled) {
        setState(() {
          colo1 = Red;
          question=value;
        });
      } else if (temp == "colo2" && isButtonDIsabled) {
        setState(() {
          colo2 = Red;
          question=value;
        });
      } else if (temp == "colo3" && isButtonDIsabled) {
        setState(() {
          colo3 = Red;
          question=value;
        });
      } else if (temp == "colo4" && isButtonDIsabled) {
        setState(() {
          colo4 = Red;
          question=value;
        });
      }
      print(option1);
      print(option2);
      print(option3);
      print(option4);
      print(correctAns);
      
      if (correctAns == option1 && isButtonDIsabled) {
        setState(() {
          colo1 = Green;
        });
      } else if (correctAns == option2 && isButtonDIsabled) {
        setState(() {
          colo2 = Green;
        });
      } else if (correctAns == option3 && isButtonDIsabled) {
        setState(() {
          colo3 = Green;
        });
      } else if (correctAns == option4 && isButtonDIsabled) {
        setState(() {
          colo4 = Green;
        });
        
      }
      isButtonDIsabled=false;
     // widget.getFunc(false);
    }
    //ChangeText();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    makingTheFormation();
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: MediaQuery.of(context).size.height*(40/453),
            left: MediaQuery.of(context).size.width * (20 / 320),
                    right: MediaQuery.of(context).size.width * (.1 / 320),
            //width: 280,
            //height: 70,
            child: Text(
              
              "$question",
              style: TextStyle(
                  fontSize: 25,
                  //fontFamily: ,
                  letterSpacing: -0.654545),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height*(139.63/453),
            left: MediaQuery.of(context).size.width * (20 / 320),
            width: MediaQuery.of(context).size.height*(54/320),
            height: MediaQuery.of(context).size.height*(30/320),
            child: RaisedButton(
              onPressed: () {
                _onPressedButton(option1, "1");
                setState(() {
                  
                });
              },
              child: Text(
                option1,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(23)),
              //textColor: Colors.white,
              //highlightColor: Colors.red,
              color: colo1,
              elevation: 10,
              //highlightElevation: 0.5,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height*(139.63/453),
            right: MediaQuery.of(context).size.width * (20 / 320),
            width: MediaQuery.of(context).size.height*(54/320),
            height: MediaQuery.of(context).size.height*(30/320),
            child: RaisedButton(
              onPressed: () {
                _onPressedButton(option2, "2");
              },
              child: Text(
                option2,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(23)),
              //textColor: Colors.white,
              //highlightColor: Colors.red,
              color: colo2,
              elevation: 10,
              //highlightElevation: 0.5,
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height*(30/453),
            left: MediaQuery.of(context).size.width * (20 / 320),
            width: MediaQuery.of(context).size.height*(54/320),
            height: MediaQuery.of(context).size.height*(30/320),
            child: RaisedButton(
              onPressed: () {
                _onPressedButton(option3, "3");
              },
              child: Text(
                option3,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(23)),
              //textColor: Colors.white,
              //highlightColor: Colors.red,
              color: colo3,
              elevation: 10,
              //highlightElevation: 0.5,
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height*(30/453),
            right: MediaQuery.of(context).size.width * (20 / 320),
            width: MediaQuery.of(context).size.height*(54/320),
            height: MediaQuery.of(context).size.height*(30/320),
            child: new RaisedButton(
              onPressed: () {
                _onPressedButton(option4, "4");
              },
              child: Text(
                option4,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(23)),
              //textColor: Colors.white,
              //highlightColor: Colors.red,
              color: colo4,

              elevation: 10,
              //highlightElevation: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
