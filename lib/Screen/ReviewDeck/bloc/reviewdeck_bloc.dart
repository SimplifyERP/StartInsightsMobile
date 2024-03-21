// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:startinsights/Screen/ReviewDeck/bloc/reviewdeck_event.dart';
import 'package:startinsights/Screen/ReviewDeck/bloc/reviewdeck_state.dart';
import 'package:startinsights/Utils/constant_methods.dart';

class ReviewDeckBloc extends Bloc<ReviewDeckEvent, ReviewDeckStatus> {
  final BuildContext mContext;

  ReviewDeckBloc({
    required this.mContext,
  }) : super(ReviewDeckInitialState()) {
    onLoadView();
  }

  void onLoadView() async {
    if (await checkNetworkStatus()) {
      emit(ReviewDeckLoadingState());
    } else {
      emit(ReviewDeckNointernetState());
    }
  }
}
