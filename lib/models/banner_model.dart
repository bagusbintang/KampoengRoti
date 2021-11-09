class BannerModel {
  int id;
  String title;
  String imageUrl;

  BannerModel({
    this.id,
    this.title,
    this.imageUrl,
  });

  BannerModel.fromJson(Map<String, dynamic> catJson) {
    id = catJson['banner_id'];
    title = catJson['banner_title'];
    imageUrl = catJson['banner_url_photo'];
  }

  Map<String, dynamic> toJson() {
    return {
      'banner_id': id,
      'banner_title': title,
      'banner_url_photo': imageUrl,
    };
  }
}
