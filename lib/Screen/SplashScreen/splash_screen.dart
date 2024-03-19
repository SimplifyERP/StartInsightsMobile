import 'package:custom_gif_loading/custom_gif_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:startinsights/Utils/StorageServiceConstant.dart';

import '../../utils/pref_manager.dart';
import 'bloc/splash_bloc.dart';
import 'bloc/splash_event.dart';
import 'bloc/splash_state.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  StorageService storageService = StorageService();
  bool mIsLogin = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      loadPrefs();
    });
  }

  Future<void> loadPrefs() async {
    mIsLogin =
        await storageService.getBool(StorageServiceConstant.MLOGINSTATUS) ??
            false;
  }

  @override
  Widget build(BuildContext context) {
    var getyear = DateTime.now();

    BlocProvider.of<SplashBloc>(context).add(SetSplash());
    return Scaffold(
      body: BlocConsumer<SplashBloc, SplashState>(
        listener: (context, state) {
          // if (state is GetSplashInfoSucessState) {
          if (mIsLogin == null) {
            //GoRouter.of(context).go('/Login');
            GoRouter.of(context).go('/Dashboard');
          } else {
            if (mIsLogin) {
              GoRouter.of(context).go('/Dashboard');
            } else {
              //GoRouter.of(context).go('/Login');
              GoRouter.of(context).go('/Dashboard');
            }
          }
          //  }
        },
        builder: (context, state) {
          if (state is SplashLoadingState) {
            //  Loading(mLoaderGif).start(context);
          } else if (state is GetSplashInfoSucessState) {
            Loading.stop();
          }

          return SafeArea(
            child: Stack(
              children: [],
            ),
          );

          return Container();
        },
      ),
    );
  }
}
