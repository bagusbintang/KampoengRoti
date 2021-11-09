import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kampoeng_roti/models/product_model.dart';
import 'package:kampoeng_roti/services/services.dart';

class ProductService {
  Future<List<ProductModel>> getProduct({
    int catId = 0,
    int outletId,
    String search = 'all',
  }) async {
    final url = Uri.encodeFull("$productUrl/${catId}/${search}/${outletId}");
    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    // print(response.body);

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

  Future<List<ProductModel>> getNewProduct({
    int outletId,
  }) async {
    var response = await http.get(
      Uri.parse("$newProductUrl/${outletId}"),
      headers: headers,
    );

    // print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['respons_res'];
      List<ProductModel> products = [];

      for (var item in data) {
        products.add(ProductModel.fromJson(item));
      }

      return products;
    } else {
      throw Exception('Gagal mendapat kan data New Product!');
    }
  }
}
