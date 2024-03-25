//

import 'package:startinsights/Model/CourseDetailsResponse.dart';

abstract class MyCoursesStatus {}

class MyCoursesInitialState extends MyCoursesStatus {}

class MyCoursesLoadingState extends MyCoursesStatus {}

class MyCoursesNointernetState extends MyCoursesStatus {}

class GetMyCoursesInfoFailState extends MyCoursesStatus {
  //final String mMessage;
  GetMyCoursesInfoFailState();
}

class GetMyCoursesInfoSuccessState extends MyCoursesStatus {
  final List<CourseDetail> mCoursesDetails;
  GetMyCoursesInfoSuccessState(this.mCoursesDetails);
}
