import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kampoeng_roti/models/cart_model.dart';
import 'package:kampoeng_roti/services/services.dart';

class CartService {
  Future<List<CartModel>> getCart({
    int userId = 1,
  }) async {
    final url = Uri.encodeFull("$getCartUrl/${userId}");
    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    // print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['respons_res'];
      List<CartModel> cartList = [];

      for (var item in data) {
        cartList.add(CartModel.fromJson(item));
      }

      return cartList;
    } else {
      throw Exception('Gagal mendapat kan data Cart!');
    }
  }

  Future<CartModel> addCart({
    int userId,
    int prodId,
    int quantity,
  }) async {
    var body = jsonEncode({
      'qty': quantity,
    });

    var response = await http.post(
      Uri.parse("$addCartUrl/${userId}/${prodId}"),
      headers: headers,
      body: body,
    );

    // print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      CartModel cartModel = CartModel.fromJson(data['respons_res']);

      return cartModel;
    } else {
      throw Exception('Gagal Menambah Cart');
    }
  }

  Future<CartModel> editCart({
    int cartId,
    // int prodId,
    int quantity,
    String notes,
  }) async {
    var body = jsonEncode({
      'qty': quantity,
      'notes': notes,
    });

    var response = await http.post(
      Uri.parse("$updateCartUrl/${cartId}"),
      headers: headers,
      body: body,
    );

    // print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      CartModel cartModel = CartModel.fromJson(data['respons_res']);

      return cartModel;
    } else {
      throw Exception('Gagal Mengubah Cart');
    }
  }

  Future<void> deleteCart({
    int cartId,
  }) async {
    var response = await http.get(
      Uri.parse("$deleteCartUrl/${cartId}"),
      headers: headers,
    );

    print(response.body);

    if (response.statusCode == 200) {
      // var data = jsonDecode(response.body)['data'];
      // CartModel cartModel = CartModel.fromJson(data['respons_res']);

      // return cartModel;
      // return "Berhasil Menghapus";
    } else {
      throw Exception('Gagal Menghapus Cart');
    }
  }
}
