// To parse this JSON data, do
//
//     final mastersResponse = mastersResponseFromJson(jsonString);

import 'dart:convert';

MastersResponse mastersResponseFromJson(String str) =>
    MastersResponse.fromJson(json.decode(str));

String mastersResponseToJson(MastersResponse data) =>
    json.encode(data.toJson());

class MastersResponse {
  Message? message;

  MastersResponse({
    this.message,
  });

  factory MastersResponse.fromJson(Map<String, dynamic> json) =>
      MastersResponse(
        message:
            json["message"] == null ? null : Message.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message?.toJson(),
      };
}

class Message {
  bool? status;
  MastersData? mastersData;

  Message({
    this.status,
    this.mastersData,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        status: json["status"],
        mastersData: json["masters_data"] == null
            ? null
            : MastersData.fromJson(json["masters_data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "masters_data": mastersData?.toJson(),
      };
}

class MastersData {
  List<UserType>? userType;
  List<RoundTypeMaster>? roundTypeMasters;
  List<TagNameMaster>? tagNameMasters;
  List<InvestedRoundMaster>? investedRoundMasters;
  List<Country>? countries;
  List<FundingStage>? fundingStages;

  MastersData({
    this.userType,
    this.roundTypeMasters,
    this.tagNameMasters,
    this.investedRoundMasters,
    this.countries,
    this.fundingStages,
  });

  factory MastersData.fromJson(Map<String, dynamic> json) => MastersData(
        userType: json["user_type"] == null
            ? []
            : List<UserType>.from(
                json["user_type"]!.map((x) => UserType.fromJson(x))),
        roundTypeMasters: json["round_type_masters"] == null
            ? []
            : List<RoundTypeMaster>.from(json["round_type_masters"]!
                .map((x) => RoundTypeMaster.fromJson(x))),
        tagNameMasters: json["tag_name_masters"] == null
            ? []
            : List<TagNameMaster>.from(json["tag_name_masters"]!
                .map((x) => TagNameMaster.fromJson(x))),
        investedRoundMasters: json["invested_round_masters"] == null
            ? []
            : List<InvestedRoundMaster>.from(json["invested_round_masters"]!
                .map((x) => InvestedRoundMaster.fromJson(x))),
        countries: json["countries"] == null
            ? []
            : List<Country>.from(
                json["countries"]!.map((x) => Country.fromJson(x))),
        fundingStages: json["funding_stages"] == null
            ? []
            : List<FundingStage>.from(
                json["funding_stages"]!.map((x) => FundingStage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "user_type": userType == null
            ? []
            : List<dynamic>.from(userType!.map((x) => x.toJson())),
        "round_type_masters": roundTypeMasters == null
            ? []
            : List<dynamic>.from(roundTypeMasters!.map((x) => x.toJson())),
        "tag_name_masters": tagNameMasters == null
            ? []
            : List<dynamic>.from(tagNameMasters!.map((x) => x.toJson())),
        "invested_round_masters": investedRoundMasters == null
            ? []
            : List<dynamic>.from(investedRoundMasters!.map((x) => x.toJson())),
        "countries": countries == null
            ? []
            : List<dynamic>.from(countries!.map((x) => x.toJson())),
        "funding_stages": fundingStages == null
            ? []
            : List<dynamic>.from(fundingStages!.map((x) => x.toJson())),
      };
}

class Country {
  String? countryName;

  Country({
    this.countryName,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        countryName: json["country_name"],
      );

  Map<String, dynamic> toJson() => {
        "country_name": countryName,
      };
}

class FundingStage {
  String? fundingStageName;

  FundingStage({
    this.fundingStageName,
  });

  factory FundingStage.fromJson(Map<String, dynamic> json) => FundingStage(
        fundingStageName: json["funding_stage_name"],
      );

  Map<String, dynamic> toJson() => {
        "funding_stage_name": fundingStageName,
      };
}

class InvestedRoundMaster {
  String? investedRound;

  InvestedRoundMaster({
    this.investedRound,
  });

  factory InvestedRoundMaster.fromJson(Map<String, dynamic> json) =>
      InvestedRoundMaster(
        investedRound: json["invested_round"],
      );

  Map<String, dynamic> toJson() => {
        "invested_round": investedRound,
      };
}

class RoundTypeMaster {
  String? roundType;
  String? description;

  RoundTypeMaster({
    this.roundType,
    this.description,
  });

  factory RoundTypeMaster.fromJson(Map<String, dynamic> json) =>
      RoundTypeMaster(
        roundType: json["round_type"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "round_type": roundType,
        "description": description,
      };
}

class TagNameMaster {
  String? tagName;

  TagNameMaster({
    this.tagName,
  });

  factory TagNameMaster.fromJson(Map<String, dynamic> json) => TagNameMaster(
        tagName: json["tag_name"],
      );

  Map<String, dynamic> toJson() => {
        "tag_name": tagName,
      };
}

class UserType {
  String? userTypeName;

  UserType({
    this.userTypeName,
  });

  factory UserType.fromJson(Map<String, dynamic> json) => UserType(
        userTypeName: json["user_type_name"],
      );

  Map<String, dynamic> toJson() => {
        "user_type_name": userTypeName,
      };
}
