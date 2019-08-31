import 'package:Dimik/ScopedModel/mainmodel.dart';
import 'package:Dimik/ui/task/TrueFalse/true_false_task.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:scoped_model/scoped_model.dart';

class TrueFalseCard extends StatefulWidget {
  final String question;
  final String answer;
  final String index;
  String explaination;

  TrueFalseCard(
      {@required this.index,
      @required this.question,
      @required this.answer,
      @required this.explaination});

  @override
  State<StatefulWidget> createState() {
    return TrueFalseCardState();
  }
}

class TrueFalseCardState extends State<TrueFalseCard> {
  bool _disabled_true_button = false;
  bool _disabled_false_button = false;
  AudioPlayer audioPlayer;

  @override
  void initState() {
    super.initState();
  }

  Future successAudio() async {
    audioPlayer = await AudioCache().play("audios/success.mp3");
  }

  Future errorAudio() async {
    audioPlayer = await AudioCache().play("audios/error.mp3");
  }

  void CorrectAnswer() {
    successAudio();
    TrueFalseState.scaffoldKey.currentState
        .showBottomSheet<Null>((BuildContext context) {
      return Container(
          decoration: BoxDecoration(
              color: Color.fromRGBO(83, 195, 111, 1),
              borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(30),
                  topRight: const Radius.circular(30))),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.20,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 20,
                left: 20,
                child: Text(
                  widget.explaination,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.10,
                left: MediaQuery.of(context).size.width * 0.40,
                child: FlatButton(
                  child: Text(
                    'Got It',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ));
    });
  }

  void WrongAnswer() {
    errorAudio();
    TrueFalseState.scaffoldKey.currentState
        .showBottomSheet<Null>((BuildContext context) {
      return Container(
          decoration: BoxDecoration(
              color: Color.fromRGBO(255, 131, 131, 1),
              borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(30),
                  topRight: const Radius.circular(30))),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.20,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 20,
                left: 20,
                child: Text(
                  widget.explaination,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.10,
                left: MediaQuery.of(context).size.width * 0.40,
                child: FlatButton(
                  child: Text(
                    'Got It',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Container(
            child: Stack(
              children: <Widget>[
                Positioned(
                    top: 25,
                    left: 20,
                    child: Container(
                        height: 47,
                        width: 47,
                        child: Center(
                          child: Text(widget.index),
                        ),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(133, 119, 226, 0.25),
                          borderRadius:
                              new BorderRadius.all(const Radius.circular(15)),
                        ))),
                Positioned(
                  top: 115,
                  left: 20,
                  right: 20,
                  child: Text(widget.question, style: TextStyle(fontSize: 18)),
                ),
                Positioned(
                  top: 245,
                  left: 95,
                  right: 95,
                  child: Container(
                    height: (50.0 / 740.0) * MediaQuery.of(context).size.height,
                    width: (130.0 / 360.0) * MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: _disabled_true_button
                          ? Colors.grey
                          : Color.fromRGBO(83, 195, 111, 1),
                      borderRadius:
                          new BorderRadius.all(const Radius.circular(23)),
                    ),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(23.0)),
                      onPressed: () {
                        if (!_disabled_false_button && !_disabled_true_button) {
                          if (widget.answer.toLowerCase() == 'true') {
                            CorrectAnswer();
                            model.incrementTFScore();
                          } else {
                            WrongAnswer();
                            model.decrementTFScore();
                          }

                          setState(() {
                            _disabled_false_button = true;
                            _disabled_true_button = true;
                          });
                        }
                      },
                      child: Text(
                        'True',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w100),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 330,
                  left: 95,
                  right: 95,
                  child: Container(
                    height: (50.0 / 740.0) * MediaQuery.of(context).size.height,
                    width: (130.0 / 360.0) * MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: _disabled_false_button
                          ? Colors.grey
                          : Color.fromRGBO(255, 131, 131, 1),
                      borderRadius:
                          new BorderRadius.all(const Radius.circular(23)),
                    ),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(23.0)),
                      onPressed: () {
                        if (!_disabled_false_button && !_disabled_true_button) {
                          if (widget.answer.toLowerCase() == 'false') {
                            CorrectAnswer();
                            model.incrementTFScore();
                          } else {
                            WrongAnswer();
                            model.decrementTFScore();
                          }

                          setState(() {
                            _disabled_false_button = true;
                            _disabled_true_button = true;
                          });
                        }
                      },
                      child: Text(
                        'False',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w100),
                      ),
                    ),
                  ),
                )
              ],
            ),
            margin: EdgeInsets.all(20),
            height: (453.0 / 740.0) * MediaQuery.of(context).size.height,
            width: (320.0 / 360.0) * MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.all(const Radius.circular(30)),
            ));
      },
    );
  }
}
