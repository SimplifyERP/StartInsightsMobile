// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:startinsights/Screen/AngelXDashboard/bloc/angledashboard_event.dart';
import 'package:startinsights/Screen/AngelXDashboard/bloc/angledashboard_state.dart';
import 'package:startinsights/Utils/constant_methods.dart';

class AngleDashboardBloc
    extends Bloc<AngleDashboardEvent, AngleDashboardStatus> {
  final BuildContext mContext;

  AngleDashboardBloc({
    required this.mContext,
  }) : super(AngleDashboardInitialState()) {
    onLoadView();
  }

  void onLoadView() async {
    if (await checkNetworkStatus()) {
      emit(AngleDashboardLoadingState());
    } else {
      emit(AngleNointernetState());
    }
  }
}
