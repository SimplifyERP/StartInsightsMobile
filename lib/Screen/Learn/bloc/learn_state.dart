//

import 'package:startinsights/Model/SearchinvestorslistResponse.dart';

abstract class LearnStatus {}

class LearnInitialState extends LearnStatus {}

class LearnLoadingState extends LearnStatus {}

class LearnNointernetState extends LearnStatus {}

class GetLearnInfoFailState extends LearnStatus {
  //final String mMessage;
  GetLearnInfoFailState();
}

class GetLearnInfoSuccessState extends LearnStatus {
  final List<SearchInvestorsList> mSearchInvestorsList;
  final int mSearchInvestorsCount;
  GetLearnInfoSuccessState(
      this.mSearchInvestorsList, this.mSearchInvestorsCount);
}
