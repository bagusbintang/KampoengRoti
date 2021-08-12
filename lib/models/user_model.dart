class UserModel {
  int id;
  int phone;
  String name;
  String username;
  String email;
  String profilePictureUrl;
  String token;

  UserModel({
    this.id,
    this.phone,
    this.name,
    this.username,
    this.email,
    this.profilePictureUrl,
    this.token,
  });

  UserModel.fromJson(Map<String, dynamic> jsonUser) {
    id = jsonUser[''];
    phone = jsonUser[''];
    name = jsonUser[''];
    username = jsonUser[''];
    email = jsonUser[''];
    profilePictureUrl = jsonUser[''];
    token = jsonUser[''];
  }

  Map<String, dynamic> toJson() {
    return {
      '': id,
      '': phone,
      '': name,
      '': username,
      '': email,
      '': profilePictureUrl,
      '': token,
    };
  }
}
