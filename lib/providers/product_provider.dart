import 'package:flutter/material.dart';
import 'package:kampoeng_roti/models/product_model.dart';
import 'package:kampoeng_roti/services/product_service.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> _products = [];

  List<ProductModel> get products => _products;

  set products(List<ProductModel> products) {
    _products = products;
    notifyListeners();
  }

  Future<void> getProducts({
    int cat_id,
  }) async {
    try {
      List<ProductModel> products =
          await ProductService().getProduct(cat_id: cat_id);
      _products = products;
    } catch (e) {
      print(e);
    }
  }
}
