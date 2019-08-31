import 'package:toast/toast.dart';

import 'login_controller.dart';
import 'package:flutter/material.dart';
import 'package:Dimik/models/user.dart';

class LogInPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LogInState();
  }
}

class _LogInState extends State<LogInPage> implements LoginScreenContract {
  bool _isLoading = false;
  User _user;
  String username, password;
  LoginScreenPresenter _presenter;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _presenter = new LoginScreenPresenter(this);
    super.initState();
  }

  login() async {
    print("Greyfiay");
    await _presenter
        .doLogin(username, password)
        .then((onValue) => {_user = onValue});

    if (_user != null) {
      onLoginSuccess(_user.token);
    } else
      onLoginError('errorTxt');
  }

  Widget logInView() {
    return Container(
      color: Color.fromRGBO(247, 248, 248, 1),
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * (616.0 / 740.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  new BorderRadius.only(bottomLeft: const Radius.circular(40)),
            ),
            child: Container(
              margin: EdgeInsets.fromLTRB(40, 48, 0, 30),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Vasha',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w100),
                        ),
                        Text('Sikkha',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w100))
                      ],
                    ),
                  ),
                  Positioned(
                    top: 150.0 / 740.0 * MediaQuery.of(context).size.height,
                    child: Text(
                      'Hello genius',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Positioned(
                    top: 196.0 / 740.0 * MediaQuery.of(context).size.height,
                    child: Text(
                        'Enter your informations below or login with a \nsocial account',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500)),
                  ),
                  Positioned(
                    top: 290,
                    child: Container(
                      height: 100,
                      width: 280,
                      child: TextField(
                        onChanged: (String value) {
                          username = value;
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Username',
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 350,
                    child: Container(
                      height: 100,
                      width: 280,
                      child: TextField(
                        onChanged: (String value) {
                          password = value;
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none, labelText: 'Password'),
                        obscureText: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * (29.0 / 740.0),
          ),
          Container(
            height: 60,
            width: 280,
            decoration: BoxDecoration(
              color: Color.fromRGBO(133, 119, 226, 1),
              borderRadius: new BorderRadius.all(const Radius.circular(30)),
            ),
            child: FlatButton(
              onPressed: () {
                setState(() {
                  _isLoading = true;
                  login();
                });
              },
              child: Text(
                'Sign In',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: _isLoading
            ? Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.blue,
                    strokeWidth: 1.5,
                  ),
                ),
              )
            : logInView(),
      ),
    );
  }

  @override
  void onLoginError(String errorTxt) {
    setState(() {
      _isLoading = false;
    });
    Toast.show('Invalid Login', context,
        duration: Toast.LENGTH_SHORT,
        textColor: Colors.white,
        gravity: Toast.BOTTOM,
        backgroundColor: Colors.red);
  }

  @override
  void onLoginSuccess(String token) {
    setState(() {
      _isLoading = false;
    });
    Navigator.pushReplacementNamed(context, '/home', arguments: _user);
  }
}
