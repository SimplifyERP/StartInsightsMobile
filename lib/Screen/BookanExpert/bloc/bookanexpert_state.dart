//

import 'package:startinsights/Model/BookanexpertlistResponse.dart';

abstract class BookanExpertStatus {}

class BookanExpertInitialState extends BookanExpertStatus {}

class BookanExpertLoadingState extends BookanExpertStatus {}

class BookanExpertNointernetState extends BookanExpertStatus {}

class GetBookanExpertInfoFailState extends BookanExpertStatus {
  //final String mMessage;
  GetBookanExpertInfoFailState();
}

class GetBookanExpertInfoSuccessState extends BookanExpertStatus {
  List<FundraisingExpert> mBookAnExpertList;
  GetBookanExpertInfoSuccessState(this.mBookAnExpertList);
}
