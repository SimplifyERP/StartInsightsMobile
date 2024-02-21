import 'package:startinsights/Network/api_result_handler.dart';
import 'package:startinsights/Network/di.dart';
import 'package:startinsights/Network/endpoints.dart';
import 'package:startinsights/Network/my_dio.dart';

class StartupDealsRepository {
  Future<ApiResults> getStartupDealsData(
    String userId,
  ) async {
    return await sl<MyDio>().postData(endPoint: getstartupdealAPI, data: {});
  }

  Future<ApiResults> getStartupDealsRedeem(
    String userId,
    String DealId,
  ) async {
    return await sl<MyDio>().postData(endPoint: getdealsredeemcodeAPI, data: {
      'name': DealId,
    });
  }
}
