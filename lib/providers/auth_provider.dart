import 'dart:io';

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
    double lat,
    double long,
  }) async {
    try {
      UserModel user = await AuthService().register(
        username: username,
        email: email,
        phone: phone,
        password: password,
        lat: lat,
        long: long,
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

  Future<bool> updateProfile({
    int userId,
    String name,
    String email,
    String phone,
  }) async {
    try {
      UserModel user = await AuthService().updateProfile(
        // username: username,
        userId: userId,
        name: name,
        email: email,
        phone: phone,
      );

      _user = user;

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> registMember({
    int userId,
    File imageFile,
    String address,
    String birthdate,
    String noKtp,
  }) async {
    try {
      String string = await AuthService().registerMember(
        // username: username,
        userId: userId,
        imageFile: imageFile,
        address: address,
        birthdate: birthdate,
        noKtp: noKtp,
      );

      print(string);

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<UserModel> refreshUser({
    int userId,
  }) async {
    try {
      UserModel user = await AuthService().refreshUser(
        // username: username,
        userId: userId,
      );

      _user = user;

      return _user;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
