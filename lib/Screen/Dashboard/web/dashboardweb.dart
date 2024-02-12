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
    // loadPrefs();
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
                                        Container(
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
                                          margin: const EdgeInsets.fromLTRB(
                                              20, 1, 20, 1),
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  flex: 5,
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(0),
                                                        color: mCardDashboard,
                                                        boxShadow: const [
                                                          BoxShadow(
                                                            color: Colors.grey,
                                                            blurRadius: 1.0,
                                                          ),
                                                        ]),
                                                    child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            mUserName,
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    'ManropeSemiBold',
                                                                fontSize: 26,
                                                                color:
                                                                    kTextColorTwo),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            "Lorem Ipsum Content",
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    'ManropeSemiBold',
                                                                fontSize: 20,
                                                                color:
                                                                    kTextColorTwo),
                                                          )
                                                        ]),
                                                  ),
                                                ),
                                                Expanded(
                                                    flex: 5,
                                                    child: Center(
                                                      child: Stack(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              const SizedBox(
                                                                width: 30,
                                                              ),
                                                              Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                        .fromLTRB(
                                                                        0,
                                                                        30,
                                                                        0,
                                                                        20),
                                                                width: 340,
                                                                height: 20,
                                                                child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topRight,
                                                                    child: Image
                                                                        .asset(
                                                                      'assets/ic_polygon.png',
                                                                      height:
                                                                          40,
                                                                    )),
                                                              ),
                                                              Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                        .fromLTRB(
                                                                        0,
                                                                        30,
                                                                        0,
                                                                        20),
                                                                width: 350,
                                                                height: 20,
                                                                child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topRight,
                                                                    child: Image
                                                                        .asset(
                                                                      'assets/ic_polygon.png',
                                                                      height:
                                                                          40,
                                                                    )),
                                                              ),
                                                              Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                        .fromLTRB(
                                                                        0,
                                                                        30,
                                                                        0,
                                                                        20),
                                                                width: 340,
                                                                height: 20,
                                                                child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topRight,
                                                                    child: Image
                                                                        .asset(
                                                                      'assets/ic_polygon.png',
                                                                      height:
                                                                          40,
                                                                    )),
                                                              )
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              const SizedBox(
                                                                width: 30,
                                                              ),
                                                              Container(
                                                                margin: const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        20),
                                                                width: 350,
                                                                height: 20,
                                                                child:
                                                                    const ClipRRect(
                                                                  borderRadius: BorderRadius.only(
                                                                      bottomLeft:
                                                                          Radius.circular(
                                                                              10),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              0),
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              10),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              0)),
                                                                  child:
                                                                      LinearProgressIndicator(
                                                                    value: 1,
                                                                    valueColor:
                                                                        AlwaysStoppedAnimation<Color>(
                                                                            kprogressbarstartupschool),
                                                                    backgroundColor:
                                                                        kprogressbarbg,
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                        .fromLTRB(
                                                                        0,
                                                                        20,
                                                                        0,
                                                                        20),
                                                                width: 350,
                                                                height: 20,
                                                                child:
                                                                    const ClipRRect(
                                                                  borderRadius: BorderRadius.only(
                                                                      bottomLeft:
                                                                          Radius.circular(
                                                                              0),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              0),
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              0),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              0)),
                                                                  child:
                                                                      LinearProgressIndicator(
                                                                    value: 0.9,
                                                                    valueColor:
                                                                        AlwaysStoppedAnimation<Color>(
                                                                            kprogressbarpitchcraft),
                                                                    backgroundColor:
                                                                        kprogressbarbg,
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                        .fromLTRB(
                                                                        0,
                                                                        20,
                                                                        20,
                                                                        20),
                                                                width: 350,
                                                                height: 20,
                                                                child:
                                                                    const ClipRRect(
                                                                  borderRadius: BorderRadius.only(
                                                                      bottomLeft:
                                                                          Radius.circular(
                                                                              0),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              10),
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              0),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              10)),
                                                                  child:
                                                                      LinearProgressIndicator(
                                                                    value: 0.5,
                                                                    valueColor:
                                                                        AlwaysStoppedAnimation<Color>(
                                                                            kprogressbarmockpitch),
                                                                    backgroundColor:
                                                                        kprogressbarbg,
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              const SizedBox(
                                                                width: 30,
                                                              ),
                                                              Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                        .fromLTRB(
                                                                        0,
                                                                        50,
                                                                        0,
                                                                        20),
                                                                width: 360,
                                                                height: 20,
                                                                child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topRight,
                                                                    child: Text(
                                                                        Languages.of(context)!
                                                                            .mStartupSchool,
                                                                        style: const TextStyle(
                                                                            fontFamily:
                                                                                'ManropeSemiBold',
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                mBlackColor))),
                                                              ),
                                                              Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                        .fromLTRB(
                                                                        0,
                                                                        50,
                                                                        0,
                                                                        20),
                                                                width: 360,
                                                                height: 20,
                                                                child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topRight,
                                                                    child: Text(
                                                                        Languages.of(context)!
                                                                            .mPitchCraft,
                                                                        style: const TextStyle(
                                                                            fontFamily:
                                                                                'ManropeSemiBold',
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                mBlackColor))),
                                                              ),
                                                              Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                        .fromLTRB(
                                                                        0,
                                                                        50,
                                                                        0,
                                                                        20),
                                                                width: 360,
                                                                height: 20,
                                                                child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topRight,
                                                                    child: Text(
                                                                        Languages.of(context)!
                                                                            .mMockPitch,
                                                                        style: const TextStyle(
                                                                            fontFamily:
                                                                                'ManropeSemiBold',
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                mBlackColor))),
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    )),
                                              ]),
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
