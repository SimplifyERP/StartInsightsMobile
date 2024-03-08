import 'package:custom_gif_loading/custom_gif_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Model/FavouriteResponse.dart';
import 'package:startinsights/Model/PitchCraftServiceDetailsResponse.dart';
import 'package:startinsights/Model/PitchcraftlistResponse.dart';
import 'package:startinsights/Network/api_result_handler.dart';
import 'package:startinsights/Repository/SearchinvestorsRepo.dart';
import 'package:startinsights/Repository/pitchcraftlist_repo.dart';
import 'package:startinsights/Screen/Service/bloc/servicelist_bloc.dart';
import 'package:startinsights/Screen/Service/bloc/servicelist_state.dart';
import 'package:startinsights/Screen/Service/web/myservicelistitem.dart';
import 'package:startinsights/Screen/Service/web/servicelistitem.dart';
import 'package:startinsights/Utils/FontSizes.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Utils/constant_methods.dart';
import 'package:startinsights/Utils/utils.dart';
import 'package:startinsights/Widgets/Appbarnew.dart';
import 'package:startinsights/Widgets/servicebutton.dart';
import 'package:startinsights/Widgets/sidemenunew.dart';

class SearchList extends StatefulWidget {
  SearchList({super.key});

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  @override
  late ServicelistBloc mServicelistBloc;

  final SearchinvestorsRepo apiService1 = SearchinvestorsRepo();

  ValueNotifier<bool> setnotifier = ValueNotifier(true);

  List<MyService> mServiceList = [];
  List<MyService> mMyServiceList = [];
  final PitchcraftListRepo _apiService1 = PitchcraftListRepo();
  List<PitchCraftServiceDetail> mPitchCraftServiceDetail = [];
  int mShowView = 1;
  @override
  void initState() {
    super.initState();
    mLoadMasterData();
  }

