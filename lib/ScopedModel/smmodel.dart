import 'package:scoped_model/scoped_model.dart';
import '../models/sm.dart';
import 'package:flutter/material.dart';

class SMModel extends Model {
  bool _smIsLoaded = false;
  bool _smIsPressed = false;
  int _smTotalTasks = 0;
  int _smCurrentTask = 0;
  int _smSolved;
  int _smTotalQuestions;
  String _smButtonText = "Get Next";
  List<Map<String,String>> _smCards = new List<Map<String,String>>();
  

  bool get smIsLoaded => _smIsLoaded;
  bool get smIsPressed => _smIsPressed;
  int get smTotalTasks => _smTotalTasks;
  int get smCurrentTask => _smCurrentTask;
  int get smSolved => _smSolved;
  int get smTotalQuestions => _smTotalQuestions;
  String get smButtonText => _smButtonText;
  List<Map<String,String>> get smQuestionList => _smCards;

  void set smIsLoaded(bool b){
    this._smIsLoaded = b;
  }

  void set smIsPressed(bool b){
    this._smIsPressed = b;
  }

  void set smTotalTasks(int t){
    this._smTotalTasks = t;
  }

  void set smCurrentTask(int t){
    this._smCurrentTask = t;
  }

  void set smSolved(int t){
    this._smSolved = t;
  }

  void set smTotalQuestions(int t){
    this._smTotalQuestions = t;
  }

  void set smButtonText(String s){
    this._smButtonText = s;
  }

  void set smQuestionList(List<Map<String,String>> sm){
    this._smCards = sm;
  }

}
