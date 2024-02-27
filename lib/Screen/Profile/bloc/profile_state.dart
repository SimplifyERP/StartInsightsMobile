//

import 'package:startinsights/Model/CoursesDetailsResponse.dart';

abstract class ProfileStatus {}

class ProfileInitialState extends ProfileStatus {}

class ProfileLoadingState extends ProfileStatus {}

class ProfileNointernetState extends ProfileStatus {}

class GetProfileInfoFailState extends ProfileStatus {
  //final String mMessage;
  GetProfileInfoFailState();
}

class GetProfileInfoSuccessState extends ProfileStatus {
  final List<Course> mCoursesDetails;
  GetProfileInfoSuccessState(this.mCoursesDetails);
}
