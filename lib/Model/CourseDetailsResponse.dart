// To parse this JSON data, do
//
//     final courseDetailsResponse = courseDetailsResponseFromJson(jsonString);

import 'dart:convert';

CourseDetailsResponse courseDetailsResponseFromJson(String str) =>
    CourseDetailsResponse.fromJson(json.decode(str));

String courseDetailsResponseToJson(CourseDetailsResponse data) =>
    json.encode(data.toJson());

class CourseDetailsResponse {
  Message? message;

  CourseDetailsResponse({
    this.message,
  });

  factory CourseDetailsResponse.fromJson(Map<String, dynamic> json) =>
      CourseDetailsResponse(
        message:
            json["message"] == null ? null : Message.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message?.toJson(),
      };
}

class Message {
  bool? status;
  List<CourseDetail>? courseDetails;

  Message({
    this.status,
    this.courseDetails,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        status: json["status"],
        courseDetails: json["course_details"] == null
            ? []
            : List<CourseDetail>.from(
                json["course_details"]!.map((x) => CourseDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "course_details": courseDetails == null
            ? []
            : List<dynamic>.from(courseDetails!.map((x) => x.toJson())),
      };
}

class CourseDetail {
  String? id;
  String? name;
  String? courseTitle;
  String? description;
  int? chaptersCount;
  List<Chapter>? chapters;

  CourseDetail({
    this.id,
    this.name,
    this.courseTitle,
    this.description,
    this.chaptersCount,
    this.chapters,
  });

  factory CourseDetail.fromJson(Map<String, dynamic> json) => CourseDetail(
        id: json["id"],
        name: json["name"],
        courseTitle: json["course_title"],
        description: json["description"],
        chaptersCount: json["chapters_count"],
        chapters: json["chapters"] == null
            ? []
            : List<Chapter>.from(
                json["chapters"]!.map((x) => Chapter.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "course_title": courseTitle,
        "description": description,
        "chapters_count": chaptersCount,
        "chapters": chapters == null
            ? []
            : List<dynamic>.from(chapters!.map((x) => x.toJson())),
      };
}

class Chapter {
  String? chapterName;
  int? lessonCount;
  List<Lesson>? lessons;

  Chapter({
    this.chapterName,
    this.lessonCount,
    this.lessons,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        chapterName: json["chapter_name"],
        lessonCount: json["lesson_count"],
        lessons: json["lessons"] == null
            ? []
            : List<Lesson>.from(
                json["lessons"]!.map((x) => Lesson.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "chapter_name": chapterName,
        "lesson_count": lessonCount,
        "lessons": lessons == null
            ? []
            : List<dynamic>.from(lessons!.map((x) => x.toJson())),
      };
}

class Lesson {
  String? lessonName;
  String? body;
  bool? courseSeenStatus;
  String? extension;

  Lesson({
    this.lessonName,
    this.body,
    this.courseSeenStatus,
    this.extension,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
        lessonName: json["lesson_name"],
        body: json["body"],
        courseSeenStatus: json["course_seen_status"],
        extension: json["extension"],
      );

  Map<String, dynamic> toJson() => {
        "lesson_name": lessonName,
        "body": body,
        "course_seen_status": courseSeenStatus,
        "extension": extension,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
