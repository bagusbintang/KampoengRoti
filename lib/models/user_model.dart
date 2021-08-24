class UserModel {
  int id;
  int phone;
  String name;
  String username;
  String email;
  String profilePictureUrl;
  String token;
  int active;
  int verified;

  UserModel({
    this.id,
    this.phone,
    this.name,
    this.username,
    this.email,
    this.profilePictureUrl,
    this.token,
    this.active,
    this.verified,
  });

  UserModel.fromJson(Map<String, dynamic> jsonUser) {
    id = jsonUser['customer_id'];
    // phone = jsonUser[''];
    name = jsonUser['customer_name'];
    username = jsonUser['customer_name'];
    email = jsonUser['customer_email'];
    // profilePictureUrl = jsonUser[''];
    // token = jsonUser[''];
    active = jsonUser['customer_active'];
    verified = jsonUser['customer_emailverified'];
  }

  Map<String, dynamic> toJson() {
    return {
      'customer_id': id,
      // '': phone,
      'customer_name': name,
      'customer_name': username,
      'customer_email': email,
      // '': profilePictureUrl,
      // '': token,
      'customer_active': active,
      'customer_emailverified': verified,
    };
  }
}
