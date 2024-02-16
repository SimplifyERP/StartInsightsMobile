// To parse this JSON data, do
//
//     final certificateResponse = certificateResponseFromJson(jsonString);

import 'dart:convert';

CertificateResponse certificateResponseFromJson(String str) =>
    CertificateResponse.fromJson(json.decode(str));

String certificateResponseToJson(CertificateResponse data) =>
    json.encode(data.toJson());

class CertificateResponse {
  Message? message;

  CertificateResponse({
    this.message,
  });

  factory CertificateResponse.fromJson(Map<String, dynamic> json) =>
      CertificateResponse(
        message:
            json["message"] == null ? null : Message.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message?.toJson(),
      };
}

class Message {
  bool? status;
  LmsCertificate? lmsCertificate;

  Message({
    this.status,
    this.lmsCertificate,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        status: json["status"],
        lmsCertificate: json["lms_certificate"] == null
            ? null
            : LmsCertificate.fromJson(json["lms_certificate"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "lms_certificate": lmsCertificate?.toJson(),
      };
}

class LmsCertificate {
  String? course;
  String? member;
  String? pdfUrl;

  LmsCertificate({
    this.course,
    this.member,
    this.pdfUrl,
  });

  factory LmsCertificate.fromJson(Map<String, dynamic> json) => LmsCertificate(
        course: json["course"],
        member: json["member"],
        pdfUrl: json["pdf_url"],
      );

  Map<String, dynamic> toJson() => {
        "course": course,
        "member": member,
        "pdf_url": pdfUrl,
      };
}
