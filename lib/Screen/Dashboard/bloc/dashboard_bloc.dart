// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:startinsights/Screen/Dashboard/bloc/dashboard_event.dart';
import 'package:startinsights/Screen/Dashboard/bloc/dashboard_state.dart';
import 'package:startinsights/Utils/constant_methods.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardStatus> {
  final BuildContext mContext;

  DashboardBloc({
    required this.mContext,
  }) : super(DashboardInitialState()) {
    onLoadView();
  }

  void onLoadView() async {
    if (await checkNetworkStatus()) {
      emit(DashboardLoadingState());
    } else {
      emit(NointernetState());
    }
  }
}
