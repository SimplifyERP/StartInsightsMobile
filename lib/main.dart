import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sizer/sizer.dart';
import 'package:startinsights/Localization/localizations_delegate.dart';
import 'package:startinsights/Network/di.dart';
import 'package:startinsights/Route/route.dart';
import 'package:startinsights/Screen/SplashScreen/bloc/splash_bloc.dart';
import 'package:startinsights/Screen/SplashScreen/splash_screen.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Utils/theme.dart';

void main() {
  // Set the status bar color to blue
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: mStatusbar,
    statusBarIconBrightness:
        Brightness.dark, //<-- For Android SEE HERE (dark icons)
    statusBarBrightness: Brightness.light,
  ));

  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
  //     statusBarColor: mStatusbar, // Color for Android
  //     statusBarBrightness:
  //         Brightness.dark // Dark == white status bar -- for IOS.
  //     ));

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light) // Or Brightness.dark
      );

  init();

  //Disable right click
  document.onContextMenu.listen((event) => event.preventDefault());

  // runApp(MaterialApp(
  //   home: MyApp(),
  //   debugShowCheckedModeBanner: false,
  // ));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          onGenerateRoute: Routes.onGenerateRoute,
          locale: const Locale('en'),
          supportedLocales: const [
            Locale('en', ''),
            // Locale('ar', ''),
            // Locale('hi', '')
          ],
          localizationsDelegates: const [
            AppLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          home:
              BlocProvider(create: (_) => SplashBloc(), child: SplashScreen()),
          //SizerUtil.deviceType == DeviceType.mobile
          /*home: mIsLogin
                ? BlocProvider(
                    create: (_) =>
                        LoginBloc(mContext: context)..getMasterData(),
                    child: LoginWeb())
                : BlocProvider(
                    create: (_) => DashboardBloc(mContext: context),
                    child: DashboardWeb())*/
          // create: (_) => AngleDashboardBloc(mContext: context),
          // child: AngleDashboardWeb()),
        );
      },
    );
  }
}
