import 'package:bloc/bloc.dart';
import 'package:custom_gif_loading/custom_gif_loading.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startinsights/Model/CommonResponse.dart';
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
