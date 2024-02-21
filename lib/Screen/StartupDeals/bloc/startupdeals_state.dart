//

import 'package:startinsights/Model/StartupDealsResponse.dart';

abstract class StartupdealsStatus {}

class StartupdealsInitialState extends StartupdealsStatus {}

class StartupdealsLoadingState extends StartupdealsStatus {}

class StartupdealsNointernetState extends StartupdealsStatus {}

class GetStartupdealsInfoFailState extends StartupdealsStatus {
  //final String mMessage;
  GetStartupdealsInfoFailState();
}

class GetStartupdealsInfoSuccessState extends StartupdealsStatus {
  final List<Datum> mDatum;
  GetStartupdealsInfoSuccessState(this.mDatum);
}
