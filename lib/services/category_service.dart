import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kampoeng_roti/models/category_model.dart';
import 'package:kampoeng_roti/services/services.dart';

class CategoryService {
  Future<List<CategoryModel>> getCategory({
    int outletId,
  }) async {
    var response = await http.get(
      Uri.parse("$categoryUrl/${outletId}"),
      headers: headers,
    );

    // print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['respons_res'];
      List<CategoryModel> categories = [];

      for (var item in data) {
        categories.add(CategoryModel.fromJson(item));
      }

      return categories;
    } else {
      throw Exception('Gagal mendapat kan data Category!');
    }
  }
}
