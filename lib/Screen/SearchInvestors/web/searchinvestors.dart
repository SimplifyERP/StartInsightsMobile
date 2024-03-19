import 'package:custom_gif_loading/custom_gif_loading.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_network/image_network.dart';
import 'package:startinsights/Libery/numberpaginator/lib/number_paginator.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Model/FavouriteResponse.dart';
import 'package:startinsights/Model/FundingCrmResponse.dart';
import 'package:startinsights/Model/SearchinvestorslistResponse.dart';
import 'package:startinsights/Network/api_result_handler.dart';
import 'package:startinsights/Repository/SearchinvestorsRepo.dart';
import 'package:startinsights/Screen/SearchInvestors/bloc/searchinvestors_bloc.dart';
import 'package:startinsights/Screen/SearchInvestors/bloc/searchinvestors_state.dart';
import 'package:startinsights/Screen/SearchInvestors/web/fundingcrmlist.dart';
import 'package:startinsights/Screen/SearchInvestors/web/searchinvestorsitemList.dart';
import 'package:startinsights/Utils/FontSizes.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Utils/constant_methods.dart';
import 'package:startinsights/Utils/screens.dart';
import 'package:startinsights/Utils/utils.dart';
import 'package:startinsights/Widgets/Appbarnew.dart';
import 'package:startinsights/Widgets/button.dart';
import 'package:startinsights/Widgets/deletebutton.dart';
import 'package:startinsights/Widgets/servicebutton.dart';
import 'package:startinsights/Widgets/sidemenunew.dart';

class SearchInvestorsWeb extends StatefulWidget {
  SearchInvestorsWeb({super.key});

  @override
  State<SearchInvestorsWeb> createState() => _SearchInvestorsState();
}

class _SearchInvestorsState extends State<SearchInvestorsWeb> {
  @override
  late SearchInvestorsBloc mSearchInvestorsBloc;

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

