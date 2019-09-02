import 'package:Dimik/databaseChange/mcqData.dart';
import 'package:flutter/material.dart';
import '../mcq_task/mcq_task_controller.dart';




class MCQStats extends StatelessWidget{

  //final String title;
  MCQ titleTemp;
  final Function getFunc;
  final bool isLoaded;
  MCQStats(this.titleTemp,this.getFunc,this.isLoaded);

  @override
  Widget build(BuildContext context) {
    
    
    return controllerClass(title:titleTemp,getFunc: getFunc,isLoaded: isLoaded);
  }
}