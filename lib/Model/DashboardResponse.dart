// To parse this JSON data, do
//
//     final dashboardResponse = dashboardResponseFromJson(jsonString);

import 'dart:convert';

DashboardResponse dashboardResponseFromJson(String str) =>
    DashboardResponse.fromJson(json.decode(str));

String dashboardResponseToJson(DashboardResponse data) =>
    json.encode(data.toJson());

class DashboardResponse {
  DashboardResponseMessage? message;

  DashboardResponse({
    this.message,
  });

  factory DashboardResponse.fromJson(Map<String, dynamic> json) =>
      DashboardResponse(
        message: json["message"] == null
            ? null
            : DashboardResponseMessage.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message?.toJson(),
      };
}

class DashboardResponseMessage {
  bool? status;
  List<MessageElement>? message;

  DashboardResponseMessage({
    this.status,
    this.message,
  });

  factory DashboardResponseMessage.fromJson(Map<String, dynamic> json) =>
      DashboardResponseMessage(
        status: json["status"],
        message: json["message"] == null
            ? []
            : List<MessageElement>.from(
                json["message"]!.map((x) => MessageElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message == null
            ? []
            : List<dynamic>.from(message!.map((x) => x.toJson())),
      };
}

class MessageElement {
  String? id;
  String? name;
  String? title;
  String? logo;
  String? investorVerified;
  String? linkedin;
  String? website;
  String? aboutUs;
  String? valueAdd;
  String? firmType;
  String? hq;
  String? fundingRequirements;
  List<FundingStagesTable>? fundingStagesTable;
  int? minCheckSize;
  int? maxCheckSize;

  MessageElement({
    this.id,
    this.name,
    this.title,
    this.logo,
    this.investorVerified,
    this.linkedin,
    this.website,
    this.aboutUs,
    this.valueAdd,
    this.firmType,
    this.hq,
    this.fundingRequirements,
    this.fundingStagesTable,
    this.minCheckSize,
    this.maxCheckSize,
  });

  factory MessageElement.fromJson(Map<String, dynamic> json) => MessageElement(
        id: json["id"],
        name: json["name"],
        title: json["title"],
        logo: json["logo"],
        investorVerified: json["investor_verified"],
        linkedin: json["linkedin"],
        website: json["website"],
        aboutUs: json["about_us"],
        valueAdd: json["value_add"],
        firmType: json["firm_type"],
        hq: json["hq"],
        fundingRequirements: json["funding_requirements"],
        fundingStagesTable: json["funding_stages_table"] == null
            ? []
            : List<FundingStagesTable>.from(json["funding_stages_table"]!
                .map((x) => FundingStagesTable.fromJson(x))),
        minCheckSize: json["min_check_size"],
        maxCheckSize: json["max_check_size"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "title": title,
        "logo": logo,
        "investor_verified": investorVerified,
        "linkedin": linkedin,
        "website": website,
        "about_us": aboutUs,
        "value_add": valueAdd,
        "firm_type": firmType,
        "hq": hq,
        "funding_requirements": fundingRequirements,
        "funding_stages_table": fundingStagesTable == null
            ? []
            : List<dynamic>.from(fundingStagesTable!.map((x) => x.toJson())),
        "min_check_size": minCheckSize,
        "max_check_size": maxCheckSize,
      };
}

class FundingStagesTable {
  String? fundingStages;

  FundingStagesTable({
    this.fundingStages,
  });

  factory FundingStagesTable.fromJson(Map<String, dynamic> json) =>
      FundingStagesTable(
        fundingStages: json["funding_stages"],
      );

  Map<String, dynamic> toJson() => {
        "funding_stages": fundingStages,
      };
}
