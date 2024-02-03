import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Model/MastersResponse.dart';
import 'package:startinsights/Network/di.dart';
import 'package:startinsights/Screen/Dashboard/bloc/dashboard_bloc.dart';
import 'package:startinsights/Screen/Dashboard/bloc/dashboard_state.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Utils/StorageServiceConstant.dart';
import 'package:startinsights/Utils/pref_manager.dart';
import 'package:startinsights/Widgets/Appbar.dart';
import 'package:startinsights/Widgets/sidemenu.dart';

class DashboardWeb extends StatefulWidget {
  DashboardWeb({super.key});

  @override
  State<DashboardWeb> createState() => _DashboardWebState();
}

class _DashboardWebState extends State<DashboardWeb> {
  @override
  late DashboardBloc mDashboardBloc;
  bool checkedValue = false;
  List<UserType>? mUserTypeDataList;
  List<UserType> getUserType = <UserType>[];

  String mUserName = "Padhu NPN";

  @override
  void initState() {
    super.initState();
    loadPrefs();
  }

  loadPrefs() async {
    mUserName =
        await sl<StorageService>().getString(StorageServiceConstant.MUSERNAME);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    mDashboardBloc = DashboardBloc(mContext: context);

    return WillPopScope(
      onWillPop: () {
        //trigger leaving and use own data
        //Navigator.pop(context, false);

        //  OnLoadNext();
        //we need to return a future
        return Future.value(false);
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: Appbar(mText: "TExt", mUserImage: "", mFrom: 1),
          body: BlocConsumer<DashboardBloc, DashboardStatus>(
            listener: (context, state) {
              if (state is GetDashboardInfoSuccessState) {}
            },
            builder: (context, state) {
              return SafeArea(
                child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
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
                                        borderRadius: BorderRadius.circular(0),
                                        color: kBorderColor),
                                    child: SideMenu(mFrom: 1))),
                            Expanded(
                                flex: 9,
                                child: Container(
                                    height: MediaQuery.of(context).size.height,
                                    padding: EdgeInsets.all(10),
                                    child: SingleChildScrollView(
                                        child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                20, 1, 20, 1),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                mUserName,
                                                style: const TextStyle(
                                                    fontFamily:
                                                        'ManropeSemiBold',
                                                    fontSize: 20,
                                                    color: kTextColorTwo),
                                              ),
                                            )),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        Stack(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 200,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: Colors.white,
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      color: Colors.grey,
                                                      blurRadius: 1.0,
                                                    ),
                                                  ]),
                                              margin: const EdgeInsets.fromLTRB(
                                                  20, 1, 20, 1),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 120,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: mCardDashboard,
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      color: Colors.grey,
                                                      blurRadius: 1.0,
                                                    ),
                                                  ]),
                                              margin: const EdgeInsets.fromLTRB(
                                                  20, 1, 20, 1),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 75,
                                              margin: const EdgeInsets.fromLTRB(
                                                  20, 121, 20, 1),
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                20, 1, 20, 1),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                Languages.of(context)!
                                                    .mEarnedBadges,
                                                style: const TextStyle(
                                                    fontFamily:
                                                        'ManropeSemiBold',
                                                    fontSize: 20,
                                                    color: kTextColorTwo),
                                              ),
                                            )),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 255,
                                          margin: const EdgeInsets.fromLTRB(
                                              20, 1, 20, 1),
                                          color: Colors.white,
                                          child: Row(children: <Widget>[
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 250,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color: mWhiteColor,
                                                      border: Border.all(
                                                        color: kTextBorder,
                                                        width: 1,
                                                      )),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Image.asset(
                                                        'assets/ic_badgeicon.png',
                                                        height: 80,
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      Text(
                                                        Languages.of(context)!
                                                            .mStartupAspirant,
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                'ManropeSemiBold',
                                                            fontSize: 22,
                                                            color:
                                                                kTextColorTwo),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        Languages.of(context)!
                                                            .mYouearnedabadge,
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                'ManropeSemiBold',
                                                            fontSize: 16,
                                                            color:
                                                                kTextColorTwo),
                                                      )
                                                    ],
                                                  )),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 250,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color: mWhiteColor,
                                                      border: Border.all(
                                                        color: kTextBorder,
                                                        width: 1,
                                                      )),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Image.asset(
                                                        'assets/ic_badgeicon.png',
                                                        height: 80,
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      Text(
                                                        Languages.of(context)!
                                                            .mStartupAspirant,
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                'ManropeSemiBold',
                                                            fontSize: 22,
                                                            color:
                                                                kTextColorTwo),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        Languages.of(context)!
                                                            .mYouearnedabadge,
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                'ManropeSemiBold',
                                                            fontSize: 16,
                                                            color:
                                                                kTextColorTwo),
                                                      )
                                                    ],
                                                  )),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 250,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color: mWhiteColor,
                                                      border: Border.all(
                                                        color: kTextBorder,
                                                        width: 1,
                                                      )),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Image.asset(
                                                        'assets/ic_badgeicon.png',
                                                        height: 80,
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      Text(
                                                        Languages.of(context)!
                                                            .mStartupAspirant,
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                'ManropeSemiBold',
                                                            fontSize: 22,
                                                            color:
                                                                kTextColorTwo),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        Languages.of(context)!
                                                            .mYouearnedabadge,
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                'ManropeSemiBold',
                                                            fontSize: 16,
                                                            color:
                                                                kTextColorTwo),
                                                      )
                                                    ],
                                                  )),
                                            ),
                                          ]),
                                        )

                                        /* Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 200,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Colors.white,
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Colors.grey,
                                                  blurRadius: 1.0,
                                                ),
                                              ]),
                                          padding: const EdgeInsets.fromLTRB(
                                              1, 1, 1, 1),
                                          margin: const EdgeInsets.fromLTRB(
                                              20, 1, 20, 1),
                                          child: Column(children: <Widget>[
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .center, // set your alignment
                                                children: <Widget>[
                                                  Container(
                                                    color:
                                                        const Color(0xffCCCCCC),
                                                    width: MediaQuery.of(
                                                            context)
                                                        .size
                                                        .width, // Code to assign full width
                                                    child: const Text(
                                                        'Hello World'),
                                                  )
                                                  // Container(
                                                  //   height: 130,
                                                  //   decoration: BoxDecoration(
                                                  //       borderRadius:
                                                  //           BorderRadius
                                                  //               .circular(5),
                                                  //       color: Colors.amber,
                                                  //       boxShadow: const [
                                                  //         BoxShadow(
                                                  //           color: Colors.grey,
                                                  //           blurRadius: 1.0,
                                                  //         ),
                                                  //       ]),
                                                  // )
                                                ])
                                          ]),
                                        )*/
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

              //  ErrorToast(context: context, text: state.mDashboard.message!);

              //} else if (state is GetPunchInOutFailState) {}
              return Container();
            },
          )),
    );
  }
}
