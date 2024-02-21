// To parse this JSON data, do
//
//     final getuserswithroleResponse = getuserswithroleResponseFromJson(jsonString);

import 'dart:convert';

GetuserswithroleResponse getuserswithroleResponseFromJson(String str) =>
    GetuserswithroleResponse.fromJson(json.decode(str));

String getuserswithroleResponseToJson(GetuserswithroleResponse data) =>
    json.encode(data.toJson());

class GetuserswithroleResponse {
  List<String>? message;

  GetuserswithroleResponse({
    this.message,
  });

  factory GetuserswithroleResponse.fromJson(Map<String, dynamic> json) =>
      GetuserswithroleResponse(
        message: json["message"] == null
            ? []
            : List<String>.from(json["message"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "message":
            message == null ? [] : List<dynamic>.from(message!.map((x) => x)),
      };
}
