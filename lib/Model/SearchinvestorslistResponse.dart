// To parse this JSON data, do
//
//     final searchinvestorslistResponse = searchinvestorslistResponseFromJson(jsonString);

import 'dart:convert';

SearchinvestorslistResponse searchinvestorslistResponseFromJson(String str) =>
    SearchinvestorslistResponse.fromJson(json.decode(str));

String searchinvestorslistResponseToJson(SearchinvestorslistResponse data) =>
    json.encode(data.toJson());

class SearchinvestorslistResponse {
  Message? message;

  SearchinvestorslistResponse({
    this.message,
  });

  factory SearchinvestorslistResponse.fromJson(Map<String, dynamic> json) =>
      SearchinvestorslistResponse(
        message:
            json["message"] == null ? null : Message.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message?.toJson(),
      };
}

class Message {
  bool? status;
  List<SearchInvestorsList>? searchInvestorsList;

  Message({
    this.status,
    this.searchInvestorsList,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        status: json["status"],
        searchInvestorsList: json["search_investors_list"] == null
            ? []
            : List<SearchInvestorsList>.from(json["search_investors_list"]!
                .map((x) => SearchInvestorsList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "search_investors_list": searchInvestorsList == null
            ? []
            : List<dynamic>.from(searchInvestorsList!.map((x) => x.toJson())),
      };
}

class SearchInvestorsList {
  String? title;
  String? logo;
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

  SearchInvestorsList({
    this.title,
    this.logo,
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

  factory SearchInvestorsList.fromJson(Map<String, dynamic> json) =>
      SearchInvestorsList(
        title: json["title"],
        logo: json["logo"],
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
        "title": title,
        "logo": logo,
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
