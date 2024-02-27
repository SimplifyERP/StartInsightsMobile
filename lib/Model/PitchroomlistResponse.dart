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
  String? pitch_deck;
  String? projections;
  String? executive_summary;
  String? shared_user;
  String? expiryDate;

  PitchRoomDetail({
    this.id,
    this.roomName,
    this.description,
    this.pitch_deck,
    this.projections,
    this.executive_summary,
    this.shared_user,
    this.expiryDate,
  });

  factory PitchRoomDetail.fromJson(Map<String, dynamic> json) =>
      PitchRoomDetail(
        id: json["id"],
        roomName: json["room_name"],
        description: json["description"],
        pitch_deck: json["pitch_deck"],
        projections: json["projections"],
        executive_summary: json["executive_summary"],
        shared_user: json["shared_user"],
        expiryDate: json["expiry_date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "room_name": roomName,
        "description": description,
        "pitch_deck": pitch_deck,
        "projections": projections,
        "executive_summary": executive_summary,
        "shared_user": shared_user,
        "expiry_date": expiryDate,
      };
}
