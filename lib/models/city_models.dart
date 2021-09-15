class CityModel {
  int id;
  String cityName;

  CityModel({
    this.id,
    this.cityName,
  });

  CityModel.fromJson(Map<String, dynamic> json) {
    id = json['city_id'];
    cityName = json['city_title'];
  }

  Map<String, dynamic> toJson() {
    return {
      'city_id': id,
      'city_title': cityName,
    };
  }
}
