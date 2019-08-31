import 'dart:io';

import 'package:Dimik/ScopedModel/mainmodel.dart';
import 'package:Dimik/models/listening_item.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:Dimik/ui/task/pictureWord/picture_word_task.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:scoped_model/scoped_model.dart';

class ListeningCard extends StatefulWidget {
  ListeningItem _listeningItem;

  ListeningCard(this._listeningItem);

  @override
  State<StatefulWidget> createState() {
    return ListeningCardState();
  }
}

enum TtsState { playing, stopped }

class ListeningCardState extends State<ListeningCard> {
  FlutterTts flutterTts;

  String _newVoiceText;

  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;
  get isStopped => ttsState == TtsState.stopped;
  AudioPlayer audioPlayer;
  int option1 = 1, option2 = 1, option3 = 1, option4 = 1;
  bool disable1 = false, disable2 = false, disable3 = false, disable4 = false;

  Future _speak(String text) async {
    if (text != null) {
      if (text.isNotEmpty) {
        var result = await flutterTts.speak(text);
        if (result == 1)
          setState(() => ttsState = TtsState.playing);
        else
          print('Error');
      }
    }
  }

  Future initTts() async {
    flutterTts = FlutterTts();
    await flutterTts.setLanguage("en-US");
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(2.0);
    await flutterTts.setSpeechRate(1.0);

    flutterTts.setStartHandler(() {
      setState(() {
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        ttsState = TtsState.stopped;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    initTts();
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }

  Future successAudio() async {
    audioPlayer = await AudioCache().play("audios/success.mp3");
  }

  Future errorAudio() async {
    audioPlayer = await AudioCache().play("audios/error.mp3");
  }

  void disableAll() {
    disable1 = disable2 = disable3 = disable4 = true;
  }

  void CorrectAnswer() {
    setState(() {
      disableAll();
    });
    successAudio();
  }

  void WrongAnswer() {
    setState(() {
      disableAll();
    });
    errorAudio();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.all(const Radius.circular(30)),
          ),
          height: MediaQuery.of(context).size.height * (455.0 / 740.0),
          width: MediaQuery.of(context).size.width * (455.0 / 360.0),
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                left: 20,
                right: 20,
                child: InkWell(
                  onTap: () {
                    _speak(widget
                        ._listeningItem.options[widget._listeningItem.correct]);
                  },
                  child: Image.asset(
                    'assets/img/icons/listen.png',
                    height: 300,
                    width: 300,
                  ),
                ),
              ),
              Positioned(
                top: 290,
                left: 20,
                child: Container(
                  height: (70.0 / 740.0) * MediaQuery.of(context).size.height,
                  width: (130.0 / 360.0) * MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: option1 == 1
                          ? Colors.grey.withOpacity(0.1)
                          : option1 == 2
                              ? Color.fromRGBO(83, 195, 111, 1)
                              : Color.fromRGBO(255, 131, 131, 1),
                      borderRadius:
                          new BorderRadius.all(const Radius.circular(23)),
                      boxShadow: [
                        BoxShadow(
                            color: option1 == 1
                                ? Colors.grey.withOpacity(0.1)
                                : Colors.white.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 5)
                      ]),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(23.0)),
                    onPressed: () {
                      if (!disable1) {
                        if (widget._listeningItem.correct == 1) {
                          setState(() {
                            option1 = 2;
                            model.incrementLTScore();
                            CorrectAnswer();
                          });
                        } else {
                          setState(() {
                            option1 = 3;
                            if (widget._listeningItem.correct == 2) {
                              setState(() {
                                option2 = 2;
                                model.decrementLTScore();
                                WrongAnswer();
                              });
                            }

                            if (widget._listeningItem.correct == 3) {
                              setState(() {
                                option3 = 2;
                                model.decrementLTScore();
                                WrongAnswer();
                              });
                            }
                            if (widget._listeningItem.correct == 4) {
                              setState(() {
                                option4 = 2;
                                model.decrementLTScore();
                                WrongAnswer();
                              });
                            }
                          });
                        }
                      }
                    },
                    child: Text(
                      widget._listeningItem.options[0],
                      style: TextStyle(
                          color: option1 == 1 ? Colors.black : Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w100),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 290,
                right: 20,
                child: Container(
                  height: (70.0 / 740.0) * MediaQuery.of(context).size.height,
                  width: (130.0 / 360.0) * MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: option2 == 1
                          ? Colors.grey.withOpacity(0.1)
                          : option2 == 2
                              ? Color.fromRGBO(83, 195, 111, 1)
                              : Color.fromRGBO(255, 131, 131, 1),
                      borderRadius:
                          new BorderRadius.all(const Radius.circular(23)),
                      boxShadow: [
                        BoxShadow(
                            color: option2 == 1
                                ? Colors.grey.withOpacity(0.1)
                                : Colors.white.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 5)
                      ]),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(23.0)),
                    onPressed: () {
                      if (!disable2) {
                        if (widget._listeningItem.correct == 2) {
                          setState(() {
                            option2 = 2;
                            model.incrementLTScore();
                            CorrectAnswer();
                          });
                        } else {
                          setState(() {
                            option2 = 3;
                            if (widget._listeningItem.correct == 1) {
                              setState(() {
                                option1 = 2;
                                model.decrementLTScore();
                                WrongAnswer();
                              });
                            }

                            if (widget._listeningItem.correct == 3) {
                              setState(() {
                                option3 = 2;
                                model.decrementLTScore();
                                WrongAnswer();
                              });
                            }
                            if (widget._listeningItem.correct == 4) {
                              setState(() {
                                option4 = 2;
                                model.decrementLTScore();
                                WrongAnswer();
                              });
                            }
                          });
                        }
                      }
                    },
                    child: Text(
                      widget._listeningItem.options[1],
                      style: TextStyle(
                          color: option2 == 1 ? Colors.black : Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w100),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 380,
                left: 20,
                child: Container(
                  height: (70.0 / 740.0) * MediaQuery.of(context).size.height,
                  width: (130.0 / 360.0) * MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: option3 == 1
                          ? Colors.grey.withOpacity(0.1)
                          : option3 == 2
                              ? Color.fromRGBO(83, 195, 111, 1)
                              : Color.fromRGBO(255, 131, 131, 1),
                      borderRadius:
                          new BorderRadius.all(const Radius.circular(23)),
                      boxShadow: [
                        BoxShadow(
                            color: option3 == 1
                                ? Colors.grey.withOpacity(0.1)
                                : Colors.white.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 5)
                      ]),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(23.0)),
                    onPressed: () {
                      if (!disable3) {
                        if (widget._listeningItem.correct == 3) {
                          setState(() {
                            option3 = 2;
                            CorrectAnswer();
                            model.incrementLTScore();
                          });
                        } else {
                          setState(() {
                            option3 = 3;
                            if (widget._listeningItem.correct == 1) {
                              setState(() {
                                option1 = 2;
                                WrongAnswer();
                                model.decrementLTScore();
                              });
                            }

                            if (widget._listeningItem.correct == 2) {
                              setState(() {
                                option2 = 2;
                                model.decrementLTScore();
                                WrongAnswer();
                              });
                            }
                            if (widget._listeningItem.correct == 4) {
                              setState(() {
                                option4 = 2;
                                model.decrementLTScore();
                                WrongAnswer();
                              });
                            }
                          });
                        }
                      }
                    },
                    child: Text(
                      widget._listeningItem.options[2],
                      style: TextStyle(
                          color: option3 == 1 ? Colors.black : Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w100),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 380,
                right: 20,
                child: Container(
                  height: (70.0 / 740.0) * MediaQuery.of(context).size.height,
                  width: (130.0 / 360.0) * MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: option4 == 1
                          ? Colors.grey.withOpacity(0.1)
                          : option4 == 2
                              ? Color.fromRGBO(83, 195, 111, 1)
                              : Color.fromRGBO(255, 131, 131, 1),
                      borderRadius:
                          new BorderRadius.all(const Radius.circular(23)),
                      boxShadow: [
                        BoxShadow(
                            color: option4 == 1
                                ? Colors.grey.withOpacity(0.1)
                                : Colors.white.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 5)
                      ]),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(23.0)),
                    onPressed: () {
                      if (!disable4) {
                        if (widget._listeningItem.correct == 4) {
                          setState(() {
                            option4 = 2;
                            model.incrementLTScore();
                            CorrectAnswer();
                          });
                        } else {
                          setState(() {
                            option4 = 3;
                            if (widget._listeningItem.correct == 1) {
                              setState(() {
                                option1 = 2;
                                model.decrementLTScore();
                                WrongAnswer();
                              });
                            }

                            if (widget._listeningItem.correct == 2) {
                              setState(() {
                                option2 = 2;
                                model.decrementLTScore();
                                WrongAnswer();
                              });
                            }
                            if (widget._listeningItem.correct == 3) {
                              setState(() {
                                option3 = 2;
                                model.decrementLTScore();
                                WrongAnswer();
                              });
                            }
                          });
                        }
                      }
                    },
                    child: Text(
                      widget._listeningItem.options[3],
                      style: TextStyle(
                          color: option4 == 1 ? Colors.black : Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w100),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
