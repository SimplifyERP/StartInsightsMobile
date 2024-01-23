import 'package:startinsights/Network/api_result_handler.dart';
import 'package:startinsights/Network/di.dart';
import 'package:startinsights/Network/endpoints.dart';
import 'package:startinsights/Network/my_dio.dart';

class MasterRepository {
  Future<ApiResults> getMasterData(
    String userId,
  ) async {
    return await sl<MyDio>().postData(endPoint: masterAPI, data: {});
  }
}
