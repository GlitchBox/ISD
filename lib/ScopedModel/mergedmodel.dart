import 'package:Dimik/data/controller/pictureword.dart';
import 'package:Dimik/data/controller/tf.dart';
import 'package:Dimik/data/controller/topic.dart';
import 'package:Dimik/data/controller/wordpicture.dart';
import 'package:Dimik/models/listening_item.dart';
import 'package:Dimik/models/pictureword.dart';
import 'package:Dimik/models/quiz_item.dart';
import 'package:Dimik/models/sa.dart';
import 'package:Dimik/models/tf.dart';
import 'package:Dimik/models/user.dart';
import 'package:Dimik/models/wordpicture.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:Dimik/models/task.dart';
import 'package:Dimik/models/topic.dart';
import 'package:Dimik/databaseChange/jumbleSentence.dart';
import 'package:Dimik/models/jumbled_sentence.dart';
import 'package:Dimik/databaseChange/FBGapData.dart';
import 'package:Dimik/models/fb.dart';
import 'package:Dimik/databaseChange/mcqData.dart';

class MergedModel extends Model {
  final List<Topic> topics = [];
  final List<Task> tasks = [];
  List<TF> _truefalselist = [];
  List<PictureWord> _picturewordlist = [];
  List<WordPicture> _wordpicturelist = [];
  List<ListeningItem> _listeningitemlist = [];
  List<SAItem> _saitemlist = [];
  List<QuizItem> _quizlist = [];

  bool gotUser = false;
  bool _isLoading = false;
  bool _generated = false;
  bool _isPressed = false;
  bool _isQuizActive = false;
  QuizItem _currentQuiz;
  int _current_quiz_tracker;

  bool _isTrueFalseLoading = false;
  bool _isPWLoading = false;
  bool _isWPLoading = false;
  bool _isLTLoading = false;
  bool _isSALoading = false;
  bool _isQuizLoading = false;

  Topic _currenttopic;

  int _trueFalseScore = 0;
  int _tfcorrect = 0;
  int _tfincorrect = 0;

  int _pwScore = 0;
  int _pwcorrect = 0;
  int _pwincorrect = 0;

  int _wpScore = 0;
  int _wpcorrect = 0;
  int _wpincorrect = 0;

  int _ltScore = 0;
  int _ltcorrect = 0;
  int _ltincorrect = 0;

  int _saScore = 0;
  int _sacorrect = 0;
  int _saincorrect = 0;

  User user;
  final List<String> halloffame = [
    'True False Master',
    'Cross Word Rookie',
    'WP Semi Pro'
  ];
  final List<String> Achievements = [
    'Fasted True False Solve at Level 1',
    'Fasted Crossword at Level 2',
    'Fasted MCQ Solve at Level 4',
    'Fasted Word to Picture at Level 3',
  ];

  void set currentTopic(Topic t) {
    _currenttopic = t;
  }

  void generateTopics() async {
    if (!_generated) {
      TopicController tController = new TopicController();
      List<Topic> list = await tController.getTopicList(user.token);
      for (int i = 0; i < 5; i++) {
        topics.add(list[i]);
      }
      /*
      TopicRest rest = TopicRest();
      TopicList list = await rest.getAllTopics(user.token);
      for (int i = 0; i < 4; i++) {
        topics.add(list.topics[i]);
      }
      */
      _generated = true;
      _isLoading = false;
      notifyListeners();
    }
  }

