import 'package:scoped_model/scoped_model.dart';
import '../ui/task/sentence_matching_task_eng/TaskElement.dart';

class SMEnglish extends Model{
  bool _smEIsLoaded = false;
  bool _smEIsPressed = false;
  int _smETotalTasks = 0;
  int _smECurrentTask = 0;
  int _smESolved;
  int _smETotalQuestions;
  String _smEButtonText = "Get Next";
  List<Map<TaskElement,TaskElement>> _smECards = new List<Map<TaskElement,TaskElement>>();
  

  bool get smEIsLoaded => _smEIsLoaded;
  bool get smEIsPressed => _smEIsPressed;
  int get smETotalTasks => _smETotalTasks;
  int get smECurrentTask => _smECurrentTask;
  int get smESolved => _smESolved;
  int get smETotalQuestions => _smETotalQuestions;
  String get smEButtonText => _smEButtonText;
  List<Map<TaskElement,TaskElement>> get smEQuestionList => _smECards;

  void set smEIsLoaded(bool b){
    this._smEIsLoaded = b;
  }

  void set smEIsPressed(bool b){
    this._smEIsPressed = b;
  }

  void set smETotalTasks(int t){
    this._smETotalTasks = t;
  }

  void set smECurrentTask(int t){
    this._smECurrentTask = t;
  }

  void set smESolved(int t){
    this._smESolved = t;
  }

  void set smETotalQuestions(int t){
    this._smETotalQuestions = t;
  }

  void set smEButtonText(String s){
    this._smEButtonText = s;
  }

  void set smEQuestionList(List<Map<TaskElement,TaskElement>> sm){
    this._smECards = sm;
  }
}