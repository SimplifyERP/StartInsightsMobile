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
  List<InvestorWise>? investorWise;
  List<RoundWise>? roundWise;
  List<WiseGraph>? investorWiseGraph;
  List<WiseGraph>? roundWiseGraph;

  Message({
    this.status,
    this.investorWise,
    this.roundWise,
    this.investorWiseGraph,
    this.roundWiseGraph,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        status: json["status"],
        investorWise: json["investor_wise"] == null
            ? []
            : List<InvestorWise>.from(
                json["investor_wise"]!.map((x) => InvestorWise.fromJson(x))),
        roundWise: json["round_wise"] == null
            ? []
            : List<RoundWise>.from(
                json["round_wise"]!.map((x) => RoundWise.fromJson(x))),
        investorWiseGraph: json["investor_wise_graph"] == null
            ? []
            : List<WiseGraph>.from(
                json["investor_wise_graph"]!.map((x) => WiseGraph.fromJson(x))),
        roundWiseGraph: json["round_wise_graph"] == null
            ? []
            : List<WiseGraph>.from(
                json["round_wise_graph"]!.map((x) => WiseGraph.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "investor_wise": investorWise == null
            ? []
            : List<dynamic>.from(investorWise!.map((x) => x.toJson())),
        "round_wise": roundWise == null
            ? []
            : List<dynamic>.from(roundWise!.map((x) => x.toJson())),
        "investor_wise_graph": investorWiseGraph == null
            ? []
            : List<dynamic>.from(investorWiseGraph!.map((x) => x.toJson())),
        "round_wise_graph": roundWiseGraph == null
            ? []
            : List<dynamic>.from(roundWiseGraph!.map((x) => x.toJson())),
      };
}

class InvestorWise {
  String? investorName;
  String? tagName;
  String? dateOfAllotment;
  String? roundName;
  int? amountInvested;
  String? distinctiveShareNo;
  String? shareCertificate;
  String? sharesAllotted;
  int? pricePerShare;
  String? fullyDilutedShares;
  String? classOfShares;
  String? folioNumber;
  String? shareholding;

  InvestorWise({
    this.investorName,
    this.tagName,
    this.dateOfAllotment,
    this.roundName,
    this.amountInvested,
    this.distinctiveShareNo,
    this.shareCertificate,
    this.sharesAllotted,
    this.pricePerShare,
    this.fullyDilutedShares,
    this.classOfShares,
    this.folioNumber,
    this.shareholding,
  });

  factory InvestorWise.fromJson(Map<String, dynamic> json) => InvestorWise(
        investorName: json["investor_name"],
        tagName: json["tag_name"],
        dateOfAllotment: json["date_of_allotment"],
        roundName: json["round_name"],
        amountInvested: json["amount_invested"],
        distinctiveShareNo: json["distinctive_share_no"],
        shareCertificate: json["share_certificate"],
        sharesAllotted: json["shares_allotted"],
        pricePerShare: json["price_per_share"],
        fullyDilutedShares: json["fully_diluted_shares"],
        classOfShares: json["class_of_shares"],
        folioNumber: json["folio_number"],
        shareholding: json["shareholding"],
      );

  Map<String, dynamic> toJson() => {
        "investor_name": investorName,
        "tag_name": tagName,
        "date_of_allotment": dateOfAllotment,
        "round_name": roundName,
        "amount_invested": amountInvested,
        "distinctive_share_no": distinctiveShareNo,
        "share_certificate": shareCertificate,
        "shares_allotted": sharesAllotted,
        "price_per_share": pricePerShare,
        "fully_diluted_shares": fullyDilutedShares,
        "class_of_shares": classOfShares,
        "folio_number": folioNumber,
        "shareholding": shareholding,
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

class RoundWise {
  String? roundName;
  String? roundType;
  DateTime? roundClosingDate;
  String? description;
  String? selectSecurityPrefix;
  int? amountRaised;
  int? pricePerShare;
  int? preMoneyValuation;
  String? dilutionForThisRound;

  RoundWise({
    this.roundName,
    this.roundType,
    this.roundClosingDate,
    this.description,
    this.selectSecurityPrefix,
    this.amountRaised,
    this.pricePerShare,
    this.preMoneyValuation,
    this.dilutionForThisRound,
  });

  factory RoundWise.fromJson(Map<String, dynamic> json) => RoundWise(
        roundName: json["round_name"],
        roundType: json["round_type"],
        roundClosingDate: json["round_closing_date"] == null
            ? null
            : DateTime.parse(json["round_closing_date"]),
        description: json["description"],
        selectSecurityPrefix: json["select_security_prefix"],
        amountRaised: json["amount_raised"],
        pricePerShare: json["price_per_share"],
        preMoneyValuation: json["pre_money_valuation"],
        dilutionForThisRound: json["dilution_for_this_round_"],
      );

  Map<String, dynamic> toJson() => {
        "round_name": roundName,
        "round_type": roundType,
        "round_closing_date":
            "${roundClosingDate!.year.toString().padLeft(4, '0')}-${roundClosingDate!.month.toString().padLeft(2, '0')}-${roundClosingDate!.day.toString().padLeft(2, '0')}",
        "description": description,
        "select_security_prefix": selectSecurityPrefix,
        "amount_raised": amountRaised,
        "price_per_share": pricePerShare,
        "pre_money_valuation": preMoneyValuation,
        "dilution_for_this_round_": dilutionForThisRound,
      };
}
