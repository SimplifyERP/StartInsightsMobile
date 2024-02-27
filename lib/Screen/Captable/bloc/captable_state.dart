//

import 'package:startinsights/Model/InvestorroundwiseResponse.dart';

abstract class CaptableStatus {}

class CaptableInitialState extends CaptableStatus {}

class CaptableLoadingState extends CaptableStatus {}

class CaptableNointernetState extends CaptableStatus {}

class GetCaptableInfoFailState extends CaptableStatus {
  //final String mMessage;
  GetCaptableInfoFailState();
}

class GetCaptableInfoSuccessState extends CaptableStatus {
  final List<InvestorWiseList> mInvestorWiseList;
  final List<WiseGraph> mInvestorWiseGraphList;
  final List<WiseGraph> mRoundWiseGraphList;
  final List<RoundWiseList> mRoundWiseList;
  GetCaptableInfoSuccessState(
      this.mInvestorWiseList,
      this.mInvestorWiseGraphList,
      this.mRoundWiseList,
      this.mRoundWiseGraphList);
}