  void generateQuiz() {
    _isQuizLoading = true;
    List<Task> _tasks1 = [Task(name: 'True False')];
    List<Topic> _topics1 = [topics[0]];
    QuizItem q1 = QuizItem(
        quiz_name: "Human",
        tasks: _tasks1,
        topics: _topics1,
        card_color: Colors.grey.withOpacity(0.75),
        text_color: Colors.black);

    List<Task> _tasks2 = [
      Task(name: 'True False'),
      Task(name: 'Word to Picture'),
    ];
    List<Topic> _topics2 = [topics[0], topics[1]];
    QuizItem q2 = QuizItem(
        quiz_name: "Nature",
        tasks: _tasks2,
        topics: _topics2,
        card_color: Colors.greenAccent.withOpacity(0.75),
        text_color: Colors.white);

    List<Task> _tasks3 = [
      Task(name: 'True False'),
      Task(name: 'Word to Picture'),
      Task(name: 'Picture to Word'),
    ];
    List<Topic> _topics3 = [topics[0], topics[1], topics[3]];
    QuizItem q3 = QuizItem(
        quiz_name: "Technology",
        tasks: _tasks3,
        topics: _topics3,
        card_color: Colors.redAccent,
        text_color: Colors.white);

    List<Task> _tasks4 = [Task(name: 'True False')];
    List<Topic> _topics4 = [topics[2]];
    QuizItem q4 = QuizItem(
        quiz_name: "Science",
        tasks: _tasks4,
        topics: _topics4,
        card_color: Colors.yellow,
        text_color: Colors.black);

    List<Task> _tasks5 = [
      Task(name: 'True False'),
      Task(name: 'Picture to Word'),
    ];
    List<Topic> _topics5 = [topics[0], topics[3]];
    QuizItem q5 = QuizItem(
        quiz_name: "Architecture",
        tasks: _tasks5,
        topics: _topics5,
        card_color: Colors.purple,
        text_color: Colors.white);

    _quizlist.add(q1);
    _quizlist.add(q2);
    _quizlist.add(q3);
    _quizlist.add(q4);
    _quizlist.add(q5);
    _isQuizLoading = false;
    notifyListeners();
  }

  void generateTasks() {
    // Task t1 = Task(name: 'True False');
    // Task t2 = Task(name: 'Word to Picture');
    // Task t3 = Task(name: 'Kid\'s Box');
    // Task t4 = Task(name: 'Picture to Word');
    // Task t5 = Task(name: 'Listen to Word');
    // Task t6 = Task(name: 'Synonym Antonym Matching');
    Task t1 = Task(name: 'Sentence Matching');
    Task t2 = Task(name: 'Sentence Matching English');
    Task t3 = Task(name: 'Jumbled Sentence');
    Task t4 = Task(name: 'Fill in The Gaps');
    Task t5 = Task(name: 'Multiple Choice Question'); 

    tasks.add(t1);
    tasks.add(t2);
    tasks.add(t3);
    tasks.add(t4);
    tasks.add(t5);
    // tasks.add(t4);
    // tasks.add(t5);
    // tasks.add(t6);
  }

  void generateTrueFalse() async {
    if (_isTrueFalseLoading) {
      TFController tfController = new TFController();
      _truefalselist =
          await tfController.getTFList(user.token, _currenttopic.id);
    }
    _isTrueFalseLoading = false;
    notifyListeners();
  }

  void generateListeningItems() {
    List<String> items = ['Fight', 'Fought', 'Fine', 'Foul'];
    int correct = 1;
    ListeningItem item = new ListeningItem(items, correct);
    _listeningitemlist.add(item);
    _isLTLoading = false;
    notifyListeners();
  }

  void generateSAItem() {
    SAItem item1 = SAItem('Good', 'Well', 'Bad');
    SAItem item2 = SAItem('Angry', 'Mad', 'Calm');
    SAItem item3 = SAItem('Clean', 'Tidy', 'Dirty');

    _saitemlist.add(item1);
    _saitemlist.add(item2);
    _saitemlist.add(item3);
    _isSALoading = false;
    notifyListeners();
  }

  void generatePicturetoWord() async {
    if (_isPWLoading) {
      PWController pwController = new PWController();
      _picturewordlist =
          await pwController.getPWList(user.token, currentTopic.id);
    }
    _isPWLoading = false;
    notifyListeners();
  }

  void generateWordtoPicture() async {
    if (_isWPLoading) {
      WPController wpController = new WPController();
      _wordpicturelist =
          await wpController.getWPList(user.token, currentTopic.id);
    }
    _isWPLoading = false;
    notifyListeners();
  }

