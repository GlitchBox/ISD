import 'package:Dimik/ScopedModel/mainmodel.dart';
import 'package:Dimik/models/quiz_item.dart';
import 'package:Dimik/models/user.dart';
import 'package:Dimik/ui/homePage/homeTopicCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int _key = 1;
  AnimationController _controller;
  bool changeToBanglas = false;
  bool topics_generated = false;
  bool quiz_generated = false;
  final GlobalKey _backdropKey = GlobalKey(debugLabel: 'Backdrop');
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  PageController _pageController;
  var currentPageValue = 0.0;
  var currentAnimationValue = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _pageController = PageController(initialPage: 0, viewportFraction: 0.75);
    _pageController.addListener(() {
      setState(() {
        currentPageValue = _pageController.page;
        currentAnimationValue = _pageController.offset;
      });
    });

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  //uporer header part tuku
  Widget homeUIHeader(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 1),
        borderRadius:
            new BorderRadius.only(bottomLeft: const Radius.circular(40)),
        /*boxShadow: [
            new BoxShadow(
              color: Color.fromRGBO(183, 197, 240, 1),
              offset: new Offset(20.0, 10.0),
              blurRadius: 20.0,
            )
          ]*/
      ),
      height: MediaQuery.of(context).size.height * (212.0 / 740.0),
      width: MediaQuery.of(context).size.width,
      child: Container(
        padding: EdgeInsets.fromLTRB(
            MediaQuery.of(context).size.width * (29.0 / 360.0),
            MediaQuery.of(context).size.width * (49.0 / 360.0),
            MediaQuery.of(context).size.width * (40.0 / 360.0),
            0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(
                        icon: Icon(Icons.menu),
                        onPressed: () =>
                            _scaffoldKey.currentState.openDrawer()),
                    Text(
                      'Vasha',
                      style: new TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Sikkha',
                      style: new TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Hero(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/profile');
                    },
                    child: CircleAvatar(
                      backgroundImage: AssetImage(
                          'assets/img/profile.jpg'), //user profile image would be added
                      minRadius: 23,
                      maxRadius: 23,
                    ),
                  ),
                  tag: 'Profile',
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * (18.0 / 720.0),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '  Home',
                    style: new TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w900),
                  ),
                  SizedBox(
                      height:
                          MediaQuery.of(context).size.height * (1.0 / 740.0)),
                  Text(
                    '    some text here',
                    style: new TextStyle(
                        fontSize: 13, fontWeight: FontWeight.normal),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget bottomNavBar(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 1),
          borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(30),
              topRight: const Radius.circular(30)),
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * (64.0 / 740.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
                onPressed: () {
                  setState(() {
                    _key = 1;
                  });
                },
                icon: Icon(
                  CupertinoIcons.home,
                  color: _key != 1
                      ? Color.fromRGBO(151, 152, 159, 1)
                      : Colors.black,
                )),
            IconButton(
              onPressed: () {
                setState(() {
                  _key = 2;
                });
              },
              icon: Icon(
                CupertinoIcons.create_solid,
                color:
                    _key != 2 ? Color.fromRGBO(151, 152, 159, 1) : Colors.black,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _key = 3;
                });
              },
              icon: Icon(
                Icons.favorite_border,
                color:
                    _key != 3 ? Color.fromRGBO(151, 152, 159, 1) : Colors.black,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _key = 4;
                });
              },
              icon: Icon(
                Icons.assignment,
                color:
                    _key != 4 ? Color.fromRGBO(151, 152, 159, 1) : Colors.black,
              ),
            )
          ],
        ));
  }

  Widget uiHome() {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        if (!topics_generated) {
          model.generateTopics();
          topics_generated = true;
        }
        if (!model.isLoading) {
          _controller.forward();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            homeUIHeader(context),
            Container(
              height: MediaQuery.of(context).size.height * (33.0 / 740.0),
            ),
            model.isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 1.0,
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  )
                : Expanded(
                    key: _backdropKey,
                    flex: 1,
                    child: PageView.builder(
                      controller: _pageController,
                      itemBuilder: (BuildContext context, int index) {
                        return TopicCard(
                          dropShadow: true,
                          mainTopic: model.AllTopic[index],
                          currentGame: model.AllTask[index].name,
                        );
                      },
                      itemCount: model.AllTopic.length,
                    )),
            Container(
              height: MediaQuery.of(context).size.height * (46.0 / 740.0),
            ),
          ],
        );
      },
    );
  }

  Widget _quizCard(QuizItem quizItem) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Card(
          //color: Color.fromRGBO(244, 94, 109, 1),
          color: quizItem.card_color,
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.all(const Radius.circular(20))),
          child: InkWell(
            onTap: () {
              model.isQuizActive = true;
              model.current_quiz_tracker = 1;
              model.currentQuizItem = quizItem;
              model.currentTopic =
                  quizItem.topics[model.current_quiz_tracker - 1];
              switch (model
                  .currentQuizItem.tasks[model.current_quiz_tracker - 1]
                  .getName()) {
                case 'Word to Picture':
                  Navigator.pushNamed(context, '/wordpicture');
                  break;
                case 'Picture to Word':
                  Navigator.pushNamed(context, '/pictureword');
                  break;
                case 'True False':
                  Navigator.pushNamed(context, '/truefalse');
                  break;

                case 'Kid\'s Box':
                  Navigator.pushNamed(context, '/kbintro');
                  break;

                default:
              }
            },
            child: Container(
              height: 110.0 / 948.0 * MediaQuery.of(context).size.height,
              child: Stack(children: <Widget>[
                Positioned(
                  top: 20,
                  left: 20,
                  child: Text(
                    quizItem.quiz_name,
                    style: TextStyle(color: quizItem.text_color, fontSize: 19),
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 20,
                  child: Text(
                    quizItem.tasks.length > 1
                        ? quizItem.tasks.length.toString() + ' Tasks'
                        : '1 Task',
                    style: TextStyle(
                        color: quizItem.text_color.withOpacity(0.5),
                        fontSize: 14),
                  ),
                )
              ]),
            ),
          ),
          margin: EdgeInsets.only(
              bottom: 35.0 / 948.0 * MediaQuery.of(context).size.height),
          //padding: EdgeInsets.all(20),
        );
      },
    );
  }

  Widget _uiQuiz() {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        if (!quiz_generated) {
          model.generateQuiz();
          quiz_generated = true;
        }
        return model.isQuizLoading
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.blue,
                    strokeWidth: 1.5,
                  ),
                ),
              )
            : Stack(
                children: <Widget>[
                  Positioned(
                    child: Text(
                      "Quiz",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                    ),
                    top: 75.0 / 948.0 * MediaQuery.of(context).size.height,
                    left: 40.0 / 375.0 * MediaQuery.of(context).size.width,
                  ),
                  Positioned(
                    top: 150.0 / 948.0 * MediaQuery.of(context).size.height,
                    left: 40.0 / 375.0 * MediaQuery.of(context).size.width,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * .80,
                      width: MediaQuery.of(context).size.width -
                          (2 *
                              40.0 /
                              375.0 *
                              MediaQuery.of(context).size.width),
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return _quizCard(model.quizlist[index]);
                        },
                        itemCount: model.quizlist.length,
                      ),
                    ),
                  )
                ],
              );
      },
    );
  }
  //ui for profile

  Widget _buildChild() {
    switch (_key) {
      case 1:
        return uiHome();
        break;
      case 2:
        return Center(child: Text('Tasks'));
        break;
      case 3:
        return Center(child: Text('Fav'));
        break;
      case 4:
        return _uiQuiz();
        break;
      default:
        return uiHome();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        if (model.gotUser == false) {
          User _user = ModalRoute.of(context).settings.arguments;
          model.user = _user;
          model.gotUser = true;
        }
        return Scaffold(
          key: _scaffoldKey,
          drawer: Drawer(
            child: Column(
              children: <Widget>[
                AppBar(
                  automaticallyImplyLeading: false,
                  title: Text('Options'),
                ),
                ListTile(
                  leading: Icon(CupertinoIcons.settings),
                  title: Text(
                    'Settings',
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(CupertinoIcons.loop),
                  title: Text(
                    'Logout',
                  ),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/');
                  },
                ),
                SwitchListTile(
                  value: changeToBanglas,
                  onChanged: (bool value) {
                    setState(() {
                      changeToBanglas = value;
                    });
                  },
                  title: Text('Change to Bangla?'),
                ),
              ],
            ),
          ),
          backgroundColor: Color.fromRGBO(242, 242, 242, 1),
          body: _buildChild(),
          bottomNavigationBar: bottomNavBar(context),
        );
      },
    );
  }
}
