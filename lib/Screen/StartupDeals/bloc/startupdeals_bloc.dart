// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:custom_gif_loading/custom_gif_loading.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startinsights/Model/StartupDealsResponse.dart';
import 'package:startinsights/Network/api_result_handler.dart';
import 'package:startinsights/Repository/startupdeals_repository.dart';
import 'package:startinsights/Screen/StartupDeals/bloc/startupdeals_event.dart';
import 'package:startinsights/Screen/StartupDeals/bloc/startupdeals_state.dart';
import 'package:startinsights/Utils/StorageServiceConstant.dart';
import 'package:startinsights/Utils/constant_methods.dart';

class StartupdealsBloc extends Bloc<StartupdealsEvent, StartupdealsStatus> {
  final BuildContext mContext;
  List<Datum> mStartupDealsList = [];

  StartupdealsBloc({
    required this.mContext,
  }) : super(StartupdealsInitialState()) {
    onLoadView();
  }

  void getStartupDealsListData() async {
    //final userId = await sl<StorageService>().getString(StorageServiceConstant.MUSEREMAIL);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final userId = (prefs.getString(StorageServiceConstant.MUSEREMAIL) ?? '');

    if (await checkNetworkStatus()) {
      Loading(mLoaderGif).start(mContext);
      ApiResults apiResults =
          await StartupDealsRepository().getStartupDealsData(userId);
      if (apiResults is ApiSuccess) {
        mStartupDealsList =
            StartupDealsResponse.fromJson(apiResults.data).message!.data!;

        emit(GetStartupdealsInfoSuccessState(mStartupDealsList));

        // hideLoading(mContext);
        Loading.stop();
      } else if (apiResults is ApiFailure) {
        //  Loading.stop();
        // hideLoading(mContext);
      }
    } else {
      emit(StartupdealsNointernetState());
    }
  }

  void onLoadView() async {
    if (await checkNetworkStatus()) {
      emit(StartupdealsLoadingState());
    } else {
      emit(StartupdealsNointernetState());
    }
  }
}
