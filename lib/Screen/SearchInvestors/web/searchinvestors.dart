import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Model/SearchinvestorslistResponse.dart';
import 'package:startinsights/Repository/pitchroom_repository.dart';
import 'package:startinsights/Screen/SearchInvestors/bloc/searchinvestors_bloc.dart';
import 'package:startinsights/Screen/SearchInvestors/bloc/searchinvestors_state.dart';
import 'package:startinsights/Screen/SearchInvestors/web/searchinvestorsitemList.dart';
import 'package:startinsights/Utils/FontSizes.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Utils/screens.dart';
import 'package:startinsights/Widgets/Appbarnew.dart';
import 'package:startinsights/Widgets/button.dart';
import 'package:startinsights/Widgets/sidemenunew.dart';

class SearchInvestorsWeb extends StatefulWidget {
  SearchInvestorsWeb({super.key});

  @override
  State<SearchInvestorsWeb> createState() => _SearchInvestorsState();
}

class _SearchInvestorsState extends State<SearchInvestorsWeb> {
  @override
  late SearchInvestorsBloc mSearchInvestorsBloc;

  final PitchroomRepository _apiService1 = PitchroomRepository();
  int selectedIndex = -1; //dont set it to 0
  bool isExpanded = true;

  final TextEditingController mSearchEditingController =
      TextEditingController();

  var items = <SearchInvestorsList>[];
  List<SearchInvestorsList> mSearchInvestorsList = [];
  bool isScreenFirst = true;

  ValueNotifier<bool> setnotifier = ValueNotifier(true);

  // 1-> Search Investors , 2->Funding CRM
  int mSelectView = 1;

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
    mSearchInvestorsBloc = SearchInvestorsBloc(mContext: context);

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
          body: BlocConsumer<SearchInvestorsBloc, SearchInvestorsStatus>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is GetSearchInvestorsInfoSuccessState) {
                mSearchInvestorsList = state.mSearchInvestorsList;

                if (isScreenFirst) {
                  isScreenFirst = false;
                  items = mSearchInvestorsList;
                }
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
                        mFrom: 2,
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
                                mFrom: 2,
                                onPressed: () {
                                  //ErrorToast(context: context, text: "Test");
                                },
                                onPressedLogout: () {
                                  setState(() {});
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                  child: Column(
                                children: [
                                  Container(
                                    height: 70,
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
                                                        .mFundraising,
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
                                                Container(
                                                    width: 400,
                                                    height: 60,
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
                                                                decoration:
                                                                    mSelectView ==
                                                                            1
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
                                                                            .mSearchInvestors,
                                                                        textAlign:
                                                                            TextAlign
                                                                                .center,
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'OpenSauceSansMedium',
                                                                            fontSize:
                                                                                mSizeThree,
                                                                            color: (mSelectView == 1
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
                                                                            .mFundingCRM,
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
                                                const SizedBox(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Image(
                                                        width: 50,
                                                        height: 50,
                                                        image: AssetImage(
                                                          "assets/new_ic_fav.png",
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
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
                                                                  .mFundraisinglink,
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
                                                                  .mSearchInvestors,
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
                                                          flex: 4,
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
                                                                    .msearchhint,
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
                                                          flex: 6,
                                                          child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Container(
                                                                  width: 120,
                                                                  child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                            Languages.of(context)!
                                                                                .mIndia,
                                                                            textAlign: TextAlign
                                                                                .center,
                                                                            style: const TextStyle(
                                                                                fontFamily: 'OpenSauceSansRegular',
                                                                                fontSize: mSizeThree,
                                                                                color: mGreyEigth)),
                                                                      ]),
                                                                ),
                                                                const SizedBox(
                                                                  width: 15,
                                                                ),
                                                                Container(
                                                                  width: 2,
                                                                  height: 20,
                                                                  color:
                                                                      mGreyEigth,
                                                                ),
                                                                const SizedBox(
                                                                  width: 15,
                                                                ),
                                                                Container(
                                                                  width: 150,
                                                                  child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                            Languages.of(context)!
                                                                                .mEarlystage,
                                                                            textAlign: TextAlign
                                                                                .center,
                                                                            style: const TextStyle(
                                                                                fontFamily: 'OpenSauceSansRegular',
                                                                                fontSize: mSizeThree,
                                                                                color: mGreyEigth)),
                                                                      ]),
                                                                ),
                                                                const SizedBox(
                                                                  width: 15,
                                                                ),
                                                                Container(
                                                                  width: 2,
                                                                  height: 20,
                                                                  color:
                                                                      mGreyEigth,
                                                                ),
                                                                const SizedBox(
                                                                  width: 15,
                                                                ),
                                                                Container(
                                                                  width: 120,
                                                                  child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                            Languages.of(context)!
                                                                                .mRoundsize,
                                                                            textAlign: TextAlign
                                                                                .center,
                                                                            style: const TextStyle(
                                                                                fontFamily: 'OpenSauceSansRegular',
                                                                                fontSize: mSizeThree,
                                                                                color: mGreyEigth)),
                                                                        const SizedBox(
                                                                          width:
                                                                              10,
                                                                        ),
                                                                        const Icon(
                                                                            Icons
                                                                                .arrow_drop_down_outlined,
                                                                            size:
                                                                                30)
                                                                      ]),
                                                                ),
                                                                const SizedBox(
                                                                  width: 30,
                                                                ),
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
                                                                    mHeigth: 40)
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
                                                                  .mInvestorsFound,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
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
                                                    padding: const EdgeInsets
                                                        .fromLTRB(
                                                        30, 10, 10, 10),
                                                    child:
                                                        SingleChildScrollView(
                                                            child:
                                                                GridView.count(
                                                      crossAxisCount: 4,
                                                      crossAxisSpacing: 10,
                                                      mainAxisSpacing: 10,
                                                      shrinkWrap: true,
                                                      children: List.generate(
                                                        items.length,
                                                        (index) {
                                                          final mSearchList =
                                                              items[index];
                                                          return SearchInvestorsItemList(
                                                              mIndex: index,
                                                              mSearchInvestorsList:
                                                                  mSearchList);
                                                        },
                                                      ),
                                                    )),
                                                  ),
                                                  const SizedBox(
                                                    height: 30,
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
}
