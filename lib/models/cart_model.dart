// import 'package:kampoeng_roti/models/product_model.dart';

class CartModel {
  int id;
  // ProductModel product;
  String prodTitle;
  double prodPrice;
  String prodUrlPhoto;
  String notes;
  int quantity;

  CartModel({
    this.id,
    // this.product,
    this.quantity,
    this.prodTitle,
    this.prodPrice,
    this.prodUrlPhoto,
    this.notes,
  });

  CartModel.fromJson(Map<String, dynamic> catJson) {
    id = catJson['shoping_cart_temp_detail_id'];
    // product = catJson[''];
    quantity = catJson['qty'];
    notes = catJson['notes'];
    prodTitle = catJson['plist_title'];
    prodPrice = double.parse(catJson['plist_price'].toString());
    prodUrlPhoto = catJson['prod_url_photo'];
  }

  Map<String, dynamic> toJson() {
    return {
      'shoping_cart_temp_detail_id': id,
      // '': product,
      'qty': quantity,
      'notes': notes,
      'plist_title': prodTitle,
      'plist_price': prodPrice,
      'prod_url_photo': prodUrlPhoto,
    };
  }

  double getTotalPrice() {
    return prodPrice * quantity;
  }
}
