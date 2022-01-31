import 'dart:convert';
import 'dart:io';
// import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:kampoeng_roti/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:kampoeng_roti/services/services.dart';

class AuthService {
  Future<UserModel> register({
    String username,
    String email,
    String phone,
    String password,
    double lat,
    double long,
  }) async {
    var body = jsonEncode({
      'name': username,
      'email': email,
      'phone': phone,
      'password': password,
      'latitude': lat,
      'longitude': long,
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

  Future<String> registerMember({
    int userId,
    File imageFile,
    String address,
    String birthdate,
    String noKtp,
  }) async {
    // var body = jsonEncode({
    //   'name': name,
    //   'email': email,
    //   'phone': phone,
    // });
    final mimeTypeData =
        lookupMimeType(imageFile.path, headerBytes: [0xFF, 0xD8]).split('/');

    // Intilize the multipart request
    final imageUploadRequest = http.MultipartRequest(
        'POST', Uri.parse("$registerMemberUrl/${userId}"));

    // Attach the file in the request
    final file = await http.MultipartFile.fromPath('img_ktp', imageFile.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));

    // var fileStream =
    //     new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // var length = await imageFile.length();
    // var request = new http.MultipartRequest(
    //     "POST", Uri.parse("$registerMemberUrl/${userId}"));
    //add your fields here
    imageUploadRequest.files.add(file);
    imageUploadRequest.fields['no_ktp'] = noKtp;
    imageUploadRequest.fields['birthdate'] = birthdate;

    // var multipartFile = new http.MultipartFile('img_ktp', fileStream, length,
    //     filename: "test.${imageFile.path.split(".").last}");
    final streamedResponse = await imageUploadRequest.send();
    final response = await http.Response.fromStream(streamedResponse);
    // var response = await imageUploadRequest.send();
    print(response);
    if (response.statusCode == 200) {
      return 'Berhasil Mendaftar member !!';
    } else {
      throw Exception('Gagal Meregister Member !!');
    }
  }

  Future<UserModel> refreshUser({
    // String username,
    int userId,
  }) async {
    // var body = jsonEncode({
    //   // 'name': username,
    //   'email': email,
    //   'password': password,
    // });

    var response = await http.get(
      Uri.parse("$getUserById/${userId}"),
      headers: headers,
    );

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['respons_res']);

      return user;
    } else {
      throw Exception('Gagal refresh user');
    }
  }
}
