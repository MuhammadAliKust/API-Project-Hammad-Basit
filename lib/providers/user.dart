import 'package:api_project/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class UserProvider extends ChangeNotifier {
  UserModel userModel = UserModel();
  String token = "";

  void setUser(UserModel model) {
    userModel = model;
    notifyListeners();
  }


  void setToken(String token) {
    this.token = token;
    notifyListeners();
  }

  UserModel get getUser => userModel;


  String get getToken => token;
}
