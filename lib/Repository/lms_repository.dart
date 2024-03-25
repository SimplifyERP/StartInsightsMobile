import 'package:startinsights/Network/api_result_handler.dart';
import 'package:startinsights/Network/di.dart';
import 'package:startinsights/Network/endpoints.dart';
import 'package:startinsights/Network/my_dio.dart';

class LMSRepository {
  Future<ApiResults> getLearnList(
    String userId,
  ) async {
    return await sl<MyDio>()
        .postData(endPoint: LearnListAPI, data: {'user_id': userId});
  }

  Future<ApiResults> RemoveFavList(
      String userId, String courseId, int status) async {
    return await sl<MyDio>().postData(
        endPoint: RemoveFavouritecourseAPI,
        data: {'user_id': userId, 'status': status, 'course_id': courseId});
  }

  Future<ApiResults> AddFavList(String userId, String courseId) async {
    return await sl<MyDio>().postData(
        endPoint: AddFavouritecourseAPI,
        data: {'user_id': userId, 'course_id': courseId});
  }

  Future<ApiResults> SaveCourses(
    String courseId,
    String status,
  ) async {
    return await sl<MyDio>().postData(
        endPoint: savedcoursesAPI,
        data: {'course_id': courseId, "status": status});
  }

  Future<ApiResults> getLearnFavList(
    String userId,
  ) async {
    return await sl<MyDio>().postData(endPoint: FavouritecourseListAPI, data: {
      'user_id': userId,
      'status': 1,
    });
  }

  Future<ApiResults> getCoursesDetails(
    String userId,
    String courseId,
  ) async {
    return await sl<MyDio>().postData(endPoint: CourseDetailsAPI, data: {
      'user_id': userId,
      'course_id': courseId,
    });
  }

  Future<ApiResults> getEventList(
    String userId,
  ) async {
    return await sl<MyDio>()
        .postData(endPoint: EventListAPI, data: {'user_id': userId});
  }

  Future<ApiResults> AddEventRegister(
    String userId,
    String eventId,
  ) async {
    return await sl<MyDio>().postData(
        endPoint: mAddEventRegister,
        data: {'user_id': userId, 'event_id': userId});
  }
}
