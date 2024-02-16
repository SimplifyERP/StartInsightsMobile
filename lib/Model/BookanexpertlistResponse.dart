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
  List<BookAnExpertList>? bookAnExpertList;

  Message({
    this.status,
    this.bookAnExpertList,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        status: json["status"],
        bookAnExpertList: json["book_an_expert_list"] == null
            ? []
            : List<BookAnExpertList>.from(json["book_an_expert_list"]!
                .map((x) => BookAnExpertList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "book_an_expert_list": bookAnExpertList == null
            ? []
            : List<dynamic>.from(bookAnExpertList!.map((x) => x.toJson())),
      };
}

class BookAnExpertList {
  String? id;
  String? expertName;
  String? designation;
  String? linkedinId;
  String? attachimage;
  int? price;
  String? description;

  BookAnExpertList({
    this.id,
    this.expertName,
    this.designation,
    this.linkedinId,
    this.attachimage,
    this.price,
    this.description,
  });

  factory BookAnExpertList.fromJson(Map<String, dynamic> json) =>
      BookAnExpertList(
        id: json["id"],
        expertName: json["expert_name"],
        designation: json["designation"],
        linkedinId: json["linkedin_id"],
        attachimage: json["attach_image"],
        price: json["price"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "expert_name": expertName,
        "designation": designation,
        "linkedin_id": linkedinId,
        "attach_image": attachimage,
        "price": price,
        "description": description,
      };
}
