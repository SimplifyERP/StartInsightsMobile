import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  document.onContextMenu.listen((event) => event.preventDefault());

  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool mIsLogin = false;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool value = prefs.getBool('counter') ?? false;
    // mIsLogin =
    //     await sl<StorageService>().getBool(StorageServiceConstant.MLOGINSTATUS);
    setState(() {
      // mIsLogin = (prefs.getBool(StorageServiceConstant.MLOGINSTATUS) ?? false);
      print(value);
    });
  }

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
/*class MyApp extends StatelessWidget {
  MyApp({super.key});
  bool mIsLogin = false;

  @override
  void initState() {
    onLoad();
  }

  onLoad() async {
    mIsLogin = await sl<StorageService>()
            .getString(StorageServiceConstant.MLOGINSTATUS) ??
        false;
    print(mIsLogin);
  }

  // This widget is the root of your application.
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
          //SizerUtil.deviceType == DeviceType.mobile
          home: mIsLogin
              ? BlocProvider(
                  create: (_) => LoginBloc(mContext: context)..getMasterData(),
                  child: LoginWeb())
              : BlocProvider(
                  create: (_) => DashboardBloc(mContext: context),
                  child: DashboardWeb()),
        );
      },
    );

    Future<void> onLoad() async {
      mIsLogin = await sl<StorageService>()
              .getString(StorageServiceConstant.MLOGINSTATUS) ??
          false;
      print(mIsLogin);
    }
  }
}*/

/* BlocProvider(
                  create: (_) => LoginBloc(mContext: context)..getMasterData(),
                  child: SizerUtil.deviceType == DeviceType.mobile
                      ? LoginMobile()
                      : LoginWeb())*/
