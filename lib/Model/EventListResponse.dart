// To parse this JSON data, do
//
//     final eventListResponse = eventListResponseFromJson(jsonString);

import 'dart:convert';

EventListResponse eventListResponseFromJson(String str) =>
    EventListResponse.fromJson(json.decode(str));

String eventListResponseToJson(EventListResponse data) =>
    json.encode(data.toJson());

class EventListResponse {
  Message? message;

  EventListResponse({
    this.message,
  });

  factory EventListResponse.fromJson(Map<String, dynamic> json) =>
      EventListResponse(
        message:
            json["message"] == null ? null : Message.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message?.toJson(),
      };
}

class Message {
  bool? status;
  List<LiveEvent>? liveEvent;
  List<RecordedEvent>? recordedEvent;

  Message({
    this.status,
    this.liveEvent,
    this.recordedEvent,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        status: json["status"],
        liveEvent: json["live_event"] == null
            ? []
            : List<LiveEvent>.from(
                json["live_event"]!.map((x) => LiveEvent.fromJson(x))),
        recordedEvent: json["recorded_event"] == null
            ? []
            : List<RecordedEvent>.from(
                json["recorded_event"]!.map((x) => RecordedEvent.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "live_event": liveEvent == null
            ? []
            : List<dynamic>.from(liveEvent!.map((x) => x.toJson())),
        "recorded_event": recordedEvent == null
            ? []
            : List<dynamic>.from(recordedEvent!.map((x) => x.toJson())),
      };
}

class LiveEvent {
  String? id;
  String? eventId;
  String? eventImage;
  String? title;
  String? eventStartDate;
  String? eventEndDate;
  String? eventStartTime;
  String? eventEndTime;
  bool? isRegistered;
  String? description;
  List<EventSpeaker>? eventSpeakers;

  LiveEvent({
    this.id,
    this.eventId,
    this.eventImage,
    this.title,
    this.eventStartDate,
    this.eventEndDate,
    this.eventStartTime,
    this.eventEndTime,
    this.isRegistered,
    this.description,
    this.eventSpeakers,
  });

  factory LiveEvent.fromJson(Map<String, dynamic> json) => LiveEvent(
        id: json["id"],
        eventId: json["event_id"],
        eventImage: json["event_image"],
        title: json["title"],
        eventStartDate: json["event_start_date"],
        eventEndDate: json["event_end_date"],
        eventStartTime: json["event_start_time"],
        eventEndTime: json["event_end_time"],
        isRegistered: json["is_registered"],
        description: json["description"],
        eventSpeakers: json["event_speakers"] == null
            ? []
            : List<EventSpeaker>.from(
                json["event_speakers"]!.map((x) => EventSpeaker.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "event_id": eventId,
        "event_image": eventImage,
        "title": title,
        "event_start_date": eventStartDate,
        "event_end_date": eventEndDate,
        "event_start_time": eventStartTime,
        "event_end_time": eventEndTime,
        "is_registered": isRegistered,
        "description": description,
        "event_speakers": eventSpeakers == null
            ? []
            : List<dynamic>.from(eventSpeakers!.map((x) => x.toJson())),
      };
}

class EventSpeaker {
  String? speakersName;
  String? description;

  EventSpeaker({
    this.speakersName,
    this.description,
  });

  factory EventSpeaker.fromJson(Map<String, dynamic> json) => EventSpeaker(
        speakersName: json["speakers_name"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "speakers_name": speakersName,
        "description": description,
      };
}

class RecordedEvent {
  String? id;
  String? eventId;
  String? eventImage;
  String? title;
  String? eventUrl;
  String? description;

  RecordedEvent({
    this.id,
    this.eventId,
    this.eventImage,
    this.title,
    this.eventUrl,
    this.description,
  });

  factory RecordedEvent.fromJson(Map<String, dynamic> json) => RecordedEvent(
        id: json["id"],
        eventId: json["event_id"],
        eventImage: json["event_image"],
        title: json["title"],
        eventUrl: json["event_url"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "event_id": eventId,
        "event_image": eventImage,
        "title": title,
        "event_url": eventUrl,
        "description": description,
      };
}
