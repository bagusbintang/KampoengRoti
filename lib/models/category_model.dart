class CategoryModel {
  int id;
  String title;
  String imageUrl;

  CategoryModel({
    this.id,
    this.title,
    this.imageUrl,
  });

  CategoryModel.fromJson(Map<String, dynamic> catJson) {
    id = catJson['pcat_id'];
    title = catJson['pcat_title'];
    imageUrl = catJson['cat_url_photo'];
  }

  Map<String, dynamic> toJson() {
    return {
      'pcat_id': id,
      'pcat_title': title,
      'cat_url_photo': imageUrl,
    };
  }
}

class CategorySingleton {
  int id = 1;
  String title = "Roti";

  int outletId = 0;
  // String imageUrl;

  // CategorySingleton({
  //   this.id,
  //   this.title,
  //   this.imageUrl,
  // });
  static final CategorySingleton _instance = CategorySingleton._internal();

  CategorySingleton._internal();

  factory CategorySingleton() {
    return _instance;
  }
}
