import 'package:startinsights/Network/api_result_handler.dart';
import 'package:startinsights/Network/di.dart';
import 'package:startinsights/Network/endpoints.dart';
import 'package:startinsights/Network/my_dio.dart';

class CoursesDetailsRepository {
  Future<ApiResults> getCoursesDetails(
    String CoursesId,
  ) async {
    return await sl<MyDio>()
        .postData(endPoint: coursesdetailsAPI, data: {'course_id': CoursesId});
  }
}
