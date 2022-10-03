class LoginModel {
  String name;
  String uid;
  String image;
  String email;
  bool isonline;
  LoginModel(
      {required this.name,
      required this.email,
      required this.image,
      required this.isonline,
      required this.uid});
  factory LoginModel.fromJson(Map json) {
    return LoginModel(
      name: json["name"],
      email: json["email"],
      image: json["image"],
      uid: json["uid"],
      isonline: json["isonline"],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "image": image,
      "uid": uid,
      "isonline": isonline,
    };
  }
}
