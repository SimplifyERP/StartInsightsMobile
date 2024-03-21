// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:startinsights/Screen/FundabilityTest/bloc/fundabilitytest_event.dart';
import 'package:startinsights/Screen/FundabilityTest/bloc/fundabilitytest_state.dart';
import 'package:startinsights/Utils/constant_methods.dart';

class FundabilityTestBloc
    extends Bloc<FundabilityTestEvent, FundabilityTestStatus> {
  final BuildContext mContext;

  FundabilityTestBloc({
    required this.mContext,
  }) : super(FundabilityTestInitialState()) {
    onLoadView();
  }

  void onLoadView() async {
    if (await checkNetworkStatus()) {
      emit(FundabilityTestLoadingState());
    } else {
      emit(FundabilityTestNointernetState());
    }
  }
}
