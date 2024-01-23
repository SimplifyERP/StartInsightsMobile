//

import 'package:startinsights/Model/CoursesDetailsResponse.dart';

abstract class MyCoursesStatus {}

class MyCoursesInitialState extends MyCoursesStatus {}

class MyCoursesLoadingState extends MyCoursesStatus {}

class MyCoursesNointernetState extends MyCoursesStatus {}

class GetMyCoursesInfoFailState extends MyCoursesStatus {
  //final String mMessage;
  GetMyCoursesInfoFailState();
}

class GetMyCoursesInfoSuccessState extends MyCoursesStatus {
  final List<Course> mCoursesDetails;
  GetMyCoursesInfoSuccessState(this.mCoursesDetails);
}
