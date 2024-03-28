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
  String? userEmail;
  String? companyName;
  String? phoneNo;
  String? designation;
  String? linkedin;
  String? profileImage;
  String? loginType;
  String? role;
  String? website;

  Userinfo({
    this.userName,
    this.fullName,
    this.userEmail,
    this.companyName,
    this.phoneNo,
    this.designation,
    this.linkedin,
    this.profileImage,
    this.loginType,
    this.role,
    this.website,
  });

  factory Userinfo.fromJson(Map<String, dynamic> json) => Userinfo(
        userName: json["user_name"],
        fullName: json["full_name"],
        userEmail: json["user_email"],
        companyName: json["company_name"],
        phoneNo: json["phone_no"],
        designation: json["designation"],
        linkedin: json["linkedin"],
        profileImage: json["profile_image"],
        loginType: json["login_type"],
        role: json["role"],
        website: json["website"],
      );

  Map<String, dynamic> toJson() => {
        "user_name": userName,
        "full_name": fullName,
        "user_email": userEmail,
        "company_name": companyName,
        "phone_no": phoneNo,
        "designation": designation,
        "linkedin": linkedin,
        "profile_image": profileImage,
        "login_type": loginType,
        "role": role,
        "website": website,
      };
}
