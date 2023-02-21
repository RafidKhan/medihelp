class UserModel {
  String? userId;
  String? name;
  String? email;
  String? phoneNumber;
  String? profilePicture;
  String? address;
  String? latitude;
  String? longitude;
  bool? isVerified;

  UserModel({
    this.userId,
    this.name,
    this.email,
    this.phoneNumber,
    this.profilePicture,
    this.address,
    this.latitude,
    this.longitude,
    this.isVerified = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userId: json["userId"],
        name: json["name"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        profilePicture: json["profilePicture"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        isVerified: json["isVerified"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "name": name,
        "email": email,
        "phoneNumber": phoneNumber,
        "profilePicture": profilePicture,
        "isVerified": isVerified,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
      };
}
