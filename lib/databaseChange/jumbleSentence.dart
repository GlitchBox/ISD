import 'dart:async';
import 'dart:io' as io;

class jumbleSentence {
  String question;
  List<String> questionPart;
  List<String> correctAnsPart;
  String correctSentence;

  jumbleSentence(this.question, this.questionPart, this.correctSentence,this.correctAnsPart);

  set getQuestion(String str){
    this.question=str;
  }

  String get getQuestion {
    //String str=question;
    return question;
  }

  set setQuestionPart(List<String>list){
    this.questionPart=list;
  }

  List<String> get getQuestionPart {
    return questionPart;
  }

  set setCorrect(List<String>list){
    this.correctAnsPart=list;
  }

  List<String> get getCorrect {
    return correctAnsPart;
  }

  set setCorrectSentence(String str){
    this.correctSentence=str;
  }

  String get getCorrectSentence {
    //String str=question;
    return correctSentence;
  }

  
}
