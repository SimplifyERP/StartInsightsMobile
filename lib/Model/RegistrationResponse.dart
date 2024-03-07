// To parse this JSON data, do
//
//     final registrationResponse = registrationResponseFromJson(jsonString);

import 'dart:convert';

RegistrationResponse registrationResponseFromJson(String str) =>
    RegistrationResponse.fromJson(json.decode(str));

String registrationResponseToJson(RegistrationResponse data) =>
    json.encode(data.toJson());

class RegistrationResponse {
  Message? message;

  RegistrationResponse({
    this.message,
  });

  factory RegistrationResponse.fromJson(Map<String, dynamic> json) =>
      RegistrationResponse(
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
  UserDetails? userDetails;

  Message({
    this.status,
    this.message,
    this.userDetails,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        status: json["status"],
        message: json["message"],
        userDetails: json["user_details"] == null
            ? null
            : UserDetails.fromJson(json["user_details"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "user_details": userDetails?.toJson(),
      };
}

class UserDetails {
  String? userId;
  String? fullName;
  String? mobileNo;
  String? typeOfUser;

  UserDetails({
    this.userId,
    this.fullName,
    this.mobileNo,
    this.typeOfUser,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        userId: json["user_id"],
        fullName: json["full_name"],
        mobileNo: json["mobile_no"],
        typeOfUser: json["type_of_user"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "full_name": fullName,
        "mobile_no": mobileNo,
        "type_of_user": typeOfUser,
      };
}
