//

abstract class FundabilityTestStatus {}

class FundabilityTestInitialState extends FundabilityTestStatus {}

class FundabilityTestLoadingState extends FundabilityTestStatus {}

class FundabilityTestNointernetState extends FundabilityTestStatus {}

class GetFundabilityTestInfoFailState extends FundabilityTestStatus {
  //final String mMessage;
  GetFundabilityTestInfoFailState();
}

class GetFundabilityTestInfoSuccessState extends FundabilityTestStatus {
  GetFundabilityTestInfoSuccessState();
}
