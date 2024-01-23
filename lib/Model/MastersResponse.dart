// To parse this JSON data, do
//
//     final mastersResponse = mastersResponseFromJson(jsonString);

import 'dart:convert';

MastersResponse mastersResponseFromJson(String str) =>
    MastersResponse.fromJson(json.decode(str));

String mastersResponseToJson(MastersResponse data) =>
    json.encode(data.toJson());

class MastersResponse {
  Message? message;

  MastersResponse({
    this.message,
  });

  factory MastersResponse.fromJson(Map<String, dynamic> json) =>
      MastersResponse(
        message:
            json["message"] == null ? null : Message.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message?.toJson(),
      };
}

class Message {
  bool? status;
  MastersData? mastersData;

  Message({
    this.status,
    this.mastersData,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        status: json["status"],
        mastersData: json["masters_data"] == null
            ? null
            : MastersData.fromJson(json["masters_data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "masters_data": mastersData?.toJson(),
      };
}

class MastersData {
  List<UserType>? userType;

  MastersData({
    this.userType,
  });

  factory MastersData.fromJson(Map<String, dynamic> json) => MastersData(
        userType: json["user_type"] == null
            ? []
            : List<UserType>.from(
                json["user_type"]!.map((x) => UserType.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "user_type": userType == null
            ? []
            : List<dynamic>.from(userType!.map((x) => x.toJson())),
      };
}

class UserType {
  String? name;

  UserType({
    this.name,
  });

  factory UserType.fromJson(Map<String, dynamic> json) => UserType(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
