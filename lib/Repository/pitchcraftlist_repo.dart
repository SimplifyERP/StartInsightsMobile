import 'package:startinsights/Network/api_result_handler.dart';
import 'package:startinsights/Network/di.dart';
import 'package:startinsights/Network/endpoints.dart';
import 'package:startinsights/Network/my_dio.dart';

class PitchcraftListRepo {
  Future<ApiResults> getPitchcraftList(
    String userId,
  ) async {
    return await sl<MyDio>().postData(endPoint: pitchcraftlistAPI, data: {});
  }

  Future<ApiResults> getPitchcraftservicedetails(
    String userId,
    String name,
  ) async {
    return await sl<MyDio>()
        .postData(endPoint: pitchcraftservicedetailsAPI, data: {
      'name': name,
    });
  }
}
