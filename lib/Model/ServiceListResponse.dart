// To parse this JSON data, do
//
//     final serviceListResponse = serviceListResponseFromJson(jsonString);

import 'dart:convert';

ServiceListResponse serviceListResponseFromJson(String str) =>
    ServiceListResponse.fromJson(json.decode(str));

String serviceListResponseToJson(ServiceListResponse data) =>
    json.encode(data.toJson());

class ServiceListResponse {
  Message? message;

  ServiceListResponse({
    this.message,
  });

  factory ServiceListResponse.fromJson(Map<String, dynamic> json) =>
      ServiceListResponse(
        message:
            json["message"] == null ? null : Message.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message?.toJson(),
      };
}

class Message {
  bool? status;
  List<MyServices>? servicesList;
  List<MyServices>? myServices;

  Message({
    this.status,
    this.servicesList,
    this.myServices,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        status: json["status"],
        servicesList: json["services_list"] == null
            ? []
            : List<MyServices>.from(
                json["services_list"]!.map((x) => MyServices.fromJson(x))),
        myServices: json["my_services"] == null
            ? []
            : List<MyServices>.from(
                json["my_services"]!.map((x) => MyServices.fromJson(x))),
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

class MyServices {
  String? id;
  String? myServiceId;
  bool? purchaseStatus;
  String? serviceName;
  String? serviceImage;
  int? pricing;
  String? shortDescription;
  String? aboutService;
  String? deliverables;
  String? servicestatus;
  List<Document>? documents;

  MyServices({
    this.id,
    this.myServiceId,
    this.purchaseStatus,
    this.serviceName,
    this.serviceImage,
    this.pricing,
    this.shortDescription,
    this.aboutService,
    this.deliverables,
    this.servicestatus,
    this.documents,
  });

  factory MyServices.fromJson(Map<String, dynamic> json) => MyServices(
        id: json["id"],
        myServiceId: json["my_service_id"],
        purchaseStatus: json["purchase_status"],
        serviceName: json["service_name"],
        serviceImage: json["service_image"],
        pricing: json["pricing"],
        shortDescription: json["short_description"],
        aboutService: json["about_service"],
        deliverables: json["deliverables"],
        servicestatus: json["service_status"],
        documents: json["documents"] == null
            ? []
            : List<Document>.from(
                json["documents"]!.map((x) => Document.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "my_service_id": myServiceId,
        "purchase_status": purchaseStatus,
        "service_name": serviceName,
        "service_image": serviceImage,
        "pricing": pricing,
        "short_description": shortDescription,
        "about_service": aboutService,
        "deliverables": deliverables,
        "servicestatus": servicestatus,
        "documents": documents == null
            ? []
            : List<dynamic>.from(documents!.map((x) => x.toJson())),
      };
}

class Document {
  String? documents;

  Document({
    this.documents,
  });

  factory Document.fromJson(Map<String, dynamic> json) => Document(
        documents: json["documents"],
      );

  Map<String, dynamic> toJson() => {
        "documents": documents,
      };
}
