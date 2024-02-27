// To parse this JSON data, do
//
//     final investorroundwiseResponse = investorroundwiseResponseFromJson(jsonString);

import 'dart:convert';

InvestorroundwiseResponse investorroundwiseResponseFromJson(String str) =>
    InvestorroundwiseResponse.fromJson(json.decode(str));

String investorroundwiseResponseToJson(InvestorroundwiseResponse data) =>
    json.encode(data.toJson());

class InvestorroundwiseResponse {
  Message? message;

  InvestorroundwiseResponse({
    this.message,
  });

  factory InvestorroundwiseResponse.fromJson(Map<String, dynamic> json) =>
      InvestorroundwiseResponse(
        message:
            json["message"] == null ? null : Message.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message?.toJson(),
      };
}

class Message {
  bool? status;
  List<InvestorWiseList>? investorWiseList;
  List<WiseGraph>? investorWiseGraph;
  List<RoundWiseList>? roundWiseList;
  List<WiseGraph>? roundWiseGraph;

  Message({
    this.status,
    this.investorWiseList,
    this.investorWiseGraph,
    this.roundWiseList,
    this.roundWiseGraph,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        status: json["status"],
        investorWiseList: json["investor_wise_list"] == null
            ? []
            : List<InvestorWiseList>.from(json["investor_wise_list"]!
                .map((x) => InvestorWiseList.fromJson(x))),
        investorWiseGraph: json["investor_wise_graph"] == null
            ? []
            : List<WiseGraph>.from(
                json["investor_wise_graph"]!.map((x) => WiseGraph.fromJson(x))),
        roundWiseList: json["round_wise_list"] == null
            ? []
            : List<RoundWiseList>.from(
                json["round_wise_list"]!.map((x) => RoundWiseList.fromJson(x))),
        roundWiseGraph: json["round_wise_graph"] == null
            ? []
            : List<WiseGraph>.from(
                json["round_wise_graph"]!.map((x) => WiseGraph.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "investor_wise_list": investorWiseList == null
            ? []
            : List<dynamic>.from(investorWiseList!.map((x) => x.toJson())),
        "investor_wise_graph": investorWiseGraph == null
            ? []
            : List<dynamic>.from(investorWiseGraph!.map((x) => x.toJson())),
        "round_wise_list": roundWiseList == null
            ? []
            : List<dynamic>.from(roundWiseList!.map((x) => x.toJson())),
        "round_wise_graph": roundWiseGraph == null
            ? []
            : List<dynamic>.from(roundWiseGraph!.map((x) => x.toJson())),
      };
}

class WiseGraph {
  String? name;
  String? percentage;
  String? colorCode;

  WiseGraph({
    this.name,
    this.percentage,
    this.colorCode,
  });

  factory WiseGraph.fromJson(Map<String, dynamic> json) => WiseGraph(
        name: json["name"],
        percentage: json["percentage"],
        colorCode: json["color_code"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "percentage": percentage,
        "color_code": colorCode,
      };
}

class InvestorWiseList {
  String? investorName;
  String? tagName;
  DateTime? dateOfAllotment;
  String? investedRound;
  int? amountInvested;
  String? distinctiveShareNo;
  String? shareCertificate;
  String? sharesAllotted;
  int? pricePerShare;
  String? fullyDilutedShares;
  String? classOfShares;
  String? folioNumber;
  String? shareholding;
  String? creationPersonId;

  InvestorWiseList({
    this.investorName,
    this.tagName,
    this.dateOfAllotment,
    this.investedRound,
    this.amountInvested,
    this.distinctiveShareNo,
    this.shareCertificate,
    this.sharesAllotted,
    this.pricePerShare,
    this.fullyDilutedShares,
    this.classOfShares,
    this.folioNumber,
    this.shareholding,
    this.creationPersonId,
  });

  factory InvestorWiseList.fromJson(Map<String, dynamic> json) =>
      InvestorWiseList(
        investorName: json["investor_name"],
        tagName: json["tag_name"],
        dateOfAllotment: json["date_of_allotment"] == null
            ? null
            : DateTime.parse(json["date_of_allotment"]),
        investedRound: json["invested_round"],
        amountInvested: json["amount_invested"],
        distinctiveShareNo: json["distinctive_share_no"],
        shareCertificate: json["share_certificate"],
        sharesAllotted: json["shares_allotted"],
        pricePerShare: json["price_per_share"],
        fullyDilutedShares: json["fully_diluted_shares"],
        classOfShares: json["class_of_shares"],
        folioNumber: json["folio_number"],
        shareholding: json["shareholding"],
        creationPersonId: json["creation_person_id"],
      );

  Map<String, dynamic> toJson() => {
        "investor_name": investorName,
        "tag_name": tagName,
        "date_of_allotment":
            "${dateOfAllotment!.year.toString().padLeft(4, '0')}-${dateOfAllotment!.month.toString().padLeft(2, '0')}-${dateOfAllotment!.day.toString().padLeft(2, '0')}",
        "invested_round": investedRound,
        "amount_invested": amountInvested,
        "distinctive_share_no": distinctiveShareNo,
        "share_certificate": shareCertificate,
        "shares_allotted": sharesAllotted,
        "price_per_share": pricePerShare,
        "fully_diluted_shares": fullyDilutedShares,
        "class_of_shares": classOfShares,
        "folio_number": folioNumber,
        "shareholding": shareholding,
        "creation_person_id": creationPersonId,
      };
}

class RoundWiseList {
  String? nameOfTheRound;
  String? roundType;
  DateTime? closingDateOfTheRound;
  String? description;
  String? selectSecurityPrefix;
  int? amountRaised;
  int? pricePerShare;
  int? preMoneyValuation;
  String? dilutionForThisRound;
  String? creationPersonId;

  RoundWiseList({
    this.nameOfTheRound,
    this.roundType,
    this.closingDateOfTheRound,
    this.description,
    this.selectSecurityPrefix,
    this.amountRaised,
    this.pricePerShare,
    this.preMoneyValuation,
    this.dilutionForThisRound,
    this.creationPersonId,
  });

  factory RoundWiseList.fromJson(Map<String, dynamic> json) => RoundWiseList(
        nameOfTheRound: json["name_of_the_round"],
        roundType: json["round_type"],
        closingDateOfTheRound: json["closing_date_of_the_round"] == null
            ? null
            : DateTime.parse(json["closing_date_of_the_round"]),
        description: json["description"],
        selectSecurityPrefix: json["select_security_prefix"],
        amountRaised: json["amount_raised"],
        pricePerShare: json["price_per_share"],
        preMoneyValuation: json["pre_money_valuation"],
        dilutionForThisRound: json["dilution_for_this_round"],
        creationPersonId: json["creation_person_id"],
      );

  Map<String, dynamic> toJson() => {
        "name_of_the_round": nameOfTheRound,
        "round_type": roundType,
        "closing_date_of_the_round":
            "${closingDateOfTheRound!.year.toString().padLeft(4, '0')}-${closingDateOfTheRound!.month.toString().padLeft(2, '0')}-${closingDateOfTheRound!.day.toString().padLeft(2, '0')}",
        "description": description,
        "select_security_prefix": selectSecurityPrefix,
        "amount_raised": amountRaised,
        "price_per_share": pricePerShare,
        "pre_money_valuation": preMoneyValuation,
        "dilution_for_this_round": dilutionForThisRound,
        "creation_person_id": creationPersonId,
      };
}
