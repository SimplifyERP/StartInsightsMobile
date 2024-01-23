// To parse this JSON data, do
//
//     final coursesDetailsResponse = coursesDetailsResponseFromJson(jsonString);

import 'dart:convert';

CoursesDetailsResponse coursesDetailsResponseFromJson(String str) =>
    CoursesDetailsResponse.fromJson(json.decode(str));

String coursesDetailsResponseToJson(CoursesDetailsResponse data) =>
    json.encode(data.toJson());

class CoursesDetailsResponse {
  Message? message;

  CoursesDetailsResponse({
    this.message,
  });

  factory CoursesDetailsResponse.fromJson(Map<String, dynamic> json) =>
      CoursesDetailsResponse(
        message:
            json["message"] == null ? null : Message.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message?.toJson(),
      };
}

class Message {
  bool? status;
  List<Course>? course;

  Message({
    this.status,
    this.course,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        status: json["status"],
        course: json["Course"] == null
            ? []
            : List<Course>.from(json["Course"]!.map((x) => Course.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "Course": course == null
            ? []
            : List<dynamic>.from(course!.map((x) => x.toJson())),
      };
}

class Course {
  String? id;
  String? name;
  String? courseTitle;
  List<String>? description;
  List<Chapter>? chapters;

  Course({
    this.id,
    this.name,
    this.courseTitle,
    this.description,
    this.chapters,
  });

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json["id"],
        name: json["name"],
        courseTitle: json["course_title"],
        description: json["description"] == null
            ? []
            : List<String>.from(json["description"]!.map((x) => x)),
        chapters: json["chapters"] == null
            ? []
            : List<Chapter>.from(
                json["chapters"]!.map((x) => Chapter.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "course_title": courseTitle,
        "description": description == null
            ? []
            : List<dynamic>.from(description!.map((x) => x)),
        "chapters": chapters == null
            ? []
            : List<dynamic>.from(chapters!.map((x) => x.toJson())),
      };
}

class Chapter {
  String? chapterName;
  List<Lesson>? lessons;

  Chapter({
    this.chapterName,
    this.lessons,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        chapterName: json["chapter_name"],
        lessons: json["lessons"] == null
            ? []
            : List<Lesson>.from(
                json["lessons"]!.map((x) => Lesson.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "chapter_name": chapterName,
        "lessons": lessons == null
            ? []
            : List<dynamic>.from(lessons!.map((x) => x.toJson())),
      };
}

class Lesson {
  String? lessonName;
  String? body;

  Lesson({
    this.lessonName,
    this.body,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
        lessonName: json["lesson_name"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "lesson_name": lessonName,
        "body": body,
      };
}
