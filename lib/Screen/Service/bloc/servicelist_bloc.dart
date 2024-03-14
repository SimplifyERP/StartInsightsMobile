// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:custom_gif_loading/custom_gif_loading.dart';
import 'package:flutter/material.dart';
import 'package:startinsights/Model/ServiceListResponse.dart';
import 'package:startinsights/Network/api_result_handler.dart';
import 'package:startinsights/Repository/pitchcraftlist_repo.dart';
import 'package:startinsights/Screen/Service/bloc/servicelist_event.dart';
import 'package:startinsights/Screen/Service/bloc/servicelist_state.dart';
import 'package:startinsights/Utils/constant_methods.dart';

class ServicelistBloc extends Bloc<ServicelistEvent, ServicelistStatus> {
  final BuildContext mContext;
  List<MyServices> mServiceList = [];
  List<MyServices> mMyServiceList = [];
  ServicelistBloc({
    required this.mContext,
  }) : super(ServicelistInitialState()) {
    onLoadView();
  }

  void getServiceListData(int mFrom) async {
    if (await checkNetworkStatus()) {
      Loading(mLoaderGif).start(mContext);
      ApiResults apiResults = await PitchcraftListRepo()
          .getPitchcraftList("jagadeesan.a1104@gmail.com");
      if (apiResults is ApiSuccess) {
        mServiceList = ServiceListResponse.fromJson(apiResults.data)
            .message!
            .servicesList!;

        mMyServiceList =
            ServiceListResponse.fromJson(apiResults.data).message!.myServices!;

        emit(GetServicelistInfoSuccessState(mServiceList, mMyServiceList));

        // hideLoading(mContext);
        Loading.stop();
      } else if (apiResults is ApiFailure) {
        //  Loading.stop();
        // hideLoading(mContext);
      }
    } else {
      emit(ServicelistNointernetState());
    }
  }

  void onLoadView() async {
    if (await checkNetworkStatus()) {
      emit(ServicelistLoadingState());
    } else {
      emit(ServicelistNointernetState());
    }
  }
}
