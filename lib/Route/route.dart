import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startinsights/Screen/BookanExpert/bloc/bookanexpert_bloc.dart';
import 'package:startinsights/Screen/BookanExpert/web/bookanexpertweb.dart';
import 'package:startinsights/Screen/Dashboard/bloc/dashboard_bloc.dart';
import 'package:startinsights/Screen/Dashboard/web/dashboardweb.dart';
import 'package:startinsights/Screen/ExpertBooking/bloc/expertbooking_bloc.dart';
import 'package:startinsights/Screen/ExpertBooking/web/expertbookingweb.dart';
import 'package:startinsights/Screen/Login/bloc/login_bloc.dart';
import 'package:startinsights/Screen/Login/web/loginweb.dart';
import 'package:startinsights/Screen/MyCourses/bloc/mycourses_bloc.dart';
import 'package:startinsights/Screen/MyCourses/web/mycoursesweb.dart';
import 'package:startinsights/Screen/Register/bloc/register_bloc.dart';
import 'package:startinsights/Screen/Register/web/registerweb.dart';
import 'package:startinsights/Screen/StartupSchool/bloc/startupschool_bloc.dart';
import 'package:startinsights/Screen/StartupSchool/web/startupschoolweb.dart';
import 'package:startinsights/Utils/screens.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case registerRoute:
        List<dynamic>? args = settings.arguments as List?;

        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<RegisterBloc>(
                create: (context) =>

                    // LoginBloc(mLoginRepo: LoginRepo(), mContext: context),
                    RegisterBloc(mContext: context),
              )
            ],
            child: RegisterWeb(getUserType: args![0]),
          ),
        );

      case loginRoute:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<LoginBloc>(
                create: (context) => LoginBloc(mContext: context),
              )
            ],
            child: LoginWeb(),
          ),
        );

      case dashboardRoute:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<DashboardBloc>(
                create: (context) => DashboardBloc(mContext: context),
              )
            ],
            child: DashboardWeb(),
          ),
        );

      case startupSchoolRoute:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<StartupSchoolBloc>(
                create: (context) =>
                    StartupSchoolBloc(mContext: context)..getCoursesListData(),
              )
            ],
            child: StartupSchoolWeb(),
          ),
        );

      case myCoursesRoute:
        List<dynamic>? args = settings.arguments as List?;
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<MyCoursesBloc>(
                create: (context) => MyCoursesBloc(mContext: context)
                  ..getCoursesListData(args![0]),
              )
            ],
            child: MyCoursesWeb(mCourseid: args![0]),
          ),
        );

      case bookinganexpertRoute:
        // List<dynamic>? args = settings.arguments as List?;
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<BookanExpertBloc>(
                  create: (context) => BookanExpertBloc(mContext: context)
                    ..getBookanexpertListData()
                  //..getCoursesListData(args![0]),
                  )
            ],
            child: BookanexpertWeb(),
          ),
        );

      case expertbookingRoute:
        List<dynamic>? args = settings.arguments as List?;
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<ExpertBookingBloc>(
                  create: (context) => ExpertBookingBloc(mContext: context)
                    ..getexpertBookingData(args![0])
                  //..getCoursesListData(args![0]),
                  )
            ],
            child: ExpertBookingWeb(),
          ),
        );

      default:
        return null;
    }
  }
}
