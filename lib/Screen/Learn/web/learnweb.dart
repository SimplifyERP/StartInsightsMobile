import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Model/FundingCrmResponse.dart';
import 'package:startinsights/Model/SearchinvestorslistResponse.dart';
import 'package:startinsights/Repository/SearchinvestorsRepo.dart';
import 'package:startinsights/Screen/Learn/bloc/learn_bloc.dart';
import 'package:startinsights/Screen/Learn/bloc/learn_state.dart';
import 'package:startinsights/Utils/FontSizes.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Utils/screens.dart';
import 'package:startinsights/Widgets/Appbarnew.dart';
import 'package:startinsights/Widgets/button.dart';
import 'package:startinsights/Widgets/primary_button.dart';
import 'package:startinsights/Widgets/sidemenunew.dart';

class LearnWeb extends StatefulWidget {
  LearnWeb({super.key});

  @override
  State<LearnWeb> createState() => _LearnWebState();
}

class _LearnWebState extends State<LearnWeb> {
  @override
  late LearnBloc mLearnBloc;

  final SearchinvestorsRepo apiService1 = SearchinvestorsRepo();
  int selectedIndex = -1; //dont set it to 0
  bool isExpanded = true;

  final TextEditingController mSearchEditingController =
      TextEditingController();

  var items = <SearchInvestorsList>[];
  List<SearchInvestorsList> mSearchInvestorsList = [];
  bool isScreenFirst = true;