  // 1-> Search Investors , 2->Funding CRM , 3 -> Fav 4 -> Details view
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
          body: BlocConsumer<SearchInvestorsBloc, SearchInvestorsStatus>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is GetSearchInvestorsInfoSuccessState) {
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
                                                                            .mSearchInvestors,
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

                                                                  OnLoadFundingCRM(
                                                                      "jagadeesan.a1104@gmail.com");
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
                                                SizedBox(
                                                  child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          mSelectView = 3;

                                                          OnloadFavList(
                                                              "jagadeesan.a1104@gmail.com",
                                                              1);
                                                        });
                                                      },
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Image(
                                                            width: 50,
                                                            height: 50,
                                                            image: (mSelectView ==
                                                                    3)
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
                                                          flex: 7,
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
                                                          flex: 3,
                                                          child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Container(
                                                                  width: 150,
                                                                  height: 45,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            30),
                                                                    color:
                                                                        mGreyTwo,
                                                                    boxShadow: const [
                                                                      BoxShadow(
                                                                        color:
                                                                            mGreyTwo,
                                                                        blurRadius:
                                                                            1.0,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  child: Center(
                                                                    child:
                                                                        DropdownButtonHideUnderline(
                                                                      child: DropdownButton2<
                                                                          String>(
                                                                        isExpanded:
                                                                            true,
                                                                        customButton: Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                                            children: [
                                                                              Image.asset('assets/new_ic_filter.png', width: 20, height: 20),
                                                                              const SizedBox(
                                                                                width: 10,
                                                                              ),
                                                                              Text((mFilterValue.isEmpty) ? Languages.of(context)!.mFilter : mFilterValue, textAlign: TextAlign.center, style: const TextStyle(fontFamily: 'OpenSauceSansRegular', fontSize: mSizeThree, color: mGreyEigth)),
                                                                              const SizedBox(
                                                                                width: 10,
                                                                              ),
                                                                              const Icon(Icons.arrow_drop_down_outlined, size: 30)
                                                                            ]),
                                                                        items: itemStages
                                                                            .map((item) {
                                                                          return DropdownMenuItem(
                                                                            value:
                                                                                item,
                                                                            //disable default onTap to avoid closing menu when selecting an item
                                                                            enabled:
                                                                                false,
                                                                            child:
                                                                                StatefulBuilder(
                                                                              builder: (context, menuSetState) {
                                                                                final isSelected = mStages.contains(item);
                                                                                return InkWell(
                                                                                  onTap: () {
                                                                                    isSelected ? mStages.remove(item) : mStages.add(item);
                                                                                    //This rebuilds the StatefulWidget to update the button's text
                                                                                    setState(() {
                                                                                      if (mStages.length > 1) {
                                                                                        mFilterValue = "2 Items";
                                                                                      } else {
                                                                                        if (mStages.isEmpty) {
                                                                                          mFilterValue = "";
                                                                                        } else {
                                                                                          mFilterValue = mStages.first;
                                                                                        }
                                                                                      }
                                                                                    });
                                                                                    //This rebuilds the dropdownMenu Widget to update the check mark
                                                                                    menuSetState(() {});
                                                                                  },
                                                                                  child: Container(
                                                                                    height: double.infinity,
                                                                                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                                                                    child: Row(
                                                                                      children: [
                                                                                        if (isSelected) const Icon(Icons.check_box_outlined) else const Icon(Icons.check_box_outline_blank),
                                                                                        const SizedBox(width: 16),
                                                                                        Expanded(
                                                                                          child: Text(
                                                                                            item,
                                                                                            style: const TextStyle(fontFamily: 'OpenSauceSansRegular', fontSize: mSizeThree, color: mGreyNine),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              },
                                                                            ),
                                                                          );
                                                                        }).toList(),
                                                                        //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
                                                                        value: mStages.isEmpty
                                                                            ? null
                                                                            : mStages.last,
                                                                        onChanged:
                                                                            (value) {},
                                                                        selectedItemBuilder:
                                                                            (context) {
                                                                          return items
                                                                              .map(
                                                                            (item) {
                                                                              return Container(
                                                                                alignment: AlignmentDirectional.center,
                                                                                child: Text(
                                                                                  mStages.join(', '),
                                                                                  style: const TextStyle(
                                                                                    fontSize: 14,
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                  ),
                                                                                  maxLines: 1,
                                                                                ),
                                                                              );
                                                                            },
                                                                          ).toList();
                                                                        },
                                                                        buttonStyleData:
                                                                            const ButtonStyleData(
                                                                          padding: EdgeInsets.only(
                                                                              left: 16,
                                                                              right: 8),
                                                                          height:
                                                                              40,
                                                                          width:
                                                                              140,
                                                                        ),
                                                                        menuItemStyleData:
                                                                            const MenuItemStyleData(
                                                                          height:
                                                                              40,
                                                                          padding:
                                                                              EdgeInsets.zero,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  width: 15,
                                                                ),
                                                                Button(
                                                                    mButtonname:
                                                                        Languages.of(context)!
                                                                            .mSearchResult,
                                                                    onpressed:
                                                                        () {
                                                                      OnloadSearchinvestors(
                                                                          "",
                                                                          currentPage,
                                                                          "",
                                                                          mStages,
                                                                          "");
                                                                    },
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
                                                              "$mGetCount${Languages.of(context)!.mInvestorsFound}",
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
                                                    padding: const EdgeInsets
                                                        .fromLTRB(
                                                        30, 10, 10, 10),
                                                    child:
                                                        SingleChildScrollView(
                                                            child:
                                                                GridView.count(
                                                      crossAxisCount: 4,
                                                      crossAxisSpacing: 10,
                                                      // childAspectRatio: 0.3,
                                                      childAspectRatio:
                                                          _aspectRatio,
                                                      mainAxisSpacing: 10,
                                                      shrinkWrap: true,
                                                      children: List.generate(
                                                        items.length,
                                                        (index) {
                                                          final mSearchList =
                                                              items[index];
                                                          return InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                mSelectView = 4;
                                                                mViewSearchInvestorsList =
                                                                    items[
                                                                        index];
                                                                mSelectId =
                                                                    mViewSearchInvestorsList!
                                                                            .id ??
                                                                        "";
                                                              });
                                                            },
                                                            child:
                                                                SearchInvestorsItemList(
                                                              mIndex: index,
                                                              mSelectId:
                                                                  mSelectId,
                                                              mSearchInvestorsList:
                                                                  mSearchList,
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
                                                              ViewMorepressed:
                                                                  () {
                                                                setState(() {
                                                                  mSelectView =
                                                                      4;

                                                                  mViewSearchInvestorsList =
                                                                      items[
                                                                          index];
                                                                  mSelectId =
                                                                      mViewSearchInvestorsList!
                                                                              .id ??
                                                                          "";
                                                                });
                                                              },
                                                              AddFavonpressed:
                                                                  () {
                                                                setState(() {
                                                                  OnloadAddFav(
                                                                      "jagadeesan.a1104@gmail.com",
                                                                      items[index]
                                                                          .id);
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
                                                  Visibility(
                                                    visible: items.isNotEmpty
                                                        ? true
                                                        : false,
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
                                                          30, 10, 10, 10),
                                                      child: NumberPaginator(
                                                        // by default, the paginator shows numbers as center content
                                                        numberPages: numPages,
                                                        initialPage:
                                                            SetcurrentPage,
                                                        onPageChange:
                                                            (int index) {
                                                          setState(() {
                                                            currentPage =
                                                                index + 1;

                                                            SetcurrentPage =
                                                                index;

                                                            OnloadSearchinvestors(
                                                                "",
                                                                currentPage,
                                                                "",
                                                                mStages,
                                                                "");
                                                          });
                                                        },
                                                      ),
                                                    ),
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
                              Visibility(
                                  visible: mSelectView == 2 ? true : false,
                                  child: Expanded(
                                    child: SingleChildScrollView(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
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
                                                            color: mGreyTen)),
                                                    TextSpan(
                                                        text: Languages.of(
                                                                context)!
                                                            .mFundingCRM,
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                'OpenSauceSansBold',
                                                            fontSize:
                                                                mSizeThree,
                                                            color: mGreyTen)),
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
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                    flex: 2,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                            Languages.of(
                                                                    context)!
                                                                .mSORTLIST,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    'OpenSauceSansBold',
                                                                fontSize:
                                                                    mSizeThree,
                                                                color:
                                                                    mGreyTen)),
                                                        Text(
                                                            mSortlistCount
                                                                .toString(),
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    'OpenSauceSansRegular',
                                                                fontSize:
                                                                    mSizeThree,
                                                                color:
                                                                    mGreyTen)),
                                                      ],
                                                    )),
                                                Expanded(
                                                    flex: 2,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                            Languages.of(
                                                                    context)!
                                                                .mCONTACTED,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    'OpenSauceSansBold',
                                                                fontSize:
                                                                    mSizeThree,
                                                                color:
                                                                    mGreyTen)),
                                                        Text(
                                                            mContactedCount
                                                                .toString(),
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    'OpenSauceSansRegular',
                                                                fontSize:
                                                                    mSizeThree,
                                                                color:
                                                                    mGreyTen)),
                                                      ],
                                                    )),
                                                Expanded(
                                                    flex: 2,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                            Languages.of(
                                                                    context)!
                                                                .mPitched,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    'OpenSauceSansBold',
                                                                fontSize:
                                                                    mSizeThree,
                                                                color:
                                                                    mGreyTen)),
                                                        Text(
                                                            mPitchedCount
                                                                .toString(),
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    'OpenSauceSansRegular',
                                                                fontSize:
                                                                    mSizeThree,
                                                                color:
                                                                    mGreyTen)),
                                                      ],
                                                    )),
                                                Expanded(
                                                    flex: 2,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                            Languages.of(
                                                                    context)!
                                                                .mDILIGENCE,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    'OpenSauceSansBold',
                                                                fontSize:
                                                                    mSizeThree,
                                                                color:
                                                                    mGreyTen)),
                                                        Text(
                                                            mDiligenceCount
                                                                .toString(),
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    'OpenSauceSansRegular',
                                                                fontSize:
                                                                    mSizeThree,
                                                                color:
                                                                    mGreyTen)),
                                                      ],
                                                    )),
                                                Expanded(
                                                    flex: 2,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                            Languages.of(
                                                                    context)!
                                                                .mWon,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    'OpenSauceSansBold',
                                                                fontSize:
                                                                    mSizeThree,
                                                                color:
                                                                    mGreyTen)),
                                                        Text(
                                                            mWonCount
                                                                .toString(),
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    'OpenSauceSansRegular',
                                                                fontSize:
                                                                    mSizeThree,
                                                                color:
                                                                    mGreyTen)),
                                                      ],
                                                    )),
                                                Expanded(
                                                    flex: 2,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                            Languages.of(
                                                                    context)!
                                                                .mLost,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    'OpenSauceSansBold',
                                                                fontSize:
                                                                    mSizeThree,
                                                                color:
                                                                    mGreyTen)),
                                                        Text(
                                                            mLostCount
                                                                .toString(),
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    'OpenSauceSansRegular',
                                                                fontSize:
                                                                    mSizeThree,
                                                                color:
                                                                    mGreyTen)),
                                                      ],
                                                    )),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Container(
                                              color: mGreyThree,
                                              height: 1,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                            ),
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            Container(
                                              height: mfundingmaxcount * 115,
                                              child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      flex: 2,
                                                      child: ListView.builder(
                                                        physics:
                                                            NeverScrollableScrollPhysics(),
                                                        controller: controller,
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        itemBuilder:
                                                            ((context, index) {
                                                          final mgetCoursesList =
                                                              mSortlistList[
                                                                  index];
                                                          return InkWell(
                                                            onTap: () {
                                                              OnLoadViewFundingCRM(
                                                                  mSortlistList[
                                                                      index],
                                                                  StagesItems);

                                                              ErrorToast(
                                                                  context:
                                                                      context,
                                                                  text: index
                                                                      .toString());
                                                            },
                                                            child: FundingCRMList(
                                                                mIndex: index,
                                                                mInvestor:
                                                                    mgetCoursesList),
                                                          );
                                                        }),
                                                        itemCount: mSortlistList
                                                            .length,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 15,
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: ListView.builder(
                                                        physics:
                                                            NeverScrollableScrollPhysics(),
                                                        controller: controller,
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        itemBuilder:
                                                            ((context, index) {
                                                          final mgetCoursesList =
                                                              mContactedList[
                                                                  index];
                                                          return InkWell(
                                                            onTap: () {
                                                              OnLoadViewFundingCRM(
                                                                  mContactedList[
                                                                      index],
                                                                  StagesItems);

                                                              ErrorToast(
                                                                  context:
                                                                      context,
                                                                  text: index
                                                                      .toString());
                                                            },
                                                            child: FundingCRMList(
                                                                mIndex: index,
                                                                mInvestor:
                                                                    mgetCoursesList),
                                                          );
                                                        }),
                                                        itemCount:
                                                            mContactedList
                                                                .length,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 15,
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: ListView.builder(
                                                        physics:
                                                            NeverScrollableScrollPhysics(),
                                                        controller: controller,
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        itemBuilder:
                                                            ((context, index) {
                                                          final mgetCoursesList =
                                                              mPitchedList[
                                                                  index];
                                                          return InkWell(
                                                            onTap: () {
                                                              OnLoadViewFundingCRM(
                                                                  mPitchedList[
                                                                      index],
                                                                  StagesItems);

                                                              ErrorToast(
                                                                  context:
                                                                      context,
                                                                  text: index
                                                                      .toString());
                                                            },
                                                            child: FundingCRMList(
                                                                mIndex: index,
                                                                mInvestor:
                                                                    mgetCoursesList),
                                                          );
                                                        }),
                                                        itemCount:
                                                            mPitchedList.length,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 15,
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: ListView.builder(
                                                        physics:
                                                            NeverScrollableScrollPhysics(),
                                                        controller: controller,
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        itemBuilder:
                                                            ((context, index) {
                                                          final mgetCoursesList =
                                                              mDiligenceList[
                                                                  index];
                                                          return InkWell(
                                                            onTap: () {
                                                              OnLoadViewFundingCRM(
                                                                  mDiligenceList[
                                                                      index],
                                                                  StagesItems);

                                                              ErrorToast(
                                                                  context:
                                                                      context,
                                                                  text: index
                                                                      .toString());
                                                            },
                                                            child: FundingCRMList(
                                                                mIndex: index,
                                                                mInvestor:
                                                                    mgetCoursesList),
                                                          );
                                                        }),
                                                        itemCount:
                                                            mDiligenceList
                                                                .length,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 15,
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: ListView.builder(
                                                        physics:
                                                            NeverScrollableScrollPhysics(),
                                                        controller: controller,
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        itemBuilder:
                                                            ((context, index) {
                                                          final mgetCoursesList =
                                                              mWonList[index];
                                                          return InkWell(
                                                            onTap: () {
                                                              OnLoadViewFundingCRM(
                                                                  mWonList[
                                                                      index],
                                                                  StagesItems);

                                                              ErrorToast(
                                                                  context:
                                                                      context,
                                                                  text: index
                                                                      .toString());
                                                            },
                                                            child: FundingCRMList(
                                                                mIndex: index,
                                                                mInvestor:
                                                                    mgetCoursesList),
                                                          );
                                                        }),
                                                        itemCount:
                                                            mWonList.length,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 15,
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: ListView.builder(
                                                        physics:
                                                            NeverScrollableScrollPhysics(),
                                                        controller: controller,
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        itemBuilder:
                                                            ((context, index) {
                                                          final mgetCoursesList =
                                                              mLostList[index];
                                                          return InkWell(
                                                            onTap: () {
                                                              OnLoadViewFundingCRM(
                                                                  mLostList[
                                                                      index],
                                                                  StagesItems);

                                                              ErrorToast(
                                                                  context:
                                                                      context,
                                                                  text: index
                                                                      .toString());
                                                            },
                                                            child: FundingCRMList(
                                                                mIndex: index,
                                                                mInvestor:
                                                                    mgetCoursesList),
                                                          );
                                                        }),
                                                        itemCount:
                                                            mLostList.length,
                                                      ),
                                                    ),
                                                  ]),
                                            ),
                                          ]), //
                                    ),
                                  )),
                              Visibility(
                                  visible: mSelectView == 3 ? true : false,
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
                                                              "${mFavList.length} ${Languages.of(context)!.mFavInv}",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: const TextStyle(
                                                                  fontFamily:
                                                                      'OpenSauceSansBold',
                                                                  fontSize:
                                                                      mSizeThree,
                                                                  color:
                                                                      mRedColorTwo))
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
                                                      // childAspectRatio: 0.3,
                                                      childAspectRatio:
                                                          _aspectRatio,

                                                      mainAxisSpacing: 10,
                                                      shrinkWrap: true,
                                                      children: List.generate(
                                                        mFavList.length,
                                                        (index) {
                                                          final mSearchList =
                                                              mFavList[index];
                                                          return SearchInvestorsItemList(
                                                            mIndex: index,
                                                            mSelectId:
                                                                mSelectId,
                                                            mSearchInvestorsList:
                                                                mSearchList,
                                                            RemoveFavonpressed:
                                                                () {
                                                              setState(() {
                                                                OnRemoveFav(
                                                                    "jagadeesan.a1104@gmail.com",
                                                                    mFavList[index]
                                                                            .id ??
                                                                        "",
                                                                    2);
                                                              });
                                                            },
                                                            AddFavonpressed:
                                                                () {
                                                              setState(() {
                                                                OnloadAddFav(
                                                                    "jagadeesan.a1104@gmail.com",
                                                                    items[index]
                                                                        .id);
                                                              });
                                                            },
                                                            ViewMorepressed:
                                                                () {
                                                              setState(() {
                                                                // mSelectView = 4;
                                                                // mViewSearchInvestorsList =
                                                                //     items[
                                                                //         index];
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
                                                  Visibility(
                                                    visible: mFavList.isNotEmpty
                                                        ? true
                                                        : false,
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
                                                          30, 10, 10, 10),
                                                      child: NumberPaginator(
                                                        // by default, the paginator shows numbers as center content
                                                        numberPages: numPages,
                                                        initialPage:
                                                            SetcurrentPage,
                                                        onPageChange:
                                                            (int index) {
                                                          setState(() {
                                                            currentPage =
                                                                index + 1;

                                                            SetcurrentPage =
                                                                index;

                                                            OnloadFavList(
                                                                "jagadeesan.a1104@gmail.com",
                                                                currentPage);
                                                          });
                                                        },
                                                      ),
                                                    ),
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
                              Visibility(
                                  visible: mSelectView == 4 ? true : false,
                                  child: (mViewSearchInvestorsList != null)
                                      ? Expanded(
                                          child: SingleChildScrollView(
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    20),
                                                            topLeft:
                                                                Radius.circular(
                                                                    20),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    0),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    0)),
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.white,
                                                        blurRadius: 1.0,
                                                      ),
                                                    ],
                                                  ),
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          30, 20, 10, 10),
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
                                                Container(
                                                  color: Colors.white,
                                                  height: 15,
                                                ),
                                                Container(
                                                  color: Colors.white,
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
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
                                                        flex: 7,
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
                                                                      left: 10,
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
                                                              hintText: Languages
                                                                      .of(context)!
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
                                                              onChanged: (String
                                                                  value) {
                                                                print(
                                                                    'value: $value');
                                                                filterSearchResults(
                                                                    value);
                                                              },
                                                              onTap: () {
                                                                print('tapped');
                                                                // The code below only works with SearchAnchor
                                                                // _searchController.openView();
                                                              },
                                                              leading: const Icon(
                                                                  Icons.search,
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
                                                              Container(
                                                                width: 150,
                                                                height: 45,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              30),
                                                                  color:
                                                                      mGreyTwo,
                                                                  boxShadow: const [
                                                                    BoxShadow(
                                                                      color:
                                                                          mGreyTwo,
                                                                      blurRadius:
                                                                          1.0,
                                                                    ),
                                                                  ],
                                                                ),
                                                                child: Center(
                                                                  child:
                                                                      DropdownButtonHideUnderline(
                                                                    child: DropdownButton2<
                                                                        String>(
                                                                      isExpanded:
                                                                          true,
                                                                      customButton: Row(
                                                                          mainAxisAlignment: MainAxisAlignment
                                                                              .center,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Image.asset('assets/new_ic_filter.png',
                                                                                width: 20,
                                                                                height: 20),
                                                                            const SizedBox(
                                                                              width: 10,
                                                                            ),
                                                                            Text((mFilterValue.isEmpty) ? Languages.of(context)!.mFilter : mFilterValue,
                                                                                textAlign: TextAlign.center,
                                                                                style: const TextStyle(fontFamily: 'OpenSauceSansRegular', fontSize: mSizeThree, color: mGreyEigth)),
                                                                            const SizedBox(
                                                                              width: 10,
                                                                            ),
                                                                            const Icon(Icons.arrow_drop_down_outlined,
                                                                                size: 30)
                                                                          ]),
                                                                      items: itemStages
                                                                          .map(
                                                                              (item) {
                                                                        return DropdownMenuItem(
                                                                          value:
                                                                              item,
                                                                          //disable default onTap to avoid closing menu when selecting an item
                                                                          enabled:
                                                                              false,
                                                                          child:
                                                                              StatefulBuilder(
                                                                            builder:
                                                                                (context, menuSetState) {
                                                                              final isSelected = mStages.contains(item);
                                                                              return InkWell(
                                                                                onTap: () {
                                                                                  isSelected ? mStages.remove(item) : mStages.add(item);
                                                                                  //This rebuilds the StatefulWidget to update the button's text
                                                                                  setState(() {
                                                                                    if (mStages.length > 1) {
                                                                                      mFilterValue = "2 Items";
                                                                                    } else {
                                                                                      if (mStages.isEmpty) {
                                                                                        mFilterValue = "";
                                                                                      } else {
                                                                                        mFilterValue = mStages.first;
                                                                                      }
                                                                                    }
                                                                                  });
                                                                                  //This rebuilds the dropdownMenu Widget to update the check mark
                                                                                  menuSetState(() {});
                                                                                },
                                                                                child: Container(
                                                                                  height: double.infinity,
                                                                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                                                                  child: Row(
                                                                                    children: [
                                                                                      if (isSelected) const Icon(Icons.check_box_outlined) else const Icon(Icons.check_box_outline_blank),
                                                                                      const SizedBox(width: 16),
                                                                                      Expanded(
                                                                                        child: Text(
                                                                                          item,
                                                                                          style: const TextStyle(fontFamily: 'OpenSauceSansRegular', fontSize: mSizeThree, color: mGreyNine),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            },
                                                                          ),
                                                                        );
                                                                      }).toList(),
                                                                      //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
                                                                      value: mStages
                                                                              .isEmpty
                                                                          ? null
                                                                          : mStages
                                                                              .last,
                                                                      onChanged:
                                                                          (value) {},
                                                                      selectedItemBuilder:
                                                                          (context) {
                                                                        return items
                                                                            .map(
                                                                          (item) {
                                                                            return Container(
                                                                              alignment: AlignmentDirectional.center,
                                                                              child: Text(
                                                                                mStages.join(', '),
                                                                                style: const TextStyle(
                                                                                  fontSize: 14,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                ),
                                                                                maxLines: 1,
                                                                              ),
                                                                            );
                                                                          },
                                                                        ).toList();
                                                                      },
                                                                      buttonStyleData:
                                                                          const ButtonStyleData(
                                                                        padding: EdgeInsets.only(
                                                                            left:
                                                                                16,
                                                                            right:
                                                                                8),
                                                                        height:
                                                                            40,
                                                                        width:
                                                                            140,
                                                                      ),
                                                                      menuItemStyleData:
                                                                          const MenuItemStyleData(
                                                                        height:
                                                                            40,
                                                                        padding:
                                                                            EdgeInsets.zero,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                width: 15,
                                                              ),
                                                              Button(
                                                                  mButtonname:
                                                                      Languages.of(
                                                                              context)!
                                                                          .mSearchResult,
                                                                  onpressed:
                                                                      () {
                                                                    OnloadSearchinvestors(
                                                                        "",
                                                                        currentPage,
                                                                        "",
                                                                        mStages,
                                                                        "");
                                                                  },
                                                                  mSelectcolor:
                                                                      mBtnColor,
                                                                  mTextColor:
                                                                      mWhiteColor,
                                                                  mFontSize: 16,
                                                                  mWidth: 150,
                                                                  mHeigth: 40)
                                                            ]),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  color: Colors.white,
                                                  height: 15,
                                                ),
                                                Container(
                                                  color: mGreyThree,
                                                  height: 1,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                        flex: 5,
                                                        child: Container(
                                                          color: mGreyThree,
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 1),
                                                          child: Container(
                                                              color:
                                                                  Colors.white,
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Container(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .fromLTRB(
                                                                            30,
                                                                            10,
                                                                            10,
                                                                            10),
                                                                    child: Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment
                                                                                .center,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                              "$mGetCount${Languages.of(context)!.mInvestorsFound}",
                                                                              textAlign: TextAlign.center,
                                                                              style: const TextStyle(fontFamily: 'OpenSauceSansBold', fontSize: mSizeThree, color: mGreyTen))
                                                                        ]),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Container(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .fromLTRB(
                                                                            30,
                                                                            10,
                                                                            10,
                                                                            10),
                                                                    child: SingleChildScrollView(
                                                                        child: GridView.count(
                                                                      crossAxisCount:
                                                                          2,
                                                                      crossAxisSpacing:
                                                                          10,
                                                                      // childAspectRatio: 0.3,
                                                                      childAspectRatio:
                                                                          DetailsaspectRatio,

                                                                      mainAxisSpacing:
                                                                          10,
                                                                      shrinkWrap:
                                                                          true,
                                                                      children:
                                                                          List.generate(
                                                                        items
                                                                            .length,
                                                                        (index) {
                                                                          final mSearchList =
                                                                              items[index];
                                                                          return InkWell(
                                                                            onTap:
                                                                                () {
                                                                              setState(() {
                                                                                mSelectView = 4;
                                                                                mViewSearchInvestorsList = items[index];
                                                                                mSelectId = mViewSearchInvestorsList!.id ?? "";
                                                                              });
                                                                            },
                                                                            child:
                                                                                SearchInvestorsItemList(
                                                                              mIndex: index,
                                                                              mSelectId: mSelectId,
                                                                              mSearchInvestorsList: mSearchList,
                                                                              RemoveFavonpressed: () {
                                                                                setState(() {
                                                                                  OnRemoveFav("jagadeesan.a1104@gmail.com", items[index].id ?? "", 1);
                                                                                });
                                                                              },
                                                                              ViewMorepressed: () {
                                                                                setState(() {
                                                                                  mSelectView = 4;
                                                                                  mViewSearchInvestorsList = items[index];
                                                                                  mSelectId = mViewSearchInvestorsList!.id ?? "";
                                                                                });
                                                                              },
                                                                              AddFavonpressed: () {
                                                                                setState(() {
                                                                                  OnloadAddFav("jagadeesan.a1104@gmail.com", items[index].id);
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
                                                                ],
                                                              )),
                                                        )),
                                                    Expanded(
                                                        flex: 5,
                                                        child: Container(
                                                          child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                SizedBox(
                                                                  height: 25,
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .topRight,
                                                                  child: Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .end,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                        InkWell(
                                                                            onTap:
                                                                                () {
                                                                              setState(() {
                                                                                mSelectView = 1;
                                                                                mSelectId = "";
                                                                              });
                                                                            },
                                                                            child:
                                                                                SvgPicture.asset(
                                                                              'assets/new_ic_roundclose.svg',
                                                                              width: 25,
                                                                              height: 25,
                                                                            )),
                                                                        const SizedBox(
                                                                          width:
                                                                              20,
                                                                        )
                                                                      ]),
                                                                ),
                                                                Container(
                                                                  margin: const EdgeInsets
                                                                      .only(
                                                                      top: 20,
                                                                      right: 20,
                                                                      left: 15),
                                                                  height: 250,
                                                                  width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                                  padding: EdgeInsets.only(
                                                                      left: 20,
                                                                      top: 10,
                                                                      right: 20,
                                                                      bottom:
                                                                          10),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),
                                                                    color: Colors
                                                                        .white,
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
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Expanded(
                                                                            flex:
                                                                                5,
                                                                            child:
                                                                                Row(
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              children: [
                                                                                Expanded(
                                                                                    flex: 3,
                                                                                    child: Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        SizedBox(
                                                                                            height: 100,
                                                                                            width: 100,
                                                                                            child: Stack(children: [
                                                                                              Align(
                                                                                                alignment: Alignment.center,
                                                                                                child: CircleAvatar(
                                                                                                  radius: 40.0,
                                                                                                  backgroundColor: Colors.white,
                                                                                                  child: ClipOval(
                                                                                                    child: (mViewSearchInvestorsList!.logo!.isNotEmpty)
                                                                                                        ? ImageNetwork(
                                                                                                            image: mViewSearchInvestorsList!.logo ?? "",
                                                                                                            height: 100,
                                                                                                            width: 100,
                                                                                                          )
                                                                                                        : Image.asset('assets/avathar.png', width: 100, height: 100, fit: BoxFit.fill),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              (mViewSearchInvestorsList!.investorVerified! == 1)
                                                                                                  ? Align(
                                                                                                      alignment: Alignment.topRight,
                                                                                                      child: Image.asset('assets/new_ic_check.png', width: 30, height: 30, fit: BoxFit.fill),
                                                                                                    )
                                                                                                  : const Text("")
                                                                                            ]))
                                                                                      ],
                                                                                    )),
                                                                                Expanded(
                                                                                    flex: 7,
                                                                                    child: Container(
                                                                                        child: SingleChildScrollView(
                                                                                            child: GridView.count(
                                                                                      crossAxisCount: 2,
                                                                                      crossAxisSpacing: 10,
                                                                                      childAspectRatio: 6,
                                                                                      mainAxisSpacing: 10,
                                                                                      shrinkWrap: true,
                                                                                      children: List.generate(
                                                                                        mViewSearchInvestorsList!.fundingStagesTable!.length,
                                                                                        (index) {
                                                                                          final mSearchList = items[index];
                                                                                          return Container(
                                                                                            decoration: BoxDecoration(
                                                                                              borderRadius: BorderRadius.circular(5),
                                                                                              color: mGreyTwo,
                                                                                              boxShadow: const [
                                                                                                BoxShadow(
                                                                                                  color: mGreyTwo,
                                                                                                  blurRadius: 0,
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                            child: Center(child: Text(mViewSearchInvestorsList!.fundingStagesTable![index].fundingStages! ?? "", textAlign: TextAlign.center, style: const TextStyle(fontFamily: 'OpenSauceSansRegular', fontSize: mSizeNine, color: mGreyNine))),
                                                                                          );
                                                                                        },
                                                                                      ),
                                                                                    ))))
                                                                              ],
                                                                            )),
                                                                        Expanded(
                                                                            flex:
                                                                                5,
                                                                            child:
                                                                                Column(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Expanded(
                                                                                  flex: 6,
                                                                                  child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                                                                                    Expanded(
                                                                                        flex: 7,
                                                                                        child: Column(
                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                          children: [
                                                                                            Text(mViewSearchInvestorsList!.title ?? "", textAlign: TextAlign.center, style: const TextStyle(fontFamily: 'OpenSauceSansBold', fontSize: mSizeThree, color: mGreyTen)),
                                                                                            SizedBox(
                                                                                              height: 10,
                                                                                            ),
                                                                                            Text(mViewSearchInvestorsList!.firmType ?? "", textAlign: TextAlign.center, style: const TextStyle(fontFamily: 'OpenSauceSansRegular', fontSize: mSizeTwo, color: mGreySeven))
                                                                                          ],
                                                                                        )),
                                                                                    Expanded(
                                                                                        flex: 3,
                                                                                        child: Row(
                                                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                          children: [
                                                                                            SvgPicture.asset(
                                                                                              'assets/new_ic_linkedin.svg',
                                                                                              width: 30,
                                                                                              height: 30,
                                                                                            ),
                                                                                            SizedBox(
                                                                                              width: 10,
                                                                                            ),
                                                                                            SvgPicture.asset(
                                                                                              'assets/new_ic_twitter.svg',
                                                                                              width: 30,
                                                                                              height: 30,
                                                                                            ),
                                                                                            SizedBox(
                                                                                              width: 10,
                                                                                            ),
                                                                                            SvgPicture.asset(
                                                                                              'assets/new_ic_web.svg',
                                                                                              width: 30,
                                                                                              height: 30,
                                                                                            )
                                                                                          ],
                                                                                        ))
                                                                                  ]),
                                                                                ),
                                                                                Container(
                                                                                  color: mGreyThree,
                                                                                  height: 1,
                                                                                  width: MediaQuery.of(context).size.width,
                                                                                ),
                                                                                Expanded(
                                                                                    flex: 4,
                                                                                    child: Row(
                                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        Expanded(
                                                                                          flex: 7,
                                                                                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                                                                                            Container(
                                                                                              height: 25,
                                                                                              width: 150,
                                                                                              decoration: BoxDecoration(
                                                                                                borderRadius: BorderRadius.circular(5),
                                                                                                color: mGreyTwo,
                                                                                                boxShadow: const [
                                                                                                  BoxShadow(
                                                                                                    color: mGreyTwo,
                                                                                                    blurRadius: 0,
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                              child: Center(child: Text(mViewSearchInvestorsList!.hq ?? "", textAlign: TextAlign.center, style: const TextStyle(fontFamily: 'OpenSauceSansRegular', fontSize: mSizeTwo, color: mGreyNine))),
                                                                                            )
                                                                                          ]),
                                                                                        ),
                                                                                        Expanded(
                                                                                          flex: 4,
                                                                                          child: Row(
                                                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            children: [
                                                                                              Image.asset('assets/new_ic_money_bag.png', width: 20, height: 20, fit: BoxFit.fill),
                                                                                              const SizedBox(
                                                                                                width: 5,
                                                                                              ),
                                                                                              Center(
                                                                                                child: Text("${Languages.of(context)!.rupess} ${mViewSearchInvestorsList!.minCheckSize.toString() ?? ""} - ${mViewSearchInvestorsList!.maxCheckSize.toString()}", textAlign: TextAlign.center, style: const TextStyle(fontFamily: 'OpenSauceSansRegular', fontSize: mSizeTwo, color: mGreySeven)),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        )
                                                                                      ],
                                                                                    ))
                                                                              ],
                                                                            ))
                                                                      ]),
                                                                ),
                                                                const SizedBox(
                                                                  height: 20,
                                                                ),
                                                                Container(
                                                                  width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                                  margin: const EdgeInsets
                                                                      .only(
                                                                      top: 20,
                                                                      right: 20,
                                                                      left: 15),
                                                                  padding: EdgeInsets.only(
                                                                      left: 20,
                                                                      top: 10,
                                                                      right: 20,
                                                                      bottom:
                                                                          10),
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    borderRadius: BorderRadius.only(
                                                                        topRight:
                                                                            Radius.circular(
                                                                                20),
                                                                        topLeft:
                                                                            Radius.circular(
                                                                                20),
                                                                        bottomRight:
                                                                            Radius.circular(
                                                                                0),
                                                                        bottomLeft:
                                                                            Radius.circular(0)),
                                                                    color: Colors
                                                                        .white,
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        color: Colors
                                                                            .white,
                                                                        blurRadius:
                                                                            1.0,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  child: Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        const SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                        Text(
                                                                            Languages.of(context)!
                                                                                .mWhoweare,
                                                                            textAlign: TextAlign
                                                                                .center,
                                                                            style: const TextStyle(
                                                                                fontFamily: 'OpenSauceSansBold',
                                                                                fontSize: mSizeThree,
                                                                                color: mGreyTen)),
                                                                        const SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                        Text(
                                                                            mViewSearchInvestorsList!.aboutUs ??
                                                                                "",
                                                                            textAlign: TextAlign
                                                                                .left,
                                                                            style: const TextStyle(
                                                                                fontFamily: 'OpenSauceSansRegular',
                                                                                fontSize: mSizeTwo,
                                                                                height: 1.5,
                                                                                color: mGreyEigth)),
                                                                        const SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                        Container(
                                                                          color:
                                                                              mGreyThree,
                                                                          height:
                                                                              1,
                                                                          width: MediaQuery.of(context)
                                                                              .size
                                                                              .width,
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                        Text(
                                                                            Languages.of(context)!
                                                                                .mValueadd,
                                                                            textAlign: TextAlign
                                                                                .center,
                                                                            style: const TextStyle(
                                                                                fontFamily: 'OpenSauceSansBold',
                                                                                fontSize: mSizeThree,
                                                                                color: mGreyTen)),
                                                                        const SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                        Text(
                                                                            mViewSearchInvestorsList!.valueAdd ??
                                                                                "",
                                                                            textAlign: TextAlign
                                                                                .left,
                                                                            style: const TextStyle(
                                                                                fontFamily: 'OpenSauceSansRegular',
                                                                                fontSize: mSizeTwo,
                                                                                height: 1.5,
                                                                                color: mGreyEigth)),
                                                                        const SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                        Container(
                                                                          color:
                                                                              mGreyThree,
                                                                          height:
                                                                              1,
                                                                          width: MediaQuery.of(context)
                                                                              .size
                                                                              .width,
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                        Text(
                                                                            Languages.of(context)!
                                                                                .mFirmtype,
                                                                            textAlign: TextAlign
                                                                                .center,
                                                                            style: const TextStyle(
                                                                                fontFamily: 'OpenSauceSansBold',
                                                                                fontSize: mSizeThree,
                                                                                color: mGreyTen)),
                                                                        const SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                        Text(
                                                                            mViewSearchInvestorsList!.firmType ??
                                                                                "",
                                                                            textAlign: TextAlign
                                                                                .left,
                                                                            style: const TextStyle(
                                                                                fontFamily: 'OpenSauceSansRegular',
                                                                                fontSize: mSizeTwo,
                                                                                height: 1.5,
                                                                                color: mGreyEigth)),
                                                                        const SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                      ]),
                                                                ),
                                                                Container(
                                                                  height: 70,
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          right:
                                                                              20),
                                                                  width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    borderRadius: BorderRadius.only(
                                                                        topRight:
                                                                            Radius.circular(
                                                                                0),
                                                                        topLeft:
                                                                            Radius.circular(
                                                                                0),
                                                                        bottomRight:
                                                                            Radius.circular(
                                                                                20),
                                                                        bottomLeft:
                                                                            Radius.circular(0)),
                                                                    color:
                                                                        mGreyThree,
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        color:
                                                                            mGreyThree,
                                                                        blurRadius:
                                                                            1.0,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Expanded(
                                                                            flex:
                                                                                8,
                                                                            child:
                                                                                Align(
                                                                              alignment: Alignment.center,
                                                                              child: ServiceButton(mButtonname: Languages.of(context)!.mSendaDeck, mSelectcolor: mBlackTwo, onpressed: () {}, mTextColor: mWhiteColor, mhovercolor: mGreyThree, mFontSize: 16, mWidth: 400, mHeigth: 40),
                                                                            )),
                                                                        Expanded(
                                                                            flex:
                                                                                2,
                                                                            child:
                                                                                Align(
                                                                              alignment: Alignment.center,
                                                                              child: InkWell(
                                                                                  onTap: () {},
                                                                                  child: SvgPicture.asset(
                                                                                    'assets/new_ic_details_heart.svg',
                                                                                    width: 45,
                                                                                    height: 45,
                                                                                  )),
                                                                            ))
                                                                      ]),
                                                                )
                                                              ]),
                                                        )),
                                                  ],
                                                )
                                              ]),
                                        ))
                                      : Text("")),
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

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Alert!!"),
          content: Text("You are awesome!"),
          actions: [
            MaterialButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void OnLoadViewFundingCRM(Investor mInvestor, List<MenuItem> stagesItems) {
    mStatusChange = mInvestor.status ?? "";
    showGeneralDialog(
      barrierLabel: "",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      // transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return StatefulBuilder(builder: (context1, setState) {
          return Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: MediaQuery.of(context).size.width / 3,
              height: MediaQuery.of(context).size.height - 100,
              padding: const EdgeInsets.only(
                  left: 10, right: 20, bottom: 10, top: 20),
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
                        flex: 8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Material(
                              color: Colors.white,
                              child: Align(
                                alignment: Alignment.centerRight,
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
                            const SizedBox(
                              height: 10,
                            ),
                            Material(
                              color: Colors.white,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Colors.white,
                                        child: ClipOval(
                                          child: (mInvestor.logo!.isNotEmpty)
                                              ? ImageNetwork(
                                                  image: mInvestor.logo ?? "",
                                                  height: 100,
                                                  width: 100,
                                                )
                                              : Image.asset(
                                                  'assets/avathar.png',
                                                  width: 100,
                                                  height: 100,
                                                  fit: BoxFit.fill),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                      flex: 8,
                                      child: Text(mInvestor.name ?? "",
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                              fontFamily: 'OpenSauceSansBold',
                                              fontSize: mSizeFive,
                                              color: mGreyTen)))
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Material(
                              color: Colors.white,
                              child: Container(
                                color: mGreyFive,
                                width: MediaQuery.of(context).size.width,
                                height: 1,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Expanded(
                                child: SingleChildScrollView(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Material(
                                      color: Colors.white,
                                      child: Row(
                                        children: [
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                  Languages.of(context)!
                                                      .mStatus,
                                                  textAlign: TextAlign.left,
                                                  style: const TextStyle(
                                                      fontFamily:
                                                          'OpenSauceSansRegular',
                                                      fontSize: mSizeThree,
                                                      color: mGreyEigth)),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                              flex: 7,
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child: DropdownButton2(
                                                    customButton: Container(
                                                      height: 32,
                                                      width: 150,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        color: mYellowFour,
                                                        boxShadow: const [
                                                          BoxShadow(
                                                            color: Colors.white,
                                                            blurRadius: 1.0,
                                                          ),
                                                        ],
                                                      ),
                                                      child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                                (mStatusChange.isEmpty)
                                                                    ? Languages.of(
                                                                            context)!
                                                                        .mFilter
                                                                    : mStatusChange,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: const TextStyle(
                                                                    fontFamily:
                                                                        'OpenSauceSansBold',
                                                                    fontSize:
                                                                        mSizeThree,
                                                                    color:
                                                                        mGreyTen)),
                                                            const Icon(
                                                              Icons
                                                                  .arrow_drop_down_outlined,
                                                              size: 30,
                                                              color:
                                                                  mBlackThree,
                                                            )
                                                          ]),
                                                    ),
                                                    items: [
                                                      ...stagesItems.map(
                                                        (item) =>
                                                            DropdownMenuItem<
                                                                MenuItem>(
                                                          value: item,
                                                          child:
                                                              buildItem(item),
                                                        ),
                                                      ),
                                                    ],
                                                    onChanged: (value) {
                                                      print(value!.text);

                                                      setState(() {
                                                        mStatusChange =
                                                            value!.text;
                                                      });

                                                      // MenuItems.onChanged(
                                                      //     context,
                                                      //     value! as MenuItem);
                                                    },
                                                    dropdownStyleData:
                                                        DropdownStyleData(
                                                      width: 160,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 6),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        border: Border.all(
                                                            color: mGreyThree,
                                                            width: 2),
                                                        color: Colors.white,
                                                      ),
                                                      offset:
                                                          const Offset(5, -10),
                                                    ),
                                                  ),
                                                ),
                                              ))
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Material(
                                      color: Colors.white,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                  Languages.of(context)!
                                                      .mContactedPerson,
                                                  textAlign: TextAlign.left,
                                                  style: const TextStyle(
                                                      fontFamily:
                                                          'OpenSauceSansRegular',
                                                      fontSize: mSizeThree,
                                                      color: mGreyEigth)),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                  mInvestor.contactedPerson ??
                                                      "",
                                                  textAlign: TextAlign.left,
                                                  style: const TextStyle(
                                                      fontFamily:
                                                          'OpenSauceSansSemiBold',
                                                      fontSize: mSizeThree,
                                                      color: mGreyTen)))
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Material(
                                      color: Colors.white,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                  Languages.of(context)!
                                                      .mFundingStage,
                                                  textAlign: TextAlign.left,
                                                  style: const TextStyle(
                                                      fontFamily:
                                                          'OpenSauceSansRegular',
                                                      fontSize: mSizeThree,
                                                      color: mGreyEigth)),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                  mInvestor.status ?? "",
                                                  textAlign: TextAlign.left,
                                                  style: const TextStyle(
                                                      fontFamily:
                                                          'OpenSauceSansSemiBold',
                                                      fontSize: mSizeThree,
                                                      color: mGreyTen)))
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Material(
                                      color: Colors.white,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                  Languages.of(context)!
                                                      .mDescription,
                                                  textAlign: TextAlign.left,
                                                  style: const TextStyle(
                                                      fontFamily:
                                                          'OpenSauceSansRegular',
                                                      fontSize: mSizeThree,
                                                      color: mGreyEigth)),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                  mInvestor.description ?? "",
                                                  textAlign: TextAlign.left,
                                                  maxLines: 100,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontFamily:
                                                          'OpenSauceSansSemiBold',
                                                      fontSize: mSizeThree,
                                                      height: 1.5,
                                                      color: mGreyTen)))
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Material(
                                      color: Colors.white,
                                      child: Container(
                                        color: mGreyFive,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 1,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Material(
                                      color: Colors.white,
                                      child: Row(
                                        children: [
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                  Languages.of(context)!
                                                      .mWebsite,
                                                  textAlign: TextAlign.left,
                                                  style: const TextStyle(
                                                      fontFamily:
                                                          'OpenSauceSansRegular',
                                                      fontSize: mSizeThree,
                                                      color: mGreyEigth)),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                  mInvestor.website ?? "",
                                                  textAlign: TextAlign.left,
                                                  style: const TextStyle(
                                                      fontFamily:
                                                          'OpenSauceSansSemiBold',
                                                      fontSize: mSizeThree,
                                                      color: mGreyTen)))
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Material(
                                      color: Colors.white,
                                      child: Row(
                                        children: [
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                  Languages.of(context)!
                                                      .mMailAddress,
                                                  textAlign: TextAlign.left,
                                                  style: const TextStyle(
                                                      fontFamily:
                                                          'OpenSauceSansRegular',
                                                      fontSize: mSizeThree,
                                                      color: mGreyEigth)),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                  mInvestor.mailAddress ?? "",
                                                  textAlign: TextAlign.left,
                                                  style: const TextStyle(
                                                      fontFamily:
                                                          'OpenSauceSansSemiBold',
                                                      fontSize: mSizeThree,
                                                      color: mGreyTen)))
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Material(
                                      color: Colors.white,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                  Languages.of(context)!
                                                      .mContactNumber,
                                                  textAlign: TextAlign.left,
                                                  style: const TextStyle(
                                                      fontFamily:
                                                          'OpenSauceSansRegular',
                                                      fontSize: mSizeThree,
                                                      color: mGreyEigth)),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                              flex: 7,
                                              child: Text(
                                                  mInvestor.contactNo ?? "",
                                                  textAlign: TextAlign.left,
                                                  style: const TextStyle(
                                                      fontFamily:
                                                          'OpenSauceSansSemiBold',
                                                      fontSize: mSizeThree,
                                                      color: mGreyTen)))
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ]),
                            ))
                          ],
                        )),
                    Expanded(
                        flex: 1,
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Material(
                                color: Colors.white,
                                child: Container(
                                  color: mGreyFive,
                                  width: MediaQuery.of(context).size.width,
                                  height: 1,
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 6,
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: DeleteButton(
                                            mButtonname:
                                                Languages.of(context)!.mDelete,
                                            onpressed: () {},
                                            mSelectcolor: mBtnColor,
                                            mTextColor: mWhiteColor,
                                            mFontSize: 16,
                                            mWidth: 150,
                                            mHeigth: 40)),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Center(
                                      child: Button(
                                          mButtonname: Languages.of(context)!
                                              .mSaveChanges,
                                          onpressed: () {
                                            OnupdatefundingCRM(
                                                "jagadeesan.a1104@gmail.com",
                                                mInvestor.typeOfInvestor ?? "",
                                                mStatusChange,
                                                mInvestor.id ?? "");
                                          },
                                          mSelectcolor: mBtnColor,
                                          mTextColor: mWhiteColor,
                                          mFontSize: 16,
                                          mWidth: 130,
                                          mHeigth: 40),
                                    ),
                                  )
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

  void OnLoadDialog(BuildContext context) {
    // showDialog<void>(
    //   barrierDismissible: true,
    //   context: context,
    //   builder: (BuildContext context) {
    //     return StatefulBuilder(builder: (context1, setState) {
    //       return Column(
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         crossAxisAlignment: CrossAxisAlignment.end,
    //         children: <Widget>[
    //           const SizedBox(
    //             height: 200,
    //           ),
    //           Container(
    //             padding: const EdgeInsets.all(10),
    //             margin: const EdgeInsets.fromLTRB(0, 20, 20, 0),
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(20),
    //               color: Colors.white,
    //               border: Border.all(color: mGreyThree, width: 2),
    //             ),
    //             height: 220,
    //             width: 200,
    //             child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 children: [
    //                   const SizedBox(
    //                     height: 10,
    //                   ),
    //                   Material(
    //                     child: InkWell(
    //                       hoverColor: Colors.white,
    //                       onTap: () {},
    //                       child: Row(
    //                         mainAxisAlignment: MainAxisAlignment.start,
    //                         crossAxisAlignment: CrossAxisAlignment.center,
    //                         children: [
    //                           Image.asset(
    //                             'assets/new_ic_user.png',
    //                             width: 20,
    //                             height: 20,
    //                           ),
    //                           const SizedBox(
    //                             width: 20,
    //                           ),
    //                           Text(Languages.of(context)!.mprofile,
    //                               textAlign: TextAlign.center,
    //                               style: const TextStyle(
    //                                   fontFamily: 'OpenSauceSansRegular',
    //                                   fontSize: mSizeThree,
    //                                   color: mGreyTen))
    //                         ],
    //                       ),
    //                     ),
    //                   ),
    //                   const SizedBox(
    //                     height: 20,
    //                   ),
    //                   Material(
    //                     child: InkWell(
    //                       hoverColor: Colors.white,
    //                       onTap: () {},
    //                       child: Row(
    //                         mainAxisAlignment: MainAxisAlignment.start,
    //                         crossAxisAlignment: CrossAxisAlignment.center,
    //                         children: [
    //                           Image.asset(
    //                             'assets/new_ic_settings.png',
    //                             width: 20,
    //                             height: 20,
    //                           ),
    //                           const SizedBox(
    //                             width: 20,
    //                           ),
    //                           Text(Languages.of(context)!.mAccountSettings,
    //                               textAlign: TextAlign.center,
    //                               style: const TextStyle(
    //                                   fontFamily: 'OpenSauceSansRegular',
    //                                   fontSize: mSizeThree,
    //                                   color: mGreyTen))
    //                         ],
    //                       ),
    //                     ),
    //                   ),
    //                   const SizedBox(
    //                     height: 20,
    //                   ),
    //                   Material(
    //                     child: InkWell(
    //                       hoverColor: Colors.white,
    //                       onTap: () {},
    //                       child: Row(
    //                         mainAxisAlignment: MainAxisAlignment.start,
    //                         crossAxisAlignment: CrossAxisAlignment.center,
    //                         children: [
    //                           Image.asset(
    //                             'assets/new_ic_support.png',
    //                             width: 20,
    //                             height: 20,
    //                           ),
    //                           const SizedBox(
    //                             width: 20,
    //                           ),
    //                           Text(Languages.of(context)!.mCustomerSupport,
    //                               textAlign: TextAlign.center,
    //                               style: const TextStyle(
    //                                   fontFamily: 'OpenSauceSansRegular',
    //                                   fontSize: mSizeThree,
    //                                   color: mGreyTen))
    //                         ],
    //                       ),
    //                     ),
    //                   ),
    //                   const SizedBox(
    //                     height: 20,
    //                   ),
    //                   Container(
    //                     width: 180,
    //                     height: 2,
    //                     color: mGreyFive,
    //                   ),
    //                   const SizedBox(
    //                     height: 20,
    //                   ),
    //                   Material(
    //                     child: InkWell(
    //                       hoverColor: Colors.white,
    //                       onTap: () {},
    //                       child: Row(
    //                         mainAxisAlignment: MainAxisAlignment.center,
    //                         crossAxisAlignment: CrossAxisAlignment.center,
    //                         children: [
    //                           const SizedBox(
    //                             width: 20,
    //                           ),
    //                           Image.asset(
    //                             'assets/new_ic_signout.png',
    //                             width: 20,
    //                             height: 20,
    //                           ),
    //                           const SizedBox(
    //                             width: 10,
    //                           ),
    //                           Text(Languages.of(context)!.mLogout,
    //                               textAlign: TextAlign.center,
    //                               style: const TextStyle(
    //                                   fontFamily: 'OpenSauceSansRegular',
    //                                   fontSize: mSizeThree,
    //                                   color: mRedSix))
    //                         ],
    //                       ),
    //                     ),
    //                   ),
    //                 ]),
    //           )
    //         ],
    //       );
    //     });
    //   },
    // );
  }

  void OnloadSearchinvestors(String UserID, int currentPage, String country,
      List<String> mStages, String amount) {
    Loading(mLoaderGif).start(context);

    apiService1
        .getSearchinvestors(
            "jagadeesan.a1104@gmail.com", currentPage, "", mStages, "")
        .then((value) async {
      print(value);

      if (value is ApiSuccess) {
        if (SearchinvestorslistResponse.fromJson(value.data)!.message!.status ??
            false) {
          Loading.stop();
          setState(() {
            items.clear();
            items = SearchinvestorslistResponse.fromJson(value.data)
                .message!
                .searchInvestorsList!;
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

  void OnloadFavList(String UserId, int currentPage) {
    Loading(mLoaderGif).start(context);
    apiService1.getFavList(UserId, currentPage).then((value) async {
      print(value);

      if (value is ApiSuccess) {
        if (FavouriteResponse.fromJson(value.data)!.message!.status ?? false) {
          Loading.stop();
          setState(() {
            mFavList.clear();
            mFavList = FavouriteResponse.fromJson(value.data)
                .message!
                .searchInvestorsList!;
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

  void OnloadChangeFav(
      String UserId, String InvestorId, int status, int mFrom) {
    Loading(mLoaderGif).start(context);
    apiService1.RemoveFavList(UserId, InvestorId, status).then((value) async {
      print(value);

      if (value is ApiSuccess) {
        if (FavouriteResponse.fromJson(value.data)!.message!.status ?? false) {
          Loading.stop();
          setState(() {
            if (mFrom == 2) {
              OnloadFavList("jagadeesan.a1104@gmail.com", 1);
            } else {
              OnloadSearchinvestors(
                  "jagadeesan.a1104@gmail.com", currentPage, "", mStages, "");
            }
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

  void OnupdatefundingCRM(String UserID, String typeofinvestor,
      String fundingstage, String investorid) {
    Loading(mLoaderGif).start(context);

    apiService1.UpdateFundingCRM(
            UserID, fundingstage, investorid, typeofinvestor)
        .then((value) async {
      print(value);

      if (value is ApiSuccess) {
        if (SearchinvestorslistResponse.fromJson(value.data)!.message!.status ??
            false) {
          Loading.stop();
          setState(() {
            Navigator.of(context).pop();
            OnLoadFundingCRM("jagadeesan.a1104@gmail.com");
          });
        } else {
          Loading.stop();
          Navigator.of(context).pop();
          ErrorToast(context: context, text: "Error");
        }
      } else if (value is ApiFailure) {
        Loading.stop();
      }
    });
  }

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child: Text(item.text,
                textAlign: TextAlign.left,
                style: const TextStyle(
                    fontFamily: 'OpenSauceSansRegular',
                    fontSize: mSizeThree,
                    color: mGreyNine))),
      ],
    );
  }

  void OnLoadFundingCRM(String UserID) {
    Loading(mLoaderGif).start(context);

    apiService1.getFundingCrm(UserID).then((value) async {
      print(value);

      if (value is ApiSuccess) {
        if (FundingCrmResponse.fromJson(value.data)!.message!.status ?? false) {
          Loading.stop();
          setState(() {
            mFundingCRMList = FundingCrmResponse.fromJson(value.data)!
                .message!
                .fundingCrmList!;

            mSortlist = mFundingCRMList[0].sortlist!;
            mSortlistCount = mFundingCRMList[0].sortlist!.sortlistCount!;

            mSortlistList.clear();

            for (int i = 0; i < mSortlist.searchInvestor!.length; i++) {
              mSortlistList.add(mSortlist.searchInvestor![i]);
            }

            for (int i = 0; i < mSortlist.userCreatedInvestor!.length; i++) {
              mSortlistList.add(mSortlist.userCreatedInvestor![i]);
            }

            mContacted = mFundingCRMList[0].contacted!;
            mContactedCount = mFundingCRMList[0].contacted!.contactedCount!;

            mContactedList.clear();

            for (int i = 0; i < mContacted.searchInvestor!.length; i++) {
              mContactedList.add(mContacted.searchInvestor![i]);
            }

            for (int i = 0; i < mContacted.userCreatedInvestor!.length; i++) {
              mContactedList.add(mContacted.userCreatedInvestor![i]);
            }

            mPitched = mFundingCRMList[0].pitched!;
            mPitchedCount = mFundingCRMList[0].pitched!.pitchedCount!;

            mPitchedList.clear();

            for (int i = 0; i < mPitched.searchInvestor!.length; i++) {
              mPitchedList.add(mPitched.searchInvestor![i]);
            }

            for (int i = 0; i < mPitched.userCreatedInvestor!.length; i++) {
              mPitchedList.add(mPitched.userCreatedInvestor![i]);
            }

            mDiligence = mFundingCRMList[0].diligence!;
            mDiligenceCount = mFundingCRMList[0].diligence!.diligenceCount!;

            mDiligenceList.clear();

            for (int i = 0; i < mDiligence.searchInvestor!.length; i++) {
              mDiligenceList.add(mDiligence.searchInvestor![i]);
            }

            for (int i = 0; i < mDiligence.userCreatedInvestor!.length; i++) {
              mDiligenceList.add(mDiligence.userCreatedInvestor![i]);
            }

            mWon = mFundingCRMList[0].won!;
            mWonCount = mFundingCRMList[0].won!.wonCount!;

            mWonList.clear();

            for (int i = 0; i < mWon.searchInvestor!.length; i++) {
              mWonList.add(mWon.searchInvestor![i]);
            }

            for (int i = 0; i < mWon.userCreatedInvestor!.length; i++) {
              mWonList.add(mWon.userCreatedInvestor![i]);
            }

            mLost = mFundingCRMList[0].lost!;
            mLostCount = mFundingCRMList[0].lost!.lostCount!;

            mLostList.clear();

            for (int i = 0; i < mLost.searchInvestor!.length; i++) {
              mLostList.add(mLost.searchInvestor![i]);
            }

            for (int i = 0; i < mLost.userCreatedInvestor!.length; i++) {
              mLostList.add(mLost.userCreatedInvestor![i]);
            }

            mfundingmaxcount = FundingCrmResponse.fromJson(value.data)!
                .message!
                .fundingMaxCount!;
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

  void OnloadAddFav(String userId, String? investorid) {
    Loading(mLoaderGif).start(context);

    apiService1.AddFavList(userId, investorid ?? "").then((value) async {
      print(value);

      if (value is ApiSuccess) {
        if (SearchinvestorslistResponse.fromJson(value.data)!.message!.status ??
            false) {
          Loading.stop();
          setState(() {
            OnloadSearchinvestors(
                "jagadeesan.a1104@gmail.com", currentPage, "", mStages, "");
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

  void OnRemoveFav(String UserId, String investorid, int mFrom) {
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
        OnloadChangeFav(UserId, investorid, 0, mFrom);

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

/*  void onChanged(BuildContext context, ProfileMenuItem item) {
    if (item.text == Languages.of(context)!.mprofile) {}
    */ /*switch (item) {
      case MenuItems.Preseed:
        print("Like");
        //Do something
        break;
      case MenuItems.Seed:
        //Do something
        break;
      case MenuItems.Early:
        //Do something
        break;

      case MenuItems.Growth:
        //Do something
        break;
    }
  }*/ /*
  }*/
}

class MenuItem {
  const MenuItem({
    required this.text,
  });

  final String text;
}

/*class MenuItems {
  static const List<MenuItem> firstItems = [
    Preseed,
    Seed,
    Early,
    Growth,
  ];

  static const Preseed = MenuItem(text: 'Pre-seed');
  static const Seed = MenuItem(text: 'Seed');
  static const Early = MenuItem(text: 'Early');
  static const Growth = MenuItem(text: 'Growth');

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child: Text(item.text,
                textAlign: TextAlign.left,
                style: const TextStyle(
                    fontFamily: 'OpenSauceSansRegular',
                    fontSize: mSizeThree,
                    color: mGreyNine))

            ),
      ],
    );
  }

  static void onChanged(BuildContext context, ProfileMenuItem item) {
    switch (item) {
      case MenuItems.Preseed:
        print("Like");
        //Do something
        break;
      case MenuItems.Seed:
        //Do something
        break;
      case MenuItems.Early:
        //Do something
        break;

      case MenuItems.Growth:
        //Do something
        break;
    }
  }
}*/
