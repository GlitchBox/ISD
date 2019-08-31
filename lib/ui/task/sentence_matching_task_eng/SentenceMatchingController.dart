import 'package:Dimik/models/sm.dart';
import 'package:flutter/material.dart';
import '../../../data/controller/sm.dart';
import '../../../config.dart';

class SentenceMatchingController{

  static void getSMView(Map<String,String> questionList) async{
  SMController smc = new SMController();

    smc.getSMList(TOKEN, 1).then((smList){

        smList.map((sm){
          questionList[sm.banglaSentence] = sm.englishSentence;
          print("returned sentence: "+sm.banglaSentence+" "+sm.englishSentence);
        });
    });
    
  }
}