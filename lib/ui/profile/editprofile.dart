//design korte hobe figma te

import 'package:Dimik/ScopedModel/mainmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class EditProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EditProfileState();
  }
}

class EditProfileState extends State<EditProfile> {
  List<String> terms = ['Name', 'Username', 'Password'];
  String name = '', username = '', password = '';
  bool uname_changed = false;
  bool email_changed = false;
  //bool pass_changed = false;

  Widget profileHeader(String image_url) {
    return Container(
      height: MediaQuery.of(context).size.height * (330.0 / 740.0),
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(224, 224, 224, 1),
              borderRadius:
                  new BorderRadius.only(bottomLeft: const Radius.circular(40)),
            ),
            height: MediaQuery.of(context).size.height * (212.0 / 740.0),
            width: MediaQuery.of(context).size.width,
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * (29.0 / 360.0),
            top: MediaQuery.of(context).size.height * (45.0 / 720.0),
            child: Container(
              child: Row(
                children: <Widget>[
                  IconButton(
                      icon: Icon(CupertinoIcons.back),
                      onPressed: () => Navigator.pop(context)),
                  Text(
                    'Edit Profile',
                    style: new TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(113, 113, 113, 1)),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              top: MediaQuery.of(context).size.height * (55.0 / 720.0),
              right: MediaQuery.of(context).size.width * (32.0 / 360.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {});
                },
                child: Icon(
                  Icons.save,
                  color: Color.fromRGBO(113, 113, 113, 1),
                ),
              )),
          Positioned(
            top: MediaQuery.of(context).size.height * (140.0 / 720.0),
            left: MediaQuery.of(context).size.width * (110.0 / 360.0),
            right: MediaQuery.of(context).size.width * (110.0 / 360.0),
            child: CircleAvatar(
                radius: 70, backgroundImage: AssetImage(image_url)),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * (245.0 / 720.0),
            left: MediaQuery.of(context).size.width * (201.0 / 360.0),
            right: MediaQuery.of(context).size.width * (117.0 / 360.0),
            child: Image.asset(
              'assets/img/uploadimage.png',
              scale: 1,
            ),
          )
        ],
      ),
    );
  }

  Widget termInput(String label, String value, bool secure) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Container(
          margin: EdgeInsets.fromLTRB(40, 20, 0, 0),
          child: TextField(
            onChanged: (String value) {
              if (label == 'Name') {
                uname_changed = true;
                name = value;
              }
              if (label == 'Username') {
                email_changed = true;
                username = value;
              }
              /*if (label == 'Password') {
                pass_changed = true;
                password = value;
              }*/
            },
            obscureText: secure,
            autofocus: true,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                border: InputBorder.none, hintText: value, labelText: label),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Scaffold(
            resizeToAvoidBottomPadding: false,
            body: GestureDetector(
                child: Center(
                  child: Column(children: <Widget>[
                    profileHeader('assets/img/profile.jpg'),
                    SizedBox(
                        height: MediaQuery.of(context).size.height < 720
                            ? MediaQuery.of(context).size.height *
                                (360.0 / 720.0)
                            : MediaQuery.of(context).size.height *
                                (390.0 / 720.0),
                        width: MediaQuery.of(context).size.width,
                        child: SingleChildScrollView(
                          child: Container(
                            height: MediaQuery.of(context).size.height *
                                (500.0 / 720.0),
                            decoration: BoxDecoration(
                                borderRadius: new BorderRadius.all(
                                    const Radius.circular(40.0))),
                            margin: EdgeInsets.fromLTRB(30, 0, 30, 40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                termInput(terms[0], model.user.username, false),
                                termInput(terms[1], model.user.email, false),
                                //termInput(terms[2], model.user.password, true),
                                SizedBox(
                                  height: 30,
                                ),
                                new RaisedButton(
                                    child: new Text("Save"),
                                    onPressed: () {
                                      if (uname_changed == true) {
                                        model.user.username = name;
                                      }
                                      if (email_changed == true) {
                                        model.user.email = username;
                                        //verification needed
                                      }
                                      /*
                                      if (pass_changed == true) {
                                        model.user.password = password;
                                      }
                                      */
                                      Navigator.pop(context);
                                    },
                                    color: Colors.redAccent,
                                    textColor: Colors.white,
                                    shape: new RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(30.0)))
                              ],
                            ),
                          ),
                        ))
                  ]),
                ),
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                }));
      },
    );
  }
}
