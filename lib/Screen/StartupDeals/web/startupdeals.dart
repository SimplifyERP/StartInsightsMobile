import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Model/StartupDealsResponse.dart';
import 'package:startinsights/Screen/StartupDeals/bloc/startupdeals_bloc.dart';
import 'package:startinsights/Screen/StartupDeals/bloc/startupdeals_state.dart';
import 'package:startinsights/Screen/StartupDeals/web/startupdealsItem.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Utils/StorageServiceConstant.dart';
import 'package:startinsights/Utils/screens.dart';
import 'package:startinsights/Widgets/Appbar.dart';
import 'package:startinsights/Widgets/sidemenu.dart';

class StartupDealsWeb extends StatefulWidget {
  StartupDealsWeb({super.key});

  @override
  State<StartupDealsWeb> createState() => _StartupDealsState();
}

class _StartupDealsState extends State<StartupDealsWeb> {
  @override
  late StartupdealsBloc mStartupdealsBloc;
  bool checkedValue = false;
  List<Datum> mStartupDealsList = [];
  String mUserImage = "";
  String userId = "";
  @override
  void initState() {
    super.initState();
    Loadpref();
  }

  Future<void> Loadpref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    userId = (prefs.getString(StorageServiceConstant.MUSEREMAIL) ?? '');
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    mStartupdealsBloc = StartupdealsBloc(mContext: context);

    void OnLoadNext() {
      Navigator.pushReplacementNamed(context, dashboardRoute);
    }

    final ScrollController controller = ScrollController();

    return WillPopScope(
      onWillPop: () {
        //trigger leaving and use own data
        //Navigator.pop(context, false);

        OnLoadNext();
        //we need to return a future
        return Future.value(false);
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: Appbar(
            mText: "TExt",
            mUserImage: "",
            mFrom: 7,
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
              Navigator.pushReplacementNamed(context, profileRoute);
              //ErrorToast(context: context, text: "Test");
            },
            onPressedLogout: () {
              Navigator.of(context, rootNavigator: true).pop();
              Navigator.pushReplacementNamed(context, loginRoute);
            },
          ),
          body: BlocConsumer<StartupdealsBloc, StartupdealsStatus>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is GetStartupdealsInfoSuccessState) {
                mStartupDealsList = state.mDatum;

                return SafeArea(
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Container(
                      color: Colors.white,
                      margin: const EdgeInsets.only(top: 0, left: 0, right: 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            //ROW 1
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(0),
                                          color: kBorderColor),
                                      child: SideMenu(mFrom: 8))),
                              Expanded(
                                  flex: 9,
                                  child: Container(
                                      height:
                                          MediaQuery.of(context).size.height,
                                      padding: EdgeInsets.all(15),
                                      child: SingleChildScrollView(
                                          child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: RichText(
                                              text: TextSpan(
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text:
                                                          Languages.of(context)!
                                                              .mStartX,
                                                      style: const TextStyle(
                                                          fontFamily:
                                                              'ManropeBold',
                                                          fontSize: 26,
                                                          color: mBlackColor)),
                                                  TextSpan(
                                                      text:
                                                          Languages.of(context)!
                                                              .mStartupDeals,
                                                      style: const TextStyle(
                                                          fontFamily:
                                                              'ManropeBold',
                                                          fontSize: 26,
                                                          color: mBtnColor)),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          SingleChildScrollView(
                                              child: GridView.count(
                                            crossAxisCount: 3,
                                            crossAxisSpacing: 0,
                                            mainAxisSpacing: 0,
                                            //childAspectRatio: (1.1 / .9),
                                            shrinkWrap: true,
                                            children: List.generate(
                                              mStartupDealsList.length,
                                              (index) {
                                                final mgetStartupDealsList =
                                                    mStartupDealsList[index];
                                                return StartupDealsItem(
                                                  mDatumList:
                                                      mgetStartupDealsList,
                                                  mStartupdealsBloc:
                                                      mStartupdealsBloc,
                                                  context: context,
                                                  userId: userId,
                                                );
                                              },
                                            ),
                                          )),
                                          const SizedBox(
                                            height: 60,
                                          ),
                                        ],
                                      )))),
                            ],
                          ),
                          Container(),
                        ],
                      ),
                    ),
                  ),
                );
              }

              //  ErrorToast(context: context, text: state.mDashboard.message!);

              //} else if (state is GetPunchInOutFailState) {}
              return Container();
            },
          )),
    );
  }
}
