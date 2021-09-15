import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kampoeng_roti/models/city_models.dart';
import 'package:kampoeng_roti/services/services.dart';

class CityService {
  Future<List<CityModel>> getCity({
    int provinceId,
  }) async {
    final url = Uri.encodeFull("$cityUrl/${provinceId}");
    var response = await http.get(Uri.parse(url), headers: headers);

    // print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['respons_res'];
      List<CityModel> city = [];

      for (var item in data) {
        city.add(CityModel.fromJson(item));
      }

      return city;
    } else {
      throw Exception('Gagal mendapat kan data City!');
    }
  }
}
