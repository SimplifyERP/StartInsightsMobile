// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:custom_gif_loading/custom_gif_loading.dart';
import 'package:flutter/material.dart';
import 'package:startinsights/Model/SearchinvestorslistResponse.dart';
import 'package:startinsights/Network/api_result_handler.dart';
import 'package:startinsights/Repository/SearchinvestorsRepo.dart';
import 'package:startinsights/Screen/SearchInvestors/bloc/searchinvestors_event.dart';
import 'package:startinsights/Screen/SearchInvestors/bloc/searchinvestors_state.dart';
import 'package:startinsights/Utils/constant_methods.dart';

class SearchInvestorsBloc
    extends Bloc<SearchInvestorsEvent, SearchInvestorsStatus> {
  final BuildContext mContext;
  List<SearchInvestorsList> mSearchInvestorsList = [];

  SearchInvestorsBloc({
    required this.mContext,
  }) : super(SearchInvestorsInitialState()) {
    onLoadView();
  }

  void getSearchinvestorsData() async {
    if (await checkNetworkStatus()) {
      Loading(mLoaderGif).start(mContext);
      ApiResults apiResults =
          await SearchinvestorsRepo().getSearchinvestors("");
      if (apiResults is ApiSuccess) {
        mSearchInvestorsList =
            SearchinvestorslistResponse.fromJson(apiResults.data)
                .message!
                .searchInvestorsList!;

        emit(GetSearchInvestorsInfoSuccessState(mSearchInvestorsList));

        // hideLoading(mContext);
        Loading.stop();
      } else if (apiResults is ApiFailure) {
        //  Loading.stop();
        // hideLoading(mContext);
      }
    } else {
      emit(SearchInvestorsNointernetState());
    }
  }

  void onLoadView() async {
    if (await checkNetworkStatus()) {
      emit(SearchInvestorsLoadingState());
    } else {
      emit(SearchInvestorsNointernetState());
    }
  }
}
