// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:custom_gif_loading/custom_gif_loading.dart';
import 'package:flutter/material.dart';
import 'package:startinsights/Model/BookanexpertlistResponse.dart';
import 'package:startinsights/Network/api_result_handler.dart';
import 'package:startinsights/Repository/bookanexpert_repository.dart';
import 'package:startinsights/Screen/BookanExpert/bloc/bookanexpert_event.dart';
import 'package:startinsights/Screen/BookanExpert/bloc/bookanexpert_state.dart';
import 'package:startinsights/Utils/constant_methods.dart';

class BookanExpertBloc extends Bloc<BookanExpertEvent, BookanExpertStatus> {
  final BuildContext mContext;
  List<BookAnExpertList> mBookAnExpertList = [];

  BookanExpertBloc({
    required this.mContext,
  }) : super(BookanExpertInitialState()) {
    onLoadView();
  }

  void getBookanexpertListData() async {
    if (await checkNetworkStatus()) {
      //showLoading(mContext);
      Loading(mLoaderGif).start(mContext);
      ApiResults apiResults =
          await BookanexpertListRepository().getBookanexpertList("");
      if (apiResults is ApiSuccess) {
        mBookAnExpertList = BookanexpertlistResponse.fromJson(apiResults.data)
            .message!
            .bookAnExpertList!;

        emit(GetBookanExpertInfoSuccessState(mBookAnExpertList));

        // hideLoading(mContext);
        Loading.stop();
      } else if (apiResults is ApiFailure) {
        //  Loading.stop();
        // hideLoading(mContext);
      }
    } else {
      emit(BookanExpertNointernetState());
    }
  }

  void onLoadView() async {
    if (await checkNetworkStatus()) {
      emit(BookanExpertLoadingState());
    } else {
      emit(BookanExpertNointernetState());
    }
  }
}
