import 'package:custom_gif_loading/custom_gif_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_network/image_network.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_web/razorpay_web.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Model/CommonResponse.dart';
import 'package:startinsights/Model/FavouriteResponse.dart';
import 'package:startinsights/Model/ServiceDetailsResponse.dart';
import 'package:startinsights/Model/ServiceListResponse.dart';
import 'package:startinsights/Network/api_result_handler.dart';
import 'package:startinsights/Repository/SearchinvestorsRepo.dart';
import 'package:startinsights/Repository/pitchcraftlist_repo.dart';
import 'package:startinsights/Screen/Service/bloc/servicelist_bloc.dart';
import 'package:startinsights/Screen/Service/bloc/servicelist_state.dart';
import 'package:startinsights/Screen/Service/web/TrackingItem.dart';
import 'package:startinsights/Screen/Service/web/myservicelistitem.dart';
import 'package:startinsights/Screen/Service/web/servicelistitem.dart';
import 'package:startinsights/Utils/FontSizes.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Utils/constant_methods.dart';
import 'package:startinsights/Utils/utils.dart';
import 'package:startinsights/Widgets/Appbarnew.dart';
import 'package:startinsights/Widgets/button.dart';
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

  List<MyServices> mServiceList = [];
  List<MyServices> mMyServiceList = [];
  final PitchcraftListRepo _apiService1 = PitchcraftListRepo();
  List<MyServiceDetail> mServiceDetail = [];
  late ServiceDetailsMessage mServiceDetailsMessage;
  int mShowView = 1;
  late Razorpay _razorpay;
  late BuildContext mcontext;
  late BuildContext mAlertDialogcontext;
  var mPitchcraftid = "";
  var mAmount = 0;
  @override
  void initState() {
    super.initState();
    mLoadMasterData();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
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
                                                            // OnLoadPaymentSuccess();
                                                            // OnLoadPaymentFail();
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
                                                              OnLoadDialog(
                                                                  mServiceList[
                                                                      index]);
                                                            },
                                                            child:
                                                                ServiceListItem(
                                                              mIndex: index,
                                                              mMyServiceList:
                                                                  mService,
                                                              onPaymentClick:
                                                                  () {
                                                                setState(() {
                                                                  mAlertDialogcontext =
                                                                      context;
                                                                  mPitchcraftid =
                                                                      mServiceList[index]
                                                                              .id ??
                                                                          "";
                                                                  mAmount =
                                                                      mServiceList[index]
                                                                              .pricing ??
                                                                          0;

                                                                  openCheckout(
                                                                      mServiceList[index]
                                                                              .pricing ??
                                                                          0,
                                                                      context);
                                                                });
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
                                                            onTap: () {},
                                                            child:
                                                                MyServiceListItem(
                                                              mIndex: index,
                                                              mMyServiceList:
                                                                  mService,
                                                              onpressed: () {
                                                                OnLoadServiceDetais(
                                                                    mMyServiceList[index]
                                                                            .id ??
                                                                        "",
                                                                    setState);
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
                              (mServiceDetail.isNotEmpty)
                                  ? Visibility(
                                      visible: (mShowView == 3) ? true : false,
                                      child: Expanded(
                                        child: ScrollConfiguration(
                                            behavior:
                                                ScrollConfiguration.of(context)
                                                    .copyWith(
                                                        scrollbars: false),
                                            child: SingleChildScrollView(
                                              child: Container(
                                                  child: Column(
                                                children: [
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height +
                                                            100,
                                                    padding: EdgeInsets.only(
                                                        bottom: 10),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          width: 1,
                                                          color: mGreyFour),
                                                      boxShadow: const [
                                                        BoxShadow(
                                                          color: Colors.white,
                                                          blurRadius: 1.0,
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
                                                          Container(
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            height: 60,
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    right: 20,
                                                                    left: 20),
                                                            decoration:
                                                                const BoxDecoration(
                                                              borderRadius: BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          20),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          20)),
                                                              color: mGreyTwo,
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color:
                                                                      mGreyTwo,
                                                                  blurRadius:
                                                                      1.0,
                                                                ),
                                                              ],
                                                            ),
                                                            child: Center(
                                                                child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                  Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Expanded(
                                                                            flex:
                                                                                5,
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                InkWell(
                                                                                  onTap: () {
                                                                                    setState(() {
                                                                                      mShowView = 2;
                                                                                    });
                                                                                  },
                                                                                  child: SvgPicture.asset(
                                                                                    'assets/new_ic_serice_back.svg',
                                                                                    width: 30,
                                                                                    height: 30,
                                                                                  ),
                                                                                ),
                                                                                const SizedBox(
                                                                                  width: 10,
                                                                                ),
                                                                                Text(
                                                                                  Languages.of(context)!.mFundraisingsession,
                                                                                  textAlign: TextAlign.center,
                                                                                  style: const TextStyle(fontFamily: 'OpenSauceSansSemiBold', fontSize: mSizeFour, color: mBlackTwo),
                                                                                )
                                                                              ],
                                                                            )),
                                                                        Expanded(
                                                                            flex:
                                                                                5,
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                Container(
                                                                                  width: 150,
                                                                                  height: 30,
                                                                                  padding: const EdgeInsets.only(right: 20, left: 20),
                                                                                  decoration: BoxDecoration(
                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                    color: SetBackgroungColor(mServiceDetail[0].serviceStatus ?? ""),
                                                                                    boxShadow: const [
                                                                                      BoxShadow(
                                                                                        color: mGreyTwo,
                                                                                        blurRadius: 1.0,
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  child: Center(
                                                                                      child: Text(
                                                                                    mServiceDetail[0].serviceStatus ?? "",
                                                                                    textAlign: TextAlign.center,
                                                                                    style: TextStyle(fontFamily: 'OpenSauceSansMedium', fontSize: mSizeThree, color: SetTextColor(mServiceDetail[0].serviceStatus ?? "")),
                                                                                  )),
                                                                                ),
                                                                                const SizedBox(
                                                                                  width: 30,
                                                                                ),
                                                                                Container(
                                                                                  width: 140,
                                                                                  height: 30,
                                                                                  padding: const EdgeInsets.only(right: 20, left: 20),
                                                                                  decoration: BoxDecoration(
                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                    color: Colors.white,
                                                                                    boxShadow: const [
                                                                                      BoxShadow(
                                                                                        color: Colors.white,
                                                                                        blurRadius: 1.0,
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  child: Center(
                                                                                      child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                                    children: [
                                                                                      SvgPicture.asset(
                                                                                        'assets/new_ic_support.svg',
                                                                                        width: 15,
                                                                                        height: 15,
                                                                                      ),
                                                                                      const SizedBox(
                                                                                        width: 10,
                                                                                      ),
                                                                                      Text(
                                                                                        Languages.of(context)!.mGetSupport,
                                                                                        textAlign: TextAlign.center,
                                                                                        style: const TextStyle(fontFamily: 'OpenSauceSansMedium', fontSize: mSizeTwo, color: mGreyNine),
                                                                                      )
                                                                                    ],
                                                                                  )),
                                                                                ),
                                                                                const SizedBox(
                                                                                  width: 30,
                                                                                ),
                                                                              ],
                                                                            ))
                                                                      ])
                                                                ])),
                                                          ),
                                                          Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Expanded(
                                                                  flex: 4,
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Container(
                                                                        width: MediaQuery.of(context)
                                                                            .size
                                                                            .width,
                                                                        height:
                                                                            550,
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            left:
                                                                                10,
                                                                            top:
                                                                                20,
                                                                            right:
                                                                                10),
                                                                        margin: const EdgeInsets
                                                                            .only(
                                                                            left:
                                                                                15,
                                                                            top:
                                                                                20,
                                                                            bottom:
                                                                                10,
                                                                            right:
                                                                                10),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(20),
                                                                          color:
                                                                              Colors.white,
                                                                          border: Border.all(
                                                                              width: 1,
                                                                              color: mGreyFour),
                                                                          boxShadow: const [
                                                                            BoxShadow(
                                                                              color: Colors.white,
                                                                              blurRadius: 1.0,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        child: ScrollConfiguration(
                                                                            behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                                                                            child: ListView.builder(
                                                                              scrollDirection: Axis.vertical,
                                                                              shrinkWrap: true,
                                                                              itemBuilder: ((context, index) {
                                                                                final mservicedetails = mServiceDetail[0].serviceTracking![index];
                                                                                return TrackingItem(mTotalview: mServiceDetail[0].serviceTracking!.length, mCurrentview: index, mServiceTracking: mservicedetails, mServiceDetailsMessage: mServiceDetailsMessage);
                                                                              }),
                                                                              itemCount: mServiceDetail[0].serviceTracking!.length,
                                                                            )),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      Container(
                                                                        width: MediaQuery.of(context)
                                                                            .size
                                                                            .width,
                                                                        height:
                                                                            160,
                                                                        margin: const EdgeInsets
                                                                            .only(
                                                                            left:
                                                                                15,
                                                                            top:
                                                                                15,
                                                                            right:
                                                                                10),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(20),
                                                                          color:
                                                                              mBlueTwo,
                                                                          border: Border.all(
                                                                              width: 1,
                                                                              color: mBlueOne),
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
                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                            children: [
                                                                              Expanded(
                                                                                  flex: 7,
                                                                                  child: Row(
                                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    children: [
                                                                                      const SizedBox(
                                                                                        width: 20,
                                                                                      ),
                                                                                      Align(
                                                                                        alignment: Alignment.center,
                                                                                        child: CircleAvatar(
                                                                                          radius: 40.0,
                                                                                          backgroundColor: Colors.white,
                                                                                          child: ClipOval(
                                                                                            child: (mServiceDetailsMessage.assignedUser!.image!.isNotEmpty)
                                                                                                ? ImageNetwork(
                                                                                                    image: mServiceDetailsMessage.assignedUser!.image! ?? "",
                                                                                                    height: 100,
                                                                                                    width: 100,
                                                                                                  )
                                                                                                : Image.asset('assets/avathar.png', width: 100, height: 100, fit: BoxFit.fill),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      const SizedBox(
                                                                                        width: 15,
                                                                                      ),
                                                                                      Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                        children: [
                                                                                          Text(
                                                                                            mServiceDetailsMessage.assignedUser!.userName!,
                                                                                            textAlign: TextAlign.left,
                                                                                            style: const TextStyle(fontFamily: 'OpenSauceSansSemiBold', fontSize: mSizeFour, color: mBlackTwo),
                                                                                          ),
                                                                                          SizedBox(
                                                                                            height: 5,
                                                                                          ),
                                                                                          Text(
                                                                                            mServiceDetailsMessage.assignedUser!.designation!,
                                                                                            textAlign: TextAlign.left,
                                                                                            style: const TextStyle(fontFamily: 'OpenSauceSansRegular', fontSize: mSizeTwo, color: mBlueOne),
                                                                                          )
                                                                                        ],
                                                                                      )
                                                                                    ],
                                                                                  )),
                                                                              Expanded(
                                                                                  flex: 3,
                                                                                  child: Center(
                                                                                      child: Row(
                                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: [
                                                                                      Container(
                                                                                        width: 150,
                                                                                        height: 30,
                                                                                        padding: const EdgeInsets.only(right: 20, left: 20),
                                                                                        decoration: BoxDecoration(
                                                                                          borderRadius: BorderRadius.circular(10),
                                                                                          color: Colors.white,
                                                                                          boxShadow: const [
                                                                                            BoxShadow(
                                                                                              color: Colors.white,
                                                                                              blurRadius: 1.0,
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                        child: Center(
                                                                                            child: Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                                                          children: [
                                                                                            SvgPicture.asset(
                                                                                              'assets/new_ic_call.svg',
                                                                                              width: 20,
                                                                                              height: 20,
                                                                                            ),
                                                                                            SizedBox(
                                                                                              width: 10,
                                                                                            ),
                                                                                            Text(
                                                                                              Languages.of(context)!.mCallMe,
                                                                                              textAlign: TextAlign.center,
                                                                                              style: const TextStyle(fontFamily: 'OpenSauceSansMedium', fontSize: mSizeTwo, color: mGreyNine),
                                                                                            )
                                                                                          ],
                                                                                        )),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: 20,
                                                                                      ),
                                                                                      Container(
                                                                                        width: 150,
                                                                                        height: 30,
                                                                                        padding: const EdgeInsets.only(right: 20, left: 20),
                                                                                        decoration: BoxDecoration(
                                                                                          borderRadius: BorderRadius.circular(10),
                                                                                          color: Colors.white,
                                                                                          boxShadow: const [
                                                                                            BoxShadow(
                                                                                              color: Colors.white,
                                                                                              blurRadius: 1.0,
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                        child: Center(
                                                                                            child: Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                                                          children: [
                                                                                            SvgPicture.asset(
                                                                                              'assets/new_ic_chat.svg',
                                                                                              width: 20,
                                                                                              height: 20,
                                                                                            ),
                                                                                            SizedBox(
                                                                                              width: 10,
                                                                                            ),
                                                                                            Text(
                                                                                              Languages.of(context)!.mChatwithMe,
                                                                                              textAlign: TextAlign.center,
                                                                                              style: const TextStyle(fontFamily: 'OpenSauceSansMedium', fontSize: mSizeTwo, color: mGreyNine),
                                                                                            )
                                                                                          ],
                                                                                        )),
                                                                                      ),
                                                                                    ],
                                                                                  )))
                                                                            ]),
                                                                      )
                                                                    ],
                                                                  )),
                                                              Expanded(
                                                                  flex: 6,
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Container(
                                                                        width: MediaQuery.of(context)
                                                                            .size
                                                                            .width,
                                                                        height:
                                                                            MediaQuery.of(context).size.height -
                                                                                35,
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            left:
                                                                                10,
                                                                            top:
                                                                                20,
                                                                            right:
                                                                                10),
                                                                        margin: const EdgeInsets
                                                                            .only(
                                                                            left:
                                                                                15,
                                                                            top:
                                                                                20,
                                                                            bottom:
                                                                                10,
                                                                            right:
                                                                                10),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(20),
                                                                          color:
                                                                              mGreyTwo,
                                                                          border: Border.all(
                                                                              width: 1,
                                                                              color: mGreyFour),
                                                                          boxShadow: const [
                                                                            BoxShadow(
                                                                              color: Colors.white,
                                                                              blurRadius: 1.0,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        child: Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                                            children: [
                                                                              Expanded(flex: 9, child: Text("")),
                                                                              Expanded(
                                                                                  flex: 1,
                                                                                  child: Column(
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                                    children: [
                                                                                      Container(
                                                                                        height: 50,
                                                                                        padding: EdgeInsets.only(left: 10, right: 10),
                                                                                        decoration: BoxDecoration(
                                                                                          borderRadius: BorderRadius.circular(8),
                                                                                          color: Colors.white,
                                                                                          border: Border.all(width: 1, color: mGreyFour),
                                                                                          boxShadow: const [
                                                                                            BoxShadow(
                                                                                              color: Colors.white,
                                                                                              blurRadius: 1.0,
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                        child: Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                                                                          Expanded(flex: 8, child: Text("")),
                                                                                          Expanded(
                                                                                              flex: 2,
                                                                                              child: Row(
                                                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                                                children: [
                                                                                                  SvgPicture.asset(
                                                                                                    'assets/new_ic_attach.svg',
                                                                                                    width: 30,
                                                                                                    height: 30,
                                                                                                  ),
                                                                                                  SizedBox(
                                                                                                    width: 20,
                                                                                                  ),
                                                                                                  SvgPicture.asset(
                                                                                                    'assets/new_ic_sendchat.svg',
                                                                                                    width: 30,
                                                                                                    height: 30,
                                                                                                  ),
                                                                                                  SizedBox(
                                                                                                    width: 5,
                                                                                                  ),
                                                                                                ],
                                                                                              ))
                                                                                        ]),
                                                                                      )
                                                                                    ],
                                                                                  ))
                                                                            ]),
                                                                      ),
                                                                    ],
                                                                  ))
                                                            ],
                                                          )
                                                        ]),
                                                  ),
                                                ],
                                              )), //
                                            )),
                                      ))
                                  : const Text(""),
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

  void OnLoadDialog(MyServices mMyService) {
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
                                              mMyService.aboutService ?? "",
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
                                        child: ScrollConfiguration(
                                            behavior:
                                                ScrollConfiguration.of(context)
                                                    .copyWith(
                                                        scrollbars: false),
                                            child: SingleChildScrollView(
                                              physics:
                                                  AlwaysScrollableScrollPhysics(),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                        Languages.of(context)!
                                                            .mDeliverables,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                'OpenSauceSansSemiBold',
                                                            fontSize: mSizeTen,
                                                            color: mBlackOne,
                                                            height: 1.5)),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                        mMyService
                                                                .deliverables ??
                                                            "",
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                'OpenSauceSansRegular',
                                                            fontSize:
                                                                mSizeThree,
                                                            color: mGreyEigth,
                                                            height: 1.5)),
                                                    SizedBox(
                                                      height: 30,
                                                    ),
                                                    Text(
                                                        Languages.of(context)!
                                                            .mdocumentsrequired,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                'OpenSauceSansSemiBold',
                                                            fontSize: mSizeTen,
                                                            color: mBlackOne,
                                                            height: 1.5)),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    ListView.builder(
                                                      itemCount: mMyService
                                                          .documents!.length,
                                                      shrinkWrap: true,
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      itemBuilder:
                                                          (context, position) {
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 20,
                                                                  left: 20,
                                                                  bottom: 10,
                                                                  top: 10),
                                                          child: Text(
                                                            "${position + 1}. ${mMyService.documents![position].documents}" ??
                                                                "",
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    'OpenSauceSansRegular',
                                                                fontSize:
                                                                    mSizeThree,
                                                                color:
                                                                    mGreyEigth),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ]),
                                            ))),
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
                                            color: Colors.white,
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
                                            mhovercolor: Colors.white,
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

  void OnLoadServiceDetais(
      String mServiceId, void Function(VoidCallback fn) setState) {
    Loading(mLoaderGif).start(context);

    _apiService1
        .getServicedetails("jagadeesan.a1104@gmail.com", "MS-Pitch Deck-00078")
        .then((value) async {
      print(value);

      if (value is ApiSuccess) {
        Loading.stop();
        mServiceDetail = ServiceDetailsResponse.fromJson(value.data)!
            .message!
            .myServiceDetails!;

        mServiceDetailsMessage =
            ServiceDetailsResponse.fromJson(value.data)!.message!;

        setState(() {
          mShowView = 3;
        });
      } else if (value is ApiFailure) {
        Loading.stop();
      }
    });
  }

  void OnLoadPaymentSuccess(String PaymentId, String mDate, String Amount) {
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
              width: 500,
              height: 550,
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
                    SvgPicture.asset(
                      'assets/new_ic_payment_successful.svg',
                      width: 200,
                      height: 200,
                    ),
                    Material(
                      color: Colors.white,
                      child: Text(Languages.of(context)!.mPaymentSuccessful,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontFamily: 'OpenSauceSansSemiBold',
                              fontSize: mSizeSix,
                              color: mBlackOne)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Material(
                      color: Colors.white,
                      child: Text("${Languages.of(context)!.rupess} $Amount",
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontFamily: 'OpenSauceSansExtraBold',
                              fontSize: mSizeSix,
                              color: mBlackOne)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Material(
                      color: Colors.white,
                      child: Text(Languages.of(context)!.mPaymentSuccessmsg,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontFamily: 'OpenSauceSansRegular',
                              fontSize: mSizeThree,
                              color: mGreySeven)),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Material(
                      color: Colors.white,
                      child: Text(
                          "${Languages.of(context)!.mPaymentid}$PaymentId | $mDate",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontFamily: 'OpenSauceSansRegular',
                              fontSize: mSizeTwo,
                              color: mGreySeven)),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Material(
                      color: Colors.white,
                      child: Text(Languages.of(context)!.mDownloadInvoice,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'OpenSauceSansRegular',
                            fontSize: mSizeTwo,
                            color: mGreySeven,
                            decoration: TextDecoration.underline,
                          )),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Button(
                        mButtonname: Languages.of(context)!.mDone,
                        onpressed: () {
                          Navigator.pop(context);
                        },
                        mSelectcolor: mBtnColor,
                        mTextColor: mWhiteColor,
                        mFontSize: 16,
                        mWidth: 180,
                        mHeigth: 40),
                  ]),
            ),
          );
        });
      },
    );
  }

  void OnLoadPaymentFail(String mAmount) {
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
              width: 500,
              height: 510,
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
                    SvgPicture.asset(
                      'assets/new_ic_payment_fail.svg',
                      width: 200,
                      height: 200,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Material(
                      color: Colors.white,
                      child: Text(Languages.of(context)!.mPaymentFailed,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontFamily: 'OpenSauceSansSemiBold',
                              fontSize: mSizeSix,
                              color: mBlackOne)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Material(
                      color: Colors.white,
                      child: Text("${Languages.of(context)!.rupess} $mAmount",
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontFamily: 'OpenSauceSansExtraBold',
                              fontSize: mSizeSix,
                              color: mBlackOne)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Material(
                      color: Colors.white,
                      child: Text(Languages.of(context)!.mPaymentFailedmsg,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontFamily: 'OpenSauceSansRegular',
                              fontSize: mSizeThree,
                              color: mGreySeven)),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Button(
                        mButtonname: Languages.of(context)!.mDone,
                        onpressed: () {
                          Navigator.pop(context);
                        },
                        mSelectcolor: mBtnColor,
                        mTextColor: mWhiteColor,
                        mFontSize: 16,
                        mWidth: 180,
                        mHeigth: 40),
                  ]),
            ),
          );
        });
      },
    );
  }

  void openCheckout(int? pricing, BuildContext buildContext) async {
    var mTotalPrice = (pricing ?? 0) * 100;
    var options = {
      'key': mRazorpayTestKey,
      'amount': mTotalPrice,
      'name': mRazorpayName,
      'description': 'Pitch craft service purchase',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      // 'external': {
      //   'wallets': ['paytm']
      // }
    };

    try {
      _razorpay.open(options);
      Loading.stop();
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Fluttertoast.showToast(
    //     msg: "SUCCESS: ${response.paymentId!}",
    //     toastLength: Toast.LENGTH_SHORT);
    Loading(mLoaderGif).start(context);
    var now = DateTime.now();
    var formatter = DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(now);

    _apiService1.Pitchcraftservicepayment(
            "jagadeesan.a1104@gmail.com",
            mPitchcraftid,
            formattedDate,
            response.paymentId!,
            mAmount.toString())
        .then((value) async {
      if (value is ApiSuccess) {
        Loading.stop();

        if (CommonResponse.fromJson(value.data)!.message!.status ?? false) {
          OnLoadPaymentSuccess(
              response.paymentId!, formattedDate, mAmount.toString());
        } else {
          ErrorToast(
              context: mcontext,
              text:
                  CommonResponse.fromJson(value.data)!.message!.message ?? "");
        }
      } else if (value is ApiFailure) {
        Loading.stop();
      }
    });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    OnLoadPaymentFail(mAmount.toString());

    Loading.stop();
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    OnLoadPaymentFail(mAmount.toString());
    Loading.stop();
  }
}
