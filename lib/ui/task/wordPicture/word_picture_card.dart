import 'package:Dimik/ScopedModel/mainmodel.dart';
import 'package:Dimik/models/wordpicture.dart';
import 'package:Dimik/ui/task/wordPicture/word_picture_task.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:scoped_model/scoped_model.dart';

class WordPictureCard extends StatefulWidget {
  WordPicture _wordPicture;

  WordPictureCard(this._wordPicture);

  @override
  State<StatefulWidget> createState() {
    return WordPictureCardState();
  }
}

class WordPictureCardState extends State<WordPictureCard> {
  AudioPlayer audioPlayer;
  int option1 = 0, option2 = 0, option3 = 0, option4 = 0;
  bool disable1 = false, disable2 = false, disable3 = false, disable4 = false;

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

  void disableAll() {
    disable1 = disable2 = disable3 = disable4 = true;
  }

  void CorrectAnswer() {
    setState(() {
      disableAll();
    });
    successAudio();
    WordPictureState.scaffoldKey.currentState
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
                  widget._wordPicture.explanation,
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
    setState(() {
      disableAll();
    });
    errorAudio();
    WordPictureState.scaffoldKey.currentState
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
                  widget._wordPicture.explanation,
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
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.all(const Radius.circular(30)),
          ),
          height: MediaQuery.of(context).size.height * (455.0 / 740.0),
          width: MediaQuery.of(context).size.width * (320.0 / 360.0),
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 30,
                left: 25,
                right: 25,
                child: Container(
                  child: Center(
                    child: Text(
                      'Below which is \'' + widget._wordPicture.word + '\' ?',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Positioned(
                child: GestureDetector(
                  child: Container(
                    height: 120,
                    width: 120,
                    child: ClipRRect(
                        borderRadius: new BorderRadius.circular(30.0),
                        child: Image.asset(
                          widget._wordPicture.imgLinks[0],
                          width: MediaQuery.of(context).size.width *
                              (270.0 / 360.0),
                          height: MediaQuery.of(context).size.width *
                              (300.0 / 455.0),
                          fit: BoxFit.cover,
                          color: option1 == 0
                              ? Colors.grey.withOpacity(0)
                              : option1 == 1
                                  ? Colors.grey.withOpacity(1)
                                  : option1 == 2
                                      ? Color.fromRGBO(83, 195, 111, 1)
                                      : Color.fromRGBO(255, 131, 131, 1),
                          colorBlendMode: BlendMode.color,
                        )),
                  ),
                  onTap: () {
                    if (!disable1) {
                      if (widget._wordPicture.correctOption == 1) {
                        setState(() {
                          option1 = 2;
                          option2 = option3 = option4 = 1;
                          model.incrementWPScore();
                          CorrectAnswer();
                        });
                      } else {
                        print('hello');
                        setState(() {
                          option1 = 3;
                          if (widget._wordPicture.correctOption == 2) {
                            setState(() {
                              option2 = 2;
                              option3 = option4 = 1;
                              model.decrementWPScore();
                              WrongAnswer();
                            });
                          }

                          if (widget._wordPicture.correctOption == 3) {
                            setState(() {
                              option3 = 2;
                              option2 = option4 = 1;
                              model.decrementWPScore();
                              WrongAnswer();
                            });
                          }
                          if (widget._wordPicture.correctOption == 4) {
                            setState(() {
                              option4 = 2;
                              option2 = option3 = 1;
                              model.decrementWPScore();
                              WrongAnswer();
                            });
                          }
                        });
                      }
                    }
                  },
                ),
                top: 170,
                left: 30,
              ),
              Positioned(
                child: GestureDetector(
                  child: Container(
                    height: 120,
                    width: 120,
                    child: ClipRRect(
                        borderRadius: new BorderRadius.circular(30.0),
                        child: Image.asset(
                          widget._wordPicture.imgLinks[1],
                          width: MediaQuery.of(context).size.width *
                              (270.0 / 360.0),
                          height: MediaQuery.of(context).size.width *
                              (300.0 / 455.0),
                          fit: BoxFit.cover,
                          color: option2 == 0
                              ? Colors.grey.withOpacity(0)
                              : option2 == 1
                                  ? Colors.grey.withOpacity(1)
                                  : option2 == 2
                                      ? Color.fromRGBO(83, 195, 111, 1)
                                      : Color.fromRGBO(255, 131, 131, 1),
                          colorBlendMode: BlendMode.color,
                        )),
                  ),
                  onTap: () {
                    if (!disable2) {
                      if (widget._wordPicture.correctOption == 2) {
                        setState(() {
                          option2 = 2;
                          option1 = option3 = option4 = 1;
                          model.incrementWPScore();
                          CorrectAnswer();
                        });
                      } else {
                        setState(() {
                          option2 = 3;
                          if (widget._wordPicture.correctOption == 1) {
                            setState(() {
                              option1 = 2;
                              option3 = option4 = 1;
                              model.decrementWPScore();
                              WrongAnswer();
                            });
                          }

                          if (widget._wordPicture.correctOption == 3) {
                            setState(() {
                              option3 = 2;
                              option1 = option4 = 1;
                              model.decrementWPScore();
                              WrongAnswer();
                            });
                          }
                          if (widget._wordPicture.correctOption == 4) {
                            setState(() {
                              option1 = option3 = 1;
                              option4 = 2;
                              model.decrementWPScore();
                              WrongAnswer();
                            });
                          }
                        });
                      }
                    }
                  },
                ),
                top: 170,
                right: 30,
              ),
              Positioned(
                child: GestureDetector(
                  child: Container(
                    height: 120,
                    width: 120,
                    child: ClipRRect(
                        borderRadius: new BorderRadius.circular(30.0),
                        child: Image.asset(
                          widget._wordPicture.imgLinks[2],
                          width: MediaQuery.of(context).size.width *
                              (270.0 / 360.0),
                          height: MediaQuery.of(context).size.width *
                              (300.0 / 455.0),
                          fit: BoxFit.cover,
                          color: option3 == 0
                              ? Colors.grey.withOpacity(0)
                              : option3 == 1
                                  ? Colors.grey.withOpacity(1)
                                  : option3 == 2
                                      ? Color.fromRGBO(83, 195, 111, 1)
                                      : Color.fromRGBO(255, 131, 131, 1),
                          colorBlendMode: BlendMode.color,
                        )),
                  ),
                  onTap: () {
                    if (!disable3) {
                      if (widget._wordPicture.correctOption == 3) {
                        setState(() {
                          option3 = 2;
                          option1 = option2 = option4 = 1;
                          model.incrementWPScore();
                          CorrectAnswer();
                        });
                      } else {
                        setState(() {
                          option3 = 3;
                          if (widget._wordPicture.correctOption == 1) {
                            setState(() {
                              option1 = 2;
                              option2 = option4 = 1;
                              model.decrementWPScore();
                              WrongAnswer();
                            });
                          }

                          if (widget._wordPicture.correctOption == 2) {
                            setState(() {
                              option2 = 2;
                              option1 = option4 = 1;
                              model.decrementWPScore();
                              WrongAnswer();
                            });
                          }
                          if (widget._wordPicture.correctOption == 4) {
                            setState(() {
                              option4 = 2;
                              option1 = option2 = 1;
                              model.decrementWPScore();
                              WrongAnswer();
                            });
                          }
                        });
                      }
                    }
                  },
                ),
                top: 330,
                left: 30,
              ),
              Positioned(
                child: GestureDetector(
                  child: Container(
                    height: 120,
                    width: 120,
                    child: ClipRRect(
                        borderRadius: new BorderRadius.circular(30.0),
                        child: Image.asset(
                          widget._wordPicture.imgLinks[3],
                          width: MediaQuery.of(context).size.width *
                              (270.0 / 360.0),
                          height: MediaQuery.of(context).size.width *
                              (300.0 / 455.0),
                          fit: BoxFit.cover,
                          color: option4 == 0
                              ? Colors.grey.withOpacity(0)
                              : option4 == 1
                                  ? Colors.grey.withOpacity(1)
                                  : option4 == 2
                                      ? Color.fromRGBO(83, 195, 111, 1)
                                      : Color.fromRGBO(255, 131, 131, 1),
                          colorBlendMode: BlendMode.color,
                        )),
                  ),
                  onTap: () {
                    if (!disable4) {
                      if (widget._wordPicture.correctOption == 4) {
                        setState(() {
                          option4 = 2;
                          option1 = option2 = option3 = 1;
                          model.incrementWPScore();
                          CorrectAnswer();
                        });
                      } else {
                        setState(() {
                          option4 = 3;
                          if (widget._wordPicture.correctOption == 1) {
                            setState(() {
                              option1 = 2;
                              option2 = option3 = 1;
                              model.decrementWPScore();
                              WrongAnswer();
                            });
                          }

                          if (widget._wordPicture.correctOption == 2) {
                            setState(() {
                              option2 = 2;
                              option1 = option3 = 1;
                              model.decrementWPScore();
                              WrongAnswer();
                            });
                          }
                          if (widget._wordPicture.correctOption == 3) {
                            setState(() {
                              option3 = 2;
                              option1 = option2 = 1;
                              model.decrementWPScore();
                              WrongAnswer();
                            });
                          }
                        });
                      }
                    }
                  },
                ),
                top: 330,
                right: 30,
              ),
            ],
          ),
        );
      },
    );
  }
}
