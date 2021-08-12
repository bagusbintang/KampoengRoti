class ProductModel {
  int id;
  String title;
  int status;
  double price;
  String imageUrl;

  ProductModel({
    this.id,
    this.title,
    this.status,
    this.price,
    this.imageUrl,
  });

  ProductModel.fromJson(Map<String, dynamic> prodJson) {
    id = prodJson['plist_id'];
    title = prodJson['plist_title'];
    status = int.parse(prodJson['plist_status'].toString());
    price = double.parse(prodJson['plist_price'].toString());
    imageUrl = prodJson['prod_url_photo'];
  }

  Map<String, dynamic> toJson() {
    return {
      'plist_id': id,
      'plist_title': title,
      'plist_status': status,
      'plist_price': price,
      'prod_url_photo': imageUrl,
    };
  }
}
