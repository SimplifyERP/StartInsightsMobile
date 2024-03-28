// To parse this JSON data, do
//
//     final pitchroomlistResponse = pitchroomlistResponseFromJson(jsonString);

import 'dart:convert';

PitchroomlistResponse pitchroomlistResponseFromJson(String str) =>
    PitchroomlistResponse.fromJson(json.decode(str));

String pitchroomlistResponseToJson(PitchroomlistResponse data) =>
    json.encode(data.toJson());

class PitchroomlistResponse {
  Message? message;

  PitchroomlistResponse({
    this.message,
  });

  factory PitchroomlistResponse.fromJson(Map<String, dynamic> json) =>
      PitchroomlistResponse(
        message:
            json["message"] == null ? null : Message.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message?.toJson(),
      };
}

class Message {
  bool? status;
  List<PitchRoomDetail>? pitchRoomDetails;

  Message({
    this.status,
    this.pitchRoomDetails,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        status: json["status"],
        pitchRoomDetails: json["pitch_room_details"] == null
            ? []
            : List<PitchRoomDetail>.from(json["pitch_room_details"]!
                .map((x) => PitchRoomDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "pitch_room_details": pitchRoomDetails == null
            ? []
            : List<dynamic>.from(pitchRoomDetails!.map((x) => x.toJson())),
      };
}

class PitchRoomDetail {
  String? id;
  String? coverImage;
  String? roomName;
  String? companyName;
  String? aboutStartup;
  String? notes;
  List<Document>? documents;
  List<SharedUser>? sharedUsers;

  PitchRoomDetail({
    this.id,
    this.coverImage,
    this.roomName,
    this.companyName,
    this.aboutStartup,
    this.notes,
    this.documents,
    this.sharedUsers,
  });

  factory PitchRoomDetail.fromJson(Map<String, dynamic> json) =>
      PitchRoomDetail(
        id: json["id"],
        coverImage: json["cover_image"],
        roomName: json["room_name"],
        companyName: json["company_name"],
        aboutStartup: json["about_startup"],
        notes: json["notes"],
        documents: json["documents"] == null
            ? []
            : List<Document>.from(
                json["documents"]!.map((x) => Document.fromJson(x))),
        sharedUsers: json["shared_users"] == null
            ? []
            : List<SharedUser>.from(
                json["shared_users"]!.map((x) => SharedUser.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cover_image": coverImage,
        "room_name": roomName,
        "company_name": companyName,
        "about_startup": aboutStartup,
        "notes": notes,
        "documents": documents == null
            ? []
            : List<dynamic>.from(documents!.map((x) => x.toJson())),
        "shared_users": sharedUsers == null
            ? []
            : List<dynamic>.from(sharedUsers!.map((x) => x.toJson())),
      };
}

class Document {
  String? docId;
  String? docName;
  String? documentType;
  String? attach;
  bool? isUpload;
  String? createdDate;
  String? createdTime;

  Document({
    this.docId,
    this.docName,
    this.documentType,
    this.attach,
    this.isUpload,
    this.createdDate,
    this.createdTime,
  });

  factory Document.fromJson(Map<String, dynamic> json) => Document(
        docId: json["doc_id"],
        docName: json["doc_name"],
        documentType: json["document_type"],
        attach: json["attach"],
        isUpload: json["is_upload"],
        createdDate: json["created_date"],
        createdTime: json["created_time"],
      );

  Map<String, dynamic> toJson() => {
        "doc_id": docId,
        "doc_name": docName,
        "document_type": documentType,
        "attach": attach,
        "is_upload": isUpload,
        "created_date": createdDate,
        "created_time": createdTime,
      };
}

class SharedUser {
  String? userId;
  String? userName;

  SharedUser({
    this.userId,
    this.userName,
  });

  factory SharedUser.fromJson(Map<String, dynamic> json) => SharedUser(
        userId: json["user_id"],
        userName: json["user_name"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_name": userName,
      };
}
