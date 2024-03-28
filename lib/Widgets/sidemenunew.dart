import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Widgets/button.dart';

// MFrom 1-> dashboard  6->startupschool 8-> Startup deals  9-> Pitch room list 10->Captable
class SideMenuNew extends StatelessWidget {
  int mFrom = 0;
  BuildContext context;
  bool isExpanded;
  SideMenuNew({
    super.key,
    required this.mFrom,
    required this.context,
    required this.mchange,
    required this.isExpanded,
    //required this.isExpanded,
  });

  int selectedIndex = -1;

  //bool isExpanded;
  double sidemenubtnheight = 40;
  ValueChanged mchange;
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context1, setState) {
      return Container(
          margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.white,
                  blurRadius: 1.0,
                ),
              ]),
          child: isExpanded
              ? ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  child: SingleChildScrollView(
                    child: blackIconTiles(setState),
                  ))
              : ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  child: SingleChildScrollView(
                    child: blackIconMenu(setState),
                  ))

          //isExpanded ? blackIconTiles(setState) : blackIconMenu(setState),
          );
    });
  }

  Widget blackIconTiles(StateSetter setState) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.18,
      height: MediaQuery.of(context).size.height - 50,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            color: Colors.white,
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            height: 80,
            child: mTopView(setState),
          ),
          Container(
            color: Colors.white,
            margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Container(
                color: Colors.white,
                height: 340,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          GoRouter.of(context).go('/Dashboard');
                        },
                        child: Container(
                          height: 40,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(left: 8),
                          decoration: mFrom == 1
                              ? const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(8),
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(4),
                                      bottomRight: Radius.circular(4)),
                                  color: mBlueTwo,
                                  boxShadow: [
                                      BoxShadow(
                                        color: Colors.transparent,
                                        blurRadius: 0,
                                      ),
                                    ])
                              : null, // where to position the child
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                    flex: 10,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 10,
                                            ),
                                            mFrom == 1
                                                ? const sidemenuImage(
                                                    menuicon:
                                                        'assets/new_ic_dashboard_sel.png')
                                                : const sidemenuImage(
                                                    menuicon:
                                                        'assets/new_ic_dashboard.png'),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            SidemenuTextNew(
                                                menuname: Languages.of(context)!
                                                    .mDashboard,
                                                textColor: mFrom == 1
                                                    ? mBlackColor
                                                    : mGreyEigth,
                                                isSelect:
                                                    mFrom == 1 ? true : false,
                                                fontSize: 17.Q)

                                            //ic_dashboardwhite
                                          ]),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: ColoredBox(
                                        color: Colors.transparent,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              width: 4,
                                              height: 40,
                                              decoration: mFrom == 1
                                                  ? const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          40),
                                                              topRight: Radius
                                                                  .circular(
                                                                      40)),
                                                      color: mBlueOne,
                                                      boxShadow: [
                                                          BoxShadow(
                                                            color: Colors
                                                                .transparent,
                                                            blurRadius: 0,
                                                          ),
                                                        ])
                                                  : null,
                                            )
                                          ],
                                        ),
                                      ),
                                    )),
                              ]),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: () {
                          GoRouter.of(context).go('/Fundraising');
                        },
                        child: Container(
                          height: 40,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(left: 8),
                          decoration: mFrom == 2
                              ? const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(8),
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(4),
                                      bottomRight: Radius.circular(4)),
                                  color: mBlueTwo,
                                  boxShadow: [
                                      BoxShadow(
                                        color: Colors.transparent,
                                        blurRadius: 0,
                                      ),
                                    ])
                              : null, // where to position the child
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                    flex: 11,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 10,
                                            ),
                                            mFrom == 2
                                                ? const sidemenuImage(
                                                    menuicon:
                                                        'assets/new_ic_fundraising_sel.png')
                                                : const sidemenuImage(
                                                    menuicon:
                                                        'assets/new_ic_fundraising.png'),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            SidemenuTextNew(
                                                menuname: Languages.of(context)!
                                                    .mFundraising,
                                                textColor: mFrom == 2
                                                    ? mBlackColor
                                                    : mGreyEigth,
                                                isSelect:
                                                    mFrom == 2 ? true : false,
                                                fontSize: 17.Q)

                                            //ic_dashboardwhite
                                          ]),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: ColoredBox(
                                        color: Colors.transparent,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              width: 4,
                                              height: 40,
                                              decoration: mFrom == 2
                                                  ? const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          40),
                                                              topRight: Radius
                                                                  .circular(
                                                                      40)),
                                                      color: mBlueOne,
                                                      boxShadow: [
                                                          BoxShadow(
                                                            color: Colors
                                                                .transparent,
                                                            blurRadius: 0,
                                                          ),
                                                        ])
                                                  : null,
                                            )
                                          ],
                                        ),
                                      ),
                                    )),
                              ]),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: () {
                          GoRouter.of(context).go('/Learn');
                        },
                        child: Container(
                          height: 40,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(left: 8),
                          decoration: mFrom == 3
                              ? const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(8),
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(4),
                                      bottomRight: Radius.circular(4)),
                                  color: mBlueTwo,
                                  boxShadow: [
                                      BoxShadow(
                                        color: Colors.transparent,
                                        blurRadius: 0,
                                      ),
                                    ])
                              : null, // where to position the child
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                    flex: 10,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 10,
                                            ),
                                            mFrom == 3
                                                ? const sidemenuImage(
                                                    menuicon:
                                                        'assets/new_ic_resource_sel.png')
                                                : const sidemenuImage(
                                                    menuicon:
                                                        'assets/new_ic_resource.png'),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            SidemenuTextNew(
                                                menuname: Languages.of(context)!
                                                    .mResources,
                                                textColor: mFrom == 3
                                                    ? mBlackColor
                                                    : mGreyEigth,
                                                isSelect:
                                                    mFrom == 3 ? true : false,
                                                fontSize: 17.Q)

                                            //ic_dashboardwhite
                                          ]),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: ColoredBox(
                                        color: Colors.transparent,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              width: 4,
                                              height: 40,
                                              decoration: mFrom == 3
                                                  ? const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          40),
                                                              topRight: Radius
                                                                  .circular(
                                                                      40)),
                                                      color: mBlueOne,
                                                      boxShadow: [
                                                          BoxShadow(
                                                            color: Colors
                                                                .transparent,
                                                            blurRadius: 0,
                                                          ),
                                                        ])
                                                  : null,
                                            )
                                          ],
                                        ),
                                      ),
                                    )),
                              ]),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: () {
                          GoRouter.of(context).go('/Service');
                        },
                        child: Container(
                          height: 40,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(left: 8),
                          decoration: mFrom == 4
                              ? const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(8),
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(4),
                                      bottomRight: Radius.circular(4)),
                                  color: mBlueTwo,
                                  boxShadow: [
                                      BoxShadow(
                                        color: Colors.transparent,
                                        blurRadius: 0,
                                      ),
                                    ])
                              : null, // where to position the child
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                    flex: 10,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 10,
                                            ),
                                            mFrom == 4
                                                ? const sidemenuImage(
                                                    menuicon:
                                                        'assets/new_ic_service_sel.png')
                                                : const sidemenuImage(
                                                    menuicon:
                                                        'assets/new_ic_service.png'),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            SidemenuTextNew(
                                                menuname: Languages.of(context)!
                                                    .mServices,
                                                textColor: mFrom == 4
                                                    ? mBlackColor
                                                    : mGreyEigth,
                                                isSelect:
                                                    mFrom == 4 ? true : false,
                                                fontSize: 17.Q)

                                            //ic_dashboardwhite
                                          ]),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: ColoredBox(
                                        color: Colors.transparent,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              width: 4,
                                              height: 40,
                                              decoration: mFrom == 4
                                                  ? const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          40),
                                                              topRight: Radius
                                                                  .circular(
                                                                      40)),
                                                      color: mBlueOne,
                                                      boxShadow: [
                                                          BoxShadow(
                                                            color: Colors
                                                                .transparent,
                                                            blurRadius: 0,
                                                          ),
                                                        ])
                                                  : null,
                                            )
                                          ],
                                        ),
                                      ),
                                    )),
                              ]),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: () {
                          GoRouter.of(context).go('/Pitchroom');
                        },
                        child: Container(
                          height: 40,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(left: 8),
                          decoration: mFrom == 5
                              ? const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(8),
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(4),
                                      bottomRight: Radius.circular(4)),
                                  color: mBlueTwo,
                                  boxShadow: [
                                      BoxShadow(
                                        color: Colors.transparent,
                                        blurRadius: 0,
                                      ),
                                    ])
                              : null, // where to position the child
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                    flex: 10,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 10,
                                            ),
                                            mFrom == 5
                                                ? const sidemenuImage(
                                                    menuicon:
                                                        'assets/new_ic_tools_sel.png')
                                                : const sidemenuImage(
                                                    menuicon:
                                                        'assets/new_ic_tools.png'),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            SidemenuTextNew(
                                                menuname: Languages.of(context)!
                                                    .mTools,
                                                textColor: mFrom == 5
                                                    ? mBlackColor
                                                    : mGreyEigth,
                                                isSelect:
                                                    mFrom == 5 ? true : false,
                                                fontSize: 17.Q)

                                            //ic_dashboardwhite
                                          ]),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: ColoredBox(
                                        color: Colors.transparent,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              width: 4,
                                              height: 40,
                                              decoration: mFrom == 5
                                                  ? const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          40),
                                                              topRight: Radius
                                                                  .circular(
                                                                      40)),
                                                      color: mBlueOne,
                                                      boxShadow: [
                                                          BoxShadow(
                                                            color: Colors
                                                                .transparent,
                                                            blurRadius: 0,
                                                          ),
                                                        ])
                                                  : null,
                                            )
                                          ],
                                        ),
                                      ),
                                    )),
                              ]),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          mBottomView(),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  Widget mTopView(StateSetter setState) {
    return Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 5),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 8,
                child: Image.asset('assets/new_appicon.png',
                    width: 150, height: 40),
              ),
              Expanded(
                flex: 2,
                child: InkWell(
                    onTap: () {
                      expandOrShrinkDrawer(setState);
                    },
                    child: Image.asset(
                      'assets/new_ic_arrow.png',
                      width: 30,
                      height: 30,
                    )),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 2,
            color: mGreyThree,
            margin: const EdgeInsets.only(right: 10),
          )
        ]));
  }

  Widget mBottomView() {
    return Container(
      height: 280,
      width: double.infinity,
      child: Stack(children: <Widget>[
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: mBlueTwo,
              boxShadow: const [
                BoxShadow(
                  color: Colors.white,
                  blurRadius: 1.0,
                ),
              ]),
          margin: const EdgeInsets.fromLTRB(10, 60, 10, 0),
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 80,
              ),
              Text(
                Languages.of(context)!.mHireOurExperts,
                style: const TextStyle(
                    fontFamily: 'OpenSauceSansMedium',
                    fontSize: 20,
                    color: mBlackOne),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                Languages.of(context)!.mHireOurExpertsMsg,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'OpenSauceSansRegular',
                    fontSize: 12.Q,
                    color: mGreySeven),
              ),
              const SizedBox(
                height: 10,
              ),
              Button(
                  mButtonname: Languages.of(context)!.mFundraisingExperts,
                  onpressed: () {
                    GoRouter.of(context).go('/FundraisingExperts');
                  },
                  mSelectcolor: mBtnColor,
                  mTextColor: mWhiteColor,
                  mFontSize: 16,
                  mHovercolor: mBlueTwo,
                  mWidth: 200),
              const SizedBox(
                height: 20,
              ),
            ],
          )),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Image.asset(
            'assets/new_employee_recruit.png',
            width: 135,
            height: 135,
          ),
        ),
      ]),
    );
  }

  Widget blackIconMenu(StateSetter setState) {
    return AnimatedContainer(
        width: MediaQuery.of(context).size.width * 0.05,
        height: MediaQuery.of(context).size.height - 50,
        color: Colors.white,
        duration: const Duration(seconds: 1),
        child: Column(
          children: [
            Expanded(
                flex: 2,
                child: Container(
                    color: Colors.white,
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: mCloseTopView(setState))),
            Expanded(
              flex: 9,
              child: Container(
                color: Colors.white,
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Container(
                    color: Colors.white,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              GoRouter.of(context).go('/Dashboard');
                            },
                            child: Container(
                              height: 40,
                              alignment: Alignment.centerLeft,
                              decoration: mFrom == 1
                                  ? const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(8),
                                          topLeft: Radius.circular(8),
                                          topRight: Radius.circular(4),
                                          bottomRight: Radius.circular(4)),
                                      color: mBlueTwo,
                                      boxShadow: [
                                          BoxShadow(
                                            color: Colors.transparent,
                                            blurRadius: 0,
                                          ),
                                        ])
                                  : null, // where to position the child
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                        flex: 9,
                                        child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              mFrom == 1
                                                  ? const sidemenuImage(
                                                      menuicon:
                                                          'assets/new_ic_dashboard_sel.png')
                                                  : const sidemenuImage(
                                                      menuicon:
                                                          'assets/new_ic_dashboard.png'),

                                              //ic_dashboardwhite
                                            ])),
                                    Expanded(
                                        flex: 1,
                                        child: ColoredBox(
                                          color: Colors.transparent,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                width: 4,
                                                height: 40,
                                                decoration: mFrom == 1
                                                    ? const BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            40),
                                                                topRight: Radius
                                                                    .circular(
                                                                        40)),
                                                        color: mBlueOne,
                                                        boxShadow: [
                                                            BoxShadow(
                                                              color: Colors
                                                                  .transparent,
                                                              blurRadius: 0,
                                                            ),
                                                          ])
                                                    : null,
                                              )
                                            ],
                                          ),
                                        )),
                                  ]),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          InkWell(
                            onTap: () {
                              GoRouter.of(context).go('/Fundraising');
                            },
                            child: Container(
                              height: 40,

                              alignment: Alignment.centerRight,
                              decoration: mFrom == 2
                                  ? const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(4),
                                          bottomRight: Radius.circular(4)),
                                      color: mBlueTwo,
                                      boxShadow: [
                                          BoxShadow(
                                            color: Colors.transparent,
                                            blurRadius: 0,
                                          ),
                                        ])
                                  : null, // where to position the child
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                        flex: 9,
                                        child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              mFrom == 2
                                                  ? const sidemenuImage(
                                                      menuicon:
                                                          'assets/new_ic_fundraising_sel.png')
                                                  : const sidemenuImage(
                                                      menuicon:
                                                          'assets/new_ic_fundraising.png'),

                                              //ic_dashboardwhite
                                            ])),
                                    Expanded(
                                        flex: 1,
                                        child: ColoredBox(
                                          color: Colors.transparent,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                width: 5,
                                                height: 40,
                                                decoration: mFrom == 2
                                                    ? const BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            10),
                                                                topRight: Radius
                                                                    .circular(
                                                                        10)),
                                                        color: mBlueOne,
                                                        boxShadow: [
                                                            BoxShadow(
                                                              color: Colors
                                                                  .transparent,
                                                              blurRadius: 0,
                                                            ),
                                                          ])
                                                    : null,
                                              )
                                            ],
                                          ),
                                        )),
                                  ]),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          InkWell(
                            onTap: () {
                              GoRouter.of(context).go('/Learn');
                            },
                            child: Container(
                              height: 40,

                              alignment: Alignment.centerRight,
                              decoration: mFrom == 3
                                  ? const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(4),
                                          bottomRight: Radius.circular(4)),
                                      color: mBlueTwo,
                                      boxShadow: [
                                          BoxShadow(
                                            color: Colors.transparent,
                                            blurRadius: 0,
                                          ),
                                        ])
                                  : null, // where to position the child
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                        flex: 9,
                                        child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              mFrom == 3
                                                  ? const sidemenuImage(
                                                      menuicon:
                                                          'assets/new_ic_resource_sel.png')
                                                  : const sidemenuImage(
                                                      menuicon:
                                                          'assets/new_ic_resource.png'),

                                              //ic_dashboardwhite
                                            ])),
                                    Expanded(
                                        flex: 1,
                                        child: ColoredBox(
                                          color: Colors.transparent,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                width: 4,
                                                height: 40,
                                                decoration: mFrom == 3
                                                    ? const BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            10),
                                                                topRight: Radius
                                                                    .circular(
                                                                        10)),
                                                        color: mBlueOne,
                                                        boxShadow: [
                                                            BoxShadow(
                                                              color: Colors
                                                                  .transparent,
                                                              blurRadius: 0,
                                                            ),
                                                          ])
                                                    : null,
                                              )
                                            ],
                                          ),
                                        )),
                                  ]),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          InkWell(
                            onTap: () {
                              GoRouter.of(context).go('/Service');
                            },
                            child: Container(
                              height: 40,

                              alignment: Alignment.centerRight,

                              decoration: mFrom == 4
                                  ? const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(4),
                                          bottomRight: Radius.circular(4)),
                                      color: mBlueTwo,
                                      boxShadow: [
                                          BoxShadow(
                                            color: Colors.transparent,
                                            blurRadius: 0,
                                          ),
                                        ])
                                  : null, // where to position the child
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                        flex: 9,
                                        child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              mFrom == 4
                                                  ? const sidemenuImage(
                                                      menuicon:
                                                          'assets/new_ic_service_sel.png')
                                                  : const sidemenuImage(
                                                      menuicon:
                                                          'assets/new_ic_service.png'),

                                              //ic_dashboardwhite
                                            ])),
                                    Expanded(
                                        flex: 1,
                                        child: ColoredBox(
                                          color: Colors.transparent,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                width: 5,
                                                height: 40,
                                                decoration: mFrom == 4
                                                    ? const BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            10),
                                                                topRight: Radius
                                                                    .circular(
                                                                        10)),
                                                        color: mBlueOne,
                                                        boxShadow: [
                                                            BoxShadow(
                                                              color: Colors
                                                                  .transparent,
                                                              blurRadius: 0,
                                                            ),
                                                          ])
                                                    : null,
                                              )
                                            ],
                                          ),
                                        )),
                                  ]),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          InkWell(
                            onTap: () {
                              GoRouter.of(context).go('/Pitchroom');
                            },
                            child: Container(
                              height: 40,

                              alignment: Alignment.centerRight,

                              decoration: mFrom == 5
                                  ? const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(4),
                                          bottomRight: Radius.circular(4)),
                                      color: mBlueTwo,
                                      boxShadow: [
                                          BoxShadow(
                                            color: Colors.transparent,
                                            blurRadius: 0,
                                          ),
                                        ])
                                  : null, // where to position the child
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                        flex: 9,
                                        child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              mFrom == 5
                                                  ? const sidemenuImage(
                                                      menuicon:
                                                          'assets/new_ic_tools_sel.png')
                                                  : const sidemenuImage(
                                                      menuicon:
                                                          'assets/new_ic_tools.png'),

                                              //ic_dashboardwhite
                                            ])),
                                    Expanded(
                                        flex: 1,
                                        child: ColoredBox(
                                          color: Colors.transparent,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                width: 5,
                                                height: 40,
                                                decoration: mFrom == 5
                                                    ? const BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            10),
                                                                topRight: Radius
                                                                    .circular(
                                                                        10)),
                                                        color: mBlueOne,
                                                        boxShadow: [
                                                            BoxShadow(
                                                              color: Colors
                                                                  .transparent,
                                                              blurRadius: 0,
                                                            ),
                                                          ])
                                                    : null,
                                              )
                                            ],
                                          ),
                                        )),
                                  ]),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.white,
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                height: 80,
                child: mCloseBottomView(),
              ),
            )
          ],
        ));
  }

  Widget mCloseTopView(StateSetter setState) {
    return Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 5),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/new_ic_logo.png', width: 3.w, height: 4.h),
              InkWell(
                  onTap: () {
                    expandOrShrinkDrawer(setState);
                  },
                  child: Image.asset(
                    'assets/new_close_arrow.png',
                    width: 2.w,
                    height: 3.h,
                  ))
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 2,
            color: mGreyThree,
            margin: const EdgeInsets.only(right: 10),
          )
        ]));
  }

  /* Widget subMenuWidget(List<String> submenus, bool isValidSubMenu) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      height: isValidSubMenu ? submenus.length.toDouble() * 37.5 : 45,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: isValidSubMenu ? Colors.blue : Colors.transparent,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(8),
            bottomRight: Radius.circular(8),
          )),
      child: ListView.builder(
          padding: EdgeInsets.all(6),
          itemCount: isValidSubMenu ? submenus.length : 0,
          itemBuilder: (context, index) {
            String subMenu = submenus[index];
            return sMenuButton(subMenu, index == 0);
          }),
    );
  }

  Widget sMenuButton(String subMenu, bool isTitle) {
    return InkWell(
      onTap: () {
        //handle the function
        //if index==0? donothing: doyourlogic here
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
            onTap: () {
              debugPrint("I am child");
            },
            child: Text(
              subMenu,
              style: TextStyle(color: isTitle ? Colors.white : Colors.grey),
            )
            */ /* Txt(
              text: subMenu,
              fontSize: isTitle ? 17 : 14,
              color: isTitle ? Colors.white : Colors.grey,
              fontWeight: FontWeight.bold,
            )*/ /*
            ),
      ),
    );
  }*/

  Widget mCloseBottomView({bool usePadding = true}) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Image.asset(
        'assets/new_ic_profile.png',
        width: 160,
        height: 160,
      ),
    );
  }

  expandOrShrinkDrawer(StateSetter setState) {
    setState(() {
      isExpanded = !isExpanded;
      mchange(isExpanded);
    });
  }
}

class sidemenuImage extends StatelessWidget {
  const sidemenuImage({
    super.key,
    required this.menuicon,
  });
  final String menuicon;
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      menuicon,
      width: 20,
      height: 20,
    );
  }
}

class SidemenuTextNew extends StatelessWidget {
  const SidemenuTextNew({
    super.key,
    required this.menuname,
    required this.textColor,
    required this.isSelect,
    required this.fontSize,
  });

  final String menuname;
  final Color textColor;
  final bool isSelect;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 5, bottom: 5, top: 5),
      child: Text(menuname,
          style: TextStyle(
              fontFamily:
                  isSelect ? 'OpenSauceSansSemiBold' : 'OpenSauceSansRegular',
              fontSize: fontSize,
              color: textColor)),
    );
  }
}
//OpenSauceSansRegular  OpenSauceSansSemiBold
