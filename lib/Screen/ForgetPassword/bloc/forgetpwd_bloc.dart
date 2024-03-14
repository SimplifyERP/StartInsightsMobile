// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:custom_gif_loading/custom_gif_loading.dart';
import 'package:flutter/material.dart';
import 'package:startinsights/Model/CommonResponse.dart';
import 'package:startinsights/Network/api_result_handler.dart';
import 'package:startinsights/Repository/login_repo.dart';
import 'package:startinsights/Screen/ForgetPassword/bloc/forgetpwd_event.dart';
import 'package:startinsights/Screen/ForgetPassword/bloc/forgwtpwd_state.dart';
import 'package:startinsights/Utils/constant_methods.dart';
import 'package:startinsights/Utils/utils.dart';

class ForgetPwdBloc extends Bloc<ForgetPwdEvent, ForgetPwdStatus> {
  final BuildContext mContext;
  final String? mEmailid;

  ForgetPwdBloc({
    required this.mContext,
    required this.mEmailid,
  }) : super(ForgetPwdInitialState()) {
    onLoadView();
  }

  void forgetPwd({
    required String mEmailid,
  }) async {
    Loading(mLoaderGif).start(mContext);
    ApiResults apiResults = await LoginRepo().forgetPwdCall(mEmailid);
    if (apiResults is ApiSuccess) {
      if (CommonResponse.fromJson(apiResults.data)!.message!.status ?? false) {
        Loading.stop();
        SucessToast(
            context: mContext,
            text: CommonResponse.fromJson(apiResults.data)!.message!.message ??
                "");
      } else {
        ErrorToast(
            context: mContext,
            text: CommonResponse.fromJson(apiResults.data)!.message!.message ??
                "");
      }

      Loading.stop();
    } else if (apiResults is ApiFailure) {
      Loading.stop();
      ErrorToast(context: mContext, text: "Failure");
    }
  }

  void onLoadView() async {
    if (await checkNetworkStatus()) {
      emit(ForgetPwdLoadingState());
    } else {
      emit(NointernetState());
    }
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
