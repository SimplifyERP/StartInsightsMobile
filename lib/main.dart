import 'dart:html';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:startinsights/Localization/localizations_delegate.dart';
import 'package:startinsights/Network/di.dart';
import 'package:startinsights/Screen/Dashboard/bloc/dashboard_bloc.dart';
import 'package:startinsights/Screen/Dashboard/web/dashboard.dart';
import 'package:startinsights/Screen/ForgetPassword/bloc/forgetpwd_bloc.dart';
import 'package:startinsights/Screen/ForgetPassword/web/forgetpwd.dart';
import 'package:startinsights/Screen/ForgetPassword/web/resetpwd.dart';
import 'package:startinsights/Screen/FundabilityTest/bloc/fundabilitytest_bloc.dart';
import 'package:startinsights/Screen/FundabilityTest/web/fundabilitytest.dart';
import 'package:startinsights/Screen/Learn/bloc/learn_bloc.dart';
import 'package:startinsights/Screen/Learn/web/learnweb.dart';
import 'package:startinsights/Screen/Login/bloc/login_bloc.dart';
import 'package:startinsights/Screen/Login/mobile/loginmobile.dart';
import 'package:startinsights/Screen/Login/web/login.dart';
import 'package:startinsights/Screen/PitchRoom/bloc/pitchroom_bloc.dart';
import 'package:startinsights/Screen/PitchRoom/web/newpitchroom.dart';
import 'package:startinsights/Screen/Profile/bloc/profile_bloc.dart';
import 'package:startinsights/Screen/Profile/web/profile.dart';
import 'package:startinsights/Screen/Register/bloc/register_bloc.dart';
import 'package:startinsights/Screen/Register/web/registerfirst.dart';
import 'package:startinsights/Screen/Register/web/registesecond.dart';
import 'package:startinsights/Screen/Register/web/verificationpage.dart';
import 'package:startinsights/Screen/ReviewDeck/bloc/reviewdeck_bloc.dart';
import 'package:startinsights/Screen/ReviewDeck/web/reviewdeck.dart';
import 'package:startinsights/Screen/SearchInvestors/bloc/searchinvestors_bloc.dart';
import 'package:startinsights/Screen/SearchInvestors/web/searchinvestors.dart';
import 'package:startinsights/Screen/Service/bloc/servicelist_bloc.dart';
import 'package:startinsights/Screen/Service/web/searchlist.dart';
import 'package:startinsights/Screen/SplashScreen/bloc/splash_bloc.dart';
import 'package:startinsights/Screen/SplashScreen/splash_screen.dart';
import 'package:startinsights/Screen/StartupDeals/bloc/startupdeals_bloc.dart';
import 'package:startinsights/Screen/StartupDeals/web/startupdeals.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Utils/ResponsiveLayout.dart';
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
    //initialLocation: '/Login',
    //initialLocation: '/Dashboard',
    initialLocation: '/',
    routes: <RouteBase>[
      GoRoute(
          name: "Splashscreen",
          path: '/',
          builder: (context, state) => MultiBlocProvider(
                providers: [
                  BlocProvider<SplashBloc>(
                    create: (context) =>

                        // LoginBloc(mLoginRepo: LoginRepo(), mContext: context),
                        SplashBloc(),
                    // ..getServiceListData(1),
                  )
                ],
                child: SplashScreen(),
              )),
      GoRoute(
        name: "home",
        path: "/Dashboard",
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider<DashboardBloc>(
              create: (context) =>
                  DashboardBloc(mContext: context)..getDashboardData(),
            )
          ],
          //child: DashboardWeb(),

          child: ResponsiveLayout(
            mobileScreenLayout: const LoginMobile(),
            webScreenLayout: Dashboard(
              mFrom: state.extra as String?,
            ),
          ),
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
        name: "Deals",
        path: "/Deals",
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider<StartupdealsBloc>(
              create: (context) => StartupdealsBloc(mContext: context)
                ..getStartupDealsListData(),
            )
          ],
          //child: DashboardWeb(),

          child: StartupDealsWeb(),
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
        name: "ReviewDeck",
        path: "/ReviewDeck",
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider<ReviewDeckBloc>(
              create: (context) => ReviewDeckBloc(mContext: context),
            )
          ],
          //child: DashboardWeb(),

          child: ReviewDeck(),
        ),
      ),
      GoRoute(
        name: "FundabilityTest",
        path: "/FundabilityTest",
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider<FundabilityTestBloc>(
              create: (context) => FundabilityTestBloc(mContext: context),
            )
          ],
          //child: DashboardWeb(),

          child: FundabilityTest(),
        ),
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
                child: ResponsiveLayout(
                  mobileScreenLayout: const LoginMobile(),
                  webScreenLayout: Login(),
                ),

                /*(SizerUtil.deviceType == DeviceType.mobile)
                    ? LoginMobile()
                    : Login()*/
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
          GoRoute(
            name: "RegisterVerfication",
            path: 'RegisterVerfication',
            // Display on the root Navigator
            builder: (context, state) => MultiBlocProvider(
              providers: [
                BlocProvider<RegisterBloc>(
                  create: (context) =>

                      // LoginBloc(mLoginRepo: LoginRepo(), mContext: context),
                      RegisterBloc(mContext: context),
                )
              ],
              child: VerificationPage(),
            ),
          ),
        ],
      ),
      GoRoute(
          name: "Service",
          path: '/Service',
          builder: (context, state) => MultiBlocProvider(
                providers: [
                  BlocProvider<ServicelistBloc>(
                    create: (context) =>

                        // LoginBloc(mLoginRepo: LoginRepo(), mContext: context),
                        ServicelistBloc(mContext: context)
                          ..getServiceListData(1),
                  )
                ],
                child: SearchList(),
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
          name: "ForgetPwd",
          path: '/ForgetPwd',
          builder: (context, state) => MultiBlocProvider(
                providers: [
                  BlocProvider<ForgetPwdBloc>(
                    create: (context) =>

                        // LoginBloc(mLoginRepo: LoginRepo(), mContext: context),
                        ForgetPwdBloc(
                            mContext: context,
                            mEmailid: state.extra as String?),
                  )
                ],
                child: ForgetPwd(
                  mEmailid: state.extra as String?,
                ),
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
          name: "ResetPassword",
          path: '/ResetPassword',
          builder: (context, state) => MultiBlocProvider(
                providers: [
                  BlocProvider<ForgetPwdBloc>(
                    create: (context) =>

                        // LoginBloc(mLoginRepo: LoginRepo(), mContext: context),
                        ForgetPwdBloc(
                            mContext: context,
                            mEmailid: state.extra as String?),
                  )
                ],
                child: ResetPwd(),
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
          name: "Learn",
          path: '/Learn',
          builder: (context, state) => MultiBlocProvider(
                providers: [
                  BlocProvider<LearnBloc>(
                    create: (context) =>

                        // LoginBloc(mLoginRepo: LoginRepo(), mContext: context),
                        LearnBloc(mContext: context)..getLearnList(),
                  )
                ],
                child: LearnWeb(),
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
          name: "Pitchroom",
          path: '/Pitchroom',
          builder: (context, state) => MultiBlocProvider(
                providers: [
                  BlocProvider<PitchroomBloc>(
                    create: (context) =>

                        // LoginBloc(mLoginRepo: LoginRepo(), mContext: context),
                        PitchroomBloc(mContext: context)
                          ..getPitchroomListData(),
                  )
                ],
                child: NewPitchRoom(),
              )),
      GoRoute(
          name: "Profile",
          path: '/Profile',
          builder: (context, state) => MultiBlocProvider(
                providers: [
                  BlocProvider<ProfileBloc>(
                    create: (context) =>

                        // LoginBloc(mLoginRepo: LoginRepo(), mContext: context),
                        ProfileBloc(mContext: context),
                  )
                ],
                child: Profile(),
              )),

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
    //  return Sizer(
    return ResponsiveSizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp.router(
          scrollBehavior: const MaterialScrollBehavior().copyWith(
            dragDevices: {PointerDeviceKind.mouse},
          ),
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
