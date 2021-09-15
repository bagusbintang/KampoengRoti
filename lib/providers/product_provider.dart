import 'package:flutter/material.dart';
import 'package:kampoeng_roti/models/product_model.dart';
import 'package:kampoeng_roti/services/product_service.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> _products = [];
  List<ProductModel> _newProducts = [];

  List<ProductModel> get products => _products;

  List<ProductModel> get newProducts => _newProducts;

  set products(List<ProductModel> products) {
    _products = products;
    notifyListeners();
  }

  set newProducts(List<ProductModel> products) {
    _newProducts = products;
    notifyListeners();
  }

  Future<void> getProducts({
    int catId,
    String search,
  }) async {
    try {
      List<ProductModel> products =
          await ProductService().getProduct(catId: catId, search: search);
      _products = products;
    } catch (e) {
      print(e);
    }
  }

  Future<void> getNewProducts() async {
    try {
      List<ProductModel> products = await ProductService().getNewProduct();
      _newProducts = products;
    } catch (e) {
      print(e);
    }
  }
}
