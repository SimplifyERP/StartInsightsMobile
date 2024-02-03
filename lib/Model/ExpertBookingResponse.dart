// To parse this JSON data, do
//
//     final expertBookingResponse = expertBookingResponseFromJson(jsonString);

import 'dart:convert';

ExpertBookingResponse expertBookingResponseFromJson(String str) =>
    ExpertBookingResponse.fromJson(json.decode(str));

String expertBookingResponseToJson(ExpertBookingResponse data) =>
    json.encode(data.toJson());

class ExpertBookingResponse {
  Message? message;

  ExpertBookingResponse({
    this.message,
  });

  factory ExpertBookingResponse.fromJson(Map<String, dynamic> json) =>
      ExpertBookingResponse(
        message:
            json["message"] == null ? null : Message.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message?.toJson(),
      };
}

class Message {
  bool? status;
  List<BookAnExpert>? bookAnExpert;

  Message({
    this.status,
    this.bookAnExpert,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        status: json["status"],
        bookAnExpert: json["book_an_expert"] == null
            ? []
            : List<BookAnExpert>.from(
                json["book_an_expert"]!.map((x) => BookAnExpert.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "book_an_expert": bookAnExpert == null
            ? []
            : List<dynamic>.from(bookAnExpert!.map((x) => x.toJson())),
      };
}

class BookAnExpert {
  String? expertName;
  String? designation;
  String? linkedinId;
  int? price;
  String? attachImage;
  String? description;
  String? fromDate;
  String? toDate;
  String? startTime;
  String? endTime;
  String? duration;
  List<Booking>? booking;

  BookAnExpert({
    this.expertName,
    this.designation,
    this.linkedinId,
    this.price,
    this.attachImage,
    this.description,
    this.fromDate,
    this.toDate,
    this.startTime,
    this.endTime,
    this.duration,
    this.booking,
  });

  factory BookAnExpert.fromJson(Map<String, dynamic> json) => BookAnExpert(
        expertName: json["expert_name"],
        designation: json["designation"],
        linkedinId: json["linkedin_id"],
        price: json["price"],
        attachImage: json["attach_image"],
        description: json["description"],
        fromDate: json["from_date"],
        toDate: json["to_date"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        duration: json["duration"],
        booking: json["booking"] == null
            ? []
            : List<Booking>.from(
                json["booking"]!.map((x) => Booking.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "expert_name": expertName,
        "designation": designation,
        "linkedin_id": linkedinId,
        "price": price,
        "attach_image": attachImage,
        "description": description,
        "from_date": fromDate,
        "to_date": toDate,
        "start_time": startTime,
        "end_time": endTime,
        "duration": duration,
        "booking": booking == null
            ? []
            : List<dynamic>.from(booking!.map((x) => x.toJson())),
      };
}

class Booking {
  String? date;
  String? startTime;
  String? endTime;

  Booking({
    this.date,
    this.startTime,
    this.endTime,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        date: json["date"],
        startTime: json["start_time"],
        endTime: json["end_time"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "start_time": startTime,
        "end_time": endTime,
      };
}
