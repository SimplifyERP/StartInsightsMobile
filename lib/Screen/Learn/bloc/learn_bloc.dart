// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:custom_gif_loading/custom_gif_loading.dart';
import 'package:flutter/material.dart';
import 'package:startinsights/Model/SearchinvestorslistResponse.dart';
import 'package:startinsights/Network/api_result_handler.dart';
import 'package:startinsights/Repository/SearchinvestorsRepo.dart';
import 'package:startinsights/Screen/Learn/bloc/learn_event.dart';
import 'package:startinsights/Screen/Learn/bloc/learn_state.dart';
import 'package:startinsights/Utils/constant_methods.dart';

class LearnBloc extends Bloc<LearnEvent, LearnStatus> {
  final BuildContext mContext;
  List<SearchInvestorsList> mSearchInvestorsList = [];
  int mGetCount = 0;

  LearnBloc({
    required this.mContext,
  }) : super(LearnInitialState()) {
    onLoadView();
  }

  void getLearnData(
    int PageNo,
    String country,
    String fundingstage,
    String amount,
  ) async {
    if (await checkNetworkStatus()) {
      Loading(mLoaderGif).start(mContext);
      List<String> mStages = [];
      ApiResults apiResults = await SearchinvestorsRepo()
          .getSearchinvestors("jagadeesan.a1104@gmail.com", 1, '', mStages, '');
      if (apiResults is ApiSuccess) {
        mSearchInvestorsList =
            SearchinvestorslistResponse.fromJson(apiResults.data)
                .message!
                .searchInvestorsList!;

        mGetCount = SearchinvestorslistResponse.fromJson(apiResults.data)
            .message!
            .investorsCount!;

        emit(GetLearnInfoSuccessState(mSearchInvestorsList, mGetCount));

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
