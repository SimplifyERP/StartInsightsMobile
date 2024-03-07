import 'dart:html';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:startinsights/Localization/localizations_delegate.dart';
import 'package:startinsights/Network/di.dart';
import 'package:startinsights/Screen/Dashboard/bloc/dashboard_bloc.dart';
import 'package:startinsights/Screen/Dashboard/web/dashboard.dart';
import 'package:startinsights/Screen/Login/bloc/login_bloc.dart';
import 'package:startinsights/Screen/Login/web/login.dart';
import 'package:startinsights/Screen/Register/bloc/register_bloc.dart';
import 'package:startinsights/Screen/Register/web/registerfirst.dart';
import 'package:startinsights/Screen/Register/web/registesecond.dart';
import 'package:startinsights/Screen/SearchInvestors/bloc/searchinvestors_bloc.dart';
import 'package:startinsights/Screen/SearchInvestors/web/searchinvestors.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Utils/theme.dart';
import 'package:startinsights/firebase_options.dart';
import 'package:url_strategy/url_strategy.dart';

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
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // runApp(MaterialApp(
  //   home: MyApp(),
  //   debugShowCheckedModeBanner: false,
  // ));

  setPathUrlStrategy();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final GoRouter router = GoRouter(
  //   initialLocation: '/Dashboard',
  //   routes: [
  //     GoRoute(
  //       name: "home",
  //       path: "/Dashboard",
  //       builder: (context, state) => MultiBlocProvider(
  //         providers: [
  //           BlocProvider<DashboardBloc>(
  //             create: (context) => DashboardBloc(mContext: context),
  //           )
  //         ],
  //         //child: DashboardWeb(),
  //         child: Dashboard(),
  //       ),
  //
  //       /* MultiBlocProvider(
  //         providers: [
  //           BlocProvider<SplashBloc>(
  //             create: (context) => SplashBloc(),
  //           )
  //         ],
  //         child: SplashScreen(),
  //       ),*/
  //       routes: [
  //         GoRoute(
  //           name: "settings",
  //           path: "settings",
  //           builder: (context, state) => MultiBlocProvider(
  //             providers: [
  //               BlocProvider<RegisterBloc>(
  //                 create: (context) =>
  //
  //                     // LoginBloc(mLoginRepo: LoginRepo(), mContext: context),
  //                     RegisterBloc(mContext: context),
  //               )
  //             ],
  //             child: RegisterWeb(getUserType: []),
  //           ),
  //         ),
  //       ],
  //     ),
  //   ],
  // );

  final GoRouter router = GoRouter(
    initialLocation: '/Dashboard',
    routes: <RouteBase>[
      GoRoute(
        name: "home",
        path: "/Dashboard",
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider<DashboardBloc>(
              create: (context) => DashboardBloc(mContext: context),
            )
          ],
          //child: DashboardWeb(),
          child: Dashboard(),
        ),
        /*  routes: <RouteBase>[
          GoRoute(
            path: 'album/:albumId',
            builder: (BuildContext context, GoRouterState state) {
              return AlbumScreen(
                albumId: state.pathParameters['albumId'],
              );
            },
            routes: [
              GoRoute(
                path: 'song/:songId',
                // Display on the root Navigator
                builder: (BuildContext context, GoRouterState state) {
                  return SongScreen(
                    songId: state.pathParameters['songId']!,
                  );
                },
              ),
            ],
          ),
        ],*/
      ),
      GoRoute(
          name: "Fundraising",
          path: '/Fundraising',
          builder: (context, state) => MultiBlocProvider(
                providers: [
                  BlocProvider<SearchInvestorsBloc>(
                    create: (context) =>

                        // LoginBloc(mLoginRepo: LoginRepo(), mContext: context),
                        SearchInvestorsBloc(mContext: context)
                          ..getSearchinvestorsData(1, '', '', ''),
                  )
                ],
                child: SearchInvestorsWeb(),
              )
          // routes: <RouteBase>[
          //   GoRoute(
          //     path: 'song/:songId',
          //     // Display on the root Navigator
          //     builder: (BuildContext context, GoRouterState state) {
          //       return SongScreen(
          //         songId: state.pathParameters['songId']!,
          //       );
          //     },
          //   ),
          // ],
          ),
      GoRoute(
          name: "Login",
          path: '/Login',
          builder: (context, state) => MultiBlocProvider(
                providers: [
                  BlocProvider<LoginBloc>(
                    create: (context) =>

                        // LoginBloc(mLoginRepo: LoginRepo(), mContext: context),
                        LoginBloc(mContext: context), //..getMasterData(),
                  )
                ],
                child: Login(),
              )
          // routes: <RouteBase>[
          //   GoRoute(
          //     path: 'song/:songId',
          //     // Display on the root Navigator
          //     builder: (BuildContext context, GoRouterState state) {
          //       return SongScreen(
          //         songId: state.pathParameters['songId']!,
          //       );
          //     },
          //   ),
          // ],
          ),
      GoRoute(
        name: "Register",
        path: '/Register',
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider<RegisterBloc>(
              create: (context) =>

                  // LoginBloc(mLoginRepo: LoginRepo(), mContext: context),
                  RegisterBloc(mContext: context),
            )
          ],
          child: RegisterFirst(),
        ),
        routes: <RouteBase>[
          GoRoute(
            name: "RegisterComplet",
            path: 'RegisterComplet',
            // Display on the root Navigator
            builder: (context, state) => MultiBlocProvider(
              providers: [
                BlocProvider<RegisterBloc>(
                  create: (context) =>

                      // LoginBloc(mLoginRepo: LoginRepo(), mContext: context),
                      RegisterBloc(mContext: context),
                )
              ],
              child: RegisterSecond(),
            ),
          ),
        ],
      ),
      /*  GoRoute(
        path: '/search',
        pageBuilder: (context, state) {
          final query = state.pathParameters['q'] ?? '';
          return FadeTransitionPage(
            child: SearchScreen(
              query: query,
            ),
            key: state.pageKey,
          );
        },
      ),*/
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          routerConfig: router,
          //onGenerateRoute: Routes.onGenerateRoute,
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

          // home:
          //      BlocProvider(create: (_) => SplashBloc(), child: SplashScreen()),
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

class MusicAppShell extends StatelessWidget {
  final Widget child;

  const MusicAppShell({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
    );
  }

  /* static int _calculateSelectedIndex(BuildContext context) {
    final GoRouter route = GoRouter.of(context);
    final String location = route.location;
    if (location.startsWith('/recents')) {
      return 1;
    } else if (location.startsWith('/search')) {
      return 2;
    } else {
      return 0;
    }
  }*/
}

class FadeTransitionPage extends CustomTransitionPage<void> {
  /// Creates a [FadeTransitionPage].
  FadeTransitionPage({
    required LocalKey key,
    required Widget child,
  }) : super(
            key: key,
            transitionsBuilder: (BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                    Widget child) =>
                FadeTransition(
                  opacity: animation.drive(_curveTween),
                  child: child,
                ),
            child: child);

  static final CurveTween _curveTween = CurveTween(curve: Curves.easeIn);
}
