// To parse this JSON data, do
//
//     final pitchCraftServiceDetailsResponse = pitchCraftServiceDetailsResponseFromJson(jsonString);

import 'dart:convert';

PitchCraftServiceDetailsResponse pitchCraftServiceDetailsResponseFromJson(
        String str) =>
    PitchCraftServiceDetailsResponse.fromJson(json.decode(str));

String pitchCraftServiceDetailsResponseToJson(
        PitchCraftServiceDetailsResponse data) =>
    json.encode(data.toJson());

class PitchCraftServiceDetailsResponse {
  Message? message;

  PitchCraftServiceDetailsResponse({
    this.message,
  });

  factory PitchCraftServiceDetailsResponse.fromJson(
          Map<String, dynamic> json) =>
      PitchCraftServiceDetailsResponse(
        message:
            json["message"] == null ? null : Message.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message?.toJson(),
      };
}

class Message {
  bool? status;
  List<PitchCraftServiceDetail>? pitchCraftServiceDetails;

  Message({
    this.status,
    this.pitchCraftServiceDetails,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        status: json["status"],
        pitchCraftServiceDetails: json["pitch_craft_service_details"] == null
            ? []
            : List<PitchCraftServiceDetail>.from(
                json["pitch_craft_service_details"]!
                    .map((x) => PitchCraftServiceDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "pitch_craft_service_details": pitchCraftServiceDetails == null
            ? []
            : List<dynamic>.from(
                pitchCraftServiceDetails!.map((x) => x.toJson())),
      };
}

class PitchCraftServiceDetail {
  String? id;
  String? serviceName;
  String? pitchCraftImage;
  int? pricing;
  String? benefits;
  String? description;
  String? deliverables;
  List<DocumentsRequired>? documentsRequired;

  PitchCraftServiceDetail({
    this.id,
    this.serviceName,
    this.pitchCraftImage,
    this.pricing,
    this.benefits,
    this.description,
    this.deliverables,
    this.documentsRequired,
  });

  factory PitchCraftServiceDetail.fromJson(Map<String, dynamic> json) =>
      PitchCraftServiceDetail(
        id: json["id"],
        serviceName: json["service_name"],
        pitchCraftImage: json["pitch_craft_image"],
        pricing: json["pricing"],
        benefits: json["benefits"],
        description: json["description"],
        deliverables: json["deliverables"],
        documentsRequired: json["documents_required"] == null
            ? []
            : List<DocumentsRequired>.from(json["documents_required"]!
                .map((x) => DocumentsRequired.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "service_name": serviceName,
        "pitch_craft_image": pitchCraftImage,
        "pricing": pricing,
        "benefits": benefits,
        "description": description,
        "deliverables": deliverables,
        "documents_required": documentsRequired == null
            ? []
            : List<dynamic>.from(documentsRequired!.map((x) => x.toJson())),
      };
}

class DocumentsRequired {
  String? documents;

  DocumentsRequired({
    this.documents,
  });

  factory DocumentsRequired.fromJson(Map<String, dynamic> json) =>
      DocumentsRequired(
        documents: json["documents"],
      );

  Map<String, dynamic> toJson() => {
        "documents": documents,
      };
}
