import 'package:Dimik/ScopedModel/jumbled_model.dart';
import 'package:Dimik/ui/task/jumble_Sentence/jumbleSentenceButtonDrag.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';
import '../jumble_Sentence/jumbleSentenceDrag.dart';
import 'package:Dimik/databaseChange/jumbleSentence.dart';
import 'package:Dimik/ScopedModel/mainmodel.dart';
import 'package:scoped_model/scoped_model.dart';

class dragableFG extends StatefulWidget {
  bool isDisAbled = false;
  jumbleSentence title;
  final Function getFunc;
  //final bool isLoaded;
  //dragableFG({this.title, this.getFunc, this.isLoaded});
  dragableFG({this.title, this.getFunc});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return dragableFGStats(title: title, getFunc: getFunc);
  }
}

class dragableFGStats extends State<dragableFG> {
  jumbleSentence title;
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
  List<String>questionPart=new List();
  List<String>correctPart=new List();
  //List<String> CorrectAns = new List();
  String CorrectSentence;
  List<int> correctButtonPosition = new List();
  List<String> correct = new List();
  String tempString = "";

  void getElement() {
    //question = title.getQuestion;
    Option = title.getQuestionPart;
    questionPart=title.getQuestionPart;
    correctPart=title.getCorrect;
    //Option = title.getCorrect;
    for (int i = 0; i < questionPart.length; i++) correctButtonPosition.add(0);
    for (int i = 0; i < questionPart.length; i++) quesPart.add("__________");
    //for(int i=0;i<question)
    //CorrectAns = title.getCorrect;
    CorrectSentence = title.getCorrectSentence;
  }

  void makeCorrectPositionSaved(int pos) {
    correctButtonPosition[pos] = 1;
    print("in");
    print(pos);
    //drawButton(context);
  }

  void showBottleSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color.fromARGB(3, 0, 255, 0),
            //Colors.withOpacity(0.3),
            height: 100,
            child: Center(
                child: Text(
              "check",
              style: TextStyle(fontSize: 30, color: Colors.red),
            )),
          );
        });
  }

  // void questionPartitioning() {
  //   List<String> temp = new List();
  //   int i = 0;

  //   while (i < question.length) {
  //     if (question[i] != '#') {
  //       String t = "";
  //       while (question[i] != '#') {
  //         t += question[i];
  //         i++;
  //         if (i >= question.length) break;
  //         //print(t);
  //       }
  //       temp.add(t);
  //     } else {
  //       temp.add('#');
  //       i++;
  //     }
  //   }

  //   int tempCount = 0;
  //   for (int i = 0; i < Option.length; i++) {
  //     if (Option.elementAt(i).length > tempCount) {
  //       tempCount = Option.elementAt(i).length;
  //     }
  //   }

  //   for (int i = 0; i < temp.length; i++) {
  //     if (temp.elementAt(i).contains("#")) {
  //       String str = "";
  //       for (int j = 0; j < tempCount; j++) {
  //         str += '_';
  //       }
  //       for (int j = 0; j < tempCount; j++) {
  //         str += '_';
  //       }
  //       quesPart.add(str);
  //       //print(temp.elementAt(i));
  //     } else {
  //       quesPart.add(temp.elementAt(i));
  //       //print(temp.elementAt(i));
  //     }
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getElement();

    for (int i = 0; i < correctPart.length; i++) {
      correct.add("");
    }
    //questionPartitioning();
  }

  void checkSolution(){
    int flag=0;
    for(int i=0;i<correct.length;i++){
      if(correct[i]==correctPart[i]){
        continue;
      }
      else flag=1;
    }
    if(flag==1) getFunc(false);
    else getFunc(true);
  }

  void captureCorrect(String str, int pos) {
    correct[pos] = str;
    //showBottleSheet();
    int flag1=0,flag2=0;
    for(int i=0;i<correct.length;i++){
      if(correct[i]=="") flag1=1;
      
    }
    if(flag1==0){
      checkSolution();
    }
  }

  //List<String> CorrectAns = ['Madagaskar', 'South Africa'];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // if (widget.isLoaded == true) {
    //   return CircularProgressIndicator(
    //     strokeWidth: 3.0,
    //     valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
    //   );
    // }
    return ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget widget, MainModel model){
      if(model.getIsLoaded == true){
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
                //left: 200,
                //top: 10,
                top: 20,
                //bottom: 270,
                left: .01,
                right: .01,
                child: Container(
                    padding: EdgeInsets.only(left: 30, right: 20),
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
                top: 200,
                left: .01,
                right: .001,
                child: Container(
                  padding: EdgeInsets.only(left: 30, right: 30, top: 70),
                  width: MediaQuery.of(context).size.width,
                  child: Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: drawButton(context),
                  ),
                ))
          ],
        ));
    });


  }

  Color colorChange(int pos) {
    List<Color> colorList = [Colors.white, Colors.green, Colors.red];
    return colorList.elementAt(pos);
  }

  List<Widget> drawQuestion(BuildContext context) {
    //getElement();
    //questionPartitioning();
    List<Widget> tiles = new List();

    for (int i = 0; i < correctPart.length; i++) {
      tiles.add(
        DragGapsView("__________", i, 0, getFunc, captureCorrect),
      );
    }

    return List<Widget>.generate(quesPart.length, (i) {
      return tiles.elementAt(i);
    });
  }

  List<Widget> drawButton(BuildContext context) {
    List<Widget> tiles = new List();

    for (int i = 0; i < Option.length; i++) {
      tiles.add(DragGapsButtonView(Option.elementAt(i)));
    }
      
    return List<Widget>.generate(Option.length, (i) {
      return tiles.elementAt(i);
    });
  }
}

