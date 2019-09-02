import 'dart:io';

import 'package:Dimik/ScopedModel/mainmodel.dart';
import 'package:Dimik/models/topic.dart';
import 'package:Dimik/view/widgets/task_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class TopicCard extends StatefulWidget {
  final bool dropShadow;
  String currentGame;
  final Topic mainTopic;
  double completion;
  bool isFav = false;

  TopicCard(
      {@required this.mainTopic,
      @required this.currentGame,
      @required this.dropShadow});
  @override
  State<StatefulWidget> createState() {
    return _TopicCardState();
  }
}

class _TopicCardState extends State<TopicCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return GestureDetector(
          onTap: () {
            switch (widget.currentGame) {
              case 'Word to Picture':
                model.currentTopic = widget.mainTopic;
                Navigator.pushNamed(context, '/wordpicture');
                break;
              case 'Picture to Word':
                model.currentTopic = widget.mainTopic;
                Navigator.pushNamed(context, '/pictureword');
                break;
              case 'True False':
                model.currentTopic = widget.mainTopic;
                Navigator.pushNamed(context, '/truefalse');
                break;

              case 'Kid\'s Box':
                model.currentTopic = widget.mainTopic;
                Navigator.pushNamed(context, '/kbintro');
                break;

              case 'Listen to Word':
                model.currentTopic = widget.mainTopic;
                Navigator.pushNamed(context, '/lwtask');
                break;

              case 'Synonym Antonym Matching':
                model.currentTopic = widget.mainTopic;
                Navigator.pushNamed(context, '/satask');
                break;
              case 'Sentence Matching':
                model.currentTopic = widget.mainTopic;
                Navigator.pushNamed(context, '/sm');
                break;
              case 'Sentence Matching English':
                model.currentTopic = widget.mainTopic;
                Navigator.pushNamed(context, '/sme');
                break;
              case 'Jumbled Sentence':
                model.currentTopic = widget.mainTopic;
                Navigator.pushNamed(context, '/jumbled');
                break;
              case 'Fill in The Gaps':
                model.currentTopic = widget.mainTopic;
                Navigator.pushNamed(context, '/fillTheGaps');
                break;
              case 'Multiple Choice Question':
                model.currentTopic = widget.mainTopic;
                Navigator.pushNamed(context, '/mcqTask');
                break;

              default:
            }
          },
          child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * (120 / 720),
                    child: Stack(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.isFav = !widget.isFav;
                            });
                          },
                          child: Icon(
                            Icons.favorite,
                            size: 30,
                            color: widget.isFav
                                ? Colors.redAccent
                                : Color.fromRGBO(171, 172, 197, 1),
                          ),
                        ),
                        Positioned(
                          left: MediaQuery.of(context).size.width * (90 / 360),
                          child: Container(
                            child: new ClipRRect(
                              borderRadius: new BorderRadius.circular(30.0),
                              // child: Image.asset(
                              //   //widget.mainTopic.imageLink,
                              //   'img/callofduty.png',
                              //   width: MediaQuery.of(context).size.width *
                              //       (120 / 360),
                              //   height: MediaQuery.of(context).size.height *
                              //       (120 / 720),
                              //   fit: BoxFit.cover,
                              // ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  Text(
                    widget.currentGame,
                    style: new TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w100),
                  ),
                  Text(
                    widget.mainTopic.name,
                    style: new TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w900),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  TaskProgressIndicator(
                    color: Colors.red,
                    progress: 25,
                  ),
                ],
              ),
              margin: EdgeInsets.fromLTRB(16, 16, 10, 16),
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 1),
                borderRadius: new BorderRadius.all(const Radius.circular(24)),
              )),
        );
      },
    );
  }
}
