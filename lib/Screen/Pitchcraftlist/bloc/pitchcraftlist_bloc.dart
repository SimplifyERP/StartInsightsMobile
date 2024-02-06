// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:custom_gif_loading/custom_gif_loading.dart';
import 'package:flutter/material.dart';
import 'package:startinsights/Model/PitchcraftlistResponse.dart';
import 'package:startinsights/Network/api_result_handler.dart';
import 'package:startinsights/Repository/pitchcraftlist_repo.dart';
import 'package:startinsights/Screen/Pitchcraftlist/bloc/pitchcraftlist_event.dart';
import 'package:startinsights/Screen/Pitchcraftlist/bloc/pitchcraftlist_state.dart';
import 'package:startinsights/Utils/constant_methods.dart';

class PitchcraftlistBloc
    extends Bloc<PitchcraftlistEvent, PitchcraftlistStatus> {
  final BuildContext mContext;
  List<MyService> mCoursesDetailsList = [];
  List<MyService> mMyserviceList = [];
  PitchcraftlistBloc({
    required this.mContext,
  }) : super(PitchcraftlistInitialState()) {
    onLoadView();
  }

  void getPitchCraftListData(int mFrom) async {
    if (await checkNetworkStatus()) {
      Loading(mLoaderGif).start(mContext);
      ApiResults apiResults = await PitchcraftListRepo().getPitchcraftList("");
      if (apiResults is ApiSuccess) {
        if (mFrom == 1) {
          mCoursesDetailsList = PitchcraftlistResponse.fromJson(apiResults.data)
              .message!
              .servicesList!;

          emit(GetPitchcraftlistInfoSuccessState(mCoursesDetailsList));
        } else {
          mMyserviceList = PitchcraftlistResponse.fromJson(apiResults.data)
              .message!
              .myServices!;

          emit(GetPitchcraftmyServiceInfoSuccessState(mMyserviceList));
        }

        // hideLoading(mContext);
        Loading.stop();
      } else if (apiResults is ApiFailure) {
        //  Loading.stop();
        // hideLoading(mContext);
      }
    } else {
      emit(PitchcraftlistNointernetState());
    }
  }

  void onLoadView() async {
    if (await checkNetworkStatus()) {
      emit(PitchcraftlistLoadingState());
    } else {
      emit(PitchcraftlistNointernetState());
    }
  }
}
