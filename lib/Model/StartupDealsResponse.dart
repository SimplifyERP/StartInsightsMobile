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
  List<DealList>? dealList;

  Message({
    this.status,
    this.dealList,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        status: json["status"],
        dealList: json["deal_list"] == null
            ? []
            : List<DealList>.from(
                json["deal_list"]!.map((x) => DealList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "deal_list": dealList == null
            ? []
            : List<dynamic>.from(dealList!.map((x) => x.toJson())),
      };
}

class DealList {
  String? id;
  String? name;
  String? serviceProviderName;
  String? attachImage;
  String? serviceHeadline;
  String? shortDescription;
  int? featureService;
  int? popularService;
  bool? redeemStatus;
  List<Startup>? startup;

  DealList({
    this.id,
    this.name,
    this.serviceProviderName,
    this.attachImage,
    this.serviceHeadline,
    this.shortDescription,
    this.featureService,
    this.popularService,
    this.redeemStatus,
    this.startup,
  });

  factory DealList.fromJson(Map<String, dynamic> json) => DealList(
        id: json["id"],
        name: json["name"],
        serviceProviderName: json["service_provider_name"],
        attachImage: json["attach_image"],
        serviceHeadline: json["service_headline"],
        shortDescription: json["short_description"],
        featureService: json["feature_service"],
        popularService: json["popular_service"],
        redeemStatus: json["redeem_status"],
        startup: json["startup"] == null
            ? []
            : List<Startup>.from(
                json["startup"]!.map((x) => Startup.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "service_provider_name": serviceProviderName,
        "attach_image": attachImage,
        "service_headline": serviceHeadline,
        "short_description": shortDescription,
        "feature_service": featureService,
        "popular_service": popularService,
        "redeem_status": redeemStatus,
        "startup": startup == null
            ? []
            : List<dynamic>.from(startup!.map((x) => x.toJson())),
      };
}

class Startup {
  TypeOfService? typeOfService;

  Startup({
    this.typeOfService,
  });

  factory Startup.fromJson(Map<String, dynamic> json) => Startup(
        typeOfService: typeOfServiceValues.map[json["type_of_service"]]!,
      );

  Map<String, dynamic> toJson() => {
        "type_of_service": typeOfServiceValues.reverse[typeOfService],
      };
}

enum TypeOfService { SALES_SUPPORT }

final typeOfServiceValues =
    EnumValues({"Sales, Support": TypeOfService.SALES_SUPPORT});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
