//

abstract class ForgetPwdStatus {}

class ForgetPwdInitialState extends ForgetPwdStatus {}

class ForgetPwdLoadingState extends ForgetPwdStatus {}

class NointernetState extends ForgetPwdStatus {}

class GetForgetPwdInfoFailState extends ForgetPwdStatus {
  //final String mMessage;
  GetForgetPwdInfoFailState();
}

class GetForgetPwdInfoSuccessState extends ForgetPwdStatus {
  //final String mMessage;
  GetForgetPwdInfoSuccessState();
}
