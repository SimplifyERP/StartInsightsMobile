import 'dart:convert';
import 'dart:typed_data';

import 'package:custom_gif_loading/custom_gif_loading.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Model/DashboardResponse.dart';
import 'package:startinsights/Model/LoginResponse.dart';
import 'package:startinsights/Model/MastersResponse.dart';
import 'package:startinsights/Model/RegistrationResponse.dart';
import 'package:startinsights/Network/api_result_handler.dart';
import 'package:startinsights/Network/di.dart';
import 'package:startinsights/Repository/dashboard_repo.dart';
import 'package:startinsights/Screen/Dashboard/bloc/dashboard_bloc.dart';
import 'package:startinsights/Screen/Dashboard/bloc/dashboard_state.dart';
import 'package:startinsights/Screen/Dashboard/web/dashboarditemist.dart';
import 'package:startinsights/Screen/Login/bloc/login_bloc.dart';
import 'package:startinsights/Utils/FontSizes.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Utils/StorageServiceConstant.dart';
import 'package:startinsights/Utils/constant_methods.dart';
import 'package:startinsights/Utils/pref_manager.dart';
import 'package:startinsights/Utils/utils.dart';
import 'package:startinsights/Widgets/Appbarnew.dart';
import 'package:startinsights/Widgets/auth_form_field.dart';
import 'package:startinsights/Widgets/button.dart';
import 'package:startinsights/Widgets/servicebutton.dart';
import 'package:startinsights/Widgets/sidemenunew.dart';

class Dashboard extends StatefulWidget {
  final String? mFrom;
  Dashboard({super.key, required this.mFrom});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  late DashboardBloc mDashboardBloc;
  bool checkedValue = false;
  List<UserType>? mUserTypeDataList;
  List<UserType> getUserType = <UserType>[];
  List<MessageElement> mDashboarddata = [];

  String mUserName = ""; //Padhu NPN
  ValueNotifier<bool> setnotifier = ValueNotifier(true);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController companynameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController linedINController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();

  final DashboardRepo _apiService1 = DashboardRepo();

  //User Image upload
  String mCaptureUserImage = "";

  String selectedFile = '';
  Uint8List? image;
  late UserDetails mUserDetails;
  @override
  void initState() {
    super.initState();
    loadPrefs();
    sl<StorageService>().setBool(StorageServiceConstant.MLOGINSTATUS, true);
  }

