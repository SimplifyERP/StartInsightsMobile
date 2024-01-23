//

import 'package:startinsights/Model/MastersResponse.dart';

abstract class LoginStatus {}

class LoginInitialState extends LoginStatus {}

class LoginLoadingState extends LoginStatus {}

class NointernetState extends LoginStatus {}

class GetLoginInfoFailState extends LoginStatus {
  //final String mMessage;
  GetLoginInfoFailState();
}

class GetLoginInfoSuccessState extends LoginStatus {
  //final String mMessage;
  MastersData mMastersDataList;
  GetLoginInfoSuccessState(this.mMastersDataList);
}
