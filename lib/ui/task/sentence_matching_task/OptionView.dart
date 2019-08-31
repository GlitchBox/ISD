import 'dart:async';
import 'package:flutter/material.dart';
import './EmptyOptionView.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../../ScopedModel/mainmodel.dart';

class OptionView extends StatefulWidget {
  String _text;
  final double _distanceFromTop;
  final String _acceptText;
  final Function notification;
  bool isDisabled = false;

  OptionView(
      this._text, this._acceptText, this._distanceFromTop, this.notification);

  @override
  State<StatefulWidget> createState() {
    return _OptionViewState();
  }
}

class _OptionViewState extends State<OptionView> {
  Color buttonColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    //print(widget._text);

    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Positioned(
          top: widget._distanceFromTop,
          left: 20,
          right: 20,
          height: 63,
          child: _manageButtonState(model),
        );
      },
    );
  }

  Widget _manageButtonState(MainModel model) {
    // if(widget.isLoaded == true)
    //   widget.isDisabled = false;
    // else
    //   widget.isDisabled = true;

    if (widget.isDisabled == true || model.smIsLoaded == false) {
      return RaisedButton(
        onPressed: () {},
        child: //Text(widget._text, style: TextStyle(fontSize: 15, /*color: Color(0x2E303E)*/), textAlign: TextAlign.center,),
            showLoadOrSentence(model),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        disabledElevation: 0.3,
        //disabledColor: Colors.blueGrey,
        disabledColor: Color(0xffA9A9A9),
      );
    }

    return Draggable<OptionView>(
      //data: widget._text,
      data: widget,
      child: DragTarget(
        builder: (context, accepted, rejected) => RaisedButton(
              onPressed: () {},
              child: Text(
                widget._text,
                style: TextStyle(
                  fontSize: 15, /*color: Color(0x2E303E)*/
                ),
                textAlign: TextAlign.center,
              ), //showLoadOrSentence(),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              //textColor: Colors.white,
              //highlightColor: Colors.red,
              color: buttonColor,
              elevation: 1,
              //highlightElevation: 0.5,
            ),
        onAccept: (OptionView dragged) {
          //print(dragged._text);
          // if( SentenceMatchingView.time != "0:00"){
          String prevText = widget._text;
          setState(() {
            if (dragged._text == widget._acceptText) {
              widget._text += (" " + dragged._text);
              buttonColor = Colors.green;
              dragged.isDisabled = true;
              widget.notification(true, model);
            } else {
              buttonColor = Colors.red;
              widget.notification(false, model);
            }
          });
          Timer(Duration(milliseconds: 700), () {
            setState(() {
              buttonColor = Colors.white;
              //print("prev: "+prevText+" text: "+widget._text);

              if (prevText != widget._text) {
                widget._text = prevText;
                widget.isDisabled = true;
              }
            });
          });
          //}
        },
      ),
      feedback: Container(
          width: 320,
          height: 63,
          child: RaisedButton(
              onPressed: () {},
              child: Text(
                widget._text,
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

      childWhenDragging: EmptyOptionView(widget._distanceFromTop),
      onDragCompleted: () {
        if (widget.isDisabled == true) {
          setState(() {});
        }
      },
    );
  }

  Widget showLoadOrSentence(MainModel model) {
    if (model.smIsLoaded == true)
      return Text(
        widget._text,
        style: TextStyle(
          fontSize: 15, /*color: Color(0x2E303E)*/
        ),
        textAlign: TextAlign.center,
      );

    return CircularProgressIndicator(
      strokeWidth: 3.0,
      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
    );
  }
}
