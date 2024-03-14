// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:custom_gif_loading/custom_gif_loading.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:startinsights/Model/LoginResponse.dart';
import 'package:startinsights/Model/MastersResponse.dart';
import 'package:startinsights/Network/api_result_handler.dart';
import 'package:startinsights/Network/di.dart';
import 'package:startinsights/Repository/login_repo.dart';
import 'package:startinsights/Repository/master_repository.dart';
import 'package:startinsights/Utils/StorageServiceConstant.dart';
import 'package:startinsights/Utils/constant_methods.dart';
import 'package:startinsights/Utils/pref_manager.dart';
import 'package:startinsights/Utils/utils.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginStatus> {
  final BuildContext mContext;
  MastersData mMastersDataList = MastersData();
  var mGetcheckedValue = false;
  Userinfo mLoginResponse = Userinfo();
  LoginBloc({
    required this.mContext,
  }) : super(LoginInitialState()) {
    onLoadView();
  }

  void getMasterData() async {
    if (await checkNetworkStatus()) {
      // showLoading(mContext);
      ApiResults apiResults = await MasterRepository().getMasterData("");
      if (apiResults is ApiSuccess) {
        mMastersDataList =
            MastersResponse.fromJson(apiResults.data).message!.mastersData!;
        MastersResponse.fromJson(apiResults.data)!.message!.mastersData!;

        String MastersDatstr = json.encode(mMastersDataList);

        sl<StorageService>()
            .setString(StorageServiceConstant.MMASTERDATA, MastersDatstr);

        Map<String, dynamic> valueMap = json.decode(MastersDatstr);
        mMastersDataList = MastersData.fromJson(valueMap);

        emit(GetLoginInfoSuccessState(mMastersDataList));
        // hideLoading(mContext);
      } else if (apiResults is ApiFailure) {
        emit(GetLoginInfoFailState());
        //  Loading.stop();
        // hideLoading(mContext);
      }
    } else {
      emit(NointernetState());
    }
  }

  void login({
    required String userid,
    required String password,
    required bool checkedValue,
  }) async {
    mGetcheckedValue = checkedValue;

    Loading(mLoaderGif).start(mContext);
    ApiResults apiResults = await LoginRepo().loginData(userid, password);
    if (apiResults is ApiSuccess) {
      Loading.stop();
      handleLoginResponse(apiResults.data, apiResults.statusCode);
    } else if (apiResults is ApiFailure) {
      Loading.stop();
      ErrorToast(context: mContext, text: "Failure");
    }
  }

  void handleLoginResponse(getjson, int? statusCode) {
    if (LoginResponse.fromJson(getjson).message!.status == true) {
      sl<StorageService>()
          .setBool(StorageServiceConstant.MLOGINSTATUS, mGetcheckedValue);
      sl<StorageService>().setString(StorageServiceConstant.MUSERNAME,
          LoginResponse.fromJson(getjson).message!.userinfo!.fullName!);

      mLoginResponse = LoginResponse.fromJson(getjson)!.message!.userinfo!;

      String mUserInfo = json.encode(getjson);

      sl<StorageService>()
          .setString(StorageServiceConstant.MUSERINFO, mUserInfo);

      sl<StorageService>().setString(StorageServiceConstant.MUSEREMAIL,
          LoginResponse.fromJson(getjson).message!.userinfo!.userEmail!);

      sl<StorageService>().setString(StorageServiceConstant.MUSEREIMAGE,
          LoginResponse.fromJson(getjson).message!.userinfo!.profileImage!);

      sl<StorageService>().setString(StorageServiceConstant.MUSEREMOBILE,
          LoginResponse.fromJson(getjson).message!.userinfo!.phoneNo!);

      SucessToast(
          context: mContext,
          text: LoginResponse.fromJson(getjson).message!.message!);

      GoRouter.of(mContext).go('/Dashboard');
    } else {
      SucessToast(
          context: mContext,
          text: LoginResponse.fromJson(getjson).message!.message!);
    }
  }

  void onLoadView() async {
    if (await checkNetworkStatus()) {
      emit(LoginLoadingState());
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
