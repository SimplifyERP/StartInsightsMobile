// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:custom_gif_loading/custom_gif_loading.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startinsights/Model/CoursesDetailsResponse.dart';
import 'package:startinsights/Network/api_result_handler.dart';
import 'package:startinsights/Repository/courselistdetails_repository.dart';
import 'package:startinsights/Screen/MyCourses/bloc/mycourses_event.dart';
import 'package:startinsights/Screen/MyCourses/bloc/mycourses_state.dart';
import 'package:startinsights/Utils/StorageServiceConstant.dart';
import 'package:startinsights/Utils/constant_methods.dart';

class MyCoursesBloc extends Bloc<MyCoursesEvent, MyCoursesStatus> {
  final BuildContext mContext;
  List<Course> mCoursesDetailsList = [];
  MyCoursesBloc({
    required this.mContext,
  }) : super(MyCoursesInitialState()) {
    onLoadView();
  }

  void getCoursesListData(String CoursesId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final userId = (prefs.getString(StorageServiceConstant.MUSEREMAIL) ?? '');

    if (await checkNetworkStatus()) {
      Loading(mLoaderGif).start(mContext);
      ApiResults apiResults =
          await CoursesDetailsRepository().getCoursesDetails(CoursesId, userId);
      if (apiResults is ApiSuccess) {
        mCoursesDetailsList =
            CoursesDetailsResponse.fromJson(apiResults.data).message!.course!;

        emit(GetMyCoursesInfoSuccessState(mCoursesDetailsList));
        // hideLoading(mContext);
        Loading.stop();
      } else if (apiResults is ApiFailure) {
        //  Loading.stop();
        // hideLoading(mContext);
      }
    } else {
      emit(MyCoursesNointernetState());
    }
  }

  void onLoadView() async {
    if (await checkNetworkStatus()) {
      emit(MyCoursesLoadingState());
    } else {
      emit(MyCoursesNointernetState());
    }
  }
}
