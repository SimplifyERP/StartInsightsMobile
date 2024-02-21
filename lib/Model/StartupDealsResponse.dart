// To parse this JSON data, do
//
//     final startupDealsResponse = startupDealsResponseFromJson(jsonString);

import 'dart:convert';

StartupDealsResponse startupDealsResponseFromJson(String str) =>
    StartupDealsResponse.fromJson(json.decode(str));

String startupDealsResponseToJson(StartupDealsResponse data) =>
    json.encode(data.toJson());

class StartupDealsResponse {
  Message? message;

  StartupDealsResponse({
    this.message,
  });

  factory StartupDealsResponse.fromJson(Map<String, dynamic> json) =>
      StartupDealsResponse(
        message:
            json["message"] == null ? null : Message.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message?.toJson(),
      };
}

class Message {
  bool? status;
  List<Datum>? data;

  Message({
    this.status,
    this.data,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  String? id;
  String? name;
  String? serviceProviderName;
  String? serviceHeadline;
  String? attachImage;
  String? shortDescription;
  int? featureService;
  int? popularService;
  List<Startup>? startup;

  Datum({
    this.id,
    this.name,
    this.serviceProviderName,
    this.serviceHeadline,
    this.attachImage,
    this.shortDescription,
    this.featureService,
    this.popularService,
    this.startup,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        serviceProviderName: json["service_provider_name"],
        serviceHeadline: json["service_headline"],
        attachImage: json["attach_image"],
        shortDescription: json["short_description"],
        featureService: json["feature_service"],
        popularService: json["popular_service"],
        startup: json["startup"] == null
            ? []
            : List<Startup>.from(
                json["startup"]!.map((x) => Startup.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "service_provider_name": serviceProviderName,
        "service_headline": serviceHeadline,
        "attach_image": attachImage,
        "short_description": shortDescription,
        "feature_service": featureService,
        "popular_service": popularService,
        "startup": startup == null
            ? []
            : List<dynamic>.from(startup!.map((x) => x.toJson())),
      };
}

class Startup {
  String? typeOfService;

  Startup({
    this.typeOfService,
  });

  factory Startup.fromJson(Map<String, dynamic> json) => Startup(
        typeOfService: json["type_of_service"],
      );

  Map<String, dynamic> toJson() => {
        "type_of_service": typeOfService,
      };
}
