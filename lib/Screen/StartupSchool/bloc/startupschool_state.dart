//

import 'package:startinsights/Model/CoursesListResponse.dart';

abstract class StartupSchoolStatus {}

class StartupSchoolInitialState extends StartupSchoolStatus {}

class StartupSchoolLoadingState extends StartupSchoolStatus {}

class StartupSchoolNointernetState extends StartupSchoolStatus {}

class GetStartupSchoolInfoFailState extends StartupSchoolStatus {
  //final String mMessage;
  GetStartupSchoolInfoFailState();
}

class GetStartupSchoolInfoSuccessState extends StartupSchoolStatus {
  final Message mCoursesList;
  GetStartupSchoolInfoSuccessState(this.mCoursesList);
}
