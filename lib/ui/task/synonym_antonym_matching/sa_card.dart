import 'package:Dimik/models/sa.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SACard extends StatefulWidget {
  SAItem item1, item2, item3;
  List<SAItem> items = [];

  SACard(this.item1, this.item2, this.item3) {
    items.add(item1);
    items.add(item2);
    items.add(item3);
  }

  @override
  State<StatefulWidget> createState() {
    return SNCardState();
  }
}

class SNCardState extends State<SACard> {
  AudioPlayer audioPlayer;

  Future successAudio() async {
    audioPlayer = await AudioCache().play("audios/success.mp3");
  }

  Future errorAudio() async {
    audioPlayer = await AudioCache().play("audios/error.mp3");
  }

  void CorrectAnswer() {
    successAudio();
  }

  void WrongAnswer() {
    errorAudio();
  }

  List<Widget> generateOptions(int type) {
    List<Widget> widgets = new List<Widget>();

    for (int i = 0; i < 3; i++) {
      Container container = new Container(
          decoration: new BoxDecoration(
              border: new Border.all(color: Colors.grey.withOpacity(0.25)),
              color: Colors.white),
          height: 55,
          width: 100,
          child: Center(
            child: Text(
              type == 1 ? widget.items[i].synonym : widget.items[i].antonym,
              style: TextStyle(color: Colors.black),
            ),
          ));
      widgets.add(Positioned(
        child: Draggable(
          child: container,
          feedback: Container(
              width: 100,
              height: 55,
              child: RaisedButton(
                onPressed: () {},
                child: Text(
                  type == 1 ? widget.items[i].synonym : widget.items[i].antonym,
                  style: TextStyle(
                    fontSize: 15, /*color: Color(0x2E303E)*/
                  ),
                  textAlign: TextAlign.center,
                ),
                //textColor: Colors.white,
                //highlightColor: Colors.red,
                color: Colors.white,
                elevation: 1,
                highlightElevation: 0.5,
              )),
          childWhenDragging: Container(),
          data: type == 1 ? widget.items[i].synonym : widget.items[i].antonym,
        ),
        left: (100 * i).toDouble(),
      ));
    }

    return widgets;
  }

  List<Widget> generateItems(SAItem item) {
    List<Widget> widgets = [];
    Container c = Container(
      decoration: new BoxDecoration(
          border: new Border.all(color: Colors.white), color: Colors.grey),
      width: 100,
      height: 55,
      child: Center(
          child: Text(
        item.word,
        style: TextStyle(color: Colors.white),
      )),
    );

    widgets.add(c);
    bool accepted = false;
    String correct = "";
    Widget s1 = DragTarget(
      builder: (context, List<String> candidateData, rejectedData) {
        return accepted
            ? Container(
                decoration: new BoxDecoration(
                  border: new Border.all(color: Colors.grey.withOpacity(0.25)),
                  color: Color.fromRGBO(83, 195, 111, 1),
                ),
                height: 55,
                width: 100,
                child: Center(
                  child: Text(
                    correct,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            : Container(
                decoration: new BoxDecoration(
                  border: new Border.all(color: Colors.grey.withOpacity(0.25)),
                  color: Colors.white,
                ),
                height: 55,
                width: 100);
      },
      onWillAccept: (data) {
        return !accepted;
      },
      onAccept: (data) {
        if (item.synonym == data) {
          CorrectAnswer();
          correct = data;
          accepted = true;
        } else {
          WrongAnswer();
        }
      },
    );

    widgets.add(s1);

    Widget a1 = DragTarget(
      builder: (context, List<String> candidateData, rejectedData) {
        return accepted
            ? Container(
                decoration: new BoxDecoration(
                  border: new Border.all(color: Colors.grey.withOpacity(0.25)),
                  color: Color.fromRGBO(83, 195, 111, 1),
                ),
                height: 55,
                width: 100,
                child: Center(
                  child: Text(
                    correct,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            : Container(
                decoration: new BoxDecoration(
                  border: new Border.all(color: Colors.grey.withOpacity(0.25)),
                  color: Colors.white,
                ),
                height: 55,
                width: 100);
      },
      onWillAccept: (data) {
        return !accepted;
      },
      onAccept: (data) {
        if (item.antonym == data) {
          CorrectAnswer();
          setState(() {
            correct = data;
            accepted = true;
          });
        } else {
          WrongAnswer();
        }
      },
    );

    widgets.add(a1);

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.all(const Radius.circular(30)),
      ),
      height: MediaQuery.of(context).size.height * (450.0 / 740.0),
      width: MediaQuery.of(context).size.width * (450.0 / 360.0),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 35,
            left: 135,
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(maxHeight: 55, maxWidth: 100 * 2.toDouble()),
              child: Row(
                children: <Widget>[
                  Container(
                    decoration: new BoxDecoration(
                        border: new Border.all(color: Colors.white),
                        color: Colors.grey),
                    width: 100,
                    height: 55,
                    child: Center(
                        child: Text(
                      'Synonym',
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                  Container(
                    decoration: new BoxDecoration(
                        border: new Border.all(color: Colors.white),
                        color: Colors.grey),
                    width: 100,
                    height: 55,
                    child: Center(
                        child: Text(
                      'Antonym',
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(maxHeight: 55, maxWidth: 100 * 3.toDouble()),
              child: Row(
                children: generateItems(widget.items[0]),
              ),
            ),
            top: 90,
            left: 35,
          ),
          Positioned(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(maxHeight: 55, maxWidth: 100 * 3.toDouble()),
              child: Row(
                children: generateItems(widget.items[1]),
              ),
            ),
            top: 145,
            left: 35,
          ),
          Positioned(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(maxHeight: 55, maxWidth: 100 * 3.toDouble()),
              child: Row(
                children: generateItems(widget.items[2]),
              ),
            ),
            top: 200,
            left: 35,
          ),
          Positioned(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(maxHeight: 55, maxWidth: 100 * 3.toDouble()),
              child: Stack(
                children: generateOptions(1),
              ),
            ),
            top: 320,
            left: 35,
          ),
          Positioned(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(maxHeight: 55, maxWidth: 100 * 3.toDouble()),
              child: Stack(
                children: generateOptions(2),
              ),
            ),
            top: 375,
            left: 35,
          ),
        ],
      ),
    );
  }
}
