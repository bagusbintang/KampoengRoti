class InvoiceDetailModel {
  int id;
  String title;
  double price;
  int qty;
  double subTotal;
  String imageUrl;

  InvoiceDetailModel({
    this.id,
    this.title,
    this.price,
    this.qty,
    this.subTotal,
    this.imageUrl,
  });

  InvoiceDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['idetail_plistid'];
    title = json['plist_title'];
    price = double.parse(json['idetail_price'].toString());
    qty = json['idetail_qty'];
    subTotal = double.parse(json['idetail_subtotal'].toString());
    imageUrl = json['prod_url_photo'];
  }

  Map<String, dynamic> toJson() {
    return {
      'idetail_plistid': id,
      'plist_title': title,
      'idetail_price': price,
      'idetail_qty': qty,
      'idetail_subtotal': subTotal,
      'prod_url_photo': imageUrl,
    };
  }
}
