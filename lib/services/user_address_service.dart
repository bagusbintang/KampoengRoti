import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kampoeng_roti/models/user_address_model.dart';
import 'package:kampoeng_roti/services/services.dart';

class UserAddressService {
  Future<List<UserAddressModel>> getAddress({
    int userId = 1,
  }) async {
    final url = Uri.encodeFull("$listUserAddressUrl/${userId}");
    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['respons_res'];
      List<UserAddressModel> userAddress = [];

      for (var item in data) {
        userAddress.add(UserAddressModel.fromJson(item));
      }

      return userAddress;
    } else {
      throw Exception('Gagal mendapat kan data Address!');
    }
  }

  Future<UserAddressModel> addUserAddress({
    int userId,
    String tagAddress,
    String personName,
    String personPhone,
    String address,
    String city,
    String province,
  }) async {
    var body = jsonEncode({
      'tag': tagAddress,
      'name': personName,
      'phone': personPhone,
      'address': address,
      'city': city,
      'province': province,
    });

    var response = await http.post(
      Uri.parse("$addUserAddressUrl/${userId}"),
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserAddressModel user = UserAddressModel.fromJson(data['respons_res']);

      return user;
    } else {
      throw Exception('Gagal Menambah Address');
    }
  }

  Future<UserAddressModel> editUserAddress({
    int addressId,
    String tagAddress,
    String personName,
    String personPhone,
    String address,
    String city,
    String province,
  }) async {
    var body = jsonEncode({
      'tag': tagAddress,
      'name': personName,
      'phone': personPhone,
      'address': address,
      'city': city,
      'province': province,
    });

    var response = await http.post(
      Uri.parse("$editUserAddressUrl/${addressId}"),
      headers: headers,
      body: body,
    );

    // print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserAddressModel user = UserAddressModel.fromJson(data['respons_res']);

      return user;
    } else {
      throw Exception('Gagal Mengubah Address');
    }
  }
}
