// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:custom_gif_loading/custom_gif_loading.dart';
import 'package:flutter/material.dart';
import 'package:startinsights/Model/InvestmentdealsdetailsResponse.dart';
import 'package:startinsights/Network/api_result_handler.dart';
import 'package:startinsights/Repository/investmentdeals_repo.dart';
import 'package:startinsights/Screen/InvestmentDeals/bloc/investmentdeals_event.dart';
import 'package:startinsights/Screen/InvestmentDeals/bloc/investmentdeals_state.dart';
import 'package:startinsights/Utils/constant_methods.dart';

class InvestmentDealsBloc
    extends Bloc<InvestmentDealsEvent, InvestmentDealsStatus> {
  final BuildContext mContext;
  List<InvestmentDeal> mInvestmentDealList = [];

  InvestmentDealsBloc({
    required this.mContext,
  }) : super(InvestmentDealsInitialState()) {
    onLoadView();
  }

  void getInvestmentDealsData() async {
    if (await checkNetworkStatus()) {
      //showLoading(mContext);
      Loading(mLoaderGif).start(mContext);
      ApiResults apiResults =
          await InvestmentDealsRepo().getInvestmentDeals("");
      if (apiResults is ApiSuccess) {
        mInvestmentDealList =
            InvestmentdealsdetailsResponse.fromJson(apiResults.data)
                .message!
                .investmentDeals!;

        emit(GetInvestmentDealsInfoSuccessState(mInvestmentDealList));

        // hideLoading(mContext);
        Loading.stop();
      } else if (apiResults is ApiFailure) {
        //  Loading.stop();
        // hideLoading(mContext);
      }
    } else {
      emit(InvestmentDealsNointernetState());
    }
  }

  void onLoadView() async {
    if (await checkNetworkStatus()) {
      emit(InvestmentDealsLoadingState());
    } else {
      emit(InvestmentDealsNointernetState());
    }
  }
}