  loadPrefs() async {
    // mUserName =
    //     await sl<StorageService>().getString(StorageServiceConstant.MUSERNAME);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> valueMap =
        json.decode((prefs.getString(StorageServiceConstant.MUSERINFO) ?? ''));
    mUserDetails =
        RegistrationResponse.fromJson(valueMap).message!.userDetails!;

    if (widget.mFrom == '1') {
      OnProfileView(mUserDetails);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    companynameController.dispose();
    linedINController.dispose();
    websiteController.dispose();
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
              if (state is GetDashboardInfoSuccessState) {
                mDashboarddata = state.mDashboarddata;
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
                                              Container(
                                                height: 260,
                                                child: ListView.builder(
                                                    shrinkWrap: true,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount:
                                                        mDashboarddata.length,
                                                    itemBuilder: (_, index) {
                                                      final mDashboardList =
                                                          mDashboarddata[index];
                                                      return InkWell(
                                                        onTap: () {},
                                                        child:
                                                            DashboardItemList(
                                                          mIndex: index,
                                                          mMessageElement:
                                                              mDashboardList,
                                                        ),
                                                      );
                                                    }),
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
                                            child: InkWell(
                                              onTap: () {
                                                GoRouter.of(context)
                                                    .go('/ReviewDeck');
                                              },
                                              child: Container(
                                                height: 280,
                                                width: double.infinity,
                                                padding:
                                                    const EdgeInsets.all(15),
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
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                          Languages.of(context)!
                                                              .mReviewYouPitchDeck,
                                                          style:
                                                              const TextStyle(
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
                                                            const EdgeInsets
                                                                .all(15),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          color: mGreyTwo,
                                                          boxShadow: const [
                                                            BoxShadow(
                                                              color:
                                                                  Colors.white,
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
                                                            .mBuildyourPitchroom,
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

  void OnProfileView(UserDetails mUserDetails) {
    nameController.text = mUserDetails.fullName ?? "";
    mobileController.text = mUserDetails.mobileNo ?? "";
    emailController.text = mUserDetails.emailid ?? "";
    // UserDetails mUserDetails
    showGeneralDialog(
      barrierLabel: "",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      // transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return StatefulBuilder(builder: (context1, setState) {
          return Align(
            alignment: Alignment.center,
            child: Container(
              width: 760,
              height: 650,
              margin: const EdgeInsets.only(left: 12, right: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: mGreyThree, width: 1)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 60,
                      width: double.infinity,
                      padding: const EdgeInsets.only(left: 40),
                      decoration: const BoxDecoration(
                        color: mGreyTwo,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                      ),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Material(
                            color: mGreyTwo,
                            child: Text(Languages.of(context)!.mprofileinfo,
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    fontFamily: 'OpenSauceSansBold',
                                    fontSize: mSizeFive,
                                    color: mGreyTen)),
                          )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 40),
                      child: Material(
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 5,
                                ),
                                InkWell(
                                  hoverColor: Colors.white,
                                  onTap: () {
                                    setState(() {
                                      //mSelectView = 1;
                                    });
                                  },
                                  child: Container(
                                    width: 150,
                                    height: 40,
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                            Languages.of(context)!.mprofile,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                fontFamily: 'OpenSauceSansBold',
                                                fontSize: mSizeFour,
                                                color: mBlackTwo))),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Visibility(
                                    visible: false,
                                    child: InkWell(
                                      hoverColor: Colors.white,
                                      onTap: () {
                                        setState(() {});
                                      },
                                      child: Container(
                                        width: 200,
                                        height: 40,
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                                Languages.of(context)!
                                                    .mAccountSettings,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    fontFamily:
                                                        'OpenSauceSansBold',
                                                    fontSize: mSizeFour,
                                                    color: mBlackTwo))),
                                      ),
                                    ))
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 150,
                                  height: 2,
                                  child: Container(
                                    color: mS1GreenNine,
                                    width: MediaQuery.of(context).size.width,
                                    height: 1,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Visibility(
                                  visible: false,
                                  child: Container(
                                    width: 200,
                                    height: 2,
                                    child: Container(
                                      color: mS1GreenNine,
                                      width: MediaQuery.of(context).size.width,
                                      height: 1,
                                    ),
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
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 40),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                flex: 6,
                                child: Material(
                                  color: Colors.white,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          child: AuthFormField(
                                            controller: nameController,
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType: TextInputType.text,
                                            hintText:
                                                Languages.of(context)!.mName,
                                            radius: 30,
                                            maxLength: 80,
                                            labelText:
                                                Languages.of(context)!.mName,
                                            mBorderView: false,
                                            mImageView: true,
                                            isMandatory: true,
                                            mTop: 20,
                                            mBottom: 20,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          child: AuthFormField(
                                            controller: mobileController,
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType: TextInputType.number,
                                            hintText:
                                                Languages.of(context)!.mMobile,
                                            radius: 30,
                                            maxLength: 10,
                                            labelText:
                                                Languages.of(context)!.mMobile,
                                            mBorderView: false,
                                            mImageView: true,
                                            isMandatory: true,
                                            mTop: 20,
                                            mBottom: 20,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          child: AuthFormField(
                                            controller: emailController,
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType: TextInputType.text,
                                            hintText: Languages.of(context)!
                                                .mEmailAddress,
                                            radius: 30,
                                            maxLength: 150,
                                            labelText: Languages.of(context)!
                                                .mEmailAddress,
                                            mBorderView: false,
                                            mImageView: true,
                                            isMandatory: true,
                                            mTop: 20,
                                            mBottom: 20,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          child: AuthFormField(
                                            controller: companynameController,
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType: TextInputType.text,
                                            hintText: Languages.of(context)!
                                                .mCompanyName,
                                            radius: 30,
                                            maxLength: 250,
                                            labelText: Languages.of(context)!
                                                .mCompanyName,
                                            mBorderView: false,
                                            mImageView: true,
                                            isMandatory: false,
                                            mTop: 20,
                                            mBottom: 20,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                      ]),
                                )),
                            const SizedBox(
                              width: 30,
                            ),
                            Expanded(
                                flex: 4,
                                child: Material(
                                  color: Colors.white,
                                  child: InkWell(
                                      hoverColor: Colors.transparent,
                                      onTap: () {
                                        setState(
                                          () {
                                            selectFile(setState);
                                          },
                                        );
                                      },
                                      child: Center(
                                        child: Column(children: [
                                          (image != null)
                                              ? Image.memory(
                                                  image!,
                                                  fit: BoxFit.fill,
                                                  width: 200,
                                                  height: 200,
                                                )
                                              : Image.asset(
                                                  'assets/new_ic_profileupload.png',
                                                  height: 200,
                                                  width: 200,
                                                ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                              Languages.of(context)!
                                                  .muploadprofile,
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                  fontFamily:
                                                      'OpenSauceSansRegular',
                                                  fontSize: mSizeThree,
                                                  color: mBlackTwo))
                                        ]),
                                      )),
                                ))
                          ]),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 40, right: 20),
                      child: Material(
                          color: Colors.white,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(Languages.of(context)!.mSocialMediaLinks,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                        fontFamily: 'OpenSauceSansSemiBold',
                                        fontSize: mSizeFour,
                                        color: mBlueOne)),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  color: mGreyFive,
                                  width: MediaQuery.of(context).size.width,
                                  height: 1,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        flex: 5,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                                Languages.of(context)!
                                                    .mlinkedinurl,
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                    fontFamily:
                                                        'OpenSauceSansRegular',
                                                    fontSize: mSizeOne,
                                                    color: mGreyEigth)),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              child: AuthFormField(
                                                controller: linedINController,
                                                textInputAction:
                                                    TextInputAction.next,
                                                keyboardType:
                                                    TextInputType.text,
                                                hintText: Languages.of(context)!
                                                    .mlinkedinurl,
                                                radius: 30,
                                                maxLength: 250,
                                                labelText:
                                                    Languages.of(context)!
                                                        .mlinkedinurl,
                                                mBorderView: false,
                                                mImageView: true,
                                                isMandatory: false,
                                                mTop: 20,
                                                mBottom: 20,
                                              ),
                                            ),
                                          ],
                                        )),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                        flex: 5,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                                Languages.of(context)!
                                                    .mwebsiteurl,
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                    fontFamily:
                                                        'OpenSauceSansRegular',
                                                    fontSize: mSizeOne,
                                                    color: mGreyEigth)),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              child: AuthFormField(
                                                controller: websiteController,
                                                textInputAction:
                                                    TextInputAction.next,
                                                keyboardType:
                                                    TextInputType.text,
                                                hintText: Languages.of(context)!
                                                    .mwebsiteurl,
                                                radius: 30,
                                                maxLength: 250,
                                                labelText:
                                                    Languages.of(context)!
                                                        .mwebsiteurl,
                                                mBorderView: false,
                                                mImageView: true,
                                                isMandatory: false,
                                                mTop: 20,
                                                mBottom: 20,
                                              ),
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: ServiceButton(
                                      mButtonname:
                                          Languages.of(context)!.mSaveProfile,
                                      onpressed: () {
                                        setState(
                                          () {
                                            if (nameController.text.isEmpty) {
                                              ErrorToast(
                                                  context: context1,
                                                  text: Languages.of(context)!
                                                      .mEnterName);
                                            } else if (mobileController
                                                .text.isEmpty) {
                                              ErrorToast(
                                                  context: context,
                                                  text: Languages.of(context)!
                                                      .mEnterMobile);
                                            } else if (!isMobileNumberValid(
                                                mobileController.text)) {
                                              ErrorToast(
                                                  context: context,
                                                  text: "Not Valid  Mobile");
                                            } else if (emailController
                                                .text.isEmpty) {
                                              ErrorToast(
                                                  context: context,
                                                  text: Languages.of(context)!
                                                      .mEmailAddresshint);
                                            } else if (!emailController.text
                                                .isValidEmail()) {
                                              ErrorToast(
                                                  context: context,
                                                  text: Languages.of(context)!
                                                      .mVaildEmailAddresshint);
                                            } else if (companynameController
                                                .text.isEmpty) {
                                              ErrorToast(
                                                  context: context,
                                                  text: Languages.of(context)!
                                                      .mentercompanyname);
                                            } else {
                                              Loading(mLoaderGif)
                                                  .start(context);

                                              _apiService1.ProfileUpdate(
                                                      nameController.text,
                                                      mobileController.text,
                                                      emailController.text,
                                                      "",
                                                      companynameController
                                                          .text,
                                                      linedINController.text,
                                                      websiteController.text,
                                                      mCaptureUserImage,
                                                      mUserDetails.password ??
                                                          "")
                                                  .then((value) async {
                                                print(value);

                                                if (value is ApiSuccess) {
                                                  if (LoginResponse.fromJson(
                                                              value.data)!
                                                          .message!
                                                          .status ??
                                                      false) {
                                                    Loading.stop();
                                                    String mUserInfo =
                                                        json.encode(value.data);

                                                    sl<StorageService>()
                                                        .setString(
                                                            StorageServiceConstant
                                                                .MUSERINFO,
                                                            mUserInfo);
                                                    Navigator.pop(context);
                                                    SucessToast(
                                                        context: context,
                                                        text:
                                                            "Profile Updated");
                                                  } else {
                                                    Loading.stop();
                                                    ErrorToast(
                                                        context: context,
                                                        text: LoginResponse
                                                                    .fromJson(value
                                                                        .data)!
                                                                .message!
                                                                .message ??
                                                            "");
                                                  }
                                                } else if (value
                                                    is ApiFailure) {
                                                  Loading.stop();
                                                }
                                              });
                                            }
                                          },
                                        );
                                      },
                                      mTextColor: mWhiteColor,
                                      mFontSize: 16,
                                      mWidth: 130,
                                      mHeigth: 35,
                                      mhovercolor: Colors.white),
                                )
                              ])),
                    )
                  ]),
            ),
          );
        });
      },
    );
  }

  void selectFile(StateSetter setState1) async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'png',
        'jpg',
        'jpeg',
      ],
    );

    if (result != null) {
      setState1(() {
        selectedFile = result.files.first.name;
      });

      image = result.files.first.bytes;

      mCaptureUserImage = base64Encode(image!);
      mCaptureUserImage = base64Encode(image!);
    }
  }
}
