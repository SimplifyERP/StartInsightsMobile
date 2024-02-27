import 'package:startinsights/Network/api_result_handler.dart';
import 'package:startinsights/Network/di.dart';
import 'package:startinsights/Network/endpoints.dart';
import 'package:startinsights/Network/my_dio.dart';

class CoursesListRepository {
  Future<ApiResults> getCoursesList(
    String userId,
  ) async {
    return await sl<MyDio>()
        .postData(endPoint: courseslistAPI, data: {'user_id': userId});
  }

  Future<ApiResults> SaveCourses(
    String courseId,
    String status,
  ) async {
    return await sl<MyDio>().postData(
        endPoint: savedcoursesAPI,
        data: {'course_id': courseId, "status": status});
  }
}
