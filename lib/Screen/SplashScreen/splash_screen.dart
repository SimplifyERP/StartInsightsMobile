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
            // Navigator.pushReplacementNamed(context, loginRoute);
            // Navigator.pushReplacementNamed(context, dashboardRoute);
          } else {
            if (mIsLogin) {
              // Navigator.pushReplacementNamed(context, searchinvestorRoute);

              //   Navigator.pushReplacementNamed(context, dashboardRoute);
            } else {
              // Navigator.pushReplacementNamed(context, dashboardRoute);
              // Navigator.pushReplacementNamed(context, loginRoute);
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
              children: [
                InkWell(
                  child: const Text(
                    "Test",
                    style: TextStyle(fontSize: 30),
                  ),
                  onTap: () {
                    GoRouter.of(context).go('/settings/:name');
                  },
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Text("sfasasfsaffas"),
                ),
              ],
            ),
          );

          return Container();
        },
      ),
    );
  }
}
