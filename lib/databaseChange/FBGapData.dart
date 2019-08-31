import 'dart:async';
import 'dart:io' as io;

class FbGap {
  String question;
  List<String> option;
  List<String> correctAns;

  FbGap(this.question, this.option, this.correctAns);

  set getQuestion(String str){
    this.question=str;
  }

  String get getQuestion {
    //String str=question;
    return question;
  }

  set setOption(List<String>list){
    this.option=list;
  }

  List<String> get getOption {
    return option;
  }

  set setCorrect(List<String>list){
    this.correctAns=list;
  }

  List<String> get getCorrect {
    return correctAns;
  }

  
}
