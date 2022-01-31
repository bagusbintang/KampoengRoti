// import 'dart:convert';

import 'package:kampoeng_roti/models/outlet_model.dart';
import 'package:kampoeng_roti/models/user_address_model.dart';

class UserModel {
  int id;
  String phone;
  String name;
  String username;
  String email;
  String profilePictureUrl;
  String token;
  String memberNo;
  double discMember;
  int active;
  int verified;
  UserAddressModel defaulAdress;
  int isRequestMember;

  UserModel({
    this.id,
    this.phone,
    this.name,
    this.username,
    this.email,
    this.profilePictureUrl,
    this.token,
    this.memberNo,
    this.discMember,
    this.active,
    this.verified,
    this.defaulAdress,
    this.isRequestMember,
  });

  UserModel.fromJson(Map<String, dynamic> jsonUser) {
    id = jsonUser['customer_id'];
    if (jsonUser['customer_phone'] != null) {
      phone = jsonUser['customer_phone'];
    }
    name = jsonUser['customer_name'];
    username = jsonUser['customer_name'];
    email = jsonUser['customer_email'];
    // profilePictureUrl = jsonUser[''];
    // token = jsonUser[''];
    active = jsonUser['customer_active'];
    verified = jsonUser['customer_emailverified'];
    if (jsonUser['default_address'] != null) {
      defaulAdress = UserAddressModel.fromJson(jsonUser['default_address']);
    }
    if (jsonUser['customer_memberno'] != null) {
      memberNo = jsonUser['customer_memberno'];
    }
    if (jsonUser['settings_disc_member'] != null) {
      discMember = double.parse(jsonUser['settings_disc_member'].toString());
    }
    if (jsonUser['is_request_member'] != null) {
      isRequestMember = jsonUser['is_request_member'];
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'customer_id': id,
      'customer_phone': phone,
      'customer_name': name,
      'customer_name': username,
      'customer_email': email,
      // '': profilePictureUrl,
      // '': token,
      'customer_memberno': memberNo,
      'settings_disc_member': discMember,
      'customer_active': active,
      'customer_emailverified': verified,
      'default_address': defaulAdress.toJson(),
      'is_request_member': isRequestMember,
    };
  }
}

class UserSingleton {
  UserModel user;
  UserAddressModel address;
  OutletModel outlet;
  // String imageUrl;

  // CategorySingleton({
  //   this.id,
  //   this.title,
  //   this.imageUrl,
  // });
  static final UserSingleton _instance = UserSingleton._internal();

  UserSingleton._internal();

  factory UserSingleton() {
    return _instance;
  }
}
