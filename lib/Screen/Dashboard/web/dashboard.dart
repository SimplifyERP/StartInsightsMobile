import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Model/MastersResponse.dart';
import 'package:startinsights/Network/di.dart';
import 'package:startinsights/Screen/Dashboard/bloc/dashboard_bloc.dart';
import 'package:startinsights/Screen/Dashboard/bloc/dashboard_state.dart';
import 'package:startinsights/Utils/FontSizes.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Utils/StorageServiceConstant.dart';
import 'package:startinsights/Utils/pref_manager.dart';
import 'package:startinsights/Widgets/Appbarnew.dart';
import 'package:startinsights/Widgets/button.dart';
import 'package:startinsights/Widgets/sidemenunew.dart';

class Dashboard extends StatefulWidget {
  Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  late DashboardBloc mDashboardBloc;
  bool checkedValue = false;
  List<UserType>? mUserTypeDataList;
  List<UserType> getUserType = <UserType>[];

  String mUserName = ""; //Padhu NPN
  ValueNotifier<bool> setnotifier = ValueNotifier(true);
  @override
  void initState() {
    super.initState();
    loadPrefs();
    sl<StorageService>().setBool(StorageServiceConstant.MLOGINSTATUS, true);
  }

  loadPrefs() async {
    // mUserName =
    //     await sl<StorageService>().getString(StorageServiceConstant.MUSERNAME);
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
          body: BlocConsumer<DashboardBloc, DashboardStatus>(
            listener: (context, state) {
              if (state is GetDashboardInfoSuccessState) {}
            },
            builder: (context, state) {
              return SafeArea(
                  child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    image: const DecorationImage(
                      image: AssetImage("assets/new_ic_background.png"),
                      fit: BoxFit.fill,
                    )),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SideMenuNew(
                        mFrom: 1,
                        context: context,
                        mchange: (value) {
                          print(value);
                          setnotifier.value = value;
                        },
                      ),
                      //invisibleSubMenus(),
                      ValueListenableBuilder(
                        valueListenable: setnotifier,
                        builder: (context, value, child) => Container(
                          width: value
                              ? MediaQuery.of(context).size.width * 0.78
                              : MediaQuery.of(context).size.width * 0.906,
                          margin: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                          padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AppbarNew(
                                mText: "TExt",
                                mUserImage: "",
                                mFrom: 1,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Container(
                                      child: Column(
                                    children: [
                                      Container(
                                        height: 180,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.white,
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.white,
                                                blurRadius: 1.0,
                                              ),
                                            ],
                                            image: const DecorationImage(
                                              image: AssetImage(
                                                  "assets/new_ic_dashboardbanner.png"),
                                              fit: BoxFit.fill,
                                            )),
                                        child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 50,
                                              ),
                                              Expanded(
                                                flex: 5,
                                                child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      RichText(
                                                        text: TextSpan(
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                                text: Languages.of(
                                                                        context)!
                                                                    .mHi,
                                                                style: const TextStyle(
                                                                    fontFamily:
                                                                        'OpenSauceSansMedium',
                                                                    fontSize:
                                                                        mSizeFive,
                                                                    color:
                                                                        mBlackOne)),
                                                            const TextSpan(
                                                                text:
                                                                    "Developer",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'OpenSauceSansMedium',
                                                                    fontSize:
                                                                        mSizeFive,
                                                                    color:
                                                                        mBlueOne)),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                          Languages.of(context)!
                                                              .mWelcomeback,
                                                          style:
                                                              const TextStyle(
                                                            fontFamily:
                                                                'OpenSauceSansBold',
                                                            decoration:
                                                                TextDecoration
                                                                    .none,
                                                            fontSize:
                                                                mSizeEight,
                                                          ))
                                                    ]),
                                              ),
                                              Expanded(
                                                flex: 5,
                                                child: Text(""),
                                              )
                                            ]),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                        height: 340,
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.white,
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.white,
                                              blurRadius: 1.0,
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                  Languages.of(context)!
                                                      .mRecommendedInvestors,
                                                  style: const TextStyle(
                                                    fontFamily:
                                                        'OpenSauceSansSemiBold',
                                                    fontSize: mSizeFive,
                                                  )),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Container(
                                                    height: 260,
                                                    width: 260,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: mGreyTwo,
                                                      boxShadow: const [
                                                        BoxShadow(
                                                          color: mGreyTwo,
                                                          blurRadius: 0,
                                                        ),
                                                      ],
                                                    ),
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Expanded(
                                                            flex: 3,
                                                            child: Container(
                                                              height: 100,
                                                              width: double
                                                                  .infinity,
                                                              child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Expanded(
                                                                      flex: 4,
                                                                      child: Stack(
                                                                          children: [
                                                                            Align(
                                                                              alignment: Alignment.center,
                                                                              child: CircleAvatar(
                                                                                radius: 35.0,
                                                                                backgroundColor: Colors.white,
                                                                                child: ClipOval(
                                                                                  child: Image.asset('assets/avathar.png', fit: BoxFit.fill),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Align(
                                                                              alignment: Alignment.topRight,
                                                                              child: Image.asset('assets/new_ic_check.png', width: 30, height: 30, fit: BoxFit.fill),
                                                                            )
                                                                          ]),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 20,
                                                                    ),
                                                                    Expanded(
                                                                      flex: 6,
                                                                      child: Column(
                                                                          crossAxisAlignment: CrossAxisAlignment
                                                                              .end,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          children: [
                                                                            Container(
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(8),
                                                                                color: mGreyThree,
                                                                                boxShadow: const [
                                                                                  BoxShadow(
                                                                                    color: mGreyThree,
                                                                                    blurRadius: 0,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              padding: const EdgeInsets.only(left: 5, right: 5),
                                                                              height: 25,
                                                                              width: (double.infinity),
                                                                              child: const Center(child: Text("Early Stage", textAlign: TextAlign.center, style: TextStyle(fontFamily: 'OpenSauceSansRegular', fontSize: mSizeThree, color: mGreyNine))),
                                                                            ),
                                                                            const SizedBox(
                                                                              height: 5,
                                                                            ),
                                                                            Container(
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(8),
                                                                                color: mGreyThree,
                                                                                boxShadow: const [
                                                                                  BoxShadow(
                                                                                    color: mGreyThree,
                                                                                    blurRadius: 0,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              height: 25,
                                                                              width: (double.infinity),
                                                                              child: const Center(child: Text("Early Stage", textAlign: TextAlign.center, style: TextStyle(fontFamily: 'OpenSauceSansRegular', fontSize: mSizeThree, color: mGreyNine))),
                                                                            )
                                                                          ]),
                                                                    )
                                                                  ]),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Expanded(
                                                            flex: 7,
                                                            child: Container(
                                                              width: double
                                                                  .infinity,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      right: 8,
                                                                      left: 8),
                                                              child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                        "Arkstons Capital",
                                                                        textAlign:
                                                                            TextAlign
                                                                                .center,
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'OpenSauceSansBold',
                                                                            fontSize:
                                                                                mSizeThree,
                                                                            color:
                                                                                mBlackOne)),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    Text(
                                                                        "Arkstons Capital",
                                                                        textAlign:
                                                                            TextAlign
                                                                                .center,
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'OpenSauceSansRegular',
                                                                            fontSize:
                                                                                mSizeTwo,
                                                                            color:
                                                                                mGreySeven)),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    Container(
                                                                      height: 1,
                                                                      color:
                                                                          mGreyThree,
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Text(
                                                                        "We invest in IoT, Fintech, SaaS, Tech, EdTech across stages. We invest in IoT, Fintech, SaaS, Tech, EdTech..........See more",
                                                                        textAlign:
                                                                            TextAlign
                                                                                .start,
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'OpenSauceSansRegular',
                                                                            fontSize:
                                                                                mSizeTwo,
                                                                            color:
                                                                                mGreySeven)),
                                                                    const SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Container(
                                                                      height: 1,
                                                                      color:
                                                                          mGreyThree,
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Image.asset(
                                                                            'assets/new_ic_money_bag.png',
                                                                            width:
                                                                                20,
                                                                            height:
                                                                                20,
                                                                            fit:
                                                                                BoxFit.fill),
                                                                        const SizedBox(
                                                                          width:
                                                                              5,
                                                                        ),
                                                                        const Center(
                                                                          child: Text(
                                                                              " 10,000 -  50,000",
                                                                              textAlign: TextAlign.start,
                                                                              style: TextStyle(fontFamily: 'OpenSauceSansRegular', fontSize: mSizeTwo, color: mGreySeven)),
                                                                        ),
                                                                      ],
                                                                    )
                                                                  ]),
                                                            ),
                                                          )
                                                        ]),
                                                  ),
                                                  Container(
                                                    height: 260,
                                                    width: 260,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: mGreyTwo,
                                                      boxShadow: const [
                                                        BoxShadow(
                                                          color: mGreyTwo,
                                                          blurRadius: 0,
                                                        ),
                                                      ],
                                                    ),
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Expanded(
                                                            flex: 3,
                                                            child: Container(
                                                              height: 100,
                                                              width: double
                                                                  .infinity,
                                                              child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Expanded(
                                                                      flex: 4,
                                                                      child: Stack(
                                                                          children: [
                                                                            Align(
                                                                              alignment: Alignment.center,
                                                                              child: CircleAvatar(
                                                                                radius: 35.0,
                                                                                backgroundColor: Colors.white,
                                                                                child: ClipOval(
                                                                                  child: Image.asset('assets/avathar.png', fit: BoxFit.fill),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Align(
                                                                              alignment: Alignment.topRight,
                                                                              child: Image.asset('assets/new_ic_check.png', width: 30, height: 30, fit: BoxFit.fill),
                                                                            )
                                                                          ]),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 20,
                                                                    ),
                                                                    Expanded(
                                                                      flex: 6,
                                                                      child: Column(
                                                                          crossAxisAlignment: CrossAxisAlignment
                                                                              .end,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          children: [
                                                                            Container(
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(8),
                                                                                color: mGreyThree,
                                                                                boxShadow: const [
                                                                                  BoxShadow(
                                                                                    color: mGreyThree,
                                                                                    blurRadius: 0,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              padding: const EdgeInsets.only(left: 5, right: 5),
                                                                              height: 25,
                                                                              width: (double.infinity),
                                                                              child: const Center(child: Text("Early Stage", textAlign: TextAlign.center, style: TextStyle(fontFamily: 'OpenSauceSansRegular', fontSize: mSizeThree, color: mGreyNine))),
                                                                            ),
                                                                            const SizedBox(
                                                                              height: 5,
                                                                            ),
                                                                            Container(
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(8),
                                                                                color: mGreyThree,
                                                                                boxShadow: const [
                                                                                  BoxShadow(
                                                                                    color: mGreyThree,
                                                                                    blurRadius: 0,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              height: 25,
                                                                              width: (double.infinity),
                                                                              child: const Center(child: Text("Early Stage", textAlign: TextAlign.center, style: TextStyle(fontFamily: 'OpenSauceSansRegular', fontSize: mSizeThree, color: mGreyNine))),
                                                                            )
                                                                          ]),
                                                                    )
                                                                  ]),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Expanded(
                                                            flex: 7,
                                                            child: Container(
                                                              width: double
                                                                  .infinity,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      right: 8,
                                                                      left: 8),
                                                              child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                        "Arkstons Capital",
                                                                        textAlign:
                                                                            TextAlign
                                                                                .center,
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'OpenSauceSansBold',
                                                                            fontSize:
                                                                                mSizeThree,
                                                                            color:
                                                                                mBlackOne)),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    Text(
                                                                        "Arkstons Capital",
                                                                        textAlign:
                                                                            TextAlign
                                                                                .center,
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'OpenSauceSansRegular',
                                                                            fontSize:
                                                                                mSizeTwo,
                                                                            color:
                                                                                mGreySeven)),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    Container(
                                                                      height: 1,
                                                                      color:
                                                                          mGreyThree,
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Text(
                                                                        "We invest in IoT, Fintech, SaaS, Tech, EdTech across stages. We invest in IoT, Fintech, SaaS, Tech, EdTech..........See more",
                                                                        textAlign:
                                                                            TextAlign
                                                                                .start,
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'OpenSauceSansRegular',
                                                                            fontSize:
                                                                                mSizeTwo,
                                                                            color:
                                                                                mGreySeven)),
                                                                    const SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Container(
                                                                      height: 1,
                                                                      color:
                                                                          mGreyThree,
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Image.asset(
                                                                            'assets/new_ic_money_bag.png',
                                                                            width:
                                                                                20,
                                                                            height:
                                                                                20,
                                                                            fit:
                                                                                BoxFit.fill),
                                                                        const SizedBox(
                                                                          width:
                                                                              5,
                                                                        ),
                                                                        const Center(
                                                                          child: Text(
                                                                              " 10,000 -  50,000",
                                                                              textAlign: TextAlign.start,
                                                                              style: TextStyle(fontFamily: 'OpenSauceSansRegular', fontSize: mSizeTwo, color: mGreySeven)),
                                                                        ),
                                                                      ],
                                                                    )
                                                                  ]),
                                                            ),
                                                          )
                                                        ]),
                                                  ),
                                                  Container(
                                                    height: 260,
                                                    width: 260,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: mGreyTwo,
                                                      boxShadow: const [
                                                        BoxShadow(
                                                          color: mGreyTwo,
                                                          blurRadius: 0,
                                                        ),
                                                      ],
                                                    ),
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Expanded(
                                                            flex: 3,
                                                            child: Container(
                                                              height: 100,
                                                              width: double
                                                                  .infinity,
                                                              child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Expanded(
                                                                      flex: 4,
                                                                      child: Stack(
                                                                          children: [
                                                                            Align(
                                                                              alignment: Alignment.center,
                                                                              child: CircleAvatar(
                                                                                radius: 35.0,
                                                                                backgroundColor: Colors.white,
                                                                                child: ClipOval(
                                                                                  child: Image.asset('assets/avathar.png', fit: BoxFit.fill),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Align(
                                                                              alignment: Alignment.topRight,
                                                                              child: Image.asset('assets/new_ic_check.png', width: 30, height: 30, fit: BoxFit.fill),
                                                                            )
                                                                          ]),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 20,
                                                                    ),
                                                                    Expanded(
                                                                      flex: 6,
                                                                      child: Column(
                                                                          crossAxisAlignment: CrossAxisAlignment
                                                                              .end,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          children: [
                                                                            Container(
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(8),
                                                                                color: mGreyThree,
                                                                                boxShadow: const [
                                                                                  BoxShadow(
                                                                                    color: mGreyThree,
                                                                                    blurRadius: 0,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              padding: const EdgeInsets.only(left: 5, right: 5),
                                                                              height: 25,
                                                                              width: (double.infinity),
                                                                              child: const Center(child: Text("Early Stage", textAlign: TextAlign.center, style: TextStyle(fontFamily: 'OpenSauceSansRegular', fontSize: mSizeThree, color: mGreyNine))),
                                                                            ),
                                                                            const SizedBox(
                                                                              height: 5,
                                                                            ),
                                                                            Container(
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(8),
                                                                                color: mGreyThree,
                                                                                boxShadow: const [
                                                                                  BoxShadow(
                                                                                    color: mGreyThree,
                                                                                    blurRadius: 0,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              height: 25,
                                                                              width: (double.infinity),
                                                                              child: const Center(child: Text("Early Stage", textAlign: TextAlign.center, style: TextStyle(fontFamily: 'OpenSauceSansRegular', fontSize: mSizeThree, color: mGreyNine))),
                                                                            )
                                                                          ]),
                                                                    )
                                                                  ]),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Expanded(
                                                            flex: 7,
                                                            child: Container(
                                                              width: double
                                                                  .infinity,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      right: 8,
                                                                      left: 8),
                                                              child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                        "Arkstons Capital",
                                                                        textAlign:
                                                                            TextAlign
                                                                                .center,
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'OpenSauceSansBold',
                                                                            fontSize:
                                                                                mSizeThree,
                                                                            color:
                                                                                mBlackOne)),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    Text(
                                                                        "Arkstons Capital",
                                                                        textAlign:
                                                                            TextAlign
                                                                                .center,
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'OpenSauceSansRegular',
                                                                            fontSize:
                                                                                mSizeTwo,
                                                                            color:
                                                                                mGreySeven)),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    Container(
                                                                      height: 1,
                                                                      color:
                                                                          mGreyThree,
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Text(
                                                                        "We invest in IoT, Fintech, SaaS, Tech, EdTech across stages. We invest in IoT, Fintech, SaaS, Tech, EdTech..........See more",
                                                                        textAlign:
                                                                            TextAlign
                                                                                .start,
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'OpenSauceSansRegular',
                                                                            fontSize:
                                                                                mSizeTwo,
                                                                            color:
                                                                                mGreySeven)),
                                                                    const SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Container(
                                                                      height: 1,
                                                                      color:
                                                                          mGreyThree,
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Image.asset(
                                                                            'assets/new_ic_money_bag.png',
                                                                            width:
                                                                                20,
                                                                            height:
                                                                                20,
                                                                            fit:
                                                                                BoxFit.fill),
                                                                        const SizedBox(
                                                                          width:
                                                                              5,
                                                                        ),
                                                                        const Center(
                                                                          child: Text(
                                                                              " 10,000 -  50,000",
                                                                              textAlign: TextAlign.start,
                                                                              style: TextStyle(fontFamily: 'OpenSauceSansRegular', fontSize: mSizeTwo, color: mGreySeven)),
                                                                        ),
                                                                      ],
                                                                    )
                                                                  ]),
                                                            ),
                                                          )
                                                        ]),
                                                  ),
                                                  Container(
                                                    height: 260,
                                                    width: 260,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: mGreyTwo,
                                                      boxShadow: const [
                                                        BoxShadow(
                                                          color: mGreyTwo,
                                                          blurRadius: 0,
                                                        ),
                                                      ],
                                                    ),
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Expanded(
                                                            flex: 3,
                                                            child: Container(
                                                              height: 100,
                                                              width: double
                                                                  .infinity,
                                                              child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Expanded(
                                                                      flex: 4,
                                                                      child: Stack(
                                                                          children: [
                                                                            Align(
                                                                              alignment: Alignment.center,
                                                                              child: CircleAvatar(
                                                                                radius: 35.0,
                                                                                backgroundColor: Colors.white,
                                                                                child: ClipOval(
                                                                                  child: Image.asset('assets/avathar.png', fit: BoxFit.fill),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Align(
                                                                              alignment: Alignment.topRight,
                                                                              child: Image.asset('assets/new_ic_check.png', width: 30, height: 30, fit: BoxFit.fill),
                                                                            )
                                                                          ]),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 20,
                                                                    ),
                                                                    Expanded(
                                                                      flex: 6,
                                                                      child: Column(
                                                                          crossAxisAlignment: CrossAxisAlignment
                                                                              .end,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          children: [
                                                                            Container(
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(8),
                                                                                color: mGreyThree,
                                                                                boxShadow: const [
                                                                                  BoxShadow(
                                                                                    color: mGreyThree,
                                                                                    blurRadius: 0,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              padding: const EdgeInsets.only(left: 5, right: 5),
                                                                              height: 25,
                                                                              width: (double.infinity),
                                                                              child: const Center(child: Text("Early Stage", textAlign: TextAlign.center, style: TextStyle(fontFamily: 'OpenSauceSansRegular', fontSize: mSizeNine, color: mGreyNine))),
                                                                            ),
                                                                            const SizedBox(
                                                                              height: 5,
                                                                            ),
                                                                            Container(
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(8),
                                                                                color: mGreyThree,
                                                                                boxShadow: const [
                                                                                  BoxShadow(
                                                                                    color: mGreyThree,
                                                                                    blurRadius: 0,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              height: 25,
                                                                              width: (double.infinity),
                                                                              child: const Center(child: Text("Early Stage", textAlign: TextAlign.center, style: TextStyle(fontFamily: 'OpenSauceSansRegular', fontSize: mSizeNine, color: mGreyNine))),
                                                                            )
                                                                          ]),
                                                                    )
                                                                  ]),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Expanded(
                                                            flex: 7,
                                                            child: Container(
                                                              width: double
                                                                  .infinity,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      right: 8,
                                                                      left: 8),
                                                              child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                        "Arkstons Capital",
                                                                        textAlign:
                                                                            TextAlign
                                                                                .center,
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'OpenSauceSansBold',
                                                                            fontSize:
                                                                                mSizeThree,
                                                                            color:
                                                                                mBlackOne)),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    Text(
                                                                        "Arkstons Capital",
                                                                        textAlign:
                                                                            TextAlign
                                                                                .center,
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'OpenSauceSansRegular',
                                                                            fontSize:
                                                                                mSizeTwo,
                                                                            color:
                                                                                mGreySeven)),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    Container(
                                                                      height: 1,
                                                                      color:
                                                                          mGreyThree,
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Text(
                                                                        "We invest in IoT, Fintech, SaaS, Tech, EdTech across stages. We invest in IoT, Fintech, SaaS, Tech, EdTech..........See more",
                                                                        textAlign:
                                                                            TextAlign
                                                                                .start,
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'OpenSauceSansRegular',
                                                                            fontSize:
                                                                                mSizeTwo,
                                                                            color:
                                                                                mGreySeven)),
                                                                    const SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Container(
                                                                      height: 1,
                                                                      color:
                                                                          mGreyThree,
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Image.asset(
                                                                            'assets/new_ic_money_bag.png',
                                                                            width:
                                                                                20,
                                                                            height:
                                                                                20,
                                                                            fit:
                                                                                BoxFit.fill),
                                                                        const SizedBox(
                                                                          width:
                                                                              5,
                                                                        ),
                                                                        const Center(
                                                                          child: Text(
                                                                              " 10,000 -  50,000",
                                                                              textAlign: TextAlign.start,
                                                                              style: TextStyle(fontFamily: 'OpenSauceSansRegular', fontSize: mSizeTwo, color: mGreySeven)),
                                                                        ),
                                                                      ],
                                                                    )
                                                                  ]),
                                                            ),
                                                          )
                                                        ]),
                                                  ),
                                                ],
                                              )
                                            ]),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Container(
                                              height: 280,
                                              width: double.infinity,
                                              padding: const EdgeInsets.all(15),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.white,
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Colors.white,
                                                    blurRadius: 1.0,
                                                  ),
                                                ],
                                              ),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                        Languages.of(context)!
                                                            .mCheckyourFundability,
                                                        style: const TextStyle(
                                                          fontFamily:
                                                              'OpenSauceSansSemiBold',
                                                          fontSize: mSizeFive,
                                                        )),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    Container(
                                                      height: 200,
                                                      width: double.infinity,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        color: mGreyTwo,
                                                        boxShadow: const [
                                                          BoxShadow(
                                                            color: Colors.white,
                                                            blurRadius: 1.0,
                                                          ),
                                                        ],
                                                      ),
                                                      child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Image.asset(
                                                              'assets/new_ic_checkscore.png',
                                                              height: 120,
                                                              width: 150,
                                                            ),
                                                            Button(
                                                                mButtonname:
                                                                    Languages.of(
                                                                            context)!
                                                                        .mCheckyourScore,
                                                                onpressed:
                                                                    () {},
                                                                mSelectcolor:
                                                                    mBtnColor,
                                                                mTextColor:
                                                                    mWhiteColor,
                                                                mFontSize:
                                                                    mSizeTen,
                                                                mWidth: 200,
                                                                mHeigth: 40),
                                                          ]),
                                                    )
                                                  ]),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Container(
                                              height: 280,
                                              width: double.infinity,
                                              padding: const EdgeInsets.all(15),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.white,
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Colors.white,
                                                    blurRadius: 1.0,
                                                  ),
                                                ],
                                              ),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                        Languages.of(context)!
                                                            .mReviewYouPitchDeck,
                                                        style: const TextStyle(
                                                          fontFamily:
                                                              'OpenSauceSansSemiBold',
                                                          fontSize: mSizeFive,
                                                        )),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    Container(
                                                      height: 200,
                                                      width: double.infinity,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        color: mGreyTwo,
                                                        boxShadow: const [
                                                          BoxShadow(
                                                            color: Colors.white,
                                                            blurRadius: 1.0,
                                                          ),
                                                        ],
                                                      ),
                                                      child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Image.asset(
                                                              'assets/new_ic_upload.png',
                                                              height: 80,
                                                              width: 80,
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                                Languages.of(
                                                                        context)!
                                                                    .mUploadyourpitchdeckordraganddrophere,
                                                                style: const TextStyle(
                                                                    fontFamily:
                                                                        'OpenSauceSansRegular',
                                                                    fontSize:
                                                                        mSizeTwo,
                                                                    color:
                                                                        mGreySeven)),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                                Languages.of(
                                                                        context)!
                                                                    .mAcceptsPDFfilesupto,
                                                                style: const TextStyle(
                                                                    fontFamily:
                                                                        'OpenSauceSansRegular',
                                                                    fontSize:
                                                                        mSizeTwo,
                                                                    color:
                                                                        mGreySeven)),
                                                          ]),
                                                    )
                                                  ]),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Container(
                                              height: 280,
                                              width: double.infinity,
                                              padding: const EdgeInsets.all(15),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.white,
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Colors.white,
                                                    blurRadius: 1.0,
                                                  ),
                                                ],
                                              ),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                        Languages.of(context)!
                                                            .mReviewYouPitchDeck,
                                                        style: const TextStyle(
                                                          fontFamily:
                                                              'OpenSauceSansSemiBold',
                                                          fontSize: mSizeFive,
                                                        )),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    Container(
                                                      height: 200,
                                                      width: double.infinity,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        color: mGreyTwo,
                                                        boxShadow: const [
                                                          BoxShadow(
                                                            color: Colors.white,
                                                            blurRadius: 1.0,
                                                          ),
                                                        ],
                                                      ),
                                                      child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Image.asset(
                                                              'assets/new_ic_upload.png',
                                                              height: 80,
                                                              width: 80,
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                                Languages.of(
                                                                        context)!
                                                                    .mUploadyourpitchdeckordraganddrophere,
                                                                style: const TextStyle(
                                                                    fontFamily:
                                                                        'OpenSauceSansRegular',
                                                                    fontSize:
                                                                        mSizeTwo,
                                                                    color:
                                                                        mGreySeven)),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                                Languages.of(
                                                                        context)!
                                                                    .mAcceptsPDFfilesupto,
                                                                style: const TextStyle(
                                                                    fontFamily:
                                                                        'OpenSauceSansRegular',
                                                                    fontSize:
                                                                        mSizeTwo,
                                                                    color:
                                                                        mGreySeven)),
                                                          ]),
                                                    )
                                                  ]),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  )), //
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ]),
              ));
//
              //  ErrorToast(context: context, text: state.mDashboard.message!);

              //} else if (state is GetPunchInOutFailState) {}
              return Container();
            },
          )),
    );
  }
}
