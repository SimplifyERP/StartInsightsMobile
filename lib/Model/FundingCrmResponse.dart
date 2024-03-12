// To parse this JSON data, do
//
//     final fundingCrmResponse = fundingCrmResponseFromJson(jsonString);

import 'dart:convert';

FundingCrmResponse fundingCrmResponseFromJson(String str) =>
    FundingCrmResponse.fromJson(json.decode(str));

String fundingCrmResponseToJson(FundingCrmResponse data) =>
    json.encode(data.toJson());

class FundingCrmResponse {
  Message? message;

  FundingCrmResponse({
    this.message,
  });

  factory FundingCrmResponse.fromJson(Map<String, dynamic> json) =>
      FundingCrmResponse(
        message:
            json["message"] == null ? null : Message.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message?.toJson(),
      };
}

class Message {
  bool? status;
  int? fundingMaxCount;
  List<FundingCrmList>? fundingCrmList;

  Message({
    this.status,
    this.fundingMaxCount,
    this.fundingCrmList,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        status: json["status"],
        fundingMaxCount: json["funding_max_count"],
        fundingCrmList: json["funding_crm_list"] == null
            ? []
            : List<FundingCrmList>.from(json["funding_crm_list"]!
                .map((x) => FundingCrmList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "funding_max_count": fundingMaxCount,
        "funding_crm_list": fundingCrmList == null
            ? []
            : List<dynamic>.from(fundingCrmList!.map((x) => x.toJson())),
      };
}

class FundingCrmList {
  Sortlist? sortlist;
  Contacted? contacted;
  Pitched? pitched;
  Diligence? diligence;
  Won? won;
  Lost? lost;

  FundingCrmList({
    this.sortlist,
    this.contacted,
    this.pitched,
    this.diligence,
    this.won,
    this.lost,
  });

  factory FundingCrmList.fromJson(Map<String, dynamic> json) => FundingCrmList(
        sortlist: json["sortlist"] == null
            ? null
            : Sortlist.fromJson(json["sortlist"]),
        contacted: json["contacted"] == null
            ? null
            : Contacted.fromJson(json["contacted"]),
        pitched:
            json["pitched"] == null ? null : Pitched.fromJson(json["pitched"]),
        diligence: json["diligence"] == null
            ? null
            : Diligence.fromJson(json["diligence"]),
        won: json["won"] == null ? null : Won.fromJson(json["won"]),
        lost: json["lost"] == null ? null : Lost.fromJson(json["lost"]),
      );

  Map<String, dynamic> toJson() => {
        "sortlist": sortlist?.toJson(),
        "contacted": contacted?.toJson(),
        "pitched": pitched?.toJson(),
        "diligence": diligence?.toJson(),
        "won": won?.toJson(),
        "lost": lost?.toJson(),
      };
}

class Investor {
  String? id;
  String? name;
  String? typeOfInvestor;
  String? logo;
  String? status;
  String? contactedPerson;
  List<FundingStage>? fundingStage;
  String? description;
  String? website;
  String? mailAddress;
  String? contactNo;

  Investor({
    this.id,
    this.name,
    this.typeOfInvestor,
    this.logo,
    this.status,
    this.contactedPerson,
    this.fundingStage,
    this.description,
    this.website,
    this.mailAddress,
    this.contactNo,
  });

  factory Investor.fromJson(Map<String, dynamic> json) => Investor(
        id: json["id"],
        name: json["name"],
        typeOfInvestor: json["type_of_investor"],
        logo: json["logo"],
        status: json["status"],
        contactedPerson: json["contacted_person"],
        fundingStage: json["funding_stage"] == null
            ? []
            : List<FundingStage>.from(
                json["funding_stage"]!.map((x) => FundingStage.fromJson(x))),
        description: json["description"],
        website: json["website"],
        mailAddress: json["mail_address"],
        contactNo: json["contact_no"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type_of_investor": typeOfInvestor,
        "logo": logo,
        "status": status,
        "contacted_person": contactedPerson,
        "funding_stage": fundingStage == null
            ? []
            : List<dynamic>.from(fundingStage!.map((x) => x.toJson())),
        "description": description,
        "website": website,
        "mail_address": mailAddress,
        "contact_no": contactNo,
      };
}

class FundingStage {
  String? fundingStages;

  FundingStage({
    this.fundingStages,
  });

  factory FundingStage.fromJson(Map<String, dynamic> json) => FundingStage(
        fundingStages: json["funding_stages"],
      );

  Map<String, dynamic> toJson() => {
        "funding_stages": fundingStages,
      };
}

enum FundingStages { EARLY_REVENUE, PROTOTYPE }

final fundingStagesValues = EnumValues({
  "Early Revenue": FundingStages.EARLY_REVENUE,
  "Prototype": FundingStages.PROTOTYPE
});

enum MailAddress { EMPTY, JAGADEESAN_A1104_GMAIL_COM }

final mailAddressValues = EnumValues({
  "": MailAddress.EMPTY,
  "jagadeesan.a1104@gmail.com": MailAddress.JAGADEESAN_A1104_GMAIL_COM
});

enum Status { SORTLIST }

final statusValues = EnumValues({"SORTLIST": Status.SORTLIST});

enum Website { APP_STARTINSIGHTSAI, EMPTY }

final websiteValues = EnumValues(
    {"app.startinsightsai": Website.APP_STARTINSIGHTSAI, "": Website.EMPTY});

class Contacted {
  List<Investor>? searchInvestor;
  List<Investor>? userCreatedInvestor;
  int? contactedCount;

  Contacted({
    this.searchInvestor,
    this.userCreatedInvestor,
    this.contactedCount,
  });

  factory Contacted.fromJson(Map<String, dynamic> json) => Contacted(
        searchInvestor: json["search_investor"] == null
            ? []
            : List<Investor>.from(
                json["search_investor"]!.map((x) => Investor.fromJson(x))),
        userCreatedInvestor: json["user_created_investor"] == null
            ? []
            : List<Investor>.from(json["user_created_investor"]!
                .map((x) => Investor.fromJson(x))),
        contactedCount: json["contacted_count"],
      );

  Map<String, dynamic> toJson() => {
        "search_investor": searchInvestor == null
            ? []
            : List<dynamic>.from(searchInvestor!.map((x) => x.toJson())),
        "user_created_investor": userCreatedInvestor == null
            ? []
            : List<dynamic>.from(userCreatedInvestor!.map((x) => x.toJson())),
        "contacted_count": contactedCount,
      };
}

class Diligence {
  List<Investor>? searchInvestor;
  List<Investor>? userCreatedInvestor;
  int? diligenceCount;

  Diligence({
    this.searchInvestor,
    this.userCreatedInvestor,
    this.diligenceCount,
  });

  factory Diligence.fromJson(Map<String, dynamic> json) => Diligence(
        searchInvestor: json["search_investor"] == null
            ? []
            : List<Investor>.from(
                json["search_investor"]!.map((x) => Investor.fromJson(x))),
        userCreatedInvestor: json["user_created_investor"] == null
            ? []
            : List<Investor>.from(json["user_created_investor"]!
                .map((x) => Investor.fromJson(x))),
        diligenceCount: json["diligence_count"],
      );

  Map<String, dynamic> toJson() => {
        "search_investor": searchInvestor == null
            ? []
            : List<dynamic>.from(searchInvestor!.map((x) => x.toJson())),
        "user_created_investor": userCreatedInvestor == null
            ? []
            : List<dynamic>.from(userCreatedInvestor!.map((x) => x.toJson())),
        "diligence_count": diligenceCount,
      };
}

class Lost {
  List<Investor>? searchInvestor;
  List<Investor>? userCreatedInvestor;
  int? lostCount;

  Lost({
    this.searchInvestor,
    this.userCreatedInvestor,
    this.lostCount,
  });

  factory Lost.fromJson(Map<String, dynamic> json) => Lost(
        searchInvestor: json["search_investor"] == null
            ? []
            : List<Investor>.from(
                json["search_investor"]!.map((x) => Investor.fromJson(x))),
        userCreatedInvestor: json["user_created_investor"] == null
            ? []
            : List<Investor>.from(json["user_created_investor"]!
                .map((x) => Investor.fromJson(x))),
        lostCount: json["lost_count"],
      );

  Map<String, dynamic> toJson() => {
        "search_investor": searchInvestor == null
            ? []
            : List<dynamic>.from(searchInvestor!.map((x) => x.toJson())),
        "user_created_investor": userCreatedInvestor == null
            ? []
            : List<dynamic>.from(userCreatedInvestor!.map((x) => x.toJson())),
        "lost_count": lostCount,
      };
}

class Pitched {
  List<Investor>? searchInvestor;
  List<Investor>? userCreatedInvestor;
  int? pitchedCount;

  Pitched({
    this.searchInvestor,
    this.userCreatedInvestor,
    this.pitchedCount,
  });

  factory Pitched.fromJson(Map<String, dynamic> json) => Pitched(
        searchInvestor: json["search_investor"] == null
            ? []
            : List<Investor>.from(
                json["search_investor"]!.map((x) => Investor.fromJson(x))),
        userCreatedInvestor: json["user_created_investor"] == null
            ? []
            : List<Investor>.from(json["user_created_investor"]!
                .map((x) => Investor.fromJson(x))),
        pitchedCount: json["pitched_count"],
      );

  Map<String, dynamic> toJson() => {
        "search_investor": searchInvestor == null
            ? []
            : List<dynamic>.from(searchInvestor!.map((x) => x.toJson())),
        "user_created_investor": userCreatedInvestor == null
            ? []
            : List<dynamic>.from(userCreatedInvestor!.map((x) => x.toJson())),
        "pitched_count": pitchedCount,
      };
}

class Sortlist {
  List<Investor>? searchInvestor;
  List<Investor>? userCreatedInvestor;
  int? sortlistCount;

  Sortlist({
    this.searchInvestor,
    this.userCreatedInvestor,
    this.sortlistCount,
  });

  factory Sortlist.fromJson(Map<String, dynamic> json) => Sortlist(
        searchInvestor: json["search_investor"] == null
            ? []
            : List<Investor>.from(
                json["search_investor"]!.map((x) => Investor.fromJson(x))),
        userCreatedInvestor: json["user_created_investor"] == null
            ? []
            : List<Investor>.from(json["user_created_investor"]!
                .map((x) => Investor.fromJson(x))),
        sortlistCount: json["sortlist_count"],
      );

  Map<String, dynamic> toJson() => {
        "search_investor": searchInvestor == null
            ? []
            : List<dynamic>.from(searchInvestor!.map((x) => x.toJson())),
        "user_created_investor": userCreatedInvestor == null
            ? []
            : List<dynamic>.from(userCreatedInvestor!.map((x) => x.toJson())),
        "sortlist_count": sortlistCount,
      };
}

class Won {
  List<Investor>? searchInvestor;
  List<Investor>? userCreatedInvestor;
  int? wonCount;

  Won({
    this.searchInvestor,
    this.userCreatedInvestor,
    this.wonCount,
  });

  factory Won.fromJson(Map<String, dynamic> json) => Won(
        searchInvestor: json["search_investor"] == null
            ? []
            : List<Investor>.from(
                json["search_investor"]!.map((x) => Investor.fromJson(x))),
        userCreatedInvestor: json["user_created_investor"] == null
            ? []
            : List<Investor>.from(json["user_created_investor"]!
                .map((x) => Investor.fromJson(x))),
        wonCount: json["won_count"],
      );

  Map<String, dynamic> toJson() => {
        "search_investor": searchInvestor == null
            ? []
            : List<dynamic>.from(searchInvestor!.map((x) => x.toJson())),
        "user_created_investor": userCreatedInvestor == null
            ? []
            : List<dynamic>.from(userCreatedInvestor!.map((x) => x.toJson())),
        "won_count": wonCount,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
