// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:custom_gif_loading/custom_gif_loading.dart';
import 'package:flutter/material.dart';
import 'package:startinsights/Model/LoginResponse.dart';
import 'package:startinsights/Network/api_result_handler.dart';
import 'package:startinsights/Repository/profile_repo.dart';
import 'package:startinsights/Screen/Profile/bloc/profile_event.dart';
import 'package:startinsights/Screen/Profile/bloc/profile_state.dart';
import 'package:startinsights/Utils/constant_methods.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileStatus> {
  final BuildContext mContext;
  Userinfo muserinfo = Userinfo();
  ProfileBloc({
    required this.mContext,
  }) : super(ProfileInitialState()) {
    onLoadView();
  }

  void getProfileData() async {
    if (await checkNetworkStatus()) {
      Loading(mLoaderGif).start(mContext);
      ApiResults apiResults =
          await ProfileRepo().ProfileList("jagadeesan.a1104@gmail.com");
      if (apiResults is ApiSuccess) {
        muserinfo = LoginResponse.fromJson(apiResults.data).message!.userinfo!;

        emit(GetProfileInfoSuccessState(muserinfo));
        // hideLoading(mContext);
        Loading.stop();
      } else if (apiResults is ApiFailure) {
        //  Loading.stop();
        // hideLoading(mContext);
      }
    } else {
      emit(ProfileNointernetState());
    }
  }

  void onLoadView() async {
    if (await checkNetworkStatus()) {
      emit(ProfileLoadingState());
    } else {
      emit(ProfileNointernetState());
    }
  }
}
