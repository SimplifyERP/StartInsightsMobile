import 'dart:convert';

import 'package:startinsights/Network/api_result_handler.dart';
import 'package:startinsights/Network/di.dart';
import 'package:startinsights/Network/endpoints.dart';
import 'package:startinsights/Network/my_dio.dart';

// 'amount': amount
// 'country': country,
class SearchinvestorsRepo {
  Future<ApiResults> getSearchinvestors(
    String userId,
    int PageNo,
    String country,
    List<String> mStages,
    String amount,
  ) async {
    return await sl<MyDio>().postData(endPoint: searchinvestorslistAPI, data: {
      'user_id': userId,
      'page_no': PageNo,
      'funding_stage': jsonEncode(mStages)
    });
  }

  Future<ApiResults> getFundingCrm(
    String userId,
  ) async {
    return await sl<MyDio>()
        .postData(endPoint: FundingCRMAPI, data: {'user_id': userId});
  }

  Future<ApiResults> getFavList(
    String userId,
    int PageNo,
  ) async {
    return await sl<MyDio>().postData(
        endPoint: FavouriteAPI,
        data: {'user_id': userId, 'status': 1, 'page_no': PageNo});
  }

  Future<ApiResults> RemoveFavList(
      String userId, String investorid, int status) async {
    return await sl<MyDio>().postData(
        endPoint: RemoveFavouriteAPI,
        data: {'user_id': userId, 'status': status, 'investor_id': investorid});
  }

  Future<ApiResults> AddFavList(String userId, String investorid) async {
    return await sl<MyDio>().postData(
        endPoint: AddFavouriteAPI,
        data: {'user_id': userId, 'investor_id': investorid});
  }

  Future<ApiResults> UpdateFundingCRM(String userId, String investorstatus,
      String investorid, String typeofinvestor) async {
    return await sl<MyDio>().postData(endPoint: UpdatefundingcrmAPI, data: {
      'user_id': userId,
      'investor_status': investorstatus,
      'investor_id': investorid,
      'type_of_investor': typeofinvestor
    });
  }

  Future<ApiResults> AddNewInvestor(
    String userId,
    String investorname,
    String investorstatus,
    String contactedperson,
    String fundingstage,
    String description,
    String website,
    String investoremail,
    String contactno,
    String notes,
    String logotype,
    String logoname,
    String logo,
  ) async {
    return await sl<MyDio>().postData(endPoint: mCreateinvestor, data: {
      'user_id': userId,
      'investor_name': investorname,
      'investor_status': investorstatus,
      'contacted_person': contactedperson,
      'funding_stage': fundingstage,
      'description': description,
      'website': website,
      'investor_email': investoremail,
      'contact_no': contactno,
      'notes': notes,
      'logo_type': logotype,
      'logo_name': logoname,
      'logo': logo,
    });
  }
}