  @override
  void addListener(listener) {
    super.addListener(listener);
    _isLoading = true;
    _isTrueFalseLoading = true;
    _isPWLoading = true;
    _isWPLoading = true;
    _isSALoading = true;
    _isLTLoading = true;
  }

  bool get generated => _generated;
  bool get isLoading => _isLoading;
  bool get isPressed => _isPressed;

  Topic get currentTopic => _currenttopic;
}

class TaskModel extends MergedModel {
  List<Task> get AllTask {
    return List.from(tasks);
  }
}

class TopicModel extends MergedModel {
  List<Topic> get AllTopic {
    return List.from(topics);
  }
}

class UserModel extends MergedModel {
  User get currentUser {
    return user;
  }

  void set username(String name) {
    user.username = (name);
  }

  void set email(String email) {
    user.email = (email);
  }
}

class TruefalseModel extends MergedModel {
  void incrementTFScore() {
    _trueFalseScore += 10;
    _tfcorrect++;
  }

  void decrementTFScore() {
    _tfincorrect++;
  }

  void set scoreTF(int s) {
    _trueFalseScore = s;
  }

  void set correctTF(int s) {
    _tfcorrect = s;
  }

  void set tfloading(bool t) {
    _isTrueFalseLoading = t;
  }

  void set incorrectTF(int s) {
    _tfincorrect = s;
  }

  int get trueFalseScore => _trueFalseScore;
  int get tfcorrect => _tfcorrect;
  int get tfincorrect => _tfincorrect;

  bool get isTFLoading => _isTrueFalseLoading;

  List<TF> get truefalselist {
    return List.from(_truefalselist);
  }
}

class PictureWordModel extends MergedModel {
  void incrementPWScore() {
    _pwScore += 10;
    _pwcorrect++;
  }

  void decrementPWScore() {
    _pwincorrect++;
  }

  void set scorePW(int s) {
    _pwScore = s;
  }

  void set correctPW(int s) {
    _pwcorrect = s;
  }

  void set pwloading(bool t) {
    _isPWLoading = t;
  }

  void set incorrectPW(int s) {
    _pwincorrect = s;
  }

  int get pwScore => _pwScore;
  int get pwcorrect => _pwcorrect;
  int get pwincorrect => _pwincorrect;

  bool get isPWLoading => _isPWLoading;
  List<PictureWord> get picturewordlist {
    return List.from(_picturewordlist);
  }
}

class WordPictureModel extends MergedModel {
  void incrementWPScore() {
    _wpScore += 10;
    _wpcorrect++;
  }

  void decrementWPScore() {
    _wpincorrect++;
  }

  void set scoreWP(int s) {
    _wpScore = s;
  }

  void set correctWP(int s) {
    _wpcorrect = s;
  }

  void set wploading(bool t) {
    _isWPLoading = t;
  }

  void set incorrectWP(int s) {
    _wpincorrect = s;
  }

  int get wpScore => _wpScore;
  int get wpcorrect => _wpcorrect;
  int get wpincorrect => _wpincorrect;

  bool get isWPLoading => _isWPLoading;
  List<WordPicture> get wordpicturelist {
    return List.from(_wordpicturelist);
  }
}

class ListeningTaskModel extends MergedModel {
  void incrementLTScore() {
    _ltScore += 10;
    _ltcorrect++;
  }

  void decrementLTScore() {
    _ltincorrect++;
  }

  void set scoreLT(int s) {
    _ltScore = s;
  }

  void set correctLT(int s) {
    _ltcorrect = s;
  }

  void set ltloading(bool t) {
    _isLTLoading = t;
  }

  void set incorrectLT(int s) {
    _ltincorrect = s;
  }

  int get ltScore => _ltScore;
  int get ltcorrect => _ltcorrect;
  int get ltincorrect => _ltincorrect;

  bool get isLTLoading => _isLTLoading;
  List<ListeningItem> get ltitemlist {
    return List.from(_listeningitemlist);
  }
}

class SATaskModel extends MergedModel {
  void incrementSAScore() {
    _saScore += 10;
    _sacorrect++;
  }

  void decrementSAScore() {
    _saincorrect++;
  }

  void set scoreSA(int s) {
    _saScore = s;
  }

