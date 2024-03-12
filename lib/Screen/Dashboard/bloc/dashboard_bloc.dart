// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:custom_gif_loading/custom_gif_loading.dart';
import 'package:flutter/material.dart';
import 'package:startinsights/Model/DashboardResponse.dart';
import 'package:startinsights/Network/api_result_handler.dart';
import 'package:startinsights/Repository/dashboard_repo.dart';
import 'package:startinsights/Screen/Dashboard/bloc/dashboard_event.dart';
import 'package:startinsights/Screen/Dashboard/bloc/dashboard_state.dart';
import 'package:startinsights/Utils/constant_methods.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardStatus> {
  final BuildContext mContext;

  List<MessageElement> mDashboarddata = [];

  DashboardBloc({
    required this.mContext,
  }) : super(DashboardInitialState()) {
    onLoadView();
  }

  void getDashboardData() async {
    if (await checkNetworkStatus()) {
      Loading(mLoaderGif).start(mContext);
      List<String> mStages = [];
      ApiResults apiResults = await DashboardRepo().mDashboard();
      if (apiResults is ApiSuccess) {
        mDashboarddata =
            DashboardResponse.fromJson(apiResults.data).message!.message!;

        emit(GetDashboardInfoSuccessState(mDashboarddata));

        // hideLoading(mContext);
        Loading.stop();
      } else if (apiResults is ApiFailure) {
        //  Loading.stop();
        // hideLoading(mContext);
      }
    } else {
      emit(NointernetState());
    }
  }

  void onLoadView() async {
    if (await checkNetworkStatus()) {
      emit(DashboardLoadingState());
    } else {
      emit(NointernetState());
    }
  }
}
