// To parse this JSON data, do
//
//     final coursesListResponse = coursesListResponseFromJson(jsonString);

import 'dart:convert';

CoursesListResponse coursesListResponseFromJson(String str) =>
    CoursesListResponse.fromJson(json.decode(str));

String coursesListResponseToJson(CoursesListResponse data) =>
    json.encode(data.toJson());

class CoursesListResponse {
  Message? message;

  CoursesListResponse({
    this.message,
  });

  factory CoursesListResponse.fromJson(Map<String, dynamic> json) =>
      CoursesListResponse(
        message:
            json["message"] == null ? null : Message.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message?.toJson(),
      };
}

class Message {
  bool? status;
  List<CoursesList>? coursesList;
  List<CoursesList>? savedCourses;

  Message({
    this.status,
    this.coursesList,
    this.savedCourses,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        status: json["status"],
        coursesList: json["courses_list"] == null
            ? []
            : List<CoursesList>.from(
                json["courses_list"]!.map((x) => CoursesList.fromJson(x))),
        savedCourses: json["saved_courses"] == null
            ? []
            : List<CoursesList>.from(
                json["saved_courses"]!.map((x) => CoursesList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "courses_list": coursesList == null
            ? []
            : List<dynamic>.from(coursesList!.map((x) => x.toJson())),
        "saved_courses": savedCourses == null
            ? []
            : List<dynamic>.from(savedCourses!.map((x) => x.toJson())),
      };
}

class CoursesList {
  String? id;
  String? title;
  String? image;
  String? shortIntroduction;
  int? lessonCount;
  int? quizCount;
  int? videosCount;

  CoursesList({
    this.id,
    this.title,
    this.image,
    this.shortIntroduction,
    this.lessonCount,
    this.quizCount,
    this.videosCount,
  });

  factory CoursesList.fromJson(Map<String, dynamic> json) => CoursesList(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        shortIntroduction: json["short_introduction"],
        lessonCount: json["lesson_count"],
        quizCount: json["quiz_count"],
        videosCount: json["videos_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "short_introduction": shortIntroduction,
        "lesson_count": lessonCount,
        "quiz_count": quizCount,
        "videos_count": videosCount,
      };
}
