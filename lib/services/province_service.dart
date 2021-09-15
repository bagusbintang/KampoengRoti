import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kampoeng_roti/models/province_models.dart';
import 'package:kampoeng_roti/services/services.dart';

class ProvinceService {
  Future<List<ProvinceModel>> getProvince() async {
    var response = await http.get(Uri.parse(provinceUrl), headers: headers);

    // print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['respons_res'];
      List<ProvinceModel> provinces = [];

      for (var item in data) {
        provinces.add(ProvinceModel.fromJson(item));
      }

      return provinces;
    } else {
      throw Exception('Gagal mendapat kan data Province!');
    }
  }
}
