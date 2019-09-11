import 'dart:async';

import 'package:Dimik/data/controller/score_update.dart';
import 'package:Dimik/models/score_update.dart';
import 'package:Dimik/ui/task/sentence_matching_task_eng/SentenceMatchingView.dart';
import 'package:Dimik/ui/task/sentence_matching_task_eng/TaskElement.dart';
import 'package:flutter/material.dart';
import './EmptyOptionView.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../../ScopedModel/mainmodel.dart';

class OptionView extends StatefulWidget{
  TaskElement _text;
  final double _distanceFromTop;
  final TaskElement _acceptText;
  final Function notification;
  bool isDisabled = false;
  final bool isLoaded;
  ScoreUpdateController scController = ScoreUpdateController();

  OptionView(this._text,this._acceptText, this._distanceFromTop, this.notification, this.isLoaded);

  @override
  State<StatefulWidget> createState() {
    return _OptionViewState();
  }
}

class _OptionViewState extends State<OptionView>{
  
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
      });
  }

  Widget _manageButtonState(MainModel model){

      // if(widget.isLoaded == true)
      //   widget.isDisabled = false;
      // else
      //   widget.isDisabled = true;
      
      if(widget.isDisabled==true || model.smEIsLoaded==false){
        return RaisedButton(
                      onPressed: (){},
                      child: //Text(widget._text, style: TextStyle(fontSize: 15, /*color: Color(0x2E303E)*/), textAlign: TextAlign.center,),
                      showLoadOrSentence(model),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      disabledElevation: 0.3,
                      disabledColor: Color(0xffff00ff),
                      
                      );
      }

      
        return  Draggable<OptionView>(
              //data: widget._text,
              data:widget,
              child: DragTarget(
                builder: (context, accepted, rejected)=> RaisedButton(
                    onPressed: (){},
                    child: Text(widget._text.sentence, style: TextStyle(fontSize: 15, /*color: Color(0x2E303E)*/), textAlign: TextAlign.center,),//showLoadOrSentence(),
                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                     //textColor: Colors.white,
                     //highlightColor: Colors.red,
                     color: buttonColor,
                     elevation: 1,
                     //highlightElevation: 0.5,
                    ),
                  onAccept: (OptionView dragged){
                    //print(dragged._text);
                   // if( SentenceMatchingView.time != "0:00"){
                      String prevText = widget._text.sentence;
                      String newString = prevText;
                      setState(() {
                      
                        // String tempComplete1 = widget._text + dragged._text;
                        // String tempComplete2 = dragged._text + widget._text; 
                        //if(tempComplete1 == widget._acceptText||tempComplete2 == widget._acceptText){
                        // if(widget._acceptText == dragged._text){
                        //     //widget._text += (" "+dragged._text);
                        //     buttonColor = Colors.green;
                        //     dragged.isDisabled = true;
                        //     widget.notification(true);
                            
                        // }
                        if(dragged._text.sentence == widget._acceptText.sentence){
                          //widget._text += (" "+dragged._text);
                          newString = dragged._text.sentence;
                          buttonColor = Colors.green;
                          dragged.isDisabled = true;
                          widget.notification(true, model);

                          ScoreUpdate score = ScoreUpdate(model.currentTopic.id, widget._text.taskID, widget._text.specificTaskID, 1);
                          widget.scController.getSMList(model.user.token, score);
                          print(widget._text.specificTaskID);
                          
                      }
                        else{
                            buttonColor = Colors.red;
                            widget.notification(false, model);

                             ScoreUpdate score1 = ScoreUpdate(model.currentTopic.id, widget._text.taskID, widget._text.specificTaskID, 0);
                             widget.scController.getSMList(model.user.token, score1);
                             ScoreUpdate score2 = ScoreUpdate(model.currentTopic.id, dragged._text.taskID, dragged._text.specificTaskID, 0);
                             widget.scController.getSMList(model.user.token, score2);

                             print(widget._text.specificTaskID);
                             print(dragged._text.specificTaskID);
                        }

                      });
                      Timer(Duration(milliseconds: 700), (){
                            setState(() {
                              buttonColor = Colors.white; 
                              //print("prev: "+prevText+" text: "+widget._text);
                              if(prevText != newString){
                                widget._text.sentence = prevText;
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
                child:RaisedButton(
                    onPressed: (){},
                    child: Text(widget._text.sentence, style: TextStyle(fontSize: 15, /*color: Color(0x2E303E)*/), textAlign: TextAlign.center,),
                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                     //textColor: Colors.white,
                     //highlightColor: Colors.red,
                     color: Colors.white,
                     elevation: 1
                     //highlightElevation: 0.5,
                  )),    
              
              childWhenDragging: EmptyOptionView(widget._distanceFromTop),
              onDragCompleted: (){
                if(widget.isDisabled==true){
                  setState(() {
                    
                  });
                }
              },  
              );

        

  }

  Widget showLoadOrSentence(MainModel model){

    if(model.smEIsLoaded == true)
      return Text(widget._text.sentence, style: TextStyle(fontSize: 15, /*color: Color(0x2E303E)*/), textAlign: TextAlign.center,);

    return CircularProgressIndicator(
      strokeWidth: 3.0,
      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
    );  

  }
}

