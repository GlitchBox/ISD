import 'dart:async';
import 'package:Dimik/models/token.dart';
import 'package:Dimik/config.dart';
import 'package:Dimik/utils/network_util.dart';
import '../../models/user.dart';

//import 'package:mobile_application/models/token.dart';
//import 'package:mobile_application/models/token.dart';
class LoginRest {
  
NetworkUtil _netUtil = new NetworkUtil();

  Future<Token> login(String username, String password) {
    
    String t1="application/x-www-form-urlencoded";
    String t2="application/json";
    Map<String,String> headers= new Map<String,String>();
    headers["Content-Type"]=t1;
    headers["Accept"]=t2;
    
    
    return _netUtil.post(LOGIN_URL,headers:headers,
     body: {
      "email": username,
      "password": password
    }).then((dynamic res) {
      print("DEBUG :=====================\n"+
      res.toString()+"\n=====================\n");
      if(res["message"] == "Unauthorised") throw new Exception(res["message"]);
      print("Hello Man");
      return new Token.fromJson(res);
    });
  }

  Future<User> getUserDetails(Token token) {
    
    String t1="application/x-www-form-urlencoded";
    String t2="application/json";
    String accessToken=token.token;
    Map<String,String> headers= new Map<String,String>();
    headers["Content-Type"]=t1;
    headers["Accept"]=t2;
    headers["Authorization"]=accessToken;
    
    return _netUtil.get(DETAILS_URL,headers: headers).then((dynamic res){
      print("DEBUG :=====================\n"+
      res.toString()+"\n=====================\n");
      if(res["error"] == "Unauthorised") throw new Exception(res["error"]);
      
      print("Hello World");
      User user=User.fromJson(res);
      user.token=token.token;
      return user;
    });

  }

  Future<Token> register(String email,String username, String password) {
    
    String t1="application/x-www-form-urlencoded";
    String t2="application/json";
    Map<String,String> headers= new Map<String,String>();
    headers["Content-Type"]=t1;
    headers["Accept"]=t2;
    
    

    return _netUtil.post(REG_URL,headers: headers,
    body: {
      "name": username,
      "email": email,
      "password": password,
      "password_confirmation": password,
    }).then((dynamic res) {
      print("DEBUG :=====================|||||||\n"+
      res.toString()+"\n=====================\n");
      //if(res["error"] == "Unauthorised") throw new Exception(res["error"]);
      if(res["message"]=="The given data was invalid")
      {
          //need to write the errors here
          print("Errors were found baby");
      }
      else if(res["message"]=="Successfully created user!")
      {
          print("Hello Register");
      }
      
      return new Token.fromJson(res);
    });
  }
  
}
