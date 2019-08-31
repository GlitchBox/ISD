import 'dart:async';

import 'package:Dimik/ScopedModel/mainmodel.dart';
import 'package:Dimik/ui/task/listening_game/listening_card.dart';
import 'package:Dimik/ui/task/synonym_antonym_matching/sa_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';

class SATask extends StatefulWidget {
  int current = 1;
  bool timer_flag = false;
  bool call_flag = false;
  @override
  State<StatefulWidget> createState() {
    return SATaskState();
  }
}

class SATaskState extends State<SATask> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget progressDetails(int total) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: 50 * (MediaQuery.of(context).size.height / 720.0),
              width: 195 * (MediaQuery.of(context).size.width / 360.0),
              alignment: FractionalOffset.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.all(const Radius.circular(29.5)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    child: Icon(Icons.arrow_back_ios),
                    onTap: () {
                      Dialog dialog = Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: new LinearGradient(
                                colors: <Color>[
                                  Color.fromRGBO(0, 193, 134, 1),
                                  Color.fromRGBO(128, 109, 222, 1)
                                ],
                                begin: FractionalOffset.topLeft,
                                end: FractionalOffset.bottomRight),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          height: 170.0 *
                              (MediaQuery.of(context).size.height / 740.0),
                          width: 320.0 *
                              (MediaQuery.of(context).size.width / 360.0),
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: 19,
                                left: 15,
                                child: Text(
                                  'Close',
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.25),
                                      fontSize: 78),
                                ),
                              ),
                              Positioned(
                                top: 90 *
                                    (MediaQuery.of(context).size.height /
                                        740.0),
                                left: 20 *
                                    (MediaQuery.of(context).size.width / 360.0),
                                right: 54 *
                                    (MediaQuery.of(context).size.width / 360.0),
                                child: Text(
                                  'are you sure you want to exit?',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              ),
                              Positioned(
                                  top: 115 *
                                      (MediaQuery.of(context).size.height /
                                          740.0),
                                  left: 125 *
                                      (MediaQuery.of(context).size.width /
                                          360.0),
                                  child: FlatButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(23.0)),
                                    child: Text(
                                      'Yes',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {
                                      model.scoreTF = 0;
                                      model.correctTF = 0;
                                      model.incorrectTF = 0;
                                      model.tfloading = true;
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                  )),
                              Positioned(
                                  top: 115 *
                                      (MediaQuery.of(context).size.height /
                                          740.0),
                                  left: 195 *
                                      (MediaQuery.of(context).size.width /
                                          360.0),
                                  child: FlatButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(23.0)),
                                    child: Text(
                                      'No',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ))
                            ],
                          ),
                        ),
                      );
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => dialog);
                    },
                  ),
                  Text('Remaining'),
                  Text(
                    '00:53',
                    style: TextStyle(color: Colors.redAccent),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 30 * (MediaQuery.of(context).size.width / 360.0),
            ),
            Container(
              height: 50 * (MediaQuery.of(context).size.height / 720.0),
              width: 96.5 * (MediaQuery.of(context).size.width / 360.0),
              alignment: FractionalOffset.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.all(const Radius.circular(29.5)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.current.toString()),
                  Text('/'),
                  Text((total / 3).toInt().toString()),
                ],
              ),
            ),
            SizedBox(
              width: 0,
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const _kDuration = const Duration(milliseconds: 300);
    const _kCurve = Curves.decelerate;
    PageController controller = PageController(keepPage: false);
    return Scaffold(
        backgroundColor: Color.fromRGBO(242, 242, 242, 1),
        body: ScopedModelDescendant(
            builder: (BuildContext context, Widget child, MainModel model) {
          if (!widget.call_flag) {
            model.generateSAItem();
            widget.call_flag = true;
          }
          return Container(
            child: model.isSALoading
                ? Center(
                    child: CircularProgressIndicator(
                    backgroundColor: Colors.blue,
                    strokeWidth: 1.5,
                  ))
                : Stack(
                    children: <Widget>[
                      Positioned(
                        top: (40.0 / 740) * MediaQuery.of(context).size.height,
                        left: (20.0 / 360) * MediaQuery.of(context).size.width,
                        child: progressDetails(model.saitemlist.length),
                      ),
                      Positioned(
                        top: 150,
                        left: 20,
                        right: 20,
                        child: SizedBox(
                            height: (453.0 / 740.0) *
                                MediaQuery.of(context).size.height,
                            width: (320.0 / 360.0) *
                                MediaQuery.of(context).size.width,
                            child: PageView.builder(
                              controller: controller,
                              physics: new NeverScrollableScrollPhysics(),
                              itemCount: model.saitemlist.length >= 3
                                  ? 3
                                  : model.saitemlist.length / 3,
                              itemBuilder: (BuildContext context, int index) {
                                return SACard(model.saitemlist[0],
                                    model.saitemlist[1], model.saitemlist[2]);
                              },
                            )),
                      ),
                      Positioned(
                        top: (677.0 / 740.0) *
                            MediaQuery.of(context).size.height,
                        left:
                            (20.0 / 360.0) * MediaQuery.of(context).size.width,
                        right:
                            (20.0 / 360.0) * MediaQuery.of(context).size.width,
                        child: Container(
                          height: (63.0 / 740.0) *
                              MediaQuery.of(context).size.height,
                          width: (340.0 / 360.0) *
                              MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(133, 119, 226, 1),
                            borderRadius: new BorderRadius.only(
                                topLeft: const Radius.circular(30),
                                topRight: const Radius.circular(30)),
                          ),
                          child: FlatButton(
                            onPressed: () {
                              setState(() {
                                if (widget.current <
                                    model.saitemlist.length / 3.0) {
                                  widget.current++;
                                } else {
                                  Navigator.pushReplacementNamed(
                                      context, '/gameover',
                                      arguments: 'satask');
                                }
                              });
                              controller.nextPage(
                                  curve: _kCurve, duration: _kDuration);
                            },
                            child: Text(
                              'Next',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w100),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          );
        }));
    ;
  }
}
