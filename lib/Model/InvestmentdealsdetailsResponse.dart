// To parse this JSON data, do
//
//     final investmentdealsdetailsResponse = investmentdealsdetailsResponseFromJson(jsonString);

import 'dart:convert';

InvestmentdealsdetailsResponse investmentdealsdetailsResponseFromJson(
        String str) =>
    InvestmentdealsdetailsResponse.fromJson(json.decode(str));

String investmentdealsdetailsResponseToJson(
        InvestmentdealsdetailsResponse data) =>
    json.encode(data.toJson());

class InvestmentdealsdetailsResponse {
  Message? message;

  InvestmentdealsdetailsResponse({
    this.message,
  });

  factory InvestmentdealsdetailsResponse.fromJson(Map<String, dynamic> json) =>
      InvestmentdealsdetailsResponse(
        message:
            json["message"] == null ? null : Message.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message?.toJson(),
      };
}

class Message {
  bool? status;
  List<InvestmentDeal>? investmentDeals;

  Message({
    this.status,
    this.investmentDeals,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        status: json["status"],
        investmentDeals: json["investment_deals"] == null
            ? []
            : List<InvestmentDeal>.from(json["investment_deals"]!
                .map((x) => InvestmentDeal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "investment_deals": investmentDeals == null
            ? []
            : List<dynamic>.from(investmentDeals!.map((x) => x.toJson())),
      };
}

class InvestmentDeal {
  String? id;
  String? name;
  String? legalName;
  int? foundedYear;
  String? website;
  String? companyLogo;
  String? description;
  String? linkedin;
  String? youtube;
  String? facebook;
  String? instagram;
  String? document1;
  String? document2;
  String? document3;
  List<InvestmentDetail>? investmentDetails;

  InvestmentDeal({
    this.id,
    this.name,
    this.legalName,
    this.foundedYear,
    this.website,
    this.companyLogo,
    this.description,
    this.linkedin,
    this.youtube,
    this.facebook,
    this.instagram,
    this.document1,
    this.document2,
    this.document3,
    this.investmentDetails,
  });

  factory InvestmentDeal.fromJson(Map<String, dynamic> json) => InvestmentDeal(
        id: json["id"],
        name: json["name"],
        legalName: json["Legal Name"],
        foundedYear: json["Founded Year"],
        website: json["Website"],
        companyLogo: json["Company Logo"],
        description: json["description"],
        linkedin: json["linkedin"],
        youtube: json["youtube"],
        facebook: json["facebook"],
        instagram: json["instagram"],
        document1: json["document_1"],
        document2: json["document_2"],
        document3: json["document_3"],
        investmentDetails: json["investment_details"] == null
            ? []
            : List<InvestmentDetail>.from(json["investment_details"]!
                .map((x) => InvestmentDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "Legal Name": legalName,
        "Founded Year": foundedYear,
        "Website": website,
        "Company Logo": companyLogo,
        "description": description,
        "linkedin": linkedin,
        "youtube": youtube,
        "facebook": facebook,
        "instagram": instagram,
        "document_1": document1,
        "document_2": document2,
        "document_3": document3,
        "investment_details": investmentDetails == null
            ? []
            : List<dynamic>.from(investmentDetails!.map((x) => x.toJson())),
      };
}

class InvestmentDetail {
  String? investorName;
  String? designation;
  String? linkedin;

  InvestmentDetail({
    this.investorName,
    this.designation,
    this.linkedin,
  });

  factory InvestmentDetail.fromJson(Map<String, dynamic> json) =>
      InvestmentDetail(
        investorName: json["investor_name"],
        designation: json["designation"],
        linkedin: json["linkedin"],
      );

  Map<String, dynamic> toJson() => {
        "investor_name": investorName,
        "designation": designation,
        "linkedin": linkedin,
      };
}
