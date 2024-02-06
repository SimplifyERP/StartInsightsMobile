//

import 'package:startinsights/Model/MastersResponse.dart';

abstract class AngleDashboardStatus {}

class AngleDashboardInitialState extends AngleDashboardStatus {}

class AngleDashboardLoadingState extends AngleDashboardStatus {}

class AngleNointernetState extends AngleDashboardStatus {}

class GetAngleDashboardInfoFailState extends AngleDashboardStatus {
  //final String mMessage;
  GetAngleDashboardInfoFailState();
}

class GetAngleDashboardInfoSuccessState extends AngleDashboardStatus {
  //final String mMessage;
  MastersData mMastersDataList;
  GetAngleDashboardInfoSuccessState(this.mMastersDataList);
}
