import 'package:Dimik/databaseChange/FBGapData.dart';
import 'package:flutter/material.dart';
import '../Fill_in_the_gaps/fillGapsControllerDragable.dart';




class FillTheGapsStats extends StatelessWidget{

  //final String title;
  FbGap titleTemp;
  final Function getFunc;
  final Function getFunction;
  final bool isLoaded;
  FillTheGapsStats(this.titleTemp,this.getFunc,this.getFunction,this.isLoaded);

  @override
  Widget build(BuildContext context) {
    
    
    return dragableFG(title:titleTemp,getFunc: getFunc,getFunction:getFunction,isLoaded: isLoaded);
  }
}