  final List<String> itemsmm = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];
  String? selectedValue;

  ValueNotifier<bool> setnotifier = ValueNotifier(true);

  // 1-> LMS list , 2->LMS list Details , 3 ->  ->
  int mSelectView = 1;
  int mGetCount = 0;
  int numPages = 1;
  int currentPage = 1;
  int SetcurrentPage = 0;

  final SearchinvestorsRepo apiService = SearchinvestorsRepo();

  late Sortlist mSortlist;
  int mSortlistCount = 0;

  late Contacted mContacted;
  int mContactedCount = 0;

  late Pitched mPitched;
  int mPitchedCount = 0;

  late Diligence mDiligence;
  int mDiligenceCount = 0;

  late Won mWon;
  int mWonCount = 0;

  late Lost mLost;
  int mLostCount = 0;

  int mfundingmaxcount = 0;

  List<Investor> mSortlistList = [];
  List<Investor> mContactedList = [];
  List<Investor> mPitchedList = [];
  List<Investor> mDiligenceList = [];
  List<Investor> mWonList = [];
  List<Investor> mLostList = [];

  List<FundingCrmList> mFundingCRMList = [];
  List<SearchInvestorsList> mFavList = [];

  SearchInvestorsList? mViewSearchInvestorsList;

  String mFilterValue = "";
  String mStatusChange = "";

  String mSelectId = "";

  List<String> mStages = [];

  final List<String> itemStages = [];

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
    mSearchEditingController.dispose();
  }

  Widget build(BuildContext context) {
    List<MenuItem> StagesItems = [
      MenuItem(
        text: Languages.of(context)!.mSortlistMenu,
      ),
      MenuItem(
        text: Languages.of(context)!.mContactedMenu,
      ),
      MenuItem(
        text: Languages.of(context)!.mPitchedMenu,
      ),
      MenuItem(
        text: Languages.of(context)!.mDiligenceMenu,
      ),
      MenuItem(
        text: Languages.of(context)!.mWonMenu,
      ),
      MenuItem(
        text: Languages.of(context)!.mLostMenu,
      ),
    ];
    itemStages.clear();
    itemStages.add(Languages.of(context)!.mPreseedMenu);
    itemStages.add(Languages.of(context)!.mSeedMenu);
    itemStages.add(Languages.of(context)!.mEarlyMenu);
    itemStages.add(Languages.of(context)!.mGrowthMenu);

    mLearnBloc = LearnBloc(mContext: context);

    void OnLoadNext() {
      Navigator.pushReplacementNamed(context, dashboardRoute);
    }

    final ScrollController controller = ScrollController();

    void filterSearchResults(String query) {
      setState(() {
        items = mSearchInvestorsList
            .where((item) =>
                item.title!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }

    var _crossAxisSpacing = 8;
    var _screenWidth = MediaQuery.of(context).size.width;
    var _crossAxisCount = 2;
    var _width = (_screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    var cellHeight = 900;
    var _aspectRatio = _width / cellHeight;

    var DetailscellHeight = 700;
    var DetailsaspectRatio = DetailscellHeight / cellHeight;

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
                mSearchInvestorsList = state.mSearchInvestorsList;
                mGetCount = state.mSearchInvestorsCount;
                if (isScreenFirst) {
                  isScreenFirst = false;
                  items = mSearchInvestorsList;
                }
                numPages = (mGetCount / 8).ceil();
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
                        mFrom: 3,
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
                                                                });
                                                              },
                                                              child: Container(
                                                                decoration: (mSelectView ==
                                                                            1 ||
                                                                        mSelectView ==
                                                                            4)
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
                                                                            color: (mSelectView == 1 || mSelectView == 4
                                                                                ? Colors.white
                                                                                : mS1GreenNine)))),
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
                                                        )
                                                      ],
                                                    )),
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
                                                        Expanded(
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
                                                                    mWidth: 150,
                                                                    mHeigth:
                                                                        40),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                SizedBox(
                                                                  child: InkWell(
                                                                      onTap: () {
                                                                        setState(
                                                                            () {
                                                                          mSelectView =
                                                                              3;
                                                                        });
                                                                      },
                                                                      child: Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Image(
                                                                            width:
                                                                                50,
                                                                            height:
                                                                                50,
                                                                            image: (mSelectView == 3)
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
                                                                Container(
                                                                  width: 10,
                                                                ),
                                                              ]),
                                                        )
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
                                                  Column(
                                                    children: [
                                                      Container(
                                                        height: 320,
                                                        width: 300,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
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
                                                              Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.0),
                                                                    child: SvgPicture
                                                                        .asset(
                                                                      'assets/new_ic_watermarkbg.svg',
                                                                      width:
                                                                          280,
                                                                      height:
                                                                          140,
                                                                    ),
                                                                  )),
                                                              Center(
                                                                  child: Text(
                                                                      "1.1 Understand the investor's mind in startups",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: const TextStyle(
                                                                          fontFamily:
                                                                              'OpenSauceSansSemiBold',
                                                                          fontSize:
                                                                              mSizeThree,
                                                                          color:
                                                                              mGreyTen))),
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Expanded(
                                                                      flex: 3,
                                                                      child:
                                                                          Row(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          SvgPicture
                                                                              .asset(
                                                                            'assets/new_ic_chapters.svg',
                                                                            width:
                                                                                15,
                                                                            height:
                                                                                15,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                          Text(
                                                                              Languages.of(context)!.mChapters,
                                                                              textAlign: TextAlign.center,
                                                                              style: const TextStyle(fontFamily: 'OpenSauceSansRegular', fontSize: mSizeTwo, color: mGreySeven))
                                                                        ],
                                                                      )),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Expanded(
                                                                      flex: 3,
                                                                      child:
                                                                          Row(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          SvgPicture
                                                                              .asset(
                                                                            'assets/new_ic_video.svg',
                                                                            width:
                                                                                15,
                                                                            height:
                                                                                15,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                          Text(
                                                                              Languages.of(context)!.mVideos,
                                                                              textAlign: TextAlign.center,
                                                                              style: const TextStyle(fontFamily: 'OpenSauceSansRegular', fontSize: mSizeTwo, color: mGreySeven))
                                                                        ],
                                                                      )),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Expanded(
                                                                      flex: 3,
                                                                      child:
                                                                          Row(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          SvgPicture
                                                                              .asset(
                                                                            'assets/new_ic_quizze.svg',
                                                                            width:
                                                                                15,
                                                                            height:
                                                                                15,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                          Text(
                                                                              Languages.of(context)!.mQuizzes,
                                                                              textAlign: TextAlign.center,
                                                                              style: const TextStyle(fontFamily: 'OpenSauceSansRegular', fontSize: mSizeTwo, color: mGreySeven))
                                                                        ],
                                                                      ))
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                              Container(
                                                                color:
                                                                    mGreyThree,
                                                                height: 1,
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                              ),
                                                              SizedBox(
                                                                height: 20,
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
                                                                    flex: 8,
                                                                    child: PrimaryButton(
                                                                        mButtonname:
                                                                            Languages.of(context)!
                                                                                .mViewCourse,
                                                                        onpressed:
                                                                            () async {},
                                                                        mSelectcolor:
                                                                            mBlueOne,
                                                                        mTextColor:
                                                                            mWhiteColor,
                                                                        mFontSize:
                                                                            mSizeTwo,
                                                                        mHeigth:
                                                                            40),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 2,
                                                                    child: Align(
                                                                        alignment: Alignment.center,
                                                                        child: InkWell(
                                                                            onTap: () {},
                                                                            child: SvgPicture.asset(
                                                                              'assets/new_ic_heart.svg',
                                                                              width: 25,
                                                                              height: 25,
                                                                            )
                                                                            // Image.asset('assets/new_ic_heart.png',
                                                                            //         width: 25,
                                                                            //         height: 25,
                                                                            //         fit: BoxFit.fill)
                                                                            //     : SvgPicture.asset(
                                                                            //     'assets/new_ic_emptyheart.svg',
                                                                            //     width: 25,
                                                                            //     height: 25,
                                                                            //     fit: BoxFit.fill),
                                                                            )),
                                                                  )
                                                                ],
                                                              ),
                                                            ]),
                                                      )
                                                    ],
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
                                        children: [],
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
}

class MenuItem {
  const MenuItem({
    required this.text,
  });

  final String text;
}
