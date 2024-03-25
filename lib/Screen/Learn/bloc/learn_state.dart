//

import 'package:startinsights/Model/LearnlistResponse.dart';

abstract class LearnStatus {}

class LearnInitialState extends LearnStatus {}

class LearnLoadingState extends LearnStatus {}

class LearnNointernetState extends LearnStatus {}

class GetLearnInfoFailState extends LearnStatus {
  //final String mMessage;
  GetLearnInfoFailState();
}

class GetLearnInfoSuccessState extends LearnStatus {
  final List<CoursesList> mCoursesList;
  GetLearnInfoSuccessState(this.mCoursesList);
}
