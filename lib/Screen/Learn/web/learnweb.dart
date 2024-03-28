import 'package:custom_gif_loading/custom_gif_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pod_player/pod_player.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Model/CommonResponse.dart';
import 'package:startinsights/Model/CourseDetailsResponse.dart';
import 'package:startinsights/Model/EventListResponse.dart';
import 'package:startinsights/Model/LearnlistResponse.dart';
import 'package:startinsights/Network/api_result_handler.dart';
import 'package:startinsights/Repository/lms_repository.dart';
import 'package:startinsights/Screen/Learn/bloc/learn_bloc.dart';
import 'package:startinsights/Screen/Learn/bloc/learn_state.dart';
import 'package:startinsights/Screen/Learn/web/LearnVideoitem.dart';
import 'package:startinsights/Screen/Learn/web/LiveEventitem.dart';
import 'package:startinsights/Screen/Learn/web/RecordEventitem.dart';
import 'package:startinsights/Screen/Learn/web/learnItem.dart';
import 'package:startinsights/Utils/FontSizes.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Utils/constant_methods.dart';
import 'package:startinsights/Utils/screens.dart';
import 'package:startinsights/Utils/utils.dart';
import 'package:startinsights/Widgets/Appbarnew.dart';
import 'package:startinsights/Widgets/button.dart';
import 'package:startinsights/Widgets/sidemenunew.dart';
import 'package:url_launcher/url_launcher.dart';

class LearnWeb extends StatefulWidget {
  LearnWeb({super.key});

  @override
  State<LearnWeb> createState() => _LearnWebState();
}

class _LearnWebState extends State<LearnWeb> {
  @override
  late LearnBloc mLearnBloc;

  int selectedIndex = -1; //dont set it to 0
  bool isExpanded = true;

  final TextEditingController mSearchEditingController =
      TextEditingController();

  var items = <CoursesList>[];
  List<CoursesList> mCoursesList = [];
  List<CoursesList> mFavList = [];
  bool isScreenFirst = true;
  int tappedIndex = 0;

  List<CourseDetail> mCourseDetail = [];

  ValueNotifier<bool> setnotifier = ValueNotifier(true);

  // 1-> LMS list , 3->LMS list Details , 2 -> Event View,4-> FAv View
  int mSelectView = 1;
  int mGetCount = 0;
  int numPages = 1;
  int currentPage = 1;
  int SetcurrentPage = 0;

  final LMSRepository apiService = LMSRepository();

  String mFilterValue = "";
  String mStatusChange = "";

  String mSelectId = "";

  //Pod Player
  late PodPlayerController controller;
  bool? isVideoPlaying;
  bool alwaysShowProgressBar = true;
  var mPlayedpostion = 0;
  var VideototalDuration = "";
  var totalHour = "";
  var totalMinute = "";
  var totalSeconds = "";
  bool mPlayfirsttime = true;
  bool mAPICall = true;

  // List<String> mLessonNameList = [];
  // List<bool> mLessonViewedList = [];
  List<String> mLessonURLList = [];

  //Event View
  List<LiveEvent> mLiveEvent = [];
  List<RecordedEvent> mRecordedEvent = [];

  @override
  void initState() {
    super.initState();
    mLoadMasterData();
    /* controller = PodPlayerController(
      playVideoFrom: PlayVideoFrom.network(''),
    )..initialise().then((value) {
        setState(() {
          isVideoPlaying = controller.isVideoPlaying;
          controller.mute();
        });
      });
    controller.addListener(_listner);*/
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
    mSearchEditingController.dispose();
    controller.removeListener(_listner);
    controller.dispose();
  }

  void _listner() {
    if (controller.isVideoPlaying != isVideoPlaying) {
      isVideoPlaying = controller.isVideoPlaying;
    }

    if (mounted) setState(() {});
  }

