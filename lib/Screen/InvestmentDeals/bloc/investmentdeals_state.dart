//

import 'package:startinsights/Model/InvestmentdealsdetailsResponse.dart';

abstract class InvestmentDealsStatus {}

class InvestmentDealsInitialState extends InvestmentDealsStatus {}

class InvestmentDealsLoadingState extends InvestmentDealsStatus {}

class InvestmentDealsNointernetState extends InvestmentDealsStatus {}

class GetInvestmentDealsInfoFailState extends InvestmentDealsStatus {
  //final String mMessage;
  GetInvestmentDealsInfoFailState();
}

class GetInvestmentDealsInfoSuccessState extends InvestmentDealsStatus {
  List<InvestmentDeal> mInvestmentDealList;
  GetInvestmentDealsInfoSuccessState(this.mInvestmentDealList);
}
