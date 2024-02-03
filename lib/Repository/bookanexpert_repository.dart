import 'package:startinsights/Network/api_result_handler.dart';
import 'package:startinsights/Network/di.dart';
import 'package:startinsights/Network/endpoints.dart';
import 'package:startinsights/Network/my_dio.dart';

class BookanexpertListRepository {
  Future<ApiResults> getBookanexpertList(
    String userId,
  ) async {
    return await sl<MyDio>().postData(endPoint: bookanexpertlistAPI, data: {});
  }

  Future<ApiResults> getexpertBooking(
    String expertId,
  ) async {
    return await sl<MyDio>()
        .postData(endPoint: expertbookingAPI, data: {'expert_id': expertId});
  }
}
