import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kampoeng_roti/models/banner_model.dart';
import 'package:kampoeng_roti/services/services.dart';

class BannerService {
  Future<List<BannerModel>> getBanner() async {
    var response = await http.get(Uri.parse(getBannerUrl), headers: headers);

    // print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['respons_res'];
      List<BannerModel> banners = [];

      for (var item in data) {
        banners.add(BannerModel.fromJson(item));
      }

      return banners;
    } else {
      throw Exception('Gagal mendapat kan data Category!');
    }
  }
}
