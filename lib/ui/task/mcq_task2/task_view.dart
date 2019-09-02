/*

import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'task_controller.dart';
//import '../../models/vocabulary.dart';
//import '../../models/task.dart';
//import '../../data/database_helper.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TaskPage extends StatefulWidget {
  // @override
  // State<StatefulWidget> createState() {
  //   return new TaskPageState();
  // }
  @override
  _TaskPageState createState() => new _TaskPageState();
}

class _TaskPageState extends State<TaskPage>
    with TickerProviderStateMixin
    implements TaskScreenContract {

  List<Vocabulary> list = List();
  
  AnimationController __controller;
  BuildContext _ctx;
  
  bool _isLoading = false;
  int _score = 0;
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  int _value= 0, _taskno;
  List<String> _options = List(); 
  String _question;
  var pressed = [false , false , false, false];
  double percentage=0;
  // TaskScreenPresenter _presenter;

  // TaskPageState(){
  //   _presenter = new TaskScreenPresenter(this);

  // }

  String get timerString {
    Duration duration = __controller.duration * __controller.value;
    _value = duration.inSeconds ;
    
    return '${duration.inSeconds%60}:${(duration.inMilliseconds%100).toString().padLeft(2, '0')}';
  }
  
  void _changedVal(){
    Duration duration = __controller.duration * __controller.value;
    setState(() {
      _value = duration.inSeconds ;
    });
    print("Dur : "+_value.toString());
  }

  Future<Null> _playAnimation() async {
      try {
        // await __controller.repeat().orCancel;
        await __controller.reverse(from: __controller.value == 0.0 ? 1.0 : __controller.value);
        
      } on TickerCanceled {
      // the animation got canceled, probably because we were disposed
      }
  }

  _checkAnswer(){
    int _idx = -1;
    for (var i = 0; i < pressed.length; i++) {
      // pressed[i] = false;
      if(pressed[i] == true)
        _idx = i;
    }
    if(_idx == -1)
    {
      //  _showSnackBar("Please select answer");
       _showDialog("No input", "Please select answer");
       return;
    } 
    
    if(list[_taskno].getEnglishWord() == _options[_idx]){
      //_showSnackBar("Correct");
      // _showDialog("Correct", "Well Done");
      _score +=10;
      if(percentage<1){
        percentage+=0.1;
      }
    }
    else{
      //_showSnackBar("Wrong answer");
       _showDialog("Wrong answer", "Better luck next time!");
      _score -= 5;
      if(percentage<1){
        percentage -=0.05;
      }
    }
    percentage > 1.0 ? percentage = 1 : percentage = percentage;
    percentage < 0 ? percentage = 0 : percentage = percentage;
    _generateNextTask();
    if(percentage >= 1){
      //Game Over
      Navigator.of(_ctx).pushReplacementNamed("/gameover");
    }
  }

  _generateNextTask(){
    _taskno++;
    if (_taskno == list.length) {
      _taskno = 0;
    }
    for (var i = 0; i < pressed.length; i++) {
      pressed[i] = false;
    }

    _options.clear();
    var rng = new Random();
    int correct_idx = rng.nextInt(3);
    _question = list[_taskno].getBanglaWord();
    for (var i = 0; i < 4; i++) {
      if(i == correct_idx)
        _options.add(list[_taskno].getEnglishWord());
      
      _options.add(list[rng.nextInt(list.length-1)].getEnglishWord());

    }

  }

  _fetchData() async {
   
    setState(() {
      _isLoading = true;
    });
    var db = new DatabaseHelper();
    final tokenAuth = await db.getToken();

    // final tokenAuth = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImUxMzYzZjRmMzU1YmMyNGJhOWMxOWRjMzRkZjQwNDViZGRjZTgzYjNmZDM1ZTRlNTczMzViOTVjNTYzZWYwYWFlN2UzMmQ3NzU3NThmOWFlIn0.eyJhdWQiOiIxIiwianRpIjoiZTEzNjNmNGYzNTViYzI0YmE5YzE5ZGMzNGRmNDA0NWJkZGNlODNiM2ZkMzVlNGU1NzMzNWI5NWM1NjNlZjBhYWU3ZTMyZDc3NTc1OGY5YWUiLCJpYXQiOjE1NDk5ODc5ODgsIm5iZiI6MTU0OTk4Nzk4OCwiZXhwIjoxNTgxNTIzOTg4LCJzdWIiOiI2Iiwic2NvcGVzIjpbXX0.ZJBV_3-TURkCsmJOP8nshCrM5x0p6_a2tKu-svtUewzq8VMarz9LYrGg99XOtUf7MzbQSG9N9qXuX9h0sdhe40u4B_gxym0pI0COX3vjkqfM3iR4TyQXFgIcvYnCMoePOkgm7m_bVsNJJuEkRUC5SM1xcJwu144g13UfArDSmjAx37grDauYUYEMmFRBeXS-iaOeXKaDkbTvOYCHhp8vDxDIR7E92t58bOrwjz6pVkSfg7jYDpwV3m6A35uAxieb6-4HC6xmldKnSkt5D_7P73tIo0AymBvlj0LqfUsbH3jCwwjgiIcmqbU3XzdFhSadt8lxC-6bKljO9iS42lNcQBFkT3UQFgQAnhz7XNIEz41YNz9ZtgwHX4h1OR5z9T5HcyF0XW3Fmy2c_FL1WqFJ3UGynTOukjf7l8cdKOozEZ0hkqmxgmfWU7zzsE6ivbeVgtTfsbCj7BrVWDIJdWlDgnIExpwOxHfc_OllAIh5OKOfKiaw5nmUGTNvEdpP_4oMDp4g-owu7K5-YlLUZVePxO6XjpdFJXWjogTciZ-iGSfeOw3nlolm3EGO3PiJiK8ppcGZ87ObvXZ9hlMuNJ_p7qXJc7fo-itgBTJH4UvhXjpL92pjx5wD_3qYR8hn4-6t7eEovzAfHRaQ1UxZEe7_qsI4OoXEHk5TaA1TqDtrlqs";
    final response =
        await http.get("http://192.168.43.225:8000/api/allVocabulary",headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "Accept": "application/json",
      "Authorization": "Bearer "+tokenAuth,
    });
    if (response.statusCode == 200) {
      print(response.body.toString());
      list = (json.decode(response.body) as List)
          .map((data) => new Vocabulary.fromJson(data))
          .toList();
      setState(() {
        _isLoading = false;
        _generateNextTask();
      });
      for (var i = 0; i < list.length; i++) {
        print("List : "+list[i].getBanglaWord().toString()+" "+list[i].getEnglishWord().toString());
      }
      
    } else {
      throw Exception('Failed to load tasks');
    }
    
  }

  void _showDialog(String text,String msg) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(text),
          content: new Text(msg),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Next"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  
  @override
  void initState() {
    super.initState();
    __controller = new AnimationController(
      vsync: this,
      duration: Duration(seconds: 200),
    );
    _taskno = -1;
    _playAnimation();
    // _presenter.getTasks();
    _fetchData();
    //print("Controller : "+__controller.duration.toString());
    //__controller.reverse(from: __controller.value == 0.0 ? 1.0 : __controller.value);
  }

  @override
  void dispose() {
    super.dispose();
    __controller.dispose();
  }
  
  void _showSnackBar(String text) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(text)));
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    return Scaffold(
      appBar: null,
      key: scaffoldKey,
      body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AnimatedBuilder(
                      animation: __controller,
                      builder: (BuildContext context, Widget child) {
                        return LinearPercentIndicator(
                          width: MediaQuery.of(context).size.width - 80,
                          lineHeight: 14.0,
                          percent: percentage,
                          backgroundColor: Colors.yellowAccent,
                          progressColor: Colors.deepOrangeAccent,
                        );
                      }
                    ),
                   
                  ],
                ),
                //padding: const EdgeInsetsDirectional.fromSTEB(0, 30, 0, 70),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AnimatedBuilder(
                      animation: __controller,
                      builder: (BuildContext context, Widget child) {
                        return Text("Time: "+
                          timerString,
                        );
                      }
                    ),
                    Text("Score: "+_score.toString()),
                  ],
                ),
                padding: const EdgeInsetsDirectional.fromSTEB(0, 30, 0, 60),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 43),
                child: Text('সঠিক অর্থটি বাছাই করুন',
                  style: TextStyle(
                    fontSize: 27.0,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 50),
                child: Text(_question,
                  style: TextStyle(
                    fontSize: 35.0,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 300,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white24,
                  ),
                  child: Column(
                    children: [
                      _buildImageRow(1),
                      _buildImageRow(3),
                    ],
                  ),
                ),
              ),
              FlatButton(
                child: const Text('Check',
                  style: TextStyle(
                    fontSize: 35.0,
                    color: Colors.white,
                  ),
                ),
                onPressed: () { 
                  // _showSnackBar("Correct!");
                  // _checkAnswer();
                  setState(() {
                    _checkAnswer();
                    // _generateNextTask();
                  });
                },
                padding: EdgeInsets.only(top:10,left: 60.0,right: 60.0,bottom: 10),
                color: Colors.redAccent,
                textColor: Colors.white,
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
              ),
              
            ],
          ),
          margin: const EdgeInsets.all(30),
        ),
    );
  }

  // Widget _buildDecoratedImage2(int imageIndex) => Expanded(
  //     child: Container(
  //       decoration: BoxDecoration(
  //         border: Border.all(width: 20, color: Colors.redAccent),
  //         borderRadius: const BorderRadius.all(const Radius.circular(6)),
  //       ),
  //       margin: const EdgeInsets.all(4),
  //       child: Image.asset('images/pic$imageIndex.jpg'),
  //     ),
  // );

  Widget _buildDecoratedImage(int imageIndex) => Expanded(
      child: new GestureDetector(
        onTap: () {
          setState((){
            pressed[imageIndex-1] = !pressed[imageIndex-1];
            for (var i = 0; i < pressed.length; i++) {
              if(i==imageIndex-1)
                continue;
              pressed[i] = false;
            }
          });
          //changeButtonState(imageIndex-1);
        },
        child: new Card(
          color: pressed[imageIndex-1] ? Colors.redAccent : Colors.white,
          elevation: 6,
          child: Container(
          decoration: BoxDecoration(
              //border: Border.all(width: 10, color: Colors.redAccent),
              borderRadius: const BorderRadius.all(const Radius.circular(8)),
            ),
            margin: const EdgeInsets.all(4),
            child: Container(
              child: Text(_options[imageIndex-1],
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
              ),
              padding: const EdgeInsets.all(40),
            ) ,
          ),
        ),
        ),
  );

  Widget _buildImageRow(int imageIndex) => Row(
      children: [
        _buildDecoratedImage(imageIndex),
        _buildDecoratedImage(imageIndex + 1),
      ],
  );

  changeButtonState(int idx){
    pressed[idx-1] = !pressed[idx-1];
    for (var i = 0; i < pressed.length; i++) {
      if(i==idx)
        continue;
      pressed[i] = false;
    }
  }

  @override
  void onTaskListChanged(List<Task> list){

  }

  @override
  void onTaskListObtained(List<Task> list){
    // _presenter.getTasks();
  }

  @override
  void onTaskError(String errortxt){}

}

class TimerPainter extends CustomPainter {
  TimerPainter({
    this.animation,
    this.backgroundColor,
    this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 15.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
     

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    //canvas.drawLine(Offset(0, -2), Offset(size.width,-2), paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2;
    canvas.drawArc(Offset.zero & size, pi * 1.5, -progress, false, paint);
    //canvas.drawLine(p1, p2, paint)
  }

  @override
  bool shouldRepaint(TimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}
*/