import 'package:startinsights/Network/api_result_handler.dart';
import 'package:startinsights/Network/di.dart';
import 'package:startinsights/Network/endpoints.dart';
import 'package:startinsights/Network/my_dio.dart';

class CaptableRepository {
  Future<ApiResults> getCaptableData(
    String userId,
  ) async {
    return await sl<MyDio>()
        .postData(endPoint: getinvestorroundwisegraphAPI, data: {
      'user_id': "jagadeesan.a1104@gmail.com",
    });
  }
}
