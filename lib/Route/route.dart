import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startinsights/Screen/AngelXDashboard/bloc/angledashboard_bloc.dart';
import 'package:startinsights/Screen/AngelXDashboard/web/angledashboardweb.dart';
import 'package:startinsights/Screen/BookanExpert/bloc/bookanexpert_bloc.dart';
import 'package:startinsights/Screen/BookanExpert/web/bookanexpertweb.dart';
import 'package:startinsights/Screen/Captable/bloc/captable_bloc.dart';
import 'package:startinsights/Screen/Captable/web/captableweb.dart';
import 'package:startinsights/Screen/Dashboard/bloc/dashboard_bloc.dart';
import 'package:startinsights/Screen/ExpertBooking/bloc/expertbooking_bloc.dart';
import 'package:startinsights/Screen/ExpertBooking/web/expertbookingweb.dart';
import 'package:startinsights/Screen/InvestmentDeals/bloc/investmentdeals_bloc.dart';
import 'package:startinsights/Screen/InvestmentDeals/web/investmentdealsweb.dart';
import 'package:startinsights/Screen/Login/bloc/login_bloc.dart';
import 'package:startinsights/Screen/Login/web/loginweb.dart';
import 'package:startinsights/Screen/MyCourses/bloc/mycourses_bloc.dart';
import 'package:startinsights/Screen/MyCourses/web/coursesweb.dart';
import 'package:startinsights/Screen/PitchRoom/bloc/pitchroom_bloc.dart';
import 'package:startinsights/Screen/PitchRoom/web/pitchroom.dart';
import 'package:startinsights/Screen/Pitchcraftlist/bloc/pitchcraftlist_bloc.dart';
import 'package:startinsights/Screen/Pitchcraftlist/web/pitchcraftlistweb.dart';
import 'package:startinsights/Screen/Pitchcraftlist/web/pitchcraftmyserviceweb.dart';
import 'package:startinsights/Screen/Profile/bloc/profile_bloc.dart';
import 'package:startinsights/Screen/Profile/web/profileweb.dart';
import 'package:startinsights/Screen/Register/bloc/register_bloc.dart';
import 'package:startinsights/Screen/Register/web/registerweb.dart';
import 'package:startinsights/Screen/SearchInvestors/bloc/searchinvestors_bloc.dart';
import 'package:startinsights/Screen/SearchInvestors/web/searchinvestors.dart';
import 'package:startinsights/Screen/StartupDeals/bloc/startupdeals_bloc.dart';
import 'package:startinsights/Screen/StartupDeals/web/startupdeals.dart';
import 'package:startinsights/Screen/StartupSchool/bloc/startupschool_bloc.dart';
import 'package:startinsights/Screen/StartupSchool/web/startupschoolweb.dart';
import 'package:startinsights/Utils/screens.dart';

import '../Screen/Dashboard/web/dashboard.dart';

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
                create: (context) =>
                    LoginBloc(mContext: context)..getMasterData(),
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
            //child: DashboardWeb(),
            child: Dashboard(),
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
            //child: MyCoursesWeb(mCourseid: args![0]),
            child: CoursesWeb(mCourseid: args![0]),
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
            child: ExpertBookingWeb(mExpertid: args![0]),
          ),
        );

      case pitchcraftlistRoute:
        List<dynamic>? args = settings.arguments as List?;
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<PitchcraftlistBloc>(
                create: (context) => PitchcraftlistBloc(mContext: context)
                  // ..getexpertBookingData(args![0])
                  ..getPitchCraftListData(1),
              )
            ],
            child: PitchcraftlistWeb(),
          ),
        );

      case pitchcraftmyserviceRoute:
        List<dynamic>? args = settings.arguments as List?;
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<PitchcraftlistBloc>(
                create: (context) => PitchcraftlistBloc(mContext: context)
                  // ..getexpertBookingData(args![0])
                  ..getPitchCraftListData(2),
              )
            ],
            child: PitchcraftmyserviceWeb(),
          ),
        );

      case angledashboardRoute:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<AngleDashboardBloc>(
                create: (context) => AngleDashboardBloc(mContext: context),
              )
            ],
            child: AngleDashboardWeb(),
          ),
        );

      case investmentdealsRoute:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<InvestmentDealsBloc>(
                create: (context) => InvestmentDealsBloc(mContext: context)
                  ..getInvestmentDealsData(),
              )
            ],
            child: InvestmentDealsWeb(),
          ),
        );

      case startupdealsRoute:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<StartupdealsBloc>(
                create: (context) => StartupdealsBloc(mContext: context)
                  ..getStartupDealsListData(),
              )
            ],
            child: StartupDealsWeb(),
          ),
        );

      case pichroomRoute:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<PitchroomBloc>(
                create: (context) =>
                    PitchroomBloc(mContext: context)..getPitchroomListData(),
              )
            ],
            child: PitchroomWeb(),
          ),
        );

      case captableRoute:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<CaptableBloc>(
                create: (context) =>
                    CaptableBloc(mContext: context)..getCaptableData(),
              )
            ],
            child: CaptableWeb(),
          ),
        );

      case profileRoute:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<ProfileBloc>(
                create: (context) =>
                    ProfileBloc(mContext: context), //..getCaptableData(),
              )
            ],
            child: ProfileWeb(),
          ),
        );

      case searchinvestorRoute:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<SearchInvestorsBloc>(
                create: (context) => SearchInvestorsBloc(mContext: context)
                  ..getSearchinvestorsData(),
              )
            ],
            child: SearchInvestorsWeb(),
          ),
        );

      default:
        return null;
    }
  }
}
