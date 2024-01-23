// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  Message? message;

  LoginResponse({
    this.message,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        message:
            json["message"] == null ? null : Message.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message?.toJson(),
      };
}

class Message {
  bool? status;
  String? message;
  Userinfo? userinfo;

  Message({
    this.status,
    this.message,
    this.userinfo,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        status: json["status"],
        message: json["message"],
        userinfo: json["userinfo"] == null
            ? null
            : Userinfo.fromJson(json["userinfo"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "userinfo": userinfo?.toJson(),
      };
}

class Userinfo {
  String? userName;
  String? fullName;
  String? phoneNo;
  String? userEmail;
  String? profileImage;

  Userinfo({
    this.userName,
    this.fullName,
    this.phoneNo,
    this.userEmail,
    this.profileImage,
  });

  factory Userinfo.fromJson(Map<String, dynamic> json) => Userinfo(
        userName: json["user_name"],
        fullName: json["full_name"],
        phoneNo: json["phone_no"],
        userEmail: json["user_email"],
        profileImage: json["profile_image"],
      );

  Map<String, dynamic> toJson() => {
        "user_name": userName,
        "full_name": fullName,
        "phone_no": phoneNo,
        "user_email": userEmail,
        "profile_image": profileImage,
      };
}
