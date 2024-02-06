//

import 'package:startinsights/Model/PitchcraftlistResponse.dart';

abstract class PitchcraftlistStatus {}

class PitchcraftlistInitialState extends PitchcraftlistStatus {}

class PitchcraftlistLoadingState extends PitchcraftlistStatus {}

class PitchcraftlistNointernetState extends PitchcraftlistStatus {}

class GetPitchcraftlistInfoFailState extends PitchcraftlistStatus {
  //final String mMessage;
  GetPitchcraftlistInfoFailState();
}

class GetPitchcraftlistInfoSuccessState extends PitchcraftlistStatus {
  final List<MyService> mCoursesDetails;
  GetPitchcraftlistInfoSuccessState(this.mCoursesDetails);
}

class GetPitchcraftmyServiceInfoSuccessState extends PitchcraftlistStatus {
  final List<MyService> mMyserviceList;
  GetPitchcraftmyServiceInfoSuccessState(this.mMyserviceList);
}
