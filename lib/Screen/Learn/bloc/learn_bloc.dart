// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:custom_gif_loading/custom_gif_loading.dart';
import 'package:flutter/material.dart';
import 'package:startinsights/Network/api_result_handler.dart';
import 'package:startinsights/Repository/lms_repository.dart';
import 'package:startinsights/Screen/Learn/bloc/learn_event.dart';
import 'package:startinsights/Screen/Learn/bloc/learn_state.dart';
import 'package:startinsights/Utils/constant_methods.dart';

import '../../../Model/LearnlistResponse.dart';

class LearnBloc extends Bloc<LearnEvent, LearnStatus> {
  final BuildContext mContext;
  List<CoursesList> mCoursesList = [];
  int mGetCount = 0;

  LearnBloc({
    required this.mContext,
  }) : super(LearnInitialState()) {
    onLoadView();
  }

  void getLearnList() async {
    if (await checkNetworkStatus()) {
      Loading(mLoaderGif).start(mContext);

      ApiResults apiResults =
          await LMSRepository().getLearnList("jagadeesan.a1104@gmail.com");
      if (apiResults is ApiSuccess) {
        mCoursesList =
            LearnlistResponse.fromJson(apiResults.data).message!.coursesList!;

        emit(GetLearnInfoSuccessState(mCoursesList));

        // hideLoading(mContext);
        Loading.stop();
      } else if (apiResults is ApiFailure) {
        //  Loading.stop();
        // hideLoading(mContext);
      }
    } else {
      emit(LearnNointernetState());
    }
  }

  void onLoadView() async {
    if (await checkNetworkStatus()) {
      emit(LearnLoadingState());
    } else {
      emit(LearnNointernetState());
    }
  }
}
