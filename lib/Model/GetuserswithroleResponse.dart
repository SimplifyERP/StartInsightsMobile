// To parse this JSON data, do
//
//     final getuserswithroleResponse = getuserswithroleResponseFromJson(jsonString);

import 'dart:convert';

GetuserswithroleResponse getuserswithroleResponseFromJson(String str) =>
    GetuserswithroleResponse.fromJson(json.decode(str));

String getuserswithroleResponseToJson(GetuserswithroleResponse data) =>
    json.encode(data.toJson());

class GetuserswithroleResponse {
  Message? message;

  GetuserswithroleResponse({
    this.message,
  });

  factory GetuserswithroleResponse.fromJson(Map<String, dynamic> json) =>
      GetuserswithroleResponse(
        message:
            json["message"] == null ? null : Message.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message?.toJson(),
      };
}

class Message {
  bool? status;
  List<UserRole>? userRole;

  Message({
    this.status,
    this.userRole,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        status: json["status"],
        userRole: json["user_role"] == null
            ? []
            : List<UserRole>.from(
                json["user_role"]!.map((x) => UserRole.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "user_role": userRole == null
            ? []
            : List<dynamic>.from(userRole!.map((x) => x.toJson())),
      };
}

class UserRole {
  String? userId;
  String? fullName;
  String? profileImage;
  String? emailId;
  String? designation;

  UserRole({
    this.userId,
    this.fullName,
    this.profileImage,
    this.emailId,
    this.designation,
  });

  factory UserRole.fromJson(Map<String, dynamic> json) => UserRole(
        userId: json["user_id"],
        fullName: json["full_name"],
        profileImage: json["profile_image"],
        emailId: json["email_id"],
        designation: json["designation"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "full_name": fullName,
        "profile_image": profileImage,
        "email_id": emailId,
        "designation": designation,
      };
}
