import 'package:Dimik/ScopedModel/mainmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:pimp_my_button/pimp_my_button.dart';
import 'package:scoped_model/scoped_model.dart';

class GameOver extends StatefulWidget {
  @override
  GameOverState createState() => GameOverState();
}

class GameOverState extends State<GameOver>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  final GlobalKey<AnimatedCircularChartState> _chartKey =
      new GlobalKey<AnimatedCircularChartState>();

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: Duration(seconds: 15), vsync: this)
          ..repeat(
            period: Duration(seconds: 30),
          );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  _makeFirework(AnimationController controller) {
    Future.delayed(
        Duration(seconds: 0),
        () => controller.forward(from: 0).then((_) async {
              await Future.delayed(Duration(seconds: 0));
              _makeFirework(controller);
            }));
  }

  @override
  Widget build(BuildContext context) {
    _animationController.forward(from: 0);
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        String task_name = ModalRoute.of(context).settings.arguments;
        int correct, incorrect, total, score;

        switch (task_name) {
          case 'truefalse':
            correct = model.tfcorrect;
            incorrect = model.tfincorrect;
            total = correct + incorrect;
            score = model.trueFalseScore;
            break;

          case 'satask':
            correct = 3; //model.tfcorrect;
            incorrect = 2; //model.tfincorrect;
            total = correct + incorrect;
            score = 5; //model.trueFalseScore;
            break;

          case 'listeningtask':
            correct = model.ltcorrect;
            incorrect = model.ltincorrect;
            total = correct + incorrect;
            score = model.ltScore;
            break;

          case 'pictureword':
            correct = model.pwcorrect;
            incorrect = model.pwincorrect;
            total = correct + incorrect;
            score = model.pwScore;
            break;
          case 'wordpicture':
            correct = model.wpcorrect;
            incorrect = model.wpincorrect;
            total = correct + incorrect;
            score = model.wpScore;
            break;
          case 'sm':
            // correct = model.sm;
            // incorrect = model.wpincorrect;
            total = model.smTotalQuestions;
            score = model.smSolved;
            correct=model.smSolved;
            incorrect=total-correct;
            break;
          case 'mcq':
            // correct = model.sm;
            // incorrect = model.wpincorrect;
            correct=model.getMCQSolved;
            incorrect=model.getMCQVal.length-model.getMCQSolved;
            total = model.getMCQVal.length;
            score = model.getMCQSolved;
            break;
          default:
        }

        List<CircularStackEntry> data = <CircularStackEntry>[
          new CircularStackEntry(
            <CircularSegmentEntry>[
              new CircularSegmentEntry((100.0 * correct / (1.0 * total)),
                  Color.fromRGBO(83, 195, 111, 1),
                  rankKey: 'Q1'),
              new CircularSegmentEntry((100.0 * incorrect / (1.0 * total)),
                  Color.fromRGBO(255, 131, 131, 1),
                  rankKey: 'Q2'),
            ],
            rankKey: 'Quarterly Profits',
          ),
        ];

        List<CircularStackEntry> correctEntry = <CircularStackEntry>[
          new CircularStackEntry(
            <CircularSegmentEntry>[
              new CircularSegmentEntry((100.0 * correct / (1.0 * total)),
                  Color.fromRGBO(83, 195, 111, 1),
                  rankKey: 'Q1'),
            ],
            rankKey: 'Quarterly Profits',
          ),
        ];

        List<CircularStackEntry> wrong = <CircularStackEntry>[
          new CircularStackEntry(
            <CircularSegmentEntry>[
              new CircularSegmentEntry((100.0 * incorrect / (1.0 * total)),
                  Color.fromRGBO(255, 131, 131, 1),
                  rankKey: 'Q1'),
            ],
            rankKey: 'Quarterly Profits',
          ),
        ];

        return Scaffold(
          backgroundColor: Color.fromRGBO(242, 242, 242, 1),
          body: Stack(
            children: <Widget>[
              Positioned(
                top: 300,
                left: 40,
                child: AnimatedBuilder(
                  animation: _animationController,
                  child: Image.asset(
                    'assets/img/balloon.png',
                    scale: 20,
                  ),
                  builder: (context, child) => Transform.translate(
                    child: child,
                    offset:
                        Offset(10, _animationController.value * -300 * 3.1416),
                  ),
                ),
              ),
              Positioned(
                top: 200,
                left: 250,
                child: AnimatedBuilder(
                  animation: _animationController,
                  child: Image.asset(
                    'assets/img/balloon.png',
                    scale: 20,
                  ),
                  builder: (context, child) => Transform.translate(
                    child: child,
                    offset:
                        Offset(10, _animationController.value * -300 * 3.1416),
                  ),
                ),
              ),
              Positioned(
                top: 100,
                left: 150,
                child: AnimatedBuilder(
                  animation: _animationController,
                  child: Image.asset(
                    'assets/img/balloon.png',
                    scale: 20,
                  ),
                  builder: (context, child) => Transform.translate(
                    child: child,
                    offset:
                        Offset(10, _animationController.value * -300 * 3.1416),
                  ),
                ),
              ),
              Positioned(
                child: PimpedButton(
                  particle: DemoParticle(),
                  pimpedWidgetBuilder: (context, controller) {
                    _makeFirework(controller);
                    return Text(
                      'Score',
                      style:
                          TextStyle(fontSize: 48, color: Colors.blueGrey[600]),
                    );
                  },
                ),
                top: (75.0 / 740.0) * MediaQuery.of(context).size.height,
                left: (117.0 / 360.0) * MediaQuery.of(context).size.width,
              ),
              Positioned(
                top: (160.0 / 740.0) * MediaQuery.of(context).size.height,
                left: (75.0 / 360.0) * MediaQuery.of(context).size.width,
                child: AnimatedCircularChart(
                  holeRadius: 50,
                  holeLabel: score.toString(),
                  labelStyle: new TextStyle(
                    color: Colors.blueGrey[600],
                    fontWeight: FontWeight.bold,
                    fontSize: 48.0,
                  ),
                  key: _chartKey,
                  size: const Size(220.0, 220.0),
                  initialChartData: data,
                  chartType: CircularChartType.Radial,
                  edgeStyle: SegmentEdgeStyle.round,
                  percentageValues: true,
                ),
              ),
              Positioned(
                top: (430.0 / 740.0) * MediaQuery.of(context).size.height,
                left: (75.0 / 360.0) * MediaQuery.of(context).size.width,
                child: AnimatedCircularChart(
                  holeRadius: 15,
                  holeLabel: correct.toString(),
                  labelStyle: new TextStyle(
                    color: Colors.blueGrey[600],
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                  ),
                  size: const Size(90.0, 90.0),
                  initialChartData: correctEntry,
                  chartType: CircularChartType.Radial,
                  edgeStyle: SegmentEdgeStyle.round,
                  percentageValues: true,
                ),
              ),
              Positioned(
                top: (430.0 / 740.0) * MediaQuery.of(context).size.height,
                left: (200.0 / 360.0) * MediaQuery.of(context).size.width,
                child: AnimatedCircularChart(
                  holeRadius: 15,
                  holeLabel: incorrect.toString(),
                  labelStyle: new TextStyle(
                    color: Colors.blueGrey[600],
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                  ),
                  size: const Size(90.0, 90.0),
                  initialChartData: wrong,
                  chartType: CircularChartType.Radial,
                  edgeStyle: SegmentEdgeStyle.round,
                  percentageValues: true,
                ),
              ),
              Positioned(
                top: (400.0 / 740.0) * MediaQuery.of(context).size.height,
                left: (85.0 / 360.0) * MediaQuery.of(context).size.width,
                child: Text(
                  'Correct',
                  style: TextStyle(
                      color: Color.fromRGBO(83, 195, 111, 1),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Positioned(
                top: (400.0 / 740.0) * MediaQuery.of(context).size.height,
                left: (215.0 / 360.0) * MediaQuery.of(context).size.width,
                child: Text(
                  'Wrong',
                  style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Positioned(
                  top: (570.0 / 740.0) * MediaQuery.of(context).size.height,
                  left: (40.0 / 360.0) * MediaQuery.of(context).size.width,
                  child: Container(
                      child: ButtonTheme(
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.all(
                                const Radius.circular(30))),
                        child: model.isQuizActive
                            ? model.currentQuizItem.tasks.length >
                                    model.current_quiz_tracker
                                ? FlatButton(
                                    child: Text(
                                      'Goto Next Task',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      model.current_quiz_tracker += 1;
                                      model.currentTopic =
                                          model.currentQuizItem.topics[
                                              model.current_quiz_tracker - 1];

                                      if (task_name == 'truefalse') {
                                        model.scoreTF = 0;
                                        model.correctTF = 0;
                                        model.incorrectTF = 0;
                                        model.tfloading = true;
                                      } else if (task_name == 'pictureword') {
                                        model.scorePW = 0;
                                        model.correctPW = 0;
                                        model.incorrectPW = 0;
                                        model.pwloading = true;
                                      } else if (task_name == 'wordpicture') {
                                        model.scoreWP = 0;
                                        model.correctWP = 0;
                                        model.incorrectWP = 0;
                                        model.wploading = true;
                                      }
                                      switch (model.currentQuizItem
                                          .tasks[model.current_quiz_tracker - 1]
                                          .getName()) {
                                        case 'Word to Picture':
                                          Navigator.pushNamed(
                                              context, '/wordpicture');
                                          break;
                                        case 'Picture to Word':
                                          Navigator.pushNamed(
                                              context, '/pictureword');
                                          break;
                                        case 'True False':
                                          Navigator.pushNamed(
                                              context, '/truefalse');
                                          break;

                                        case 'Kid\'s Box':
                                          Navigator.pushNamed(
                                              context, '/kbintro');
                                          break;

                                        default:
                                      }
                                    })
                                : FlatButton(
                                    child: Text(
                                      'Try Quiz Again?',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      model.current_quiz_tracker = 1;
                                      model.currentTopic =
                                          model.currentQuizItem.topics[
                                              model.current_quiz_tracker - 1];
                                      if (task_name == 'truefalse') {
                                        model.scoreTF = 0;
                                        model.correctTF = 0;
                                        model.incorrectTF = 0;
                                        model.tfloading = true;
                                      } else if (task_name == 'pictureword') {
                                        model.scorePW = 0;
                                        model.correctPW = 0;
                                        model.incorrectPW = 0;
                                        model.pwloading = true;
                                      } else if (task_name == 'wordpicture') {
                                        model.scoreWP = 0;
                                        model.correctWP = 0;
                                        model.incorrectWP = 0;
                                        model.wploading = true;
                                      }
                                      switch (model.currentQuizItem
                                          .tasks[model.current_quiz_tracker - 1]
                                          .getName()) {
                                        case 'Word to Picture':
                                          Navigator.pushNamed(
                                              context, '/wordpicture');
                                          break;
                                        case 'Picture to Word':
                                          Navigator.pushNamed(
                                              context, '/pictureword');
                                          break;
                                        case 'True False':
                                          Navigator.pushNamed(
                                              context, '/truefalse');
                                          break;

                                        case 'Kid\'s Box':
                                          Navigator.pushNamed(
                                              context, '/kbintro');
                                          break;

                                        default:
                                      }
                                    })
                            : FlatButton(
                                child: Text(
                                  'Try Again?',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);

                                  if (task_name == 'truefalse') {
                                    model.scoreTF = 0;
                                    model.correctTF = 0;
                                    model.incorrectTF = 0;
                                    model.tfloading = true;
                                  } else if (task_name == 'pictureword') {
                                    model.scorePW = 0;
                                    model.correctPW = 0;
                                    model.incorrectPW = 0;
                                    model.pwloading = true;
                                  } else if (task_name == 'wordpicture') {
                                    model.scoreWP = 0;
                                    model.correctWP = 0;
                                    model.incorrectWP = 0;
                                    model.wploading = true;
                                  } else if (task_name == 'listeningtask') {
                                    model.scoreLT = 0;
                                    model.correctLT = 0;
                                    model.incorrectLT = 0;
                                    model.ltloading = true;
                                  }

                                  switch (task_name) {
                                    case 'wordpicture':
                                      Navigator.pushNamed(
                                          context, '/wordpicture');
                                      break;
                                    case 'pictureword':
                                      Navigator.pushNamed(
                                          context, '/pictureword');
                                      break;
                                    case 'truefalse':
                                      Navigator.pushNamed(
                                          context, '/truefalse');
                                      break;

                                    case 'satask':
                                      Navigator.pushNamed(context, '/satask');
                                      break;

                                    case 'listeningtask':
                                      Navigator.pushNamed(context, '/lwtask');
                                      break;

                                    case 'Kid\'s Box':
                                      Navigator.pushNamed(context, '/kbintro');
                                      break;

                                    default:
                                  }
                                }),
                      ),
                      height:
                          (60.0 / 740.0) * MediaQuery.of(context).size.height,
                      width:
                          (280.0 / 360.0) * MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: new BorderRadius.all(
                            const Radius.circular(30),
                          )))),
              Positioned(
                  top: (645.0 / 740.0) * MediaQuery.of(context).size.height,
                  left: (40.0 / 360.0) * MediaQuery.of(context).size.width,
                  child: Container(
                      child: ButtonTheme(
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.all(
                                const Radius.circular(30))),
                        child: FlatButton(
                            child: Text(
                              'Take Back to Home',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              if (model.isQuizActive) {
                                model.isQuizActive = false;
                              }
                              Navigator.pop(context);
                              if (task_name == 'truefalse') {
                                model.scoreTF = 0;
                                model.correctTF = 0;
                                model.incorrectTF = 0;
                                model.tfloading = true;
                                Navigator.pushNamed(context, '/home');
                              } else if (task_name == 'pictureword') {
                                model.scorePW = 0;
                                model.correctPW = 0;
                                model.incorrectPW = 0;
                                model.pwloading = true;
                                Navigator.pushNamed(context, '/home');
                              } else if (task_name == 'wordpicture') {
                                model.scoreWP = 0;
                                model.correctWP = 0;
                                model.incorrectWP = 0;
                                model.wploading = true;
                                Navigator.pushNamed(context, '/home');
                              } else if (task_name == 'listeningtask') {
                                model.scoreLT = 0;
                                model.correctLT = 0;
                                model.incorrectLT = 0;
                                model.ltloading = true;
                                Navigator.pushNamed(context, '/home');
                              }
                              else if (task_name == 'sm') {
                                model.smSolved = 0;
                                // model.correctLT = 0;
                                // model.incorrectLT = 0;
                                // model.ltloading = true;
                                Navigator.pushNamed(context, '/home');
                              }
                              else if (task_name == 'mcq') {
                                model.setMCQSolved = 0;
                                // model.correctLT = 0;
                                // model.incorrectLT = 0;
                                // model.ltloading = true;
                                Navigator.pushNamed(context, '/home');
                              }
                            }),
                      ),
                      height:
                          (60.0 / 740.0) * MediaQuery.of(context).size.height,
                      width:
                          (280.0 / 360.0) * MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(133, 119, 226, 1),
                          borderRadius: new BorderRadius.all(
                            const Radius.circular(30),
                          )))),
            ],
          ),
        );
      },
    );
  }
}
