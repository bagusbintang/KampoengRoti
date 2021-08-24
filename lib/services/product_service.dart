import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kampoeng_roti/models/product_model.dart';
import 'package:kampoeng_roti/services/services.dart';

class ProductService {
  Future<List<ProductModel>> getProduct({
    int cat_id = 1,
  }) async {
    final url = Uri.encodeFull("$productUrl/${cat_id}");
    var response = await http.get(
      url,
      headers: headers,
    );

    print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['respons_res'];
      List<ProductModel> products = [];

      for (var item in data) {
        products.add(ProductModel.fromJson(item));
      }

      return products;
    } else {
      throw Exception('Gagal mendapat kan data Product!');
    }
  }
}
