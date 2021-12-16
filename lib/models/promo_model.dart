class PromoModel {
  int id;
  String title;
  String desc;
  double discount;
  double minTrans;
  double maxDisc;
  DateTime start;
  DateTime end;
  String imageUrl;
  int promoType;

  PromoModel({
    this.id,
    this.title,
    this.desc,
    this.discount,
    this.minTrans,
    this.maxDisc,
    this.start,
    this.end,
    this.imageUrl,
    this.promoType,
  });

  PromoModel.fromJson(Map<String, dynamic> json) {
    id = json['voucher_id'];
    title = json['voucher_title'];
    desc = json['voucher_desc'];
    discount = double.parse(json['voucher_discount'].toString());
    minTrans = double.parse(json['voucher_minimum'].toString());
    maxDisc = double.parse(json['voucher_maximum'].toString());

    start = DateTime.parse(json['voucher_start'].toString());
    end = DateTime.parse(json['voucher_end'].toString());
    if (json['voucher_url_photo'] != null) {
      imageUrl = json['voucher_url_photo'];
    }
    promoType = int.parse(json['voucher_type'].toString());
  }

  Map<String, dynamic> toJson() {
    return {
      'plist_id': id,
      'plist_title': title,
      'voucher_desc': desc,
      'voucher_discount': discount,
      'voucher_minimum': minTrans,
      'voucher_maximum': maxDisc,
      'voucher_start': start,
      'voucher_end': end,
      'voucher_url_photo': imageUrl,
      'voucher_type': promoType,
    };
  }
}
