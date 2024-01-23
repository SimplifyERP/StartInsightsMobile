// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:custom_gif_loading/custom_gif_loading.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startinsights/Model/CoursesListResponse.dart';
import 'package:startinsights/Network/api_result_handler.dart';
import 'package:startinsights/Network/di.dart';
import 'package:startinsights/Repository/courselist_repository.dart';
import 'package:startinsights/Screen/StartupSchool/bloc/startupschool_event.dart';
import 'package:startinsights/Screen/StartupSchool/bloc/startupschool_state.dart';
import 'package:startinsights/Utils/StorageServiceConstant.dart';
import 'package:startinsights/Utils/constant_methods.dart';
import 'package:startinsights/Utils/pref_manager.dart';

class StartupSchoolBloc extends Bloc<StartupSchoolEvent, StartupSchoolStatus> {
  final BuildContext mContext;
  // List<CoursesList> mCoursesList = [];

  StartupSchoolBloc({
    required this.mContext,
  }) : super(StartupSchoolInitialState()) {
    onLoadView();
  }

  void getCoursesListData() async {
    sl<StorageService>().setBool(StorageServiceConstant.MLOGINSTATUS, true);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('counter', true);

    if (await checkNetworkStatus()) {
      //showLoading(mContext);
      Loading(mLoaderGif).start(mContext);
      ApiResults apiResults = await CoursesListRepository().getCoursesList("");
      if (apiResults is ApiSuccess) {
        // mCoursesList =
        //     CoursesListResponse.fromJson(apiResults.data).message!.coursesList!;

        emit(GetStartupSchoolInfoSuccessState(
            CoursesListResponse.fromJson(apiResults.data).message!));
        // hideLoading(mContext);
        Loading.stop();
      } else if (apiResults is ApiFailure) {
        //  Loading.stop();
        // hideLoading(mContext);
      }
    } else {
      emit(StartupSchoolNointernetState());
    }
  }

  void SaveCoursesData(String id, String status) async {
    if (await checkNetworkStatus()) {
      //showLoading(mContext);
      Loading(mLoaderGif).start(mContext);
      ApiResults apiResults =
          await CoursesListRepository().SaveCourses(id, status);
      if (apiResults is ApiSuccess) {
        // mCoursesList =
        //     CoursesListResponse.fromJson(apiResults.data).message!.coursesList!;
        //
        // emit(GetStartupSchoolInfoSuccessState(mCoursesList));
        // hideLoading(mContext);
        getCoursesListData();
        Loading.stop();
      } else if (apiResults is ApiFailure) {
        //  Loading.stop();
        // hideLoading(mContext);
      }
    } else {
      emit(StartupSchoolNointernetState());
    }
  }

  void onLoadView() async {
    if (await checkNetworkStatus()) {
      emit(StartupSchoolLoadingState());
    } else {
      emit(StartupSchoolNointernetState());
    }
  }
}
