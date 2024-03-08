//

import 'package:startinsights/Model/PitchcraftlistResponse.dart';

abstract class ServicelistStatus {}

class ServicelistInitialState extends ServicelistStatus {}

class ServicelistLoadingState extends ServicelistStatus {}

class ServicelistNointernetState extends ServicelistStatus {}

class GetServicelistInfoFailState extends ServicelistStatus {
  //final String mMessage;
  GetServicelistInfoFailState();
}

class GetServicelistInfoSuccessState extends ServicelistStatus {
  final List<MyService> mServiceList;
  final List<MyService> mMyServicelist;
  GetServicelistInfoSuccessState(this.mServiceList, this.mMyServicelist);
}

class GetServiceInfoSuccessState extends ServicelistStatus {
  final List<MyService> mMyserviceList;
  GetServiceInfoSuccessState(this.mMyserviceList);
}
