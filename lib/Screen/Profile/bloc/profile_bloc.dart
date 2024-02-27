// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:custom_gif_loading/custom_gif_loading.dart';
import 'package:flutter/material.dart';
import 'package:startinsights/Model/CoursesDetailsResponse.dart';
import 'package:startinsights/Network/api_result_handler.dart';
import 'package:startinsights/Repository/courselistdetails_repository.dart';
import 'package:startinsights/Screen/Profile/bloc/profile_event.dart';
import 'package:startinsights/Screen/Profile/bloc/profile_state.dart';
import 'package:startinsights/Utils/constant_methods.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileStatus> {
  final BuildContext mContext;
  List<Course> mCoursesDetailsList = [];
  ProfileBloc({
    required this.mContext,
  }) : super(ProfileInitialState()) {
    onLoadView();
  }

  void getCoursesListData(String CoursesId) async {
    if (await checkNetworkStatus()) {
      Loading(mLoaderGif).start(mContext);
      ApiResults apiResults = await CoursesDetailsRepository()
          .getCoursesDetails(CoursesId, "jagadeesan.a1104@gmail.com");
      if (apiResults is ApiSuccess) {
        mCoursesDetailsList =
            CoursesDetailsResponse.fromJson(apiResults.data).message!.course!;

        emit(GetProfileInfoSuccessState(mCoursesDetailsList));
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
