// To parse this JSON data, do
//
//     final bookanexpertlistResponse = bookanexpertlistResponseFromJson(jsonString);

import 'dart:convert';

BookanexpertlistResponse bookanexpertlistResponseFromJson(String str) =>
    BookanexpertlistResponse.fromJson(json.decode(str));

String bookanexpertlistResponseToJson(BookanexpertlistResponse data) =>
    json.encode(data.toJson());

class BookanexpertlistResponse {
  Message? message;

  BookanexpertlistResponse({
    this.message,
  });

  factory BookanexpertlistResponse.fromJson(Map<String, dynamic> json) =>
      BookanexpertlistResponse(
        message:
            json["message"] == null ? null : Message.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message?.toJson(),
      };
}

class Message {
  bool? status;
  List<FundraisingExpert>? fundraisingExperts;

  Message({
    this.status,
    this.fundraisingExperts,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        status: json["status"],
        fundraisingExperts: json["fundraising_experts"] == null
            ? []
            : List<FundraisingExpert>.from(json["fundraising_experts"]!
                .map((x) => FundraisingExpert.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "fundraising_experts": fundraisingExperts == null
            ? []
            : List<dynamic>.from(fundraisingExperts!.map((x) => x.toJson())),
      };
}

class FundraisingExpert {
  String? id;
  String? name;
  String? expertName;
  String? attachImage;
  String? designation;
  String? mailId;
  int? price;
  String? shortDescription;
  String? description;

  FundraisingExpert({
    this.id,
    this.name,
    this.expertName,
    this.attachImage,
    this.designation,
    this.mailId,
    this.price,
    this.shortDescription,
    this.description,
  });

  factory FundraisingExpert.fromJson(Map<String, dynamic> json) =>
      FundraisingExpert(
        id: json["id"],
        name: json["name"],
        expertName: json["expert_name"],
        attachImage: json["attach_image"],
        designation: json["designation"],
        mailId: json["mail_id"],
        price: json["price"],
        shortDescription: json["short_description"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "expert_name": expertName,
        "attach_image": attachImage,
        "designation": designation,
        "mail_id": mailId,
        "price": price,
        "short_description": shortDescription,
        "description": description,
      };
}
