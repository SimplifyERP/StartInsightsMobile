import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startinsights/Libery/lib/multiselect_dropdown.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Model/MastersResponse.dart';
import 'package:startinsights/Model/SearchinvestorslistResponse.dart';
import 'package:startinsights/Repository/pitchroom_repository.dart';
import 'package:startinsights/Screen/SearchInvestors/CDM.dart';
import 'package:startinsights/Screen/SearchInvestors/bloc/searchinvestors_bloc.dart';
import 'package:startinsights/Screen/SearchInvestors/bloc/searchinvestors_state.dart';
import 'package:startinsights/Screen/SearchInvestors/web/searchinvestorsitemList.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Utils/StorageServiceConstant.dart';
import 'package:startinsights/Utils/screens.dart';
import 'package:startinsights/Widgets/expandedview.dart';
import 'package:startinsights/Widgets/primary_button.dart';

class SearchInvestorsWeb extends StatefulWidget {
  SearchInvestorsWeb({super.key});

  @override
  State<SearchInvestorsWeb> createState() => _SearchInvestorsState();
}

class _SearchInvestorsState extends State<SearchInvestorsWeb> {
  @override
  late SearchInvestorsBloc mSearchInvestorsBloc;

  final PitchroomRepository _apiService1 = PitchroomRepository();

  final TextEditingController mSearchEditingController =
      TextEditingController();

  var items = <SearchInvestorsList>[];
  List<SearchInvestorsList> mSearchInvestorsList = [];
  bool isScreenFirst = true;
  ValueNotifier<bool> setnotifier = ValueNotifier(true);
  int selectedIndex = -1; //dont set it to 0
  bool isExpanded = true;

  String mSelectDB = "";
  String mSelectDBHint = "";
  List<InvestedRoundMaster>? mGetDBlist;
  @override
  void initState() {
    super.initState();
    mLoadMasterData();
  }

