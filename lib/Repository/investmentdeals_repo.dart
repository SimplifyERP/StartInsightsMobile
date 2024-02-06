import 'package:startinsights/Network/api_result_handler.dart';
import 'package:startinsights/Network/di.dart';
import 'package:startinsights/Network/endpoints.dart';
import 'package:startinsights/Network/my_dio.dart';

class InvestmentDealsRepo {
  Future<ApiResults> getInvestmentDeals(
    String userId,
  ) async {
    return await sl<MyDio>()
        .postData(endPoint: investmentdealsdetailsAPI, data: {});
  }
}
