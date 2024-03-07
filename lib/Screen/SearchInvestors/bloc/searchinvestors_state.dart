//

import 'package:startinsights/Model/SearchinvestorslistResponse.dart';

abstract class SearchInvestorsStatus {}

class SearchInvestorsInitialState extends SearchInvestorsStatus {}

class SearchInvestorsLoadingState extends SearchInvestorsStatus {}

class SearchInvestorsNointernetState extends SearchInvestorsStatus {}

class GetSearchInvestorsInfoFailState extends SearchInvestorsStatus {
  //final String mMessage;
  GetSearchInvestorsInfoFailState();
}

class GetSearchInvestorsInfoSuccessState extends SearchInvestorsStatus {
  final List<SearchInvestorsList> mSearchInvestorsList;
  final int mSearchInvestorsCount;
  GetSearchInvestorsInfoSuccessState(
      this.mSearchInvestorsList, this.mSearchInvestorsCount);
}
