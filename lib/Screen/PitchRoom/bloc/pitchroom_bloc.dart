// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:custom_gif_loading/custom_gif_loading.dart';
import 'package:flutter/material.dart';
import 'package:startinsights/Model/PitchroomlistResponse.dart';
import 'package:startinsights/Network/api_result_handler.dart';
import 'package:startinsights/Repository/pitchroom_repository.dart';
import 'package:startinsights/Screen/PitchRoom/bloc/pitchroom_event.dart';
import 'package:startinsights/Screen/PitchRoom/bloc/pitchroom_state.dart';
import 'package:startinsights/Utils/constant_methods.dart';

class PitchroomBloc extends Bloc<PitchroomEvent, PitchroomStatus> {
  final BuildContext mContext;
  List<PitchRoomDetail> mPitchroomList = [];

  PitchroomBloc({
    required this.mContext,
  }) : super(PitchroomInitialState()) {
    onLoadView();
  }

  void getPitchroomListData() async {
    if (await checkNetworkStatus()) {
      Loading(mLoaderGif).start(mContext);
      ApiResults apiResults = await PitchroomRepository().getPitchroomData("");
      if (apiResults is ApiSuccess) {
        mPitchroomList = PitchroomlistResponse.fromJson(apiResults.data)
            .message!
            .pitchRoomDetails!;

        emit(GetPitchroomInfoSuccessState(mPitchroomList));

        // hideLoading(mContext);
        Loading.stop();
      } else if (apiResults is ApiFailure) {
        //  Loading.stop();
        // hideLoading(mContext);
      }
    } else {
      emit(PitchroomNointernetState());
    }
  }

  void onLoadView() async {
    if (await checkNetworkStatus()) {
      emit(PitchroomLoadingState());
    } else {
      emit(PitchroomNointernetState());
    }
  }
}
