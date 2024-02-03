//

import 'package:startinsights/Model/ExpertBookingResponse.dart';

abstract class ExpertBookingStatus {}

class ExpertBookingInitialState extends ExpertBookingStatus {}

class ExpertBookingLoadingState extends ExpertBookingStatus {}

class ExpertBookingNointernetState extends ExpertBookingStatus {}

class GetExpertBookingInfoFailState extends ExpertBookingStatus {
  //final String mMessage;
  GetExpertBookingInfoFailState();
}

class GetExpertBookingInfoSuccessState extends ExpertBookingStatus {
  List<BookAnExpert> mBookAnExpertList;
  GetExpertBookingInfoSuccessState(this.mBookAnExpertList);
}
