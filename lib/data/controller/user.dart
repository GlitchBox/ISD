import 'package:Dimik/data/db/user.dart';
import '../../models/token.dart';
import '../../data/rest/login.dart';
import '../../models/user.dart';

class UserController {
  LoginRest loginRest = new LoginRest();
  //UserDatabaseHelper userDatabaseHelper = new UserDatabaseHelper();
  User user;
  //This will return the details of
  Future<User> login(String username, String password) async {
    int count = 0;
    User user;
    if (count == 0) {
      print("Heho");
      Token token =
          await loginRest.login(username, password).catchError((Object error) {
        print(error.toString());
      });
      //String accessToken="Bearer "+token.token;

      //String accessToken="Bearer "+token.token;
      user = await loginRest.getUserDetails(token).catchError((Object error) {
        print(error.toString());
      });
      //await user.downloadImage(); Image downloading going on here
      print("Baby");
      //await userDatabaseHelper.insertUser(user);
    }
    return user;
  }
}
