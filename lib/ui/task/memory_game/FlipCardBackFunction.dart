import 'package:Dimik/style/theme.dart' as prefix0;
import 'package:Dimik/ui/task/memory_game/optionButton.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flip_card/flip_card.dart';
import '../../../ScopedModel/mainmodel.dart';
import 'package:Dimik/models/memorygame.dart';

class FlipCardBackView extends StatefulWidget {
  final MG card;
  FlipCardBackView({this.card});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FlipCardBackStats(card: card);
  }
}

class FlipCardBackStats extends State<FlipCardBackView> {
  MG card;
  FlipCardBackStats({this.card});
  List<Color> col = new List();
  List<String> correct = new List();
  List<String> option = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // option.add("Dog");
    // option.add("Cat");
    // option.add("Mat");
    // option.add("Bat");

    // correct.add("Dog");
    // correct.add("Mat");

    for(int i=0;i<card.correctAnswers.length;i++){
      correct.add(card.correctAnswers.elementAt(i));
      print(correct);
    }

    for(int i=0;i<card.options.length;i++){
      option.add(card.options.elementAt(i));
    }

    for (int i = 0; i < option.length; i++) {
      col.add(Colors.grey);
    }
  }

  bool checkButton(String val, int index) {
    bool flag;
    ;
    if (correct.contains(val)) {
      col[index] = Colors.green;
      correct.remove(val);
      flag = true;
    } else {
      col[index] = Colors.red;
      flag = false;
    }
    setState(() {});
    return flag;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Stack(children: <Widget>[
        Positioned(
            top: MediaQuery.of(context).size.height * (143 / 740),
            bottom: MediaQuery.of(context).size.height * (144 / 740),
            left: MediaQuery.of(context).size.width * (20 / 370),
            right: MediaQuery.of(context).size.width * (20 / 370),
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                child: Stack(children: <Widget>[
                  Positioned(
                    //left: 200,
                    //top: 10,
                    top: MediaQuery.of(context).size.height * (20 / 453),
                    //bottom: 270,
                    left: MediaQuery.of(context).size.width * (2 / 320),
                    right: MediaQuery.of(context).size.width * (2 / 320),
                    child: Container(
                        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * (18 / 320), 
                                      right: MediaQuery.of(context).size.width * (18 / 320)),
                        width: MediaQuery.of(context).size.width,
                        child: Wrap(
                            // spacing: 8.0,
                            //runSpacing: 4.0,
                            //children: drawQuestion(context)

                            children: <Widget>[
                              Text(
                                "What can you find from the picture ?",
                                style: TextStyle(fontSize: 28),
                              ),
                            ])
                        //Text("data")

                        ),
                  ),
                  Positioned(
                      top: MediaQuery.of(context).size.width * (150 / 453),
                      left: MediaQuery.of(context).size.width * (.1 / 320),
                      right: MediaQuery.of(context).size.width * (.1 / 320),
                      child: Container(
                        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * (15 / 320), 
                                  right: MediaQuery.of(context).size.width * (15 / 320), 
                                    top: MediaQuery.of(context).size.height * (200/option.length / 320)),
                        width: MediaQuery.of(context).size.width,
                        child: Wrap(
                          spacing: 8.0,
                          runSpacing: 4.0,
                          children: drawButton(context, model),
                        ),
                      ))
                ])))
      ]);
    });
  }

  List<Widget> drawButton(BuildContext context, MainModel model) {
    List<Widget> tiles = new List();
    for (int i = 0; i < option.length; i++) {
      tiles.add(OptionButton(
        text: option.elementAt(i),
        col: col.elementAt(i),
        index: i,
        func: checkButton,
      ));
    }

    return List<Widget>.generate(option.length, (i) {
      return tiles.elementAt(i);
    });
  }
}
