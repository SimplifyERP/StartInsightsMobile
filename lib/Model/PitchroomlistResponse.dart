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
  String? roomName;
  String? description;
  String? document1;
  String? document2;
  String? document3;
  String? document4;

  PitchRoomDetail({
    this.id,
    this.roomName,
    this.description,
    this.document1,
    this.document2,
    this.document3,
    this.document4,
  });

  factory PitchRoomDetail.fromJson(Map<String, dynamic> json) =>
      PitchRoomDetail(
        id: json["id"],
        roomName: json["room_name"],
        description: json["description"],
        document1: json["document_1"],
        document2: json["document_2"],
        document3: json["document_3"],
        document4: json["document_4"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "room_name": roomName,
        "description": description,
        "document_1": document1,
        "document_2": document2,
        "document_3": document3,
        "document_4": document4,
      };
}
