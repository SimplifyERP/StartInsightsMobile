// To parse this JSON data, do
//
//     final startupRedeemcodeResponse = startupRedeemcodeResponseFromJson(jsonString);

import 'dart:convert';

StartupRedeemcodeResponse startupRedeemcodeResponseFromJson(String str) =>
    StartupRedeemcodeResponse.fromJson(json.decode(str));

String startupRedeemcodeResponseToJson(StartupRedeemcodeResponse data) =>
    json.encode(data.toJson());

class StartupRedeemcodeResponse {
  Message? message;

  StartupRedeemcodeResponse({
    this.message,
  });

  factory StartupRedeemcodeResponse.fromJson(Map<String, dynamic> json) =>
      StartupRedeemcodeResponse(
        message:
            json["message"] == null ? null : Message.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message?.toJson(),
      };
}

class Message {
  bool? status;
  List<RedeemCode>? redeemCode;

  Message({
    this.status,
    this.redeemCode,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        status: json["status"],
        redeemCode: json["redeem_code"] == null
            ? []
            : List<RedeemCode>.from(
                json["redeem_code"]!.map((x) => RedeemCode.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "redeem_code": redeemCode == null
            ? []
            : List<dynamic>.from(redeemCode!.map((x) => x.toJson())),
      };
}

class RedeemCode {
  String? id;
  String? name;
  String? redeemCode;
  String? redeemurl;
  String? redeemdescription;

  RedeemCode({
    this.id,
    this.name,
    this.redeemCode,
    this.redeemurl,
    this.redeemdescription,
  });

  factory RedeemCode.fromJson(Map<String, dynamic> json) => RedeemCode(
        id: json["id"],
        name: json["name"],
        redeemCode: json["redeem_code"],
        redeemurl: json["redeem_url"],
        redeemdescription: json["redeem_description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "redeem_code": redeemCode,
        "redeem_url": redeemurl,
        "redeem_description": redeemdescription,
      };
}
