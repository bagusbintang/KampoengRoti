import 'dart:convert';

import 'package:kampoeng_roti/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:kampoeng_roti/services/services.dart';

class AuthService {
  Future<UserModel> register({
    String username,
    String email,
    String phone,
    String password,
  }) async {
    var body = jsonEncode({
      'name': username,
      'email': email,
      'phone': phone,
      'password': password,
    });

    var response = await http.post(
      Uri.parse(registerUrl),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['respons_res']);

      return user;
    } else {
      throw Exception('Gagal Register');
    }
  }

  Future<UserModel> login({
    // String username,
    String email,
    String password,
  }) async {
    var body = jsonEncode({
      // 'name': username,
      'email': email,
      'password': password,
    });

    var response = await http.post(
      Uri.parse(loginUrl),
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['respons_res']);

      return user;
    } else {
      throw Exception('Gagal Login');
    }
  }

  Future<UserModel> updateProfile({
    int userId,
    String name,
    String email,
    String phone,
  }) async {
    var body = jsonEncode({
      'name': name,
      'email': email,
      'phone': phone,
    });

    var response = await http.post(
      Uri.parse("$getUpdateUserUrl/${userId}"),
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['respons_res']);

      return user;
    } else {
      throw Exception('Gagal Mengubah Profil !!');
    }
  }
}
