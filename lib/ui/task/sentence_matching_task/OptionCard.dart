import 'package:Dimik/ui/task/sentence_matching_task/TaskElement.dart';
import 'package:flutter/material.dart';
import './OptionView.dart';

class OptionCard extends StatelessWidget{

  final Map<TaskElement, TaskElement> _options;
  final double _initialDistFromTop = 0;
  final Function notification;
  List<TaskElement> arrangedOptions = new List<TaskElement>(6) ;
  
  

  OptionCard(this._options, this.notification);
  

  @override
  Widget build(BuildContext context) {

    // print("In optionCard");
    // print(_options);
    arrangeOptions();
    
    return Stack(
                    children: <Widget>[
                    OptionView(arrangedOptions[0], acceptString(arrangedOptions[0]), _initialDistFromTop, notification),
                    OptionView(arrangedOptions[1], acceptString(arrangedOptions[1]),_initialDistFromTop+78, notification),
                    OptionView(arrangedOptions[2],acceptString(arrangedOptions[2]),_initialDistFromTop+78*2, notification),
                    OptionView(arrangedOptions[3],acceptString(arrangedOptions[3]),_initialDistFromTop+78*3, notification),
                    OptionView(arrangedOptions[4], acceptString(arrangedOptions[4]),_initialDistFromTop+78*4, notification),
                    OptionView(arrangedOptions[5], acceptString(arrangedOptions[5]),_initialDistFromTop+78*5, notification),
                    ]
                  );
  }

  TaskElement acceptString(TaskElement s){
    //print("in as: "+s);

    if(_options[s] != null)
      return _options[s];
    return _options.keys.firstWhere(
      (k) => _options[k] == s, orElse: () => null);

  }

  void arrangeOptions(){
    List<int> order =[4,3,0,2,5,1];
    order.shuffle();
    int index = 0;
    
    _options.forEach((k,v){
      //print("here: "+k+" "+v+" "+index.toString());
      arrangedOptions[order[index++]] = k;
      arrangedOptions[order[index++]] = v;
      
    });
    
  }
}