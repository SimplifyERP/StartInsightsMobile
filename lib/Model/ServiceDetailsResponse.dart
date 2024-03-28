// To parse this JSON data, do
//
//     final serviceDetailsResponse = serviceDetailsResponseFromJson(jsonString);

import 'dart:convert';

ServiceDetailsResponse serviceDetailsResponseFromJson(String str) =>
    ServiceDetailsResponse.fromJson(json.decode(str));

String serviceDetailsResponseToJson(ServiceDetailsResponse data) =>
    json.encode(data.toJson());

class ServiceDetailsResponse {
  ServiceDetailsMessage? message;

  ServiceDetailsResponse({
    this.message,
  });

  factory ServiceDetailsResponse.fromJson(Map<String, dynamic> json) =>
      ServiceDetailsResponse(
        message: json["message"] == null
            ? null
            : ServiceDetailsMessage.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message?.toJson(),
      };
}

class ServiceDetailsMessage {
  bool? status;
  List<MyServiceDetail>? myServiceDetails;
  AssignedUser? assignedUser;
  PaymentDetails? paymentDetails;

  ServiceDetailsMessage({
    this.status,
    this.myServiceDetails,
    this.assignedUser,
    this.paymentDetails,
  });

  factory ServiceDetailsMessage.fromJson(Map<String, dynamic> json) =>
      ServiceDetailsMessage(
        status: json["status"],
        myServiceDetails: json["my_service_details"] == null
            ? []
            : List<MyServiceDetail>.from(json["my_service_details"]!
                .map((x) => MyServiceDetail.fromJson(x))),
        assignedUser: json["assigned_user"] == null
            ? null
            : AssignedUser.fromJson(json["assigned_user"]),
        paymentDetails: json["payment_details"] == null
            ? null
            : PaymentDetails.fromJson(json["payment_details"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "my_service_details": myServiceDetails == null
            ? []
            : List<dynamic>.from(myServiceDetails!.map((x) => x.toJson())),
        "assigned_user": assignedUser?.toJson(),
        "payment_details": paymentDetails?.toJson(),
      };
}

class AssignedUser {
  String? userName;
  String? designation;
  String? mobileNo;
  String? image;

  AssignedUser({
    this.userName,
    this.designation,
    this.mobileNo,
    this.image,
  });

  factory AssignedUser.fromJson(Map<String, dynamic> json) => AssignedUser(
        userName: json["user_name"],
        designation: json["designation"],
        mobileNo: json["mobile_no"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "user_name": userName,
        "designation": designation,
        "mobile_no": mobileNo,
        "image": image,
      };
}

class MyServiceDetail {
  String? id;
  bool? purchaseStatus;
  String? serviceName;
  String? serviceImage;
  int? pricing;
  String? shortDescription;
  String? aboutService;
  String? deliverables;
  List<Document>? documents;
  String? serviceStatus;
  List<ServiceTracking>? serviceTracking;

  MyServiceDetail({
    this.id,
    this.purchaseStatus,
    this.serviceName,
    this.serviceImage,
    this.pricing,
    this.shortDescription,
    this.aboutService,
    this.deliverables,
    this.documents,
    this.serviceStatus,
    this.serviceTracking,
  });

  factory MyServiceDetail.fromJson(Map<String, dynamic> json) =>
      MyServiceDetail(
        id: json["id"],
        purchaseStatus: json["purchase_status"],
        serviceName: json["service_name"],
        serviceImage: json["service_image"],
        pricing: json["pricing"],
        shortDescription: json["short_description"],
        aboutService: json["about_service"],
        deliverables: json["deliverables"],
        documents: json["documents"] == null
            ? []
            : List<Document>.from(
                json["documents"]!.map((x) => Document.fromJson(x))),
        serviceStatus: json["service_status"],
        serviceTracking: json["service_tracking"] == null
            ? []
            : List<ServiceTracking>.from(json["service_tracking"]!
                .map((x) => ServiceTracking.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "purchase_status": purchaseStatus,
        "service_name": serviceName,
        "service_image": serviceImage,
        "pricing": pricing,
        "short_description": shortDescription,
        "about_service": aboutService,
        "deliverables": deliverables,
        "documents": documents == null
            ? []
            : List<dynamic>.from(documents!.map((x) => x.toJson())),
        "service_status": serviceStatus,
        "service_tracking": serviceTracking == null
            ? []
            : List<dynamic>.from(serviceTracking!.map((x) => x.toJson())),
      };
}

class Document {
  String? documents;

  Document({
    this.documents,
  });

  factory Document.fromJson(Map<String, dynamic> json) => Document(
        documents: json["documents"],
      );

  Map<String, dynamic> toJson() => {
        "documents": documents,
      };
}

class ServiceTracking {
  String? steps;
  int? tat;
  String? currentStatus;
  bool? status;
  bool? docstatus;

  ServiceTracking({
    this.steps,
    this.tat,
    this.currentStatus,
    this.status,
    this.docstatus,
  });

  factory ServiceTracking.fromJson(Map<String, dynamic> json) =>
      ServiceTracking(
        steps: json["steps"],
        tat: json["tat"],
        currentStatus: json["current_status"],
        status: json["status"],
        docstatus: json["doc_status"],
      );

  Map<String, dynamic> toJson() => {
        "steps": steps,
        "tat": tat,
        "current_status": currentStatus,
        "status": status,
        "docstatus": docstatus,
      };
}

class PaymentDetails {
  String? id;
  String? paymentId;
  String? paymentDate;
  int? amountPaid;

  PaymentDetails({
    this.id,
    this.paymentId,
    this.paymentDate,
    this.amountPaid,
  });

  factory PaymentDetails.fromJson(Map<String, dynamic> json) => PaymentDetails(
        id: json["id"],
        paymentId: json["payment_id"],
        paymentDate: json["payment_date"],
        amountPaid: json["amount_paid"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "payment_id": paymentId,
        "payment_date": paymentDate,
        "amount_paid": amountPaid,
      };
}
