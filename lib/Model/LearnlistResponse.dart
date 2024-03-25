// To parse this JSON data, do
//
//     final learnlistResponse = learnlistResponseFromJson(jsonString);

import 'dart:convert';

LearnlistResponse learnlistResponseFromJson(String str) =>
    LearnlistResponse.fromJson(json.decode(str));

String learnlistResponseToJson(LearnlistResponse data) =>
    json.encode(data.toJson());

class LearnlistResponse {
  Message? message;

  LearnlistResponse({
    this.message,
  });

  factory LearnlistResponse.fromJson(Map<String, dynamic> json) =>
      LearnlistResponse(
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

  Message({
    this.status,
    this.coursesList,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        status: json["status"],
        coursesList: json["courses_list"] == null
            ? []
            : List<CoursesList>.from(
                json["courses_list"]!.map((x) => CoursesList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "courses_list": coursesList == null
            ? []
            : List<dynamic>.from(coursesList!.map((x) => x.toJson())),
      };
}

class CoursesList {
  String? id;
  String? title;
  bool? favouriteStatus;
  String? image;
  String? shortIntroduction;
  int? chapterCount;
  int? videosCount;
  int? quizCount;

  CoursesList({
    this.id,
    this.title,
    this.favouriteStatus,
    this.image,
    this.shortIntroduction,
    this.chapterCount,
    this.videosCount,
    this.quizCount,
  });

  factory CoursesList.fromJson(Map<String, dynamic> json) => CoursesList(
        id: json["id"],
        title: json["title"],
        favouriteStatus: json["favourite_status"],
        image: json["image"],
        shortIntroduction: json["short_introduction"],
        chapterCount: json["chapter_count"],
        videosCount: json["videos_count"],
        quizCount: json["quiz_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "favourite_status": favouriteStatus,
        "image": image,
        "short_introduction": shortIntroduction,
        "chapter_count": chapterCount,
        "videos_count": videosCount,
        "quiz_count": quizCount,
      };
}
