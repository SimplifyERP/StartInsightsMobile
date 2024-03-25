import 'package:startinsights/Network/api_result_handler.dart';
import 'package:startinsights/Network/di.dart';
import 'package:startinsights/Network/endpoints.dart';
import 'package:startinsights/Network/my_dio.dart';

class CoursesDetailsRepository {
  Future<ApiResults> getCoursesDetails(
    String CoursesId,
    String userId,
  ) async {
    return await sl<MyDio>().postData(
        endPoint: CourseDetailsAPI,
        data: {'course_id': CoursesId, 'user_id': userId});
  }

  Future<ApiResults> getCoursesVideoProgress(
    String mLessonid,
    String userId,
  ) async {
    return await sl<MyDio>().postData(endPoint: lmsprogresAPI, data: {
      'lesson_id': mLessonid,
      'status': 'Complete',
      'user_id': userId
    });
  }

  Future<ApiResults> getLmsCertificate(
    String course,
    String userId,
  ) async {
    return await sl<MyDio>().postData(
        endPoint: lmscertificateAPI,
        data: {'course': course, 'member': userId});
  }
}
