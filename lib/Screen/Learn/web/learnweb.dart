import 'dart:html';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Model/SearchinvestorslistResponse.dart';
import 'package:startinsights/Repository/SearchinvestorsRepo.dart';
import 'package:startinsights/Screen/Learn/bloc/learn_bloc.dart';
import 'package:startinsights/Screen/Learn/bloc/learn_state.dart';
import 'package:startinsights/Screen/Learn/web/learnItem.dart';
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

  ValueNotifier<bool> setnotifier = ValueNotifier(true);

  // 1-> LMS list , 3->LMS list Details , 2 -> Event View
  int mSelectView = 1;
  int mGetCount = 0;
  int numPages = 1;
  int currentPage = 1;
  int SetcurrentPage = 0;

  final SearchinvestorsRepo apiService = SearchinvestorsRepo();

  late Widget _iframeWidget;
  final IFrameElement _iframeElement = IFrameElement();

  int mfundingmaxcount = 0;

  String mFilterValue = "";
  String mStatusChange = "";

  String mSelectId = "";

  @override
  void initState() {
    super.initState();
    mLoadMasterData();

    /*  <iframe src="https://startinsights.fornax.ai/"
    style="position:fixed; top:0; left:0; bottom:0; "
    "right:0; width:100%; height:100%; border:none; margin:0; padding:0;
    overflow:hidden; z-index:999999;"></iframe>*/

    _iframeElement.height = '100%';
    _iframeElement.width = '100%';

    _iframeElement.style.margin = '0';
    _iframeElement.style.padding = '0';
    _iframeElement.style.position = 'fixed';
    _iframeElement.src = 'https://startinsights.fornax.ai/';
    _iframeElement.style.border = 'none';

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'iframeElement',
      (int viewId) => _iframeElement,
    );

    _iframeWidget = HtmlElementView(
      key: UniqueKey(),
      viewType: 'iframeElement',
    );

    //ignore: undefined_prefixed_name
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
                mSearchInvestorsList = state.mSearchInvestorsList;
                mGetCount = state.mSearchInvestorsCount;
                if (isScreenFirst) {
                  isScreenFirst = false;
                  items = mSearchInvestorsList;
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
                                                        10,
                                                        // mBookAnExpertList.length,
                                                        (index) {
                                                          // final mgetCoursesList = mBookAnExpertList[index];
                                                          return LearnItem(
                                                            onPressed: () {
                                                              setState(() {
                                                                mSelectView = 3;
                                                              });
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
                                                        itemCount: 10,
                                                        itemBuilder:
                                                            (_, index) {
                                                          // final mDashboardList =
                                                          // mDashboarddata[index];
                                                          return InkWell(
                                                            onTap: () {},
                                                            child: Container(
                                                              height: 400,
                                                              width: 300,
                                                              margin: EdgeInsets
                                                                  .all(10),
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(10),
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                                color: mGreyTwo,
                                                                boxShadow: const [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .white,
                                                                    blurRadius:
                                                                        1.0,
                                                                  ),
                                                                ],
                                                              ),
                                                              child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Stack(
                                                                      children: [
                                                                        Align(
                                                                            alignment:
                                                                                Alignment.center,
                                                                            child: ClipRRect(
                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                              child: SvgPicture.asset(
                                                                                'assets/new_ic_watermarkbg.svg',
                                                                                width: 350,
                                                                                height: 140,
                                                                              ),
                                                                            )),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.end,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Align(
                                                                                alignment: Alignment.topRight,
                                                                                child: ClipRRect(
                                                                                  borderRadius: BorderRadius.circular(8.0),
                                                                                  child: Container(
                                                                                    height: 25,
                                                                                    width: 80,
                                                                                    decoration: BoxDecoration(
                                                                                      borderRadius: BorderRadius.circular(15),
                                                                                      color: mRedColorOne,
                                                                                      boxShadow: const [
                                                                                        BoxShadow(
                                                                                          color: mRedColorOne,
                                                                                          blurRadius: 1.0,
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    child: Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                                                                      Container(
                                                                                        height: 15,
                                                                                        width: 15,
                                                                                        //square box; equal height and width so that it won't look like oval
                                                                                        decoration: BoxDecoration(
                                                                                          color: Colors.white,
                                                                                          shape: BoxShape.circle,
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: 5,
                                                                                      ),
                                                                                      Text(Languages.of(context)!.mLive, textAlign: TextAlign.center, style: const TextStyle(fontFamily: 'OpenSauceSansSemiBold', fontSize: mSizeThree, color: Colors.white))
                                                                                    ]),
                                                                                  ),
                                                                                )),
                                                                            SizedBox(
                                                                              width: 20,
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          20,
                                                                    ),
                                                                    Center(
                                                                        child: Text(
                                                                            "1.1 Understand the investor's mind in ",
                                                                            textAlign: TextAlign
                                                                                .center,
                                                                            style: const TextStyle(
                                                                                fontFamily: 'OpenSauceSansSemiBold',
                                                                                fontSize: mSizeThree,
                                                                                color: mGreyTen))),
                                                                    SizedBox(
                                                                      height:
                                                                          20,
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                            Languages.of(context)!
                                                                                .mSpeaker,
                                                                            textAlign: TextAlign
                                                                                .center,
                                                                            style: const TextStyle(
                                                                                fontFamily: 'OpenSauceSansSemiBold',
                                                                                fontSize: mSizeThree,
                                                                                color: mBlueOne)),
                                                                        SizedBox(
                                                                          width:
                                                                              10,
                                                                        ),
                                                                        Text(
                                                                            "Prem Ananth & Rajesh Kumar",
                                                                            textAlign: TextAlign
                                                                                .center,
                                                                            style: const TextStyle(
                                                                                fontFamily: 'OpenSauceSansRegular',
                                                                                fontSize: mSizeThree,
                                                                                color: mBlueOne))
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          10,
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
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        SvgPicture
                                                                            .asset(
                                                                          'assets/new_ic_calendar.svg',
                                                                          width:
                                                                              25,
                                                                          height:
                                                                              25,
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              10,
                                                                        ),
                                                                        Text(
                                                                            "31-Oct-2024 | 5:00PM",
                                                                            textAlign: TextAlign
                                                                                .center,
                                                                            style: const TextStyle(
                                                                                fontFamily: 'OpenSauceSansRegular',
                                                                                fontSize: mSizeTwo,
                                                                                color: mGreySeven))
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          20,
                                                                    ),
                                                                    PrimaryButton(
                                                                        mButtonname:
                                                                            Languages.of(context)!
                                                                                .mregister,
                                                                        onpressed:
                                                                            () async {},
                                                                        mSelectcolor:
                                                                            mS1Green,
                                                                        mTextColor:
                                                                            mWhiteColor,
                                                                        mFontSize:
                                                                            mSizeTwo,
                                                                        mHeigth:
                                                                            40),
                                                                  ]),
                                                            ),
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
                                                    height: 250,
                                                    child: ListView.builder(
                                                        shrinkWrap: true,
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemCount: 10,
                                                        itemBuilder:
                                                            (_, index) {
                                                          // final mDashboardList =
                                                          // mDashboarddata[index];
                                                          return InkWell(
                                                            onTap: () {},
                                                            child: Container(
                                                              height: 250,
                                                              width: 300,
                                                              margin: EdgeInsets
                                                                  .all(10),
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(10),
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                                color: mGreyTwo,
                                                                boxShadow: const [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .white,
                                                                    blurRadius:
                                                                        1.0,
                                                                  ),
                                                                ],
                                                              ),
                                                              child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Stack(
                                                                      children: [
                                                                        Align(
                                                                            alignment:
                                                                                Alignment.center,
                                                                            child: ClipRRect(
                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                              child: SvgPicture.asset(
                                                                                'assets/new_ic_watermarkbg.svg',
                                                                                width: 350,
                                                                                height: 140,
                                                                              ),
                                                                            )),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          20,
                                                                    ),
                                                                    Center(
                                                                        child: Text(
                                                                            "1.1 Understand the investor's mind in ",
                                                                            textAlign: TextAlign
                                                                                .center,
                                                                            style: const TextStyle(
                                                                                fontFamily: 'OpenSauceSansSemiBold',
                                                                                fontSize: mSizeThree,
                                                                                color: mGreyTen))),
                                                                    SizedBox(
                                                                      height:
                                                                          20,
                                                                    ),
                                                                  ]),
                                                            ),
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
                                  child: Expanded(
                                    child: ScrollConfiguration(
                                        behavior:
                                            ScrollConfiguration.of(context)
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
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.5,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10,
                                                          right: 10,
                                                          top: 20,
                                                          bottom: 10),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
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
                                                              .center,
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
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  mSelectView =
                                                                      1;
                                                                });
                                                              },
                                                              child: SvgPicture
                                                                  .asset(
                                                                'assets/new_ic_serice_back.svg',
                                                                width: 20,
                                                                height: 20,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                              "1.1 Understand the investor mind in startups",
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
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Container(
                                                            width: 800,
                                                            height: 450,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15),
                                                              color:
                                                                  Colors.amber,
                                                              boxShadow: const [
                                                                BoxShadow(
                                                                  color:
                                                                      mGreyTwo,
                                                                  blurRadius: 0,
                                                                ),
                                                              ],
                                                            )),
                                                        SizedBox(
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
                                                                  Colors.white,
                                                              onTap: () {},
                                                              child: Container(
                                                                width: 150,
                                                                height: 40,
                                                                child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    child: Text(
                                                                        Languages.of(context)!
                                                                            .mCoursesOverview,
                                                                        textAlign:
                                                                            TextAlign
                                                                                .center,
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'OpenSauceSansBold',
                                                                            fontSize:
                                                                                mSizeThree,
                                                                            color:
                                                                                mS1GreenEigth))),
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
                                                            Container(
                                                              width: 150,
                                                              height: 2,
                                                              child: Container(
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
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Text(
                                                          "1.1 Understand the investor mind in startups",
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: const TextStyle(
                                                              fontFamily:
                                                                  'OpenSauceSansSemiBold',
                                                              fontSize:
                                                                  mSizeFour,
                                                              color: mBlackTwo),
                                                        ),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Text(
                                                          "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32.",
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: const TextStyle(
                                                              fontFamily:
                                                                  'OpenSauceSansRegular',
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
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.25,
                                                  padding: EdgeInsets.only(
                                                      top: 20, bottom: 10),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
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
                                                        SizedBox(
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
                                                              SizedBox(
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
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Material(
                                                          color: Colors.white,
                                                          child: Container(
                                                            color: mGreyThree,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            height: 1,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        SizedBox(
                                                          height: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .height,
                                                          child:
                                                              ListView.builder(
                                                                  itemCount: 25,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    // final mgetCoursesDetails = mCoursesDetailsList![0].chapters![index];
                                                                    return Card(
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                      ),
                                                                      color:
                                                                          mGreyTwolight,
                                                                      child: Theme(
                                                                          data: ThemeData().copyWith(dividerColor: Colors.transparent),
                                                                          child: ExpansionTile(
                                                                            title:
                                                                                Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                                              SizedBox(
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
                                                                                          "Padhu",
                                                                                          style: const TextStyle(fontFamily: 'OpenSauceSansRegular', fontSize: 16, color: mGreyEigth),
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
                                                                                                  SizedBox(
                                                                                                    width: 5,
                                                                                                  ),
                                                                                                  Text("5.5 Hrs", textAlign: TextAlign.center, style: const TextStyle(fontFamily: 'OpenSauceSansRegular', fontSize: mSizeOne, color: mGreySeven))
                                                                                                ]),
                                                                                              )),
                                                                                          SizedBox(
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
                                                                                                  SizedBox(
                                                                                                    width: 5,
                                                                                                  ),
                                                                                                  Text("100 Videos", textAlign: TextAlign.center, style: const TextStyle(fontFamily: 'OpenSauceSansRegular', fontSize: mSizeOne, color: mGreySeven))
                                                                                                ]),
                                                                                              )),
                                                                                          SizedBox(
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
                                                                              SizedBox(
                                                                                height: 10,
                                                                              ),
                                                                              Text(
                                                                                "1.1 Understand the investor's mind in startups",
                                                                                style: const TextStyle(fontFamily: 'OpenSauceSansSemiBold', fontSize: mSizeTwo, color: mBlackColor),
                                                                              ),
                                                                              SizedBox(
                                                                                height: 5,
                                                                              ),
                                                                            ]),
                                                                            children: [
                                                                              SizedBox(
                                                                                height: 10,
                                                                              ),
                                                                              Container(
                                                                                color: mGreyThree,
                                                                                height: 1,
                                                                                margin: const EdgeInsets.only(left: 10, right: 10),
                                                                                width: MediaQuery.of(context).size.width,
                                                                              ),
                                                                              Text("sdg")
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
