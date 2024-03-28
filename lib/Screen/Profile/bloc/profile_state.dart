//

import 'package:startinsights/Model/LoginResponse.dart';

abstract class ProfileStatus {}

class ProfileInitialState extends ProfileStatus {}

class ProfileLoadingState extends ProfileStatus {}

class ProfileNointernetState extends ProfileStatus {}

class GetProfileInfoFailState extends ProfileStatus {
  //final String mMessage;
  GetProfileInfoFailState();
}

class GetProfileInfoSuccessState extends ProfileStatus {
  final Userinfo muserinfo;
  GetProfileInfoSuccessState(this.muserinfo);
}
