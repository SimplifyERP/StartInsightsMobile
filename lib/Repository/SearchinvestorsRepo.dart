import 'package:startinsights/Network/api_result_handler.dart';
import 'package:startinsights/Network/di.dart';
import 'package:startinsights/Network/endpoints.dart';
import 'package:startinsights/Network/my_dio.dart';

class SearchinvestorsRepo {
  Future<ApiResults> getSearchinvestors(
    String userId,
    int PageNo,
    String country,
    String fundingstage,
    String amount,
  ) async {
    return await sl<MyDio>().postData(endPoint: searchinvestorslistAPI, data: {
      'page_no': PageNo,
      'country': country,
      'funding_stage': fundingstage,
      'amount': amount
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
}
