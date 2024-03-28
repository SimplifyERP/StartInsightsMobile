// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:custom_gif_loading/custom_gif_loading.dart';
import 'package:flutter/material.dart';
import 'package:startinsights/Model/InvestorroundwiseResponse.dart';
import 'package:startinsights/Network/api_result_handler.dart';
import 'package:startinsights/Network/di.dart';
import 'package:startinsights/Repository/captable_repository.dart';
import 'package:startinsights/Screen/Captable/bloc/captable_event.dart';
import 'package:startinsights/Screen/Captable/bloc/captable_state.dart';
import 'package:startinsights/Utils/StorageServiceConstant.dart';
import 'package:startinsights/Utils/constant_methods.dart';
import 'package:startinsights/Utils/pref_manager.dart';

class CaptableBloc extends Bloc<CaptableEvent, CaptableStatus> {
  final BuildContext mContext;
  List<InvestorWise> mInvestorWiseList = [];
  List<WiseGraph> mInvestorWiseGraphList = [];
  List<WiseGraph> mRoundWiseGraphList = [];
  List<RoundWise> mRoundWiseList = [];
  CaptableBloc({
    required this.mContext,
  }) : super(CaptableInitialState()) {
    onLoadView();
  }

  void getCaptableData() async {
    final userId =
        await sl<StorageService>().getString(StorageServiceConstant.MUSEREMAIL);
    if (await checkNetworkStatus()) {
      Loading(mLoaderGif).start(mContext);
      ApiResults apiResults =
          await CaptableRepository().getCaptableData(userId);
      if (apiResults is ApiSuccess) {
        mInvestorWiseList = InvestorroundwiseResponse.fromJson(apiResults.data)
            .message!
            .investorWise!;

        mInvestorWiseGraphList =
            InvestorroundwiseResponse.fromJson(apiResults.data)
                .message!
                .investorWiseGraph!;

        mRoundWiseList = InvestorroundwiseResponse.fromJson(apiResults.data)
            .message!
            .roundWise!;

        mRoundWiseGraphList =
            InvestorroundwiseResponse.fromJson(apiResults.data)
                .message!
                .roundWiseGraph!;

        emit(GetCaptableInfoSuccessState(mInvestorWiseList,
            mInvestorWiseGraphList, mRoundWiseList, mRoundWiseGraphList));

        // hideLoading(mContext);
        Loading.stop();
      } else if (apiResults is ApiFailure) {
        //  Loading.stop();
        // hideLoading(mContext);
      }
    } else {
      emit(CaptableNointernetState());
    }
  }

  void onLoadView() async {
    if (await checkNetworkStatus()) {
      emit(CaptableLoadingState());
    } else {
      emit(CaptableNointernetState());
    }
  }
}
