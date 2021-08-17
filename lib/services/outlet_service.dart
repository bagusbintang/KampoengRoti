import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kampoeng_roti/models/outlet_model.dart';
import 'package:kampoeng_roti/services/services.dart';

class OutletService {
  Future<List<OutletModel>> getOutlets() async {
    var response = await http.get(
      outletUrl,
      headers: headers,
    );

    print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['respons_res'];
      List<OutletModel> outlets = [];

      for (var item in data) {
        outlets.add(OutletModel.fromJson(item));
      }

      return outlets;
    } else {
      throw Exception('Gagal mendapat kan data Outlet!');
    }
  }
}
