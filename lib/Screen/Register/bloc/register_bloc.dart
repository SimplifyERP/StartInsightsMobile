import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:custom_gif_loading/custom_gif_loading.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startinsights/Model/CommonResponse.dart';
import 'package:startinsights/Model/RegistrationResponse.dart';
import 'package:startinsights/Network/api_result_handler.dart';
import 'package:startinsights/Repository/register_repo.dart';
import 'package:startinsights/Screen/Register/bloc/register_event.dart';
import 'package:startinsights/Screen/Register/bloc/register_state.dart';
import 'package:startinsights/Utils/StorageServiceConstant.dart';
import 'package:startinsights/Utils/constant_methods.dart';
import 'package:startinsights/Utils/screens.dart';
import 'package:startinsights/Utils/utils.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterStatus> {
  final BuildContext mContext;

  RegisterBloc({
    required this.mContext,
  }) : super(RegisterInitialState());

  late UserDetails mUserDetails;

  void register({
    required String firstname,
    required String userid,
    required String phoneno,
    required String password,
    required String usertype,
    required String logintype,
    required String companyname,
    required String linkedin,
  }) async {
    Loading(mLoaderGif).start(mContext);
    ApiResults apiResults = await RegisterRepo().createRegisterData(firstname,
        userid, phoneno, password, usertype, logintype, companyname, linkedin);
    if (apiResults is ApiSuccess) {
      Loading.stop();
      //  handleLoginResponse(apiResults.data, apiResults.statusCode);

      SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString(StorageServiceConstant.MUSERNAME, firstname);
      await prefs.setString(StorageServiceConstant.MUSEREMAIL, userid);
      await prefs.setString(StorageServiceConstant.MUSEREIMAGE, "");
      await prefs.setString(StorageServiceConstant.MUSEREMOBILE, phoneno);

      /*sl<StorageService>()
          .setString(StorageServiceConstant.MUSERNAME, firstname);

      sl<StorageService>().setString(StorageServiceConstant.MUSEREMAIL, userid);

      sl<StorageService>().setString(StorageServiceConstant.MUSEREIMAGE, "");

      sl<StorageService>()
          .setString(StorageServiceConstant.MUSEREMOBILE, phoneno);*/

      Navigator.pushReplacementNamed(mContext, dashboardRoute);

      SucessToast(
          context: mContext,
          text: CommonResponse.fromJson(apiResults.data).message!.message!);
    } else if (apiResults is ApiFailure) {
      Loading.stop();
      ErrorToast(context: mContext, text: "Failure");
    }
  }

  void CreateAccount({
    required String firstname,
    required String phoneno,
    required String emailid,
  }) async {
    Loading(mLoaderGif).start(mContext);
    ApiResults apiResults =
        await RegisterRepo().CreateAccount(firstname, phoneno, emailid);
    if (apiResults is ApiSuccess) {
      Loading.stop();

      if (RegistrationResponse.fromJson(apiResults.data).message!.status ==
          true) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String mUserInfo = json.encode(apiResults.data);
        await prefs.setString(StorageServiceConstant.MUSERINFO, mUserInfo);
        GoRouter.of(mContext).go('/Register/RegisterComplet');
      } else {
        // ignore: use_build_context_synchronously
        showErrorSnackBar(
            context: mContext,
            text: RegistrationResponse.fromJson(apiResults.data)
                .message!
                .message!);
      }
    } else if (apiResults is ApiFailure) {
      Loading.stop();
      // ignore: use_build_context_synchronously
      ErrorToast(context: mContext, text: "Failure");
    }
  }

  void CreateAccountFinish({
    required String usertype,
    required String password,
  }) async {
    Loading(mLoaderGif).start(mContext);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> valueMap =
        json.decode((prefs.getString(StorageServiceConstant.MUSERINFO) ?? ''));
    mUserDetails =
        RegistrationResponse.fromJson(valueMap).message!.userDetails!;

    ApiResults apiResults = await RegisterRepo().CreateAccountFinish(
        mUserDetails.userId ?? "",
        mUserDetails.mobileNo ?? "",
        usertype,
        password);
    if (apiResults is ApiSuccess) {
      Loading.stop();

      if (RegistrationResponse.fromJson(apiResults.data).message!.status ==
          true) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String mUserInfo = json.encode(apiResults.data);
        await prefs.setString(StorageServiceConstant.MUSERINFO, mUserInfo);

        GoRouter.of(mContext).go('/Dashboard');
      } else {
        // ignore: use_build_context_synchronously
        showErrorSnackBar(
            context: mContext,
            text: RegistrationResponse.fromJson(apiResults.data)
                .message!
                .message!);
      }
    } else if (apiResults is ApiFailure) {
      Loading.stop();
      ErrorToast(context: mContext, text: "Failure");
    }
  }

  // void login({
  //   required String email,
  //   required String password,
  // }) async {
  //   Loading(mLoaderGif).start(mContext);
  //   ApiResults apiResults = await LoginRepo().createLoginData(email, password);
  //   if (apiResults is ApiSuccess) {
  //     Loading.stop();
  //     handleLoginResponse(apiResults.data, apiResults.statusCode);
  //   } else if (apiResults is ApiFailure) {
  //     Loading.stop();
  //     ErrorToast(context: mContext, text: "Login details Error");
  //   }
  // }

  // void handleLoginResponse(json, int? statusCode) {
  //   if (LoginResponse.fromJson(json).message!.status == true) {
  //     sl<StorageService>().setBool(Constant.MLOGINSTATUS, true);
  //     sl<StorageService>().setString(Constant.MUSERNAME,
  //         LoginResponse.fromJson(json).message!.userinfo!.fullName!);
  //     sl<StorageService>().setString(Constant.MUSEREMAIL,
  //         LoginResponse.fromJson(json).message!.userinfo!.userEmail!);
  //     sl<StorageService>().setString(Constant.MUSEREIMAGE,
  //         LoginResponse.fromJson(json).message!.userinfo!.image!);
  //     sl<StorageService>().setString(Constant.MEMPID,
  //         LoginResponse.fromJson(json).message!.userinfo!.empid!);
  //
  //     SucessToast(
  //         context: mContext,
  //         text: LoginResponse.fromJson(json).message!.message!);
  //
  //     Navigator.pushReplacementNamed(mContext, dashboardRoute);
  //   }
  // }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
