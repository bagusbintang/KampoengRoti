import 'package:kampoeng_roti/models/product_model.dart';

class CartModel {
  int id;
  ProductModel product;
  int quantity;

  CartModel({
    this.id,
    this.product,
    this.quantity,
  });

  CartModel.fromJson(Map<String, dynamic> catJson) {
    id = catJson[''];
    product = catJson[''];
    quantity = catJson[''];
  }

  Map<String, dynamic> toJson() {
    return {
      '': id,
      '': product,
      '': quantity,
    };
  }

  double getTotalPrice() {
    return product.price * quantity;
  }
}
