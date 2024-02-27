// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:custom_gif_loading/custom_gif_loading.dart';
import 'package:flutter/material.dart';
import 'package:startinsights/Model/ExpertBookingResponse.dart';
import 'package:startinsights/Network/api_result_handler.dart';
import 'package:startinsights/Repository/bookanexpert_repository.dart';
import 'package:startinsights/Screen/ExpertBooking/bloc/expertbooking_event.dart';
import 'package:startinsights/Screen/ExpertBooking/bloc/expertbooking_state.dart';
import 'package:startinsights/Utils/constant_methods.dart';

class ExpertBookingBloc extends Bloc<ExpertBookingEvent, ExpertBookingStatus> {
  final BuildContext mContext;
  List<BookAnExpert> mBookAnExpertList = [];

  ExpertBookingBloc({
    required this.mContext,
  }) : super(ExpertBookingInitialState()) {
    onLoadView();
  }

  void getexpertBookingData(String expertid) async {
    if (await checkNetworkStatus()) {
      //showLoading(mContext);
      Loading(mLoaderGif).start(mContext);
      ApiResults apiResults =
          await BookanexpertListRepository().getexpertBooking(expertid);
      if (apiResults is ApiSuccess) {
        mBookAnExpertList = ExpertBookingResponse.fromJson(apiResults.data)
            .message!
            .bookAnExpert!;

        if (ExpertBookingResponse.fromJson(apiResults.data).message!.status ??
            false) {
          emit(GetExpertBookingInfoSuccessState(mBookAnExpertList));
        }

        // hideLoading(mContext);
        Loading.stop();
      } else if (apiResults is ApiFailure) {
        //  Loading.stop();
        // hideLoading(mContext);
      }
    } else {
      emit(ExpertBookingNointernetState());
    }
  }

  void onLoadView() async {
    if (await checkNetworkStatus()) {
      emit(ExpertBookingLoadingState());
    } else {
      emit(ExpertBookingNointernetState());
    }
  }
}