  void mLoadMasterData() async {
    // Map<String, dynamic> valueMap = json.decode(await sl<StorageService>()
    //     .getString(StorageServiceConstant.MMASTERDATA));

    // SharedPreferences prefs = await SharedPreferences.getInstance();
    //
    // final getMaster =
    //     (prefs.getString(StorageServiceConstant.MMASTERDATA) ?? '');
    // Map<String, dynamic> valueMap = json.decode(getMaster);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    mServicelistBloc = ServicelistBloc(mContext: context);

    void OnLoadNext() {
      //   Navigator.pushReplacementNamed(context, dashboardRoute);
    }

    var _crossAxisSpacing = 8;
    var _screenWidth = MediaQuery.of(context).size.width;
    var _crossAxisCount = 2;
    var _width = (_screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    var cellHeight = 650;
    var _aspectRatio = _width / cellHeight;

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
          body: BlocConsumer<ServicelistBloc, ServicelistStatus>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is GetServicelistInfoSuccessState) {
                mServiceList = state.mServiceList;
                mMyServiceList = state.mMyServicelist;
              }
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
                        mFrom: 4,
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
                                mFrom: 4,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                  child: Column(
                                children: [
                                  Container(
                                    height: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.white,
                                          blurRadius: 1.0,
                                        ),
                                      ],
                                    ),
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const SizedBox(
                                                  width: 30,
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    Languages.of(context)!
                                                        .mServices,
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        fontFamily:
                                                            'OpenSauceSansSemiBold',
                                                        fontSize: mSizeFive,
                                                        color: mBlackOne),
                                                  ),
                                                )
                                              ]),
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            child: Row(
                                              //ROW 1
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const SizedBox(
                                                  width: 30,
                                                ),
                                                (mShowView == 2)
                                                    ? InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            mShowView = 1;
                                                          });
                                                        },
                                                        child: Container(
                                                            width: 180,
                                                            height: 40,
                                                            padding:
                                                                const EdgeInsets
                                                                    .fromLTRB(
                                                                    5, 5, 5, 5),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30),
                                                              color:
                                                                  Colors.white,
                                                              border:
                                                                  Border.all(
                                                                color: mGreyTen,
                                                                width: 1,
                                                              ),
                                                              boxShadow: const [
                                                                BoxShadow(
                                                                  color:
                                                                      mGreyTen,
                                                                  blurRadius: 1,
                                                                ),
                                                              ],
                                                            ),
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                SvgPicture
                                                                    .asset(
                                                                  'assets/ic_new_myservice.svg',
                                                                  width: 20,
                                                                  height: 20,
                                                                  color:
                                                                      mGreyTen,
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Text(
                                                                  Languages.of(
                                                                          context)!
                                                                      .mAllServices,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: const TextStyle(
                                                                      fontFamily:
                                                                          'OpenSauceSansMedium',
                                                                      fontSize:
                                                                          mSizeThree,
                                                                      color:
                                                                          mGreyTen),
                                                                )
                                                              ],
                                                            )),
                                                      )
                                                    : InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            mShowView = 2;
                                                          });
                                                        },
                                                        child: Container(
                                                            width: 180,
                                                            height: 40,
                                                            padding:
                                                                const EdgeInsets
                                                                    .fromLTRB(
                                                                    5, 5, 5, 5),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30),
                                                              color: mGreyTen,
                                                              boxShadow: const [
                                                                BoxShadow(
                                                                  color:
                                                                      mGreyTen,
                                                                  blurRadius: 1,
                                                                ),
                                                              ],
                                                            ),
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                SvgPicture
                                                                    .asset(
                                                                  'assets/ic_new_myservice.svg',
                                                                  width: 20,
                                                                  height: 20,
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Text(
                                                                  Languages.of(
                                                                          context)!
                                                                      .mMyServices,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: const TextStyle(
                                                                      fontFamily:
                                                                          'OpenSauceSansMedium',
                                                                      fontSize:
                                                                          mSizeThree,
                                                                      color: Colors
                                                                          .white),
                                                                )
                                                              ],
                                                            ))),
                                                Container(
                                                  width: 50,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                              const SizedBox(
                                height: 20,
                              ),
                              Visibility(
                                  visible: (mShowView == 1) ? true : false,
                                  child: Expanded(
                                    child: SingleChildScrollView(
                                      child: Container(
                                          child: Column(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
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
                                                    CrossAxisAlignment.stretch,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(
                                                        30, 10, 10, 10),
                                                    child: RichText(
                                                      text: TextSpan(
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                              text: Languages.of(
                                                                      context)!
                                                                  .mservicelink,
                                                              style: const TextStyle(
                                                                  fontFamily:
                                                                      'OpenSauceSansMedium',
                                                                  fontSize:
                                                                      mSizeThree,
                                                                  color:
                                                                      mGreyTen)),
                                                          TextSpan(
                                                              text: Languages.of(
                                                                      context)!
                                                                  .mServices,
                                                              style: const TextStyle(
                                                                  fontFamily:
                                                                      'OpenSauceSansBold',
                                                                  fontSize:
                                                                      mSizeThree,
                                                                  color:
                                                                      mGreyTen)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  Container(
                                                    color: mGreyThree,
                                                    height: 1,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(
                                                        30, 10, 50, 10),
                                                    child:
                                                        SingleChildScrollView(
                                                            child:
                                                                GridView.count(
                                                      crossAxisCount: 3,
                                                      crossAxisSpacing: 5,
                                                      // childAspectRatio: 0.3,
                                                      childAspectRatio:
                                                          _aspectRatio,

                                                      mainAxisSpacing: 5,
                                                      shrinkWrap: true,
                                                      children: List.generate(
                                                        mServiceList.length,
                                                        (index) {
                                                          final mService =
                                                              mServiceList[
                                                                  index];

                                                          return InkWell(
                                                            onTap: () {
                                                              OnLoadServiceDetais(
                                                                  mServiceList[
                                                                              index]
                                                                          .id ??
                                                                      "");
                                                            },
                                                            child:
                                                                ServiceListItem(
                                                              mIndex: index,
                                                              mMyServiceList:
                                                                  mService,
                                                              onpressed: () {
                                                                OnLoadServiceDetais(
                                                                    mServiceList[index]
                                                                            .id ??
                                                                        "");
                                                              },
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    )),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                ]),
                                          ),
                                        ],
                                      )), //
                                    ),
                                  )),
                              Visibility(
                                  visible: (mShowView == 2) ? true : false,
                                  child: Expanded(
                                    child: SingleChildScrollView(
                                      child: Container(
                                          child: Column(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
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
                                                    CrossAxisAlignment.stretch,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(
                                                        30, 10, 10, 10),
                                                    child: RichText(
                                                      text: TextSpan(
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                              text: Languages.of(
                                                                      context)!
                                                                  .mmyservicelink,
                                                              style: const TextStyle(
                                                                  fontFamily:
                                                                      'OpenSauceSansMedium',
                                                                  fontSize:
                                                                      mSizeThree,
                                                                  color:
                                                                      mGreyTen)),
                                                          TextSpan(
                                                              text: Languages.of(
                                                                      context)!
                                                                  .mMyServices,
                                                              style: const TextStyle(
                                                                  fontFamily:
                                                                      'OpenSauceSansBold',
                                                                  fontSize:
                                                                      mSizeThree,
                                                                  color:
                                                                      mGreyTen)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  Container(
                                                    color: mGreyThree,
                                                    height: 1,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(
                                                        30, 10, 50, 10),
                                                    child:
                                                        SingleChildScrollView(
                                                            child:
                                                                GridView.count(
                                                      crossAxisCount: 3,
                                                      crossAxisSpacing: 5,
                                                      // childAspectRatio: 0.3,
                                                      childAspectRatio:
                                                          _aspectRatio,

                                                      mainAxisSpacing: 5,
                                                      shrinkWrap: true,
                                                      children: List.generate(
                                                        mMyServiceList.length,
                                                        (index) {
                                                          final mService =
                                                              mMyServiceList[
                                                                  index];

                                                          return InkWell(
                                                            onTap: () {
                                                              OnLoadServiceDetais(
                                                                  mMyServiceList[
                                                                              index]
                                                                          .id ??
                                                                      "");
                                                            },
                                                            child:
                                                                MyServiceListItem(
                                                              mIndex: index,
                                                              mMyServiceList:
                                                                  mService,
                                                              onpressed: () {
                                                                OnLoadServiceDetais(
                                                                    mMyServiceList[index]
                                                                            .id ??
                                                                        "");
                                                              },
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    )),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                ]),
                                          ),
                                        ],
                                      )), //
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      )
                    ]),
              ));

              //  ErrorToast(context: context, text: state.mDashboard.message!);

              //} else if (state is GetPunchInOutFailState) {}
              return Container();
            },
          )),
    );
  }

  void OnloadChangeFav(String UserId, String InvestorId, int status) {
    Loading(mLoaderGif).start(context);
    apiService1.RemoveFavList(UserId, InvestorId, status).then((value) async {
      print(value);

      if (value is ApiSuccess) {
        if (FavouriteResponse.fromJson(value.data)!.message!.status ?? false) {
          Loading.stop();
          setState(() {});
        } else {
          Loading.stop();
          ErrorToast(context: context, text: "Error");
        }
      } else if (value is ApiFailure) {
        Loading.stop();
      }
    });
  }

  void OnLoadDialog(PitchCraftServiceDetail mMyService) {
    int mSelectView = 1;
    showGeneralDialog(
      barrierLabel: "",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      // transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return StatefulBuilder(builder: (context1, setState) {
          return Align(
            alignment: Alignment.center,
            child: Container(
              width: MediaQuery.of(context).size.width / 3,
              height: MediaQuery.of(context).size.height - 200,
              padding: const EdgeInsets.only(
                  left: 30, right: 20, bottom: 10, top: 20),
              margin: const EdgeInsets.only(left: 12, right: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: mGreyThree, width: 1)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Material(
                                color: Colors.white,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 9,
                                      child: Text(mMyService.serviceName ?? "",
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                              fontFamily: 'OpenSauceSansBold',
                                              fontSize: mSizeFour,
                                              color: mBlackTwo)),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: InkWell(
                                            focusColor: Colors.white,
                                            hoverColor: Colors.white,
                                            onTap: () {
                                              Navigator.pop(context1);
                                            },
                                            child: SvgPicture.asset(
                                              'assets/new_ic_close.svg',
                                              width: 15,
                                              height: 15,
                                            )),
                                      ),
                                    ),
                                  ],
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Material(
                              color: Colors.white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      InkWell(
                                        hoverColor: Colors.white,
                                        onTap: () {
                                          setState(() {
                                            mSelectView = 1;
                                          });
                                        },
                                        child: Container(
                                          width: 150,
                                          height: 40,
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                  Languages.of(context)!
                                                      .mAboutService,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'OpenSauceSansBold',
                                                      fontSize: mSizeFour,
                                                      color: (mSelectView == 1)
                                                          ? mS1GreenNine
                                                          : mBlackTwo))),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      InkWell(
                                        hoverColor: Colors.white,
                                        onTap: () {
                                          setState(() {
                                            mSelectView = 2;
                                          });
                                        },
                                        child: Container(
                                          width: 200,
                                          height: 40,
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                  Languages.of(context)!
                                                      .mProcessDocuments,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'OpenSauceSansBold',
                                                      fontSize: mSizeFour,
                                                      color: (mSelectView == 2)
                                                          ? mS1GreenNine
                                                          : mBlackTwo))),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 150,
                                        height: 2,
                                        child: Container(
                                          color: (mSelectView == 1)
                                              ? mS1GreenNine
                                              : Colors.transparent,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 1,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        width: 200,
                                        height: 2,
                                        child: Container(
                                          color: (mSelectView == 2)
                                              ? mS1GreenNine
                                              : Colors.transparent,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 1,
                                        ),
                                      )
                                    ],
                                  ),
                                  Material(
                                    color: Colors.white,
                                    child: Container(
                                      color: mGreyFive,
                                      width: MediaQuery.of(context).size.width,
                                      height: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            (mSelectView == 1)
                                ? Material(
                                    color: Colors.white,
                                    child: Container(
                                        height: 330,
                                        child: SingleChildScrollView(
                                          physics:
                                              AlwaysScrollableScrollPhysics(),
                                          child: Text(
                                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                  fontFamily:
                                                      'OpenSauceSansRegular',
                                                  fontSize: mSizeThree,
                                                  color: mGreyEigth,
                                                  height: 1.5)),
                                        )),
                                  )
                                : Material(
                                    color: Colors.white,
                                    child: Container(
                                        height: 330,
                                        child: SingleChildScrollView(
                                          physics:
                                              AlwaysScrollableScrollPhysics(),
                                          child: Text("",
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                  fontFamily:
                                                      'OpenSauceSansRegular',
                                                  fontSize: mSizeThree,
                                                  color: mGreyEigth,
                                                  height: 1.5)),
                                        )),
                                  ),
                          ],
                        )),
                    Expanded(
                        flex: 2,
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                color: mGreyThree,
                                height: 1,
                                width: MediaQuery.of(context).size.width,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                      flex: 5,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Material(
                                            child: Text(
                                                Languages.of(context)!.rupess,
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(
                                                    fontFamily:
                                                        'OpenSauceSansSemiBold',
                                                    fontSize: mSizeTen,
                                                    color: mBlackTwo)),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Material(
                                            child: Text(
                                                mMyService.pricing.toString() ??
                                                    "0",
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(
                                                    fontFamily:
                                                        'OpenSauceSansSemiBold',
                                                    fontSize: mSizeFive,
                                                    color: mBlackTwo)),
                                          )
                                        ],
                                      )),
                                  Expanded(
                                      flex: 5,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: ServiceButton(
                                            mButtonname: Languages.of(context)!
                                                .mAddtoService,
                                            onpressed: () {},
                                            mTextColor: mWhiteColor,
                                            mFontSize: 16,
                                            mWidth: 150,
                                            mHeigth: 40),
                                      ))
                                ],
                              )
                            ],
                          ),
                        ))
                  ]),
            ),
          );
        });
      },
    );
  }

  void OnLoadServiceDetais(String mServiceId) {
    Loading(mLoaderGif).start(context);

    _apiService1
        .getPitchcraftservicedetails("", mServiceId)
        .then((value) async {
      print(value);

      if (value is ApiSuccess) {
        Loading.stop();
        mPitchCraftServiceDetail =
            PitchCraftServiceDetailsResponse.fromJson(value.data)!
                .message!
                .pitchCraftServiceDetails!;

        OnLoadDialog(mPitchCraftServiceDetail[0]);
      } else if (value is ApiFailure) {
        Loading.stop();
      }
    });
  }
}
