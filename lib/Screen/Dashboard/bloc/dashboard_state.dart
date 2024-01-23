//

import 'package:startinsights/Model/MastersResponse.dart';

abstract class DashboardStatus {}

class DashboardInitialState extends DashboardStatus {}

class DashboardLoadingState extends DashboardStatus {}

class NointernetState extends DashboardStatus {}

class GetDashboardInfoFailState extends DashboardStatus {
  //final String mMessage;
  GetDashboardInfoFailState();
}

class GetDashboardInfoSuccessState extends DashboardStatus {
  //final String mMessage;
  MastersData mMastersDataList;
  GetDashboardInfoSuccessState(this.mMastersDataList);
}
