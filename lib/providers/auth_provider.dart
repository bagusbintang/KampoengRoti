import 'package:flutter/material.dart';
import 'package:kampoeng_roti/models/user_model.dart';
import 'package:kampoeng_roti/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  UserModel _user;

  UserModel get user => _user;

  set user(UserModel user) {
    _user = user;
    notifyListeners();
  }

  Future<bool> register({
    String username,
    String email,
    String phone,
    String password,
  }) async {
    try {
      UserModel user = await AuthService().register(
        username: username,
        email: email,
        phone: phone,
        password: password,
      );

      _user = user;

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> login({
    // String username,
    String email,
    String password,
  }) async {
    try {
      UserModel user = await AuthService().login(
        // username: username,
        email: email,
        password: password,
      );

      _user = user;

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