  void set correctsA(int s) {
    _sacorrect = s;
  }

  void set saloading(bool t) {
    _isSALoading = t;
  }

  void set incorrectSA(int s) {
    _saincorrect = s;
  }

  int get saScore => _saScore;
  int get sacorrect => _sacorrect;
  int get saincorrect => _saincorrect;

  bool get isSALoading => _isSALoading;
  List<SAItem> get saitemlist {
    return List.from(_saitemlist);
  }
}

class QuizModel extends MergedModel {
  bool get isQuizActive => _isQuizActive;
  QuizItem get currentQuizItem => _currentQuiz;
  int get current_quiz_tracker => _current_quiz_tracker;

  void set current_quiz_tracker(int t) {
    _current_quiz_tracker = t;
  }

  void set isQuizActive(bool t) {
    _isQuizActive = t;
  }

  void set currentQuizItem(QuizItem q) {
    _currentQuiz = q;
  }

  void set quizloading(bool t) {
    _isWPLoading = t;
  }

  bool get isQuizLoading => _isQuizLoading;

  List<QuizItem> get quizlist {
    return List.from(_quizlist);
  }
}

class JumbledModel extends Model {
  JumbledList _jumbledSentences;
  bool _isLoaded = false;
  String _topic;
  int _solved = 0;
  List<jumbleSentence> _val;

  JumbledList get getJumbledSentences => _jumbledSentences;
  bool get getIsLoaded => _isLoaded;
  String get getTopicID => _topic;
  int get getSolved => _solved;
  List<jumbleSentence> get getVal => _val;

  void set setJumbledSentences(List<jumbleSentence> jl) {
    this._val = List.from(jl);
  }

  void set setIsLoaded(bool l) {
    this._isLoaded = l;
  }

  void set setTopic(String t) {
    this._topic = t;
  }

  void set setSolved(int s) {
    this._solved = s;
  }

  void set setVal(List<jumbleSentence> js) {
    this._val = js;
  }

  void addToVal(jumbleSentence js) {
    this._val.add(js);
  }
}

class FillInTheGaps extends Model{
  
  FBList _fbList;
  bool _isFBLoaded=false;
  String _fbtopic;
  int _fbsolved = 0;
  List<FbGap> _fbval;

  FBList get getFillBlanks => _fbList;
  bool get getFBIsLoaded => _isFBLoaded;
  String get getFBTopicID => _fbtopic;
  int get getFBSolved => _fbsolved;
  List<FbGap> get getFBVal => _fbval; 

  void set setFBFillBlanks(List<FbGap> fb) {
    this._fbval = List.from(fb);
  }

  void set setFBIsLoaded(bool l) {
    this._isFBLoaded = l;
  }

  void set setFBTopic(String t) {
    this._fbtopic = t;
  }

  void set setFBSolved(int s) {
    this._fbsolved = s;
  }

  void set setFBVal(List<FbGap> fb) {
    this._fbval = fb;
  }

  void addFBToVal(FbGap fb){
    this._fbval.add(fb);
  }
}

class MCQScoped extends Model{
  MCQ _mcqList;
  bool _ismcqLoaded=false;
  String _mcqtopic;
  int _mcqsolved = 0;
  List<MCQ> _mcqval;

  MCQ get getMCQ => _mcqList;
  bool get getMCQIsLoaded => _ismcqLoaded;
  String get getMCQTopicID => _mcqtopic;
  int get getMCQSolved => _mcqsolved;
  List<MCQ> get getMCQVal => _mcqval; 

  void set setMCQ(List<MCQ> mcq) {
    this._mcqval = List.from(mcq);
  }

  void set setMCQIsLoaded(bool l) {
    this._ismcqLoaded = l;
  }

  void set setmcqTopic(String t) {
    this._mcqtopic = t;
  }

  void set setMCQSolved(int s) {
    this._mcqsolved = s;
  }

  void set setMCQVal(List<MCQ> mcq) {
    this._mcqval = mcq;
  }

  void addMCQToVal(MCQ mcq){
    this._mcqval.add(mcq);
  }
}