  Widget build(BuildContext context) {
    mLearnBloc = LearnBloc(mContext: context);

    void OnLoadNext() {
      Navigator.pushReplacementNamed(context, dashboardRoute);
    }

    final ScrollController mscrollcontroller = ScrollController();

    void filterSearchResults(String query) {
      setState(() {
        items = mCoursesList
            .where((item) =>
                item.title!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }

    var _crossAxisSpacing = 10;
    var _screenWidth = MediaQuery.of(context).size.width;
    var _crossAxisCount = 2;
    var _width = (_screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    var cellHeight = 850;
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
          body: BlocConsumer<LearnBloc, LearnStatus>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is GetLearnInfoSuccessState) {
                mCoursesList = state.mCoursesList;

                if (isScreenFirst) {
                  isScreenFirst = false;
                  items = mCoursesList;
                }
                numPages = (mGetCount / 8).ceil();
              }
              // return _iframeWidget;
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
                        mFrom: 3,
                        context: context,
                        mchange: (value) {
                          print(value);
                          setnotifier.value = value;
                        },
                        isExpanded: true,
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
                                mFrom: 3,
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
                                                        .mLearntoRaise,
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
                                          alignment: Alignment.centerRight,
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
                                                Container(
                                                    width: 400,
                                                    height: 45,
                                                    padding: const EdgeInsets
                                                        .fromLTRB(5, 5, 5, 5),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      color: mS1GreenThree,
                                                      boxShadow: const [
                                                        BoxShadow(
                                                          color: mS1GreenThree,
                                                          blurRadius: 1.0,
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
                                                        Expanded(
                                                          flex: 5,
                                                          child: InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  mSelectView =
                                                                      1;
                                                                  OnLoadLearnList(
                                                                      "jagadeesan.a1104@gmail.com");
                                                                });
                                                              },
                                                              child: Container(
                                                                decoration: (mSelectView ==
                                                                            1) ||
                                                                        mSelectView ==
                                                                            3
                                                                    ? BoxDecoration(
                                                                        gradient:
                                                                            const LinearGradient(
                                                                          colors: [
                                                                            mgradientThree,
                                                                            mgradientFour
                                                                          ],
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(30),
                                                                      )
                                                                    : null,
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(5),
                                                                child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                        Languages.of(context)!
                                                                            .mCourses,
                                                                        textAlign:
                                                                            TextAlign
                                                                                .center,
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'OpenSauceSansMedium',
                                                                            fontSize:
                                                                                mSizeThree,
                                                                            color: (mSelectView == 1 || mSelectView == 3
                                                                                ? Colors.white
                                                                                : mS1GreenNine) //|| mSelectView == 4
                                                                            ))),
                                                              )),
                                                        ),
                                                        const SizedBox(
                                                          width: 20,
                                                        ),
                                                        Expanded(
                                                          flex: 5,
                                                          child: InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  mGetEventList(
                                                                      "jagadeesan.a1104@gmail.com");
                                                                  mSelectView =
                                                                      2;
                                                                });
                                                              },
                                                              child: Container(
                                                                decoration:
                                                                    mSelectView ==
                                                                            2
                                                                        ? BoxDecoration(
                                                                            gradient:
                                                                                const LinearGradient(
                                                                              colors: [
                                                                                mgradientThree,
                                                                                mgradientFour
                                                                              ],
                                                                            ),
                                                                            borderRadius:
                                                                                BorderRadius.circular(30),
                                                                          )
                                                                        : null,
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(5),
                                                                child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                        Languages.of(context)!
                                                                            .mEvents,
                                                                        textAlign:
                                                                            TextAlign
                                                                                .center,
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'OpenSauceSansMedium',
                                                                            fontSize:
                                                                                mSizeThree,
                                                                            color: (mSelectView == 2
                                                                                ? Colors.white
                                                                                : mS1GreenNine)))),
                                                              )),
                                                        ),
                                                      ],
                                                    )),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                SizedBox(
                                                  child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          mSelectView = 4;
                                                        });
                                                        OnloadFavList(
                                                            "jagadeesan.a1104@gmail.com");
                                                      },
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Image(
                                                            width: 40,
                                                            height: 40,
                                                            image: (mSelectView ==
                                                                    4)
                                                                ? const AssetImage(
                                                                    "assets/new_ic_selfav.png",
                                                                  )
                                                                : const AssetImage(
                                                                    "assets/new_ic_fav.png",
                                                                  ),
                                                          ),
                                                        ],
                                                      )),
                                                ),
                                                const SizedBox(
                                                  width: 20,
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
                                  visible: mSelectView == 1 ? true : false,
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
                                                                  .mResources,
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
                                                    padding: const EdgeInsets
                                                        .fromLTRB(
                                                        30, 10, 10, 10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Expanded(
                                                          flex: 9,
                                                          child: Container(
                                                              height: 45,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30),
                                                                color: mGreyTwo,
                                                                boxShadow: const [
                                                                  BoxShadow(
                                                                    color:
                                                                        mGreyTwo,
                                                                    blurRadius:
                                                                        1.0,
                                                                  ),
                                                                ],
                                                              ),
                                                              child: SearchBar(
                                                                overlayColor:
                                                                    MaterialStateProperty
                                                                        .resolveWith(
                                                                            (states) {
                                                                  // If the button is pressed, return green, otherwise blue
                                                                  if (states.contains(
                                                                      MaterialState
                                                                          .hovered)) {
                                                                    return mGreyTwo;
                                                                  }
                                                                  return mGreyTwo;
                                                                }),
                                                                padding: MaterialStateProperty.all(
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            10,
                                                                        right:
                                                                            10)),
                                                                controller:
                                                                    mSearchEditingController,
                                                                elevation:
                                                                    MaterialStateProperty
                                                                        .all(0),
                                                                side: MaterialStateProperty.all(
                                                                    const BorderSide(
                                                                        color:
                                                                            mGreyTwo)),
                                                                backgroundColor:
                                                                    MaterialStateProperty
                                                                        .all(
                                                                            mGreyTwo),
                                                                hintText: Languages.of(
                                                                        context)!
                                                                    .mSearchCourses,
                                                                hintStyle:
                                                                    MaterialStateProperty
                                                                        .all(
                                                                            const TextStyle(
                                                                  color:
                                                                      mGreySeven,
                                                                  fontSize:
                                                                      mSizeThree,
                                                                  fontFamily:
                                                                      'OpenSauceSansRegular',
                                                                )),
                                                                textStyle:
                                                                    MaterialStateProperty
                                                                        .all(
                                                                            const TextStyle(
                                                                  fontSize:
                                                                      mSizeThree,
                                                                  fontFamily:
                                                                      'OpenSauceSansRegular',
                                                                  color:
                                                                      mGreySeven,
                                                                )),
                                                                onChanged:
                                                                    (String
                                                                        value) {
                                                                  print(
                                                                      'value: $value');
                                                                  filterSearchResults(
                                                                      value);
                                                                },
                                                                onTap: () {
                                                                  print(
                                                                      'tapped');
                                                                  // The code below only works with SearchAnchor
                                                                  // _searchController.openView();
                                                                },
                                                                leading: const Icon(
                                                                    Icons
                                                                        .search,
                                                                    size: 30,
                                                                    color:
                                                                        mGreySeven),
                                                              )),
                                                        ),
                                                        const SizedBox(
                                                          width: 20,
                                                        ),
                                                        Visibility(
                                                            visible: false,
                                                            child: Expanded(
                                                              flex: 3,
                                                              child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Button(
                                                                        mButtonname:
                                                                            Languages.of(context)!
                                                                                .mSearchResult,
                                                                        onpressed:
                                                                            () {},
                                                                        mSelectcolor:
                                                                            mBtnColor,
                                                                        mTextColor:
                                                                            mWhiteColor,
                                                                        mFontSize:
                                                                            16,
                                                                        mWidth:
                                                                            150,
                                                                        mHeigth:
                                                                            40),
                                                                    SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                  ]),
                                                            ))
                                                      ],
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
                                                        30, 10, 10, 10),
                                                    child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                              Languages.of(
                                                                      context)!
                                                                  .mViewCourses,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: const TextStyle(
                                                                  fontFamily:
                                                                      'OpenSauceSansBold',
                                                                  fontSize:
                                                                      mSizeThree,
                                                                  color:
                                                                      mGreyTen))
                                                        ]),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 10, right: 10),
                                                    child:
                                                        SingleChildScrollView(
                                                            child:
                                                                GridView.count(
                                                      crossAxisCount: 4,
                                                      crossAxisSpacing: 0,
                                                      mainAxisSpacing: 0,
                                                      childAspectRatio:
                                                          _aspectRatio,
                                                      shrinkWrap: true,
                                                      children: List.generate(
                                                        items.length,
                                                        (index) {
                                                          final mgetCoursesList =
                                                              items[index];
                                                          return LearnItem(
                                                            onPressed: () {
                                                              setState(() {
                                                                OnLoadEventDetails(
                                                                  "jagadeesan.a1104@gmail.com",
                                                                  items[index]
                                                                          .id ??
                                                                      "",
                                                                );
                                                              });
                                                            },
                                                            mCoursesList:
                                                                mgetCoursesList,
                                                            RemoveFavonpressed:
                                                                () {
                                                              setState(() {
                                                                OnRemoveFav(
                                                                    "jagadeesan.a1104@gmail.com",
                                                                    items[index]
                                                                            .id ??
                                                                        "",
                                                                    1);
                                                              });
                                                            },
                                                            AddFavonpressed:
                                                                () {
                                                              OnloadAddFav(
                                                                  "jagadeesan.a1104@gmail.com",
                                                                  items[index]
                                                                      .id);
                                                            },
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
                                  visible: mSelectView == 2 ? true : false,
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
                                                                  .mmyLearnlink,
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
                                                                  .mEvents,
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
                                                    child: SingleChildScrollView(
                                                        child: Text(
                                                            Languages.of(
                                                                    context)!
                                                                .mOnlineEvents,
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    'OpenSauceSansBold',
                                                                fontSize:
                                                                    mSizeThree,
                                                                color:
                                                                    mGreyTen))),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    height: 400,
                                                    child: ListView.builder(
                                                        shrinkWrap: true,
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemCount:
                                                            mLiveEvent.length,
                                                        itemBuilder:
                                                            (_, index) {
                                                          final liveEvent =
                                                              mLiveEvent[index];
                                                          return LiveEventItem(
                                                            mLiveEvent:
                                                                liveEvent,
                                                            onpressed: () {
                                                              // OnRegisterEvent("jagadeesan.a1104@gmail.com",liveEvent.)
                                                              // dgsg
                                                            },
                                                          );
                                                        }),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Material(
                                                    color: Colors.white,
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
                                                                  .start,
                                                          children: [
                                                            const SizedBox(
                                                              width: 20,
                                                            ),
                                                            InkWell(
                                                              hoverColor:
                                                                  Colors.white,
                                                              onTap: () {
                                                                setState(() {});
                                                              },
                                                              child: Container(
                                                                width: 170,
                                                                height: 40,
                                                                child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    child: Text(
                                                                        Languages.of(context)!
                                                                            .mRecordedPastEvents,
                                                                        textAlign:
                                                                            TextAlign
                                                                                .center,
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'OpenSauceSansBold',
                                                                            fontSize:
                                                                                mSizeThree,
                                                                            color:
                                                                                mgradientThree))),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const SizedBox(
                                                              width: 20,
                                                            ),
                                                            Container(
                                                              width: 170,
                                                              height: 2,
                                                              child: Container(
                                                                color:
                                                                    mgradientThree,
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                height: 1,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Material(
                                                          color: Colors.white,
                                                          child: Container(
                                                            color: mGreyFive,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            height: 1,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Container(
                                                    height: 280,
                                                    child: ListView.builder(
                                                        shrinkWrap: true,
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemCount:
                                                            mRecordedEvent
                                                                .length,
                                                        itemBuilder:
                                                            (_, index) {
                                                          final mrecordedEvent =
                                                              mRecordedEvent[
                                                                  index];
                                                          return RecordedEventItem(
                                                            mRecordedEvent:
                                                                mrecordedEvent,
                                                            onpressed: () {
                                                              launchUrl(
                                                                  Uri.parse(
                                                                      mrecordedEvent
                                                                              .eventUrl ??
                                                                          ""),
                                                                  mode: LaunchMode
                                                                      .externalApplication);
                                                            },
                                                          );
                                                        }),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                ]),
                                          ),
                                        ],
                                      )), //
                                    ),
                                  )),
                              Visibility(
                                  visible: mSelectView == 3 ? true : false,
                                  child: (mCourseDetail.isNotEmpty)
                                      ? Expanded(
                                          child: ScrollConfiguration(
                                              behavior: ScrollConfiguration.of(
                                                      context)
                                                  .copyWith(scrollbars: false),
                                              child: SingleChildScrollView(
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.5,
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 10,
                                                                right: 10,
                                                                top: 20,
                                                                bottom: 10),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          color: Colors.white,
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
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  const SizedBox(
                                                                    width: 20,
                                                                  ),
                                                                  InkWell(
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        mSelectView =
                                                                            1;
                                                                      });
                                                                    },
                                                                    child: SvgPicture
                                                                        .asset(
                                                                      'assets/new_ic_serice_back.svg',
                                                                      width: 20,
                                                                      height:
                                                                          20,
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Text(
                                                                    mCourseDetail[0]
                                                                            .courseTitle ??
                                                                        "",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: const TextStyle(
                                                                        fontFamily:
                                                                            'OpenSauceSansSemiBold',
                                                                        fontSize:
                                                                            mSizeFour,
                                                                        color:
                                                                            mBlackTwo),
                                                                  )
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 20,
                                                              ),
                                                              Container(
                                                                  width: 800,
                                                                  height: 450,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15),
                                                                    color: Colors
                                                                        .white,
                                                                    boxShadow: const [
                                                                      BoxShadow(
                                                                        color:
                                                                            mGreyTwo,
                                                                        blurRadius:
                                                                            0,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  child: Stack(
                                                                    children: [
                                                                      PodVideoPlayer(
                                                                        alwaysShowProgressBar:
                                                                            alwaysShowProgressBar,
                                                                        controller:
                                                                            controller,
                                                                        matchFrameAspectRatioToVideo:
                                                                            true,
                                                                        matchVideoAspectRatioToFrame:
                                                                            true,
                                                                        // videoTitle: "Test",
                                                                      ),

                                                                      Center(
                                                                        child:
                                                                            Container(
                                                                          padding: const EdgeInsets
                                                                              .fromLTRB(
                                                                              15,
                                                                              10,
                                                                              15,
                                                                              10),
                                                                          height:
                                                                              70,
                                                                          child:
                                                                              Row(children: [
                                                                            Expanded(
                                                                                flex: 2,
                                                                                child: Center(
                                                                                  child: Visibility(
                                                                                    visible: controller.isVideoPlaying,
                                                                                    child: InkWell(
                                                                                        onTap: () {
                                                                                          controller.doubleTapVideoBackward(10);
                                                                                        },
                                                                                        child: Image.asset(
                                                                                          'assets/ic_backward.png',
                                                                                          height: 25,
                                                                                          width: 25,
                                                                                        )),
                                                                                  ),
                                                                                )),
                                                                            const Expanded(
                                                                                flex: 6,
                                                                                child: Center(
                                                                                  child: Text(""),
                                                                                )),
                                                                            Expanded(
                                                                                flex: 2,
                                                                                child: Center(
                                                                                  child: Visibility(
                                                                                    visible: controller.isVideoPlaying,
                                                                                    child: InkWell(
                                                                                        onTap: () {
                                                                                          controller.doubleTapVideoForward(10);
                                                                                        },
                                                                                        child: Image.asset(
                                                                                          'assets/ic_forward.png',
                                                                                          height: 25,
                                                                                          width: 25,
                                                                                        )),
                                                                                  ),
                                                                                ))
                                                                          ]),
                                                                        ),
                                                                      )

                                                                      // Container(
                                                                      //   padding:
                                                                      //       EdgeInsets.fromLTRB(15, 10, 15, 10),
                                                                      //   child: Row(
                                                                      //       crossAxisAlignment:
                                                                      //           CrossAxisAlignment.center,
                                                                      //       mainAxisAlignment:
                                                                      //           MainAxisAlignment.center,
                                                                      //       children: [
                                                                      //         Positioned.fill(
                                                                      //           child: Align(
                                                                      //               alignment:
                                                                      //                   Alignment.centerRight,
                                                                      //               child: Text("gsdgsdg")),
                                                                      //         ),
                                                                      //       ]),
                                                                      // )
                                                                    ],
                                                                  )),
                                                              const SizedBox(
                                                                height: 20,
                                                              ),
                                                              Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  const SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  InkWell(
                                                                    hoverColor:
                                                                        Colors
                                                                            .white,
                                                                    onTap:
                                                                        () {},
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          150,
                                                                      height:
                                                                          40,
                                                                      child: Align(
                                                                          alignment: Alignment
                                                                              .centerLeft,
                                                                          child: Text(
                                                                              Languages.of(context)!.mCoursesOverview,
                                                                              textAlign: TextAlign.center,
                                                                              style: const TextStyle(fontFamily: 'OpenSauceSansBold', fontSize: mSizeThree, color: mS1GreenEigth))),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Container(
                                                                    width: 150,
                                                                    height: 2,
                                                                    child:
                                                                        Container(
                                                                      color:
                                                                          mS1GreenEigth,
                                                                      width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width,
                                                                      height: 1,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Material(
                                                                color: Colors
                                                                    .white,
                                                                child:
                                                                    Container(
                                                                  color:
                                                                      mGreyFive,
                                                                  width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                                  height: 1,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                              Text(
                                                                mCourseDetail[0]
                                                                        .courseTitle ??
                                                                    "",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: const TextStyle(
                                                                    fontFamily:
                                                                        'OpenSauceSansSemiBold',
                                                                    fontSize:
                                                                        mSizeFour,
                                                                    color:
                                                                        mBlackTwo),
                                                              ),
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                              Text(
                                                                mCourseDetail[0]
                                                                        .description ??
                                                                    "",
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: const TextStyle(
                                                                    fontFamily:
                                                                        'OpenSauceSansRegular',
                                                                    height: 1.5,
                                                                    fontSize:
                                                                        mSizeThree,
                                                                    color:
                                                                        mGreyEigth),
                                                              ),
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                            ]),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.25,
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 20,
                                                                bottom: 10),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          color: Colors.white,
                                                          boxShadow: const [
                                                            BoxShadow(
                                                              color: mGreyTwo,
                                                              blurRadius: 0,
                                                            ),
                                                          ],
                                                        ),
                                                        child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    const SizedBox(
                                                                      width: 20,
                                                                    ),
                                                                    Text(
                                                                      Languages.of(
                                                                              context)!
                                                                          .mCoursesSummary,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      style: const TextStyle(
                                                                          fontFamily:
                                                                              'OpenSauceSansBold',
                                                                          fontSize:
                                                                              mSizeThree,
                                                                          color:
                                                                              mBlackTwo),
                                                                    ),
                                                                  ]),
                                                              const SizedBox(
                                                                height: 20,
                                                              ),
                                                              Material(
                                                                color: Colors
                                                                    .white,
                                                                child:
                                                                    Container(
                                                                  color:
                                                                      mGreyThree,
                                                                  width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                                  height: 1,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 20,
                                                              ),
                                                              SizedBox(
                                                                height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height,
                                                                child: ListView
                                                                    .builder(
                                                                        itemCount: mCourseDetail[0]
                                                                            .chapters!
                                                                            .length,
                                                                        itemBuilder:
                                                                            (context,
                                                                                index) {
                                                                          // final mgetCoursesDetails = mCoursesDetailsList![0].chapters![index];
                                                                          return Card(
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(10),
                                                                            ),
                                                                            color:
                                                                                mGreyTwolight,
                                                                            child: Theme(
                                                                                data: ThemeData().copyWith(dividerColor: Colors.transparent),
                                                                                child: ExpansionTile(
                                                                                  title: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                                                    const SizedBox(
                                                                                      height: 5,
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        Expanded(
                                                                                            flex: 1,
                                                                                            child: Container(
                                                                                              width: MediaQuery.of(context).size.width * 0.25,
                                                                                              child: Text(
                                                                                                "Module ${index + 1}",
                                                                                                style: const TextStyle(fontFamily: 'OpenSauceSansRegular', fontSize: mSizeTwo, color: mGreyEigth),
                                                                                              ),
                                                                                            )),
                                                                                        Expanded(
                                                                                            flex: 1,
                                                                                            child: Container(
                                                                                              width: MediaQuery.of(context).size.width * 0.25,
                                                                                              child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                                                                                                Expanded(
                                                                                                    flex: 2,
                                                                                                    child: Container(
                                                                                                      width: MediaQuery.of(context).size.width * 0.25,
                                                                                                      child: Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                                                                        SvgPicture.asset(
                                                                                                          'assets/new_ic_clock.svg',
                                                                                                          width: 13,
                                                                                                          height: 13,
                                                                                                        ),
                                                                                                        const SizedBox(
                                                                                                          width: 5,
                                                                                                        ),
                                                                                                        const Text("5.5 Hrs", textAlign: TextAlign.center, style: TextStyle(fontFamily: 'OpenSauceSansRegular', fontSize: mSizeOne, color: mGreySeven))
                                                                                                      ]),
                                                                                                    )),
                                                                                                const SizedBox(
                                                                                                  width: 5,
                                                                                                ),
                                                                                                Expanded(
                                                                                                    flex: 3,
                                                                                                    child: Container(
                                                                                                      width: MediaQuery.of(context).size.width * 0.25,
                                                                                                      child: Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                                                                        SvgPicture.asset(
                                                                                                          'assets/new_ic_video.svg',
                                                                                                          width: 13,
                                                                                                          height: 13,
                                                                                                        ),
                                                                                                        const SizedBox(
                                                                                                          width: 5,
                                                                                                        ),
                                                                                                        Text("${mCourseDetail[0].chapters![index].lessonCount} Videos", textAlign: TextAlign.center, style: const TextStyle(fontFamily: 'OpenSauceSansRegular', fontSize: mSizeOne, color: mGreySeven))
                                                                                                      ]),
                                                                                                    )),
                                                                                                const SizedBox(
                                                                                                  width: 5,
                                                                                                ),
                                                                                                Expanded(
                                                                                                    flex: 1,
                                                                                                    child: SizedBox(
                                                                                                      width: MediaQuery.of(context).size.width * 0.25,
                                                                                                      child: Align(
                                                                                                          alignment: Alignment.centerRight,
                                                                                                          child: SvgPicture.asset(
                                                                                                            'assets/new_ic_downarrow.svg',
                                                                                                            width: 20,
                                                                                                            height: 20,
                                                                                                          )),
                                                                                                    )),
                                                                                              ]),
                                                                                            )),
                                                                                      ],
                                                                                    ),
                                                                                    const SizedBox(
                                                                                      height: 10,
                                                                                    ),
                                                                                    Text(
                                                                                      mCourseDetail[0].chapters![index].chapterName ?? "",
                                                                                      style: const TextStyle(fontFamily: 'OpenSauceSansSemiBold', fontSize: mSizeTwo, color: mBlackColor),
                                                                                    ),
                                                                                    const SizedBox(
                                                                                      height: 5,
                                                                                    ),
                                                                                  ]),
                                                                                  children: [
                                                                                    const SizedBox(
                                                                                      height: 10,
                                                                                    ),
                                                                                    Container(
                                                                                      color: mGreyThree,
                                                                                      height: 1,
                                                                                      margin: const EdgeInsets.only(left: 10, right: 10),
                                                                                      width: MediaQuery.of(context).size.width,
                                                                                    ),
                                                                                    /*Text("sdg")*/
                                                                                    Container(
                                                                                      height: mCourseDetail[0].chapters![index].lessons!.length * 50,
                                                                                      color: mGreyTwolight,
                                                                                      child: ListView.builder(
                                                                                        itemBuilder: ((context, index1) {
                                                                                          final mLessonsList = mCourseDetail[0].chapters![index].lessons![index1];
                                                                                          return LearnVideoItem(
                                                                                            mLessonList: mLessonsList,
                                                                                            onpressed: () {
                                                                                              controller.changeVideo(playVideoFrom: PlayVideoFrom.network(mLessonsList.body!.replaceAll('%3A', ':')));
                                                                                              controller.addListener(_listner);

                                                                                              controller.currentVideoPosition.inHours;
                                                                                              print(controller.currentVideoPosition.inSeconds);
                                                                                            },
                                                                                          );
                                                                                        }),
                                                                                        itemCount: mCourseDetail[0].chapters![index].lessons!.length,
                                                                                      ),
                                                                                    )
                                                                                  ], // Some list of List Tile's or widget of that kind,
                                                                                )),
                                                                          );

                                                                          //MyCourseItem(mChapterList: mgetCoursesDetails);
                                                                        }),
                                                              )
                                                            ]),
                                                      ),
                                                    ),
                                                  ],
                                                ), //
                                              )),
                                        )
                                      : Text("")),
                              Visibility(
                                  visible: mSelectView == 4 ? true : false,
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
                                                                  .mResources,
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
                                                    padding: const EdgeInsets
                                                        .fromLTRB(
                                                        30, 10, 10, 10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Expanded(
                                                          flex: 9,
                                                          child: Container(
                                                              height: 45,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30),
                                                                color: mGreyTwo,
                                                                boxShadow: const [
                                                                  BoxShadow(
                                                                    color:
                                                                        mGreyTwo,
                                                                    blurRadius:
                                                                        1.0,
                                                                  ),
                                                                ],
                                                              ),
                                                              child: SearchBar(
                                                                overlayColor:
                                                                    MaterialStateProperty
                                                                        .resolveWith(
                                                                            (states) {
                                                                  // If the button is pressed, return green, otherwise blue
                                                                  if (states.contains(
                                                                      MaterialState
                                                                          .hovered)) {
                                                                    return mGreyTwo;
                                                                  }
                                                                  return mGreyTwo;
                                                                }),
                                                                padding: MaterialStateProperty.all(
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            10,
                                                                        right:
                                                                            10)),
                                                                controller:
                                                                    mSearchEditingController,
                                                                elevation:
                                                                    MaterialStateProperty
                                                                        .all(0),
                                                                side: MaterialStateProperty.all(
                                                                    const BorderSide(
                                                                        color:
                                                                            mGreyTwo)),
                                                                backgroundColor:
                                                                    MaterialStateProperty
                                                                        .all(
                                                                            mGreyTwo),
                                                                hintText: Languages.of(
                                                                        context)!
                                                                    .mSearchCourses,
                                                                hintStyle:
                                                                    MaterialStateProperty
                                                                        .all(
                                                                            const TextStyle(
                                                                  color:
                                                                      mGreySeven,
                                                                  fontSize:
                                                                      mSizeThree,
                                                                  fontFamily:
                                                                      'OpenSauceSansRegular',
                                                                )),
                                                                textStyle:
                                                                    MaterialStateProperty
                                                                        .all(
                                                                            const TextStyle(
                                                                  fontSize:
                                                                      mSizeThree,
                                                                  fontFamily:
                                                                      'OpenSauceSansRegular',
                                                                  color:
                                                                      mGreySeven,
                                                                )),
                                                                onChanged:
                                                                    (String
                                                                        value) {
                                                                  print(
                                                                      'value: $value');
                                                                  filterSearchResults(
                                                                      value);
                                                                },
                                                                onTap: () {
                                                                  print(
                                                                      'tapped');
                                                                  // The code below only works with SearchAnchor
                                                                  // _searchController.openView();
                                                                },
                                                                leading: const Icon(
                                                                    Icons
                                                                        .search,
                                                                    size: 30,
                                                                    color:
                                                                        mGreySeven),
                                                              )),
                                                        ),
                                                        const SizedBox(
                                                          width: 20,
                                                        ),
                                                        Visibility(
                                                            visible: false,
                                                            child: Expanded(
                                                              flex: 3,
                                                              child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Button(
                                                                        mButtonname:
                                                                            Languages.of(context)!
                                                                                .mSearchResult,
                                                                        onpressed:
                                                                            () {},
                                                                        mSelectcolor:
                                                                            mBtnColor,
                                                                        mTextColor:
                                                                            mWhiteColor,
                                                                        mFontSize:
                                                                            16,
                                                                        mWidth:
                                                                            150,
                                                                        mHeigth:
                                                                            40),
                                                                    SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                  ]),
                                                            ))
                                                      ],
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
                                                        30, 10, 10, 10),
                                                    child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                              Languages.of(
                                                                      context)!
                                                                  .mViewCourses,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: const TextStyle(
                                                                  fontFamily:
                                                                      'OpenSauceSansBold',
                                                                  fontSize:
                                                                      mSizeThree,
                                                                  color:
                                                                      mGreyTen))
                                                        ]),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 10, right: 10),
                                                    child:
                                                        SingleChildScrollView(
                                                            child:
                                                                GridView.count(
                                                      crossAxisCount: 4,
                                                      crossAxisSpacing: 0,
                                                      mainAxisSpacing: 0,
                                                      childAspectRatio:
                                                          _aspectRatio,
                                                      shrinkWrap: true,
                                                      children: List.generate(
                                                        mFavList.length,
                                                        (index) {
                                                          final mgetCoursesList =
                                                              mFavList[index];
                                                          return LearnItem(
                                                            onPressed: () {
                                                              setState(() {
                                                                OnLoadEventDetails(
                                                                  "jagadeesan.a1104@gmail.com",
                                                                  mFavList[index]
                                                                          .id ??
                                                                      "",
                                                                );
                                                              });
                                                            },
                                                            mCoursesList:
                                                                mgetCoursesList,
                                                            RemoveFavonpressed:
                                                                () {
                                                              setState(() {
                                                                OnRemoveFav(
                                                                    "jagadeesan.a1104@gmail.com",
                                                                    mFavList[index]
                                                                            .id ??
                                                                        "",
                                                                    1);
                                                              });
                                                            },
                                                            AddFavonpressed:
                                                                () {
                                                              OnloadAddFav(
                                                                  "jagadeesan.a1104@gmail.com",
                                                                  items[index]
                                                                      .id);
                                                            },
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

  void OnloadAddFav(String userId, String? investorid) {
    Loading(mLoaderGif).start(context);

    apiService.AddFavList(userId, investorid ?? "").then((value) async {
      print(value);

      if (value is ApiSuccess) {
        if (CommonResponse.fromJson(value.data)!.message!.status ?? false) {
          Loading.stop();
          setState(() {
            OnLoadLearnList("jagadeesan.a1104@gmail.com");
          });
        } else {
          Loading.stop();
          ErrorToast(
              context: context,
              text: CommonResponse.fromJson(value.data)!.message!.message!);
        }
      } else if (value is ApiFailure) {
        Loading.stop();
      }
    });
  }

  void mGetEventList(String userId) {
    Loading(mLoaderGif).start(context);

    apiService.getEventList(userId).then((value) async {
      print(value);

      if (value is ApiSuccess) {
        if (EventListResponse.fromJson(value.data)!.message!.status ?? false) {
          Loading.stop();
          setState(() {
            mLiveEvent =
                EventListResponse.fromJson(value.data)!.message!.liveEvent!;
            mRecordedEvent =
                EventListResponse.fromJson(value.data)!.message!.recordedEvent!;
          });
        } else {
          Loading.stop();
          ErrorToast(context: context, text: "Error");
        }
      } else if (value is ApiFailure) {
        Loading.stop();
      }
    });
  }

  void OnRegisterEvent(String UserId, String eventId, int mFrom) {
    Widget cancelButton = TextButton(
      child: Text(Languages.of(context)!.mCancel,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontFamily: 'OpenSauceSansRegular',
              fontSize: mSizeThree,
              color: mGreyTen)),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text(Languages.of(context)!.mok,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontFamily: 'OpenSauceSansRegular',
              fontSize: mSizeThree,
              color: mGreyTen)),
      onPressed: () {
        AddRegisterEvent(UserId, eventId, 0, mFrom);

        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text(Languages.of(context)!.meventregister,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontFamily: 'OpenSauceSansRegular',
              fontSize: mSizeTen,
              color: mGreyTen)),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void AddRegisterEvent(String UserId, String courseId, int status, int mFrom) {
    Loading(mLoaderGif).start(context);
    apiService.AddEventRegister(UserId, courseId).then((value) async {
      print(value);

      if (value is ApiSuccess) {
        if (CommonResponse.fromJson(value.data)!.message!.status ?? false) {
          Loading.stop();
          setState(() {
            SucessToast(
                context: context,
                text: CommonResponse.fromJson(value.data)!.message!.message ??
                    "");
            mGetEventList("jagadeesan.a1104@gmail.com");
          });
        } else {
          Loading.stop();
          ErrorToast(
              context: context,
              text: CommonResponse.fromJson(value.data)!.message!.message!);
        }
      } else if (value is ApiFailure) {
        Loading.stop();
      }
    });
  }

  void OnRemoveFav(String UserId, String courseId, int mFrom) {
    Widget cancelButton = TextButton(
      child: Text(Languages.of(context)!.mCancel,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontFamily: 'OpenSauceSansRegular',
              fontSize: mSizeThree,
              color: mGreyTen)),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text(Languages.of(context)!.mok,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontFamily: 'OpenSauceSansRegular',
              fontSize: mSizeThree,
              color: mGreyTen)),
      onPressed: () {
        OnloadChangeFav(UserId, courseId, 0, mFrom);

        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text(Languages.of(context)!.mFavMsg,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontFamily: 'OpenSauceSansRegular',
              fontSize: mSizeTen,
              color: mGreyTen)),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void OnloadChangeFav(String UserId, String courseId, int status, int mFrom) {
    Loading(mLoaderGif).start(context);
    apiService.RemoveFavList(UserId, courseId, status).then((value) async {
      print(value);

      if (value is ApiSuccess) {
        if (CommonResponse.fromJson(value.data)!.message!.status ?? false) {
          Loading.stop();
          setState(() {
            if (mSelectView == 4) {
              OnloadFavList("jagadeesan.a1104@gmail.com");
            } else {
              OnLoadLearnList("jagadeesan.a1104@gmail.com");
            }
          });
        } else {
          Loading.stop();
          ErrorToast(
              context: context,
              text: CommonResponse.fromJson(value.data)!.message!.message!);
        }
      } else if (value is ApiFailure) {
        Loading.stop();
      }
    });
  }

  void OnLoadLearnList(String mUserID) {
    Loading(mLoaderGif).start(context);
    apiService.getLearnList(mUserID).then((value) async {
      print(value);

      if (value is ApiSuccess) {
        if (LearnlistResponse.fromJson(value.data)!.message!.status ?? false) {
          Loading.stop();
          setState(() {
            items.clear();
            mCoursesList.clear();
            mCoursesList =
                LearnlistResponse.fromJson(value.data).message!.coursesList!;
            items = mCoursesList;
          });
        } else {
          Loading.stop();
          ErrorToast(
              context: context,
              text: CommonResponse.fromJson(value.data)!.message!.message!);
        }
      } else if (value is ApiFailure) {
        Loading.stop();
      }
    });
  }

  void OnloadFavList(String UserId) {
    Loading(mLoaderGif).start(context);
    apiService.getLearnFavList(UserId).then((value) async {
      print(value);

      if (value is ApiSuccess) {
        if (LearnlistResponse.fromJson(value.data)!.message!.status ?? false) {
          Loading.stop();
          setState(() {
            // items.clear();
            // mCoursesList.clear();
            mFavList =
                LearnlistResponse.fromJson(value.data).message!.coursesList!;
            mFavList =
                LearnlistResponse.fromJson(value.data).message!.coursesList!;
            // items = mCoursesList;
          });
        } else {
          Loading.stop();
          ErrorToast(context: context, text: "Error");
        }
      } else if (value is ApiFailure) {
        Loading.stop();
      }
    });
  }

  void OnLoadEventDetails(String UserId, String CourseId) {
    Loading(mLoaderGif).start(context);
    apiService.getCoursesDetails(UserId, CourseId).then((value) async {
      print(value);

      if (value is ApiSuccess) {
        if (CourseDetailsResponse.fromJson(value.data)!.message!.status ??
            false) {
          Loading.stop();
          setState(() {
            // items.clear();
            // mCoursesList.clear();
            mCourseDetail = CourseDetailsResponse.fromJson(value.data)
                .message!
                .courseDetails!;

            /* for (int i = 0; i < mCourseDetail![0].chapters!.length; i++) {
              for (int j = 0;
                  j < mCourseDetail![0].chapters![i].lessons!.length;
                  j++) {
                controller = PodPlayerController(
                  playVideoFrom: PlayVideoFrom.network(mCourseDetail![0]
                      .chapters![i]
                      .lessons![j]
                      .body!
                      .replaceAll('%3A', ':')),
                ); //Your file here

                // print(controller.value.duration);

                mLessonURLList
                    .add(controller.totalVideoLength.inSeconds.toString());

                // mLessonNameList.add(
                //     mCourseDetail![0].chapters![i].lessons![j].lessonName!);
                //
                // mLessonViewedList.add(mCourseDetail![0]
                //     .chapters![i]
                //     .lessons![j]
                //     .courseSeenStatus!);
              }
            }

            if (mPlayfirsttime) {
              controller.changeVideo(
                  playVideoFrom: PlayVideoFrom.network(mLessonURLList[0]));
              mPlayfirsttime = false;
            }*/

            controller = PodPlayerController(
              playVideoFrom: PlayVideoFrom.network(mCourseDetail[0]
                  .chapters![0]
                  .lessons![0]
                  .body!
                  .replaceAll('%3A', ':')),
            )..initialise().then((value) {
                setState(() {
                  isVideoPlaying = controller.isVideoPlaying;
                  controller.mute();
                });
              });
            controller.addListener(_listner);

            totalHour = controller.currentVideoPosition.inHours == 0
                ? '0'
                : '${controller.currentVideoPosition.inHours}:';
            totalMinute =
                controller.currentVideoPosition.toString().split(':')[1];
            totalSeconds = (controller.currentVideoPosition -
                    Duration(
                        minutes: controller.currentVideoPosition.inMinutes))
                .inSeconds
                .toString()
                .padLeft(2, '0');

            totalHour = controller.currentVideoPosition.inSeconds.toString();

            VideototalDuration =
                controller.totalVideoLength.inSeconds.toString();
            print("API CAll${'$totalHour hour: '
                '$totalMinute minute: '
                '$totalSeconds seconds'}");

            if ((int.parse(VideototalDuration) - 10) == int.parse(totalHour)) {
              if (mAPICall) {
                //mAPICall = false;
                print("API CAll");
              }

              // ErrorToast(context: context, text: "API CAll");
            }

            controller.addListener(_listner);

            mSelectView = 3;
            // items = mCoursesList;
          });
        } else {
          Loading.stop();
          ErrorToast(context: context, text: "Error");
        }
      } else if (value is ApiFailure) {
        Loading.stop();
      }
    });
  }
}

class MenuItem {
  const MenuItem({
    required this.text,
  });

  final String text;
}
