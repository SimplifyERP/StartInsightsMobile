// To parse this JSON data, do
//
//     final pitchcraftlistResponse = pitchcraftlistResponseFromJson(jsonString);

import 'dart:convert';

PitchcraftlistResponse pitchcraftlistResponseFromJson(String str) =>
    PitchcraftlistResponse.fromJson(json.decode(str));

String pitchcraftlistResponseToJson(PitchcraftlistResponse data) =>
    json.encode(data.toJson());

class PitchcraftlistResponse {
  Message? message;

  PitchcraftlistResponse({
    this.message,
  });

  factory PitchcraftlistResponse.fromJson(Map<String, dynamic> json) =>
      PitchcraftlistResponse(
        message:
            json["message"] == null ? null : Message.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message?.toJson(),
      };
}

class Message {
  bool? status;
  List<MyService>? servicesList;
  List<MyService>? myServices;

  Message({
    this.status,
    this.servicesList,
    this.myServices,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        status: json["status"],
        servicesList: json["services_list"] == null
            ? []
            : List<MyService>.from(
                json["services_list"]!.map((x) => MyService.fromJson(x))),
        myServices: json["my_services"] == null
            ? []
            : List<MyService>.from(
                json["my_services"]!.map((x) => MyService.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "services_list": servicesList == null
            ? []
            : List<dynamic>.from(servicesList!.map((x) => x.toJson())),
        "my_services": myServices == null
            ? []
            : List<dynamic>.from(myServices!.map((x) => x.toJson())),
      };
}

class MyService {
  String? id;
  String? serviceName;
  String? pitchCraftImage;
  int? pricing;
  String? shortDescription;

  MyService({
    this.id,
    this.serviceName,
    this.pitchCraftImage,
    this.pricing,
    this.shortDescription,
  });

  factory MyService.fromJson(Map<String, dynamic> json) => MyService(
        id: json["id"],
        serviceName: json["service_name"],
        pitchCraftImage: json["pitch_craft_image"],
        pricing: json["pricing"],
        shortDescription: json["short_description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "service_name": serviceName,
        "pitch_craft_image": pitchCraftImage,
        "pricing": pricing,
        "short_description": shortDescription,
      };
}
