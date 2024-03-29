import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Model/BookanexpertlistResponse.dart';
import 'package:startinsights/Screen/BookanExpert/bloc/bookanexpert_bloc.dart';
import 'package:startinsights/Screen/BookanExpert/bloc/bookanexpert_state.dart';
import 'package:startinsights/Screen/BookanExpert/web/bookanexpertItem.dart';
import 'package:startinsights/Utils/FontSizes.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Utils/StorageServiceConstant.dart';
import 'package:startinsights/Utils/screens.dart';
import 'package:startinsights/Widgets/Appbarnew.dart';
import 'package:startinsights/Widgets/sidemenunew.dart';

class BookanexpertWeb extends StatefulWidget {
  BookanexpertWeb({super.key});

  @override
  State<BookanexpertWeb> createState() => _BookanexpertWebState();
}

class _BookanexpertWebState extends State<BookanexpertWeb> {
  @override
  late BookanExpertBloc mBookanExpertBloc;
  bool checkedValue = false;
  List<FundraisingExpert> mBookAnExpertList = [];
  String mUserImage = "";
  String userId = "";
  ValueNotifier<bool> setnotifier = ValueNotifier(true);
  int mShowView = 1;
  @override
  void initState() {
    super.initState();
    Loadpref();
  }

  Future<void> Loadpref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    userId = (prefs.getString(StorageServiceConstant.MUSEREMAIL) ?? '');
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    mBookanExpertBloc = BookanExpertBloc(mContext: context);

    var _crossAxisSpacing = 10;
    var _screenWidth = MediaQuery.of(context).size.width;
    var _crossAxisCount = 2;
    var _width = (_screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    var cellHeight = 700;
    var _aspectRatio = _width / cellHeight;

    void OnLoadNext() {
      Navigator.pushReplacementNamed(context, dashboardRoute);
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
          body: BlocConsumer<BookanExpertBloc, BookanExpertStatus>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is GetBookanExpertInfoSuccessState) {
                mBookAnExpertList = state.mBookAnExpertList;

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
                          mFrom: 0,
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
                                  mFrom: 0,
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
                                                          .mFundraisingExperts,
                                                      textAlign:
                                                          TextAlign.center,
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
                                              child: const Row(
                                                //ROW 1
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [],
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
                                    visible: true,
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
                                                      CrossAxisAlignment
                                                          .stretch,
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
                                                                    .mFundraisingExperts,
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
                                                          10, 10, 10, 10),
                                                      child:
                                                          SingleChildScrollView(
                                                              child: GridView
                                                                  .count(
                                                        crossAxisCount: 3,
                                                        crossAxisSpacing: 5,
                                                        // childAspectRatio: 0.3,
                                                        childAspectRatio:
                                                            _aspectRatio,

                                                        mainAxisSpacing: 5,
                                                        shrinkWrap: true,
                                                        children: List.generate(
                                                          mBookAnExpertList
                                                              .length,
                                                          //  10,
                                                          (index) {
                                                            final mBookAnExpert =
                                                                mBookAnExpertList[
                                                                    index];

                                                            return InkWell(
                                                              onTap: () {},
                                                              child:
                                                                  BookanExpertItem(
                                                                mBookAnExpertList:
                                                                    mBookAnExpert,
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
              }

              //  ErrorToast(context: context, text: state.mDashboard.message!);

              //} else if (state is GetPunchInOutFailState) {}
              return Container();
            },
          )),
    );
  }
}