  void mLoadMasterData() async {
    // Map<String, dynamic> valueMap = json.decode(await sl<StorageService>()
    //     .getString(StorageServiceConstant.MMASTERDATA));

    SharedPreferences prefs = await SharedPreferences.getInstance();

    final getMaster =
        (prefs.getString(StorageServiceConstant.MMASTERDATA) ?? '');
    Map<String, dynamic> valueMap = json.decode(getMaster);
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

                return SafeArea(
                  child: Row(children: [
                    isExpanded ? blackIconTiles() : blackIconMenu(),
                    //invisibleSubMenus(),

                    Container(
                      padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                      width: isExpanded
                          ? MediaQuery.of(context).size.width - 200
                          : MediaQuery.of(context).size.width - 100,
                      height: MediaQuery.of(context).size.height,
                      color: Colors.white,
                      child: Column(children: [
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 5,
                              child: SizedBox(
                                height: 50,
                                width: double.infinity,
                                child: SearchBar(
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.only(
                                          left: 10, right: 10)),
                                  controller: mSearchEditingController,
                                  elevation: MaterialStateProperty.all(1.0),
                                  side: MaterialStateProperty.all(
                                      const BorderSide(color: Colors.black)),
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  hintText: Languages.of(context)!.search,
                                  shape: MaterialStateProperty.all(
                                      const ContinuousRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    // side: BorderSide(color: Colors.pinkAccent),
                                  )),
                                  hintStyle:
                                      MaterialStateProperty.all(const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16,
                                    fontFamily: 'OpenSansRegular',
                                  )),
                                  textStyle:
                                      MaterialStateProperty.all(const TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'OpenSansRegular',
                                    color: Colors.black,
                                  )),
                                  onChanged: (String value) {
                                    print('value: $value');
                                    filterSearchResults(value);
                                  },
                                  onTap: () {
                                    print('tapped');
                                    // The code below only works with SearchAnchor
                                    // _searchController.openView();
                                  },
                                  leading: const Icon(Icons.search,
                                      size: 30, color: Colors.blue),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              flex: 5,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        flex: 3,
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: double.infinity,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                              color: mBtnColor,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 0, 5, 0),
                                              child: InkWell(
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Row(children: [
                                                    Expanded(
                                                        flex: 8,
                                                        child: Text(
                                                          (mSelectDB.isNotEmpty)
                                                              ? mSelectDB
                                                              : mSelectDBHint,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'OpenSansRegular',
                                                              fontSize: 15,
                                                              color:
                                                                  mBlackColor),
                                                        )),
                                                    const Expanded(
                                                        flex: 2,
                                                        child: Icon(Icons
                                                            .arrow_drop_down_outlined))
                                                  ]),
                                                ),
                                                onTap: () {
                                                  // SelectDialog.showModal<
                                                  //     String>(
                                                  //   context,
                                                  //   alwaysShowScrollBar: true,
                                                  //   label:
                                                  //       Languages.of(context)!
                                                  //           .mDesignation,
                                                  //   titleStyle: const TextStyle(
                                                  //       fontFamily:
                                                  //           'OpenSansSemiBold',
                                                  //       fontSize: 20,
                                                  //       color: mBlackColor),
                                                  //   searchBoxDecoration: InputDecoration(
                                                  //       hintText: Languages.of(
                                                  //               context)!
                                                  //           .mDesignation,
                                                  //       hintStyle: const TextStyle(
                                                  //           fontFamily:
                                                  //               'OpenSansMedium',
                                                  //           fontSize: 16.0,
                                                  //           color:
                                                  //               mBlackColor)),
                                                  //   items: modelDBItems(
                                                  //       mGetDBlist),
                                                  //   onChange: (String
                                                  //       selected) async {
                                                  //     setState(() {
                                                  //       mSelectDB = selected;
                                                  //     });
                                                  //   },
                                                  // );
                                                },
                                              )),
                                        )),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                        flex: 3,
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: double.infinity,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                              color: mBtnColor,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 0, 5, 0),
                                              child: InkWell(
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Row(children: [
                                                    Expanded(
                                                        flex: 8,
                                                        child: Text(
                                                          (mSelectDB.isNotEmpty)
                                                              ? mSelectDB
                                                              : mSelectDBHint,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'OpenSansRegular',
                                                              fontSize: 15,
                                                              color:
                                                                  mBlackColor),
                                                        )),
                                                    const Expanded(
                                                        flex: 2,
                                                        child: Icon(Icons
                                                            .arrow_drop_down_outlined))
                                                  ]),
                                                ),
                                                onTap: () {
                                                  // SelectDialog.showModal<
                                                  //     String>(
                                                  //   context,
                                                  //   alwaysShowScrollBar: true,
                                                  //   label:
                                                  //       Languages.of(context)!
                                                  //           .mDesignation,
                                                  //   titleStyle: const TextStyle(
                                                  //       fontFamily:
                                                  //           'OpenSansSemiBold',
                                                  //       fontSize: 20,
                                                  //       color: mBlackColor),
                                                  //   searchBoxDecoration: InputDecoration(
                                                  //       hintText: Languages.of(
                                                  //               context)!
                                                  //           .mDesignation,
                                                  //       hintStyle: const TextStyle(
                                                  //           fontFamily:
                                                  //               'OpenSansMedium',
                                                  //           fontSize: 16.0,
                                                  //           color:
                                                  //               mBlackColor)),
                                                  //   items: modelDBItems(
                                                  //       mGetDBlist),
                                                  //   onChange: (String
                                                  //       selected) async {
                                                  //     setState(() {
                                                  //       mSelectDB = selected;
                                                  //     });
                                                  //   },
                                                  // );
                                                },
                                              )),
                                        )),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                        flex: 3,
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: double.infinity,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                              color: mBtnColor,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 0),
                                            child: MultiSelectDropDown(
                                              // clearIcon: true,
                                              // controller: _controller,
                                              hint: "",
                                              borderWidth: 0,

                                              onOptionSelected: (options) {
                                                debugPrint(options.toString());
                                              },
                                              options: modelDBItems(mGetDBlist),
                                              selectedOptionBackgroundColor:
                                                  Colors.grey.shade300,
                                              selectedOptionTextColor:
                                                  Colors.blue,
                                              dropdownMargin: 2,
                                              singleSelectItemStyle:
                                                  const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),

                                              chipConfig: const ChipConfig(
                                                  wrapType: WrapType.wrap,
                                                  deleteIcon: Icon(null),
                                                  backgroundColor: Colors.red),
                                              optionTextStyle:
                                                  const TextStyle(fontSize: 16),
                                              selectedOptionIcon: const Icon(
                                                Icons.check_circle,
                                                color: Colors.pink,
                                              ),

                                              /*const <ValueItem>[
                                                ValueItem(
                                                    label: 'Option 1',
                                                    value: '1'),
                                                ValueItem(
                                                    label: 'Option 2',
                                                    value: '2'),
                                                ValueItem(
                                                    label: 'Option 3',
                                                    value: '3'),
                                                ValueItem(
                                                    label: 'Option 4',
                                                    value: '4'),
                                                ValueItem(
                                                    label: 'Option 5',
                                                    value: '5'),
                                                ValueItem(
                                                    label: 'Option 6',
                                                    value: '6'),
                                              ],*/
                                              maxItems: mGetDBlist!.length,

                                              selectionType:
                                                  SelectionType.multi,

                                              dropdownHeight: 300,
                                            ),

                                            /*InkWell(
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Row(children: [
                                                    Expanded(
                                                        flex: 8,
                                                        child: Text(
                                                          (mSelectDB.isNotEmpty)
                                                              ? mSelectDB
                                                              : mSelectDBHint,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'OpenSansRegular',
                                                              fontSize: 15,
                                                              color:
                                                                  mBlackColor),
                                                        )),
                                                    const Expanded(
                                                        flex: 2,
                                                        child: Icon(Icons
                                                            .arrow_drop_down_outlined))
                                                  ]),
                                                ),
                                                onTap: () {
                                                  SelectDialog.showModal<
                                                      String>(
                                                    context,
                                                    alwaysShowScrollBar: true,
                                                    label:
                                                        Languages.of(context)!
                                                            .mDesignation,
                                                    titleStyle: const TextStyle(
                                                        fontFamily:
                                                            'OpenSansSemiBold',
                                                        fontSize: 20,
                                                        color: mBlackColor),
                                                    searchBoxDecoration: InputDecoration(
                                                        hintText: Languages.of(
                                                                context)!
                                                            .mDesignation,
                                                        hintStyle: const TextStyle(
                                                            fontFamily:
                                                                'OpenSansMedium',
                                                            fontSize: 16.0,
                                                            color:
                                                                mBlackColor)),
                                                    items: modelDBItems(
                                                        mGetDBlist),
                                                    onChange: (String
                                                        selected) async {
                                                      setState(() {
                                                        mSelectDB = selected;
                                                      });
                                                    },
                                                  );
                                                },
                                              )*/
                                          ),
                                        )),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                        flex: 3,
                                        child: Container(
                                            height: 40,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: mBtnColor,
                                                border: Border.all(
                                                  color: mBtnColor,
                                                  width: 1,
                                                )),
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 0),
                                                child: InkWell(
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: PrimaryButton(
                                                        mButtonname:
                                                            Languages.of(
                                                                    context)!
                                                                .mPrevious,
                                                        onpressed: () {},
                                                        mSelectcolor: mBtnColor,
                                                        mTextColor: mWhiteColor,
                                                        mFontSize: 16,
                                                        mHeigth: 40),
                                                  ),
                                                ))))
                                  ]),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            // decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(5),
                            //     color: Colors.white,
                            //     boxShadow: const [
                            //       BoxShadow(
                            //         color: Colors.grey,
                            //         blurRadius: 1.0,
                            //       ),
                            //     ]),
                            // height:
                            //     MediaQuery.of(context).size.height * 23 / 100,
                            width: double.infinity,
                            //padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                            margin: const EdgeInsets.fromLTRB(1, 1, 1, 1),
                            child: Column(children: <Widget>[
                              Row(
                                children: [
                                  Container(
                                    width: 0,
                                    height: 40,
                                    color: mTabelColor,
                                  ),
                                  mTableTitle(Languages.of(context)!.minvestors,
                                      16, 4, kColorOne),
                                  mTableSpace(),
                                  mTableTitle(Languages.of(context)!.mGeography,
                                      16, 3, kColorOne),
                                  mTableSpace(),
                                  mTableTitle(Languages.of(context)!.mChecks,
                                      16, 2, kColorOne),
                                  mTableSpace(),
                                  mTableTitle(Languages.of(context)!.mStages,
                                      16, 3, kColorOne),
                                  mTableSpace(),
                                  mTableTitle(
                                      Languages.of(context)!.mInvestmentthesis,
                                      16,
                                      6,
                                      kColorOne),
                                  mTableSpace(),
                                  mTableTitle("", 16, 3, kColorOne),
                                  mTableSpace(),
                                ],
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Container(
                                height: items.length * 50,
                                color: Colors.white,
                                child: ListView.builder(
                                  itemBuilder: ((context, index) {
                                    final mSearchInvestors = items[index];
                                    return SearchInvestorsItemList(
                                      mSearchInvestorsList: mSearchInvestors,
                                      mIndex: index,
                                    );
                                  }),
                                  itemCount: items.length,
                                ),
                              )
                            ]))
                      ]),
                    )
                  ]),
                );
              }

              //  ErrorToast(context: context, text: state.mDashboard.message!);

              //} else if (state is GetPunchInOutFailState) {}
              return Container();
            },
          )),
    );
  }

  modelDBItems(List<InvestedRoundMaster>? mGetDBlist) {
    // <ValueItem>[
    // ValueItem(
    // label: 'Option 1',
    // value: '1'),
    /*  List<ValueItem> mGetroutedata = [];

    List.generate(
        mGetDBlist!.length,
        (index) => mGetroutedata.add(ValueItem(
              label: "mGetDBlist![index].investedRound!",
              value: "mGetDBlist![index].investedRound!",
            )));

    return mGetroutedata;*/

    final list = (mGetDBlist as List<InvestedRoundMaster>).map((e) {
      final item = e.investedRound as String;

      return ValueItem(
        label: item,
        value: item,
      );
    }).toList();

    return list;
  }

  Widget blackIconTiles() {
    return Container(
      width: 200,
      color: Colors.red,
      child: Column(
        children: [
          controlTile(),
          Expanded(
            child: ListView.builder(
              itemCount: cdms.length,
              itemBuilder: (BuildContext context, int index) {
                //  if(index==0) return controlTile();

                CDM cdm = cdms[index];
                bool selected = selectedIndex == index;
                return ExpansionTile(
                    onExpansionChanged: (z) {
                      setState(() {
                        selectedIndex = z ? index : -1;
                      });
                    },
                    leading: Icon(cdm.icon, color: Colors.white),
                    title: cdm.submenus.isEmpty
                        ? InkWell(
                            child: Text(
                              cdm.title,
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () {
                              debugPrint("I was clicked");
                            },
                          )
                        : Text(cdm.title,
                            style: TextStyle(color: Colors.white)),
                    // Txt(
                    //   text: cdm.title,
                    //   color: Colors.white,
                    // ),
                    trailing: cdm.submenus.isEmpty
                        ? SizedBox.shrink()
                        : Icon(
                            selected
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: Colors.white,
                          ),
                    children: cdm.submenus.map((subMenu) {
                      return sMenuButton(subMenu, false);
                    }).toList());
              },
            ),
          ),
          accountTile(),
        ],
      ),
    );
  }

  Widget controlTile() {
    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 30),
      child: ListTile(
        leading: FlutterLogo(),
        title: Text(
          "FlutterShip",
          style: TextStyle(color: Colors.white),
        ),

        // Txt(
        //   text: "FlutterShip",
        //   fontSize: 18,
        //   color: Colors.white,
        //   fontWeight: FontWeight.bold,
        // ),
        onTap: expandOrShrinkDrawer,
      ),
    );
  }

  Widget blackIconMenu() {
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      width: 100,
      color: Colors.black,
      child: Column(
        children: [
          controlButton(),
          Expanded(
            child: ListView.builder(
                itemCount: cdms.length,
                itemBuilder: (contex, index) {
                  // if(index==0) return controlButton();
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      height: 45,
                      alignment: Alignment.center,
                      child: Icon(cdms[index].icon, color: Colors.white),
                    ),
                  );
                }),
          ),
          accountButton(),
        ],
      ),
    );
  }

  Widget controlButton() {
    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 30),
      child: InkWell(
        onTap: expandOrShrinkDrawer,
        child: Container(
          height: 45,
          alignment: Alignment.center,
          child: FlutterLogo(
            size: 40,
          ),
        ),
      ),
    );
  }

  Widget subMenuWidget(List<String> submenus, bool isValidSubMenu) {
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
            /* Txt(
              text: subMenu,
              fontSize: isTitle ? 17 : 14,
              color: isTitle ? Colors.white : Colors.grey,
              fontWeight: FontWeight.bold,
            )*/
            ),
      ),
    );
  }

  Widget accountButton({bool usePadding = true}) {
    return Padding(
      padding: EdgeInsets.all(usePadding ? 8 : 0),
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          color: Colors.white70,
          image: DecorationImage(
            image: NetworkImage(
                "https://cdn.pixabay.com/photo/2016/03/29/03/14/portrait-1287421_960_720.jpg"),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }

  Widget accountTile() {
    return Container(
        color: Colors.blue,
        child: ListTile(
          leading: accountButton(usePadding: false),
          title: Text(
            "Prem Shanhi",
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            "Web Designer",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ));
  }

  static List<CDM> cdms = [
    // CDM(Icons.grid_view, "Control", []),

    CDM(Icons.grid_view, "Dashboard", []),
    CDM(Icons.subscriptions, "Category",
        ["HTML & CSS", "Javascript", "PHP & MySQL"]),
    CDM(Icons.markunread_mailbox, "Posts", ["Add", "Edit", "Delete"]),
    CDM(Icons.pie_chart, "Analytics", []),
    CDM(Icons.trending_up, "Chart", []),

    CDM(Icons.power, "Plugins",
        ["Ad Blocker", "Everything Https", "Dark Mode"]),
    CDM(Icons.explore, "Explore", []),
    CDM(Icons.settings, "Setting", []),
  ];

  void expandOrShrinkDrawer() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  Widget mTableTitle(String title, double textsize, int flexsize, Color black) {
    return ExpandedView(
      mText: title,
      mHeight: 40,
      mSelectcolor: Colors.white,
      mTextColor: black,
      mFontSize: textsize,
      mFontFamily: 'ManropeSemiBold',
      mflex: flexsize,
      malignment: Alignment.center,
      mtextalign: TextAlign.center,
      marqueeView: false,
    );
    ;
  }

  Widget mTableSpace() {
    return Container(
      width: 0,
      height: 40,
      color: mTabelColor,
    );
  }
}

/*class ComplexDrawer extends StatefulWidget {
  const ComplexDrawer({Key? key}) : super(key: key);

  @override
  _ComplexDrawerState createState() => _ComplexDrawerState();
}

class _ComplexDrawerState extends State<ComplexDrawer> {
  int selectedIndex = -1; //dont set it to 0

  bool isExpanded = true;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      child: row(),
      color: Colors.green,
    );
  }

  Widget row() {
    return Row(children: [
      isExpanded ? blackIconTiles() : blackIconMenu(),
      //invisibleSubMenus(),
      Text("aagags"),
    ]);
  }

  Widget blackIconTiles() {
    return Container(
      width: 200,
      color: Colors.red,
      child: Column(
        children: [
          controlTile(),
          Expanded(
            child: ListView.builder(
              itemCount: cdms.length,
              itemBuilder: (BuildContext context, int index) {
                //  if(index==0) return controlTile();

                CDM cdm = cdms[index];
                bool selected = selectedIndex == index;
                return ExpansionTile(
                    onExpansionChanged: (z) {
                      setState(() {
                        selectedIndex = z ? index : -1;
                      });
                    },
                    leading: Icon(cdm.icon, color: Colors.white),
                    title: cdm.submenus.isEmpty
                        ? InkWell(
                            child: Text(
                              cdm.title,
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () {
                              debugPrint("I was clicked");
                            },
                          )
                        : Text(cdm.title,
                            style: TextStyle(color: Colors.white)),
                    // Txt(
                    //   text: cdm.title,
                    //   color: Colors.white,
                    // ),
                    trailing: cdm.submenus.isEmpty
                        ? SizedBox.shrink()
                        : Icon(
                            selected
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: Colors.white,
                          ),
                    children: cdm.submenus.map((subMenu) {
                      return sMenuButton(subMenu, false);
                    }).toList());
              },
            ),
          ),
          accountTile(),
        ],
      ),
    );
  }

  Widget controlTile() {
    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 30),
      child: ListTile(
        leading: FlutterLogo(),
        title: Text(
          "FlutterShip",
          style: TextStyle(color: Colors.white),
        ),

        // Txt(
        //   text: "FlutterShip",
        //   fontSize: 18,
        //   color: Colors.white,
        //   fontWeight: FontWeight.bold,
        // ),
        onTap: expandOrShrinkDrawer,
      ),
    );
  }

  Widget blackIconMenu() {
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      width: 100,
      color: Colors.black,
      child: Column(
        children: [
          controlButton(),
          Expanded(
            child: ListView.builder(
                itemCount: cdms.length,
                itemBuilder: (contex, index) {
                  // if(index==0) return controlButton();
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      height: 45,
                      alignment: Alignment.center,
                      child: Icon(cdms[index].icon, color: Colors.white),
                    ),
                  );
                }),
          ),
          accountButton(),
        ],
      ),
    );
  }

  Widget controlButton() {
    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 30),
      child: InkWell(
        onTap: expandOrShrinkDrawer,
        child: Container(
          height: 45,
          alignment: Alignment.center,
          child: FlutterLogo(
            size: 40,
          ),
        ),
      ),
    );
  }

  Widget subMenuWidget(List<String> submenus, bool isValidSubMenu) {
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
  }

  Widget accountButton({bool usePadding = true}) {
    return Padding(
      padding: EdgeInsets.all(usePadding ? 8 : 0),
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          color: Colors.white70,
          image: DecorationImage(
            image: NetworkImage(
                "https://cdn.pixabay.com/photo/2016/03/29/03/14/portrait-1287421_960_720.jpg"),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }

  Widget accountTile() {
    return Container(
        color: Colors.blue,
        child: ListTile(
          leading: accountButton(usePadding: false),
          title: Text(
            "Prem Shanhi",
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            "Web Designer",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ));
  }

  static List<CDM> cdms = [
    // CDM(Icons.grid_view, "Control", []),

    CDM(Icons.grid_view, "Dashboard", []),
    CDM(Icons.subscriptions, "Category",
        ["HTML & CSS", "Javascript", "PHP & MySQL"]),
    CDM(Icons.markunread_mailbox, "Posts", ["Add", "Edit", "Delete"]),
    CDM(Icons.pie_chart, "Analytics", []),
    CDM(Icons.trending_up, "Chart", []),

    CDM(Icons.power, "Plugins",
        ["Ad Blocker", "Everything Https", "Dark Mode"]),
    CDM(Icons.explore, "Explore", []),
    CDM(Icons.settings, "Setting", []),
  ];

  void expandOrShrinkDrawer() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }
}*/
