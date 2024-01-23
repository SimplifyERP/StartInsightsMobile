import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Model/CoursesDetailsResponse.dart';
import 'package:startinsights/Screen/MyCourses/bloc/mycourses_bloc.dart';
import 'package:startinsights/Screen/MyCourses/bloc/mycourses_state.dart';
import 'package:startinsights/Screen/MyCourses/web/MyCourseItem.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Utils/screens.dart';
import 'package:startinsights/Widgets/Appbar.dart';
import 'package:startinsights/Widgets/sidemenu.dart';

class MyCoursesWeb extends StatefulWidget {
  final String mCourseid;

  MyCoursesWeb({
    super.key,
    required this.mCourseid,
  });

  @override
  State<MyCoursesWeb> createState() => _MyCoursesWebState();
}

class _MyCoursesWebState extends State<MyCoursesWeb> {
  @override
  late MyCoursesBloc mMyCoursesBloc;
  bool checkedValue = false;
  List<Course> mCoursesDetailsList = [];
  String mDescriptionText = "";
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    mMyCoursesBloc = MyCoursesBloc(mContext: context);

    void OnLoadNext() {
      Navigator.pushReplacementNamed(context, dashboardRoute);
    }

    final ScrollController controller = ScrollController();

    return WillPopScope(
      onWillPop: () {
        //trigger leaving and use own data
        //Navigator.pop(context, false);

        OnLoadNext();
        //we need to return a future
        return Future.value(false);
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: Appbar(mText: "TExt", mUserImage: "", mFrom: 6),
          body: BlocConsumer<MyCoursesBloc, MyCoursesStatus>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is GetMyCoursesInfoSuccessState) {
                mCoursesDetailsList = state.mCoursesDetails;

                // mCoursesDetailsList![0].description!
                for (var i = 0;
                    i < (mCoursesDetailsList![0].description ?? []).length;
                    i++) {
                  mDescriptionText =
                      "$mDescriptionText${mCoursesDetailsList![0].description![i]}\n\n";
                }

                return SafeArea(
                  child: SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: Container(
                      color: Colors.white,
                      margin: const EdgeInsets.only(top: 0, left: 0, right: 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            //ROW 1
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(0),
                                          color: kBorderColor),
                                      child: SideMenu(mFrom: 6))),
                              Expanded(
                                  flex: 9,
                                  child: Container(
                                      height:
                                          MediaQuery.of(context).size.height,
                                      padding: EdgeInsets.all(15),
                                      child: SingleChildScrollView(
                                          child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: RichText(
                                              text: TextSpan(
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text:
                                                          Languages.of(context)!
                                                              .mStartX,
                                                      style: const TextStyle(
                                                          fontFamily:
                                                              'ManropeBold',
                                                          fontSize: 26,
                                                          color: mBlackColor)),
                                                  TextSpan(
                                                      text:
                                                          Languages.of(context)!
                                                              .mStartupSchool,
                                                      style: const TextStyle(
                                                          fontFamily:
                                                              'ManropeBold',
                                                          fontSize: 26,
                                                          color: mBlackColor)),
                                                  TextSpan(
                                                      text:
                                                          Languages.of(context)!
                                                              .mSlash,
                                                      style: const TextStyle(
                                                          fontFamily:
                                                              'ManropeBold',
                                                          fontSize: 26,
                                                          color: mBlackColor)),
                                                  TextSpan(
                                                      text:
                                                          Languages.of(context)!
                                                              .mMyCourses,
                                                      style: const TextStyle(
                                                          fontFamily:
                                                              'ManropeBold',
                                                          fontSize: 26,
                                                          color: mBtnColor)),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              Languages.of(context)!
                                                  .mBasicsofPitching,
                                              style: const TextStyle(
                                                  fontFamily: 'ManropeBold',
                                                  fontSize: 26,
                                                  color: mBlackColor),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                  flex: 6,
                                                  child: SingleChildScrollView(
                                                    child: Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 2,
                                                              left: 2,
                                                              right: 2),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            child: Column(
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    child: Text(
                                                                        Languages.of(context)!
                                                                            .mDescription,
                                                                        style: const TextStyle(
                                                                            fontFamily:
                                                                                'ManropeSemiBold',
                                                                            fontSize:
                                                                                18,
                                                                            color:
                                                                                mBlackColor)),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 20,
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    child: Text(
                                                                        mDescriptionText ??
                                                                            "",
                                                                        style: const TextStyle(
                                                                            fontFamily:
                                                                                'ManropeRegular',
                                                                            fontSize:
                                                                                15,
                                                                            color:
                                                                                kTextColorOne)),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 20,
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    child: Text(
                                                                        Languages.of(context)!
                                                                            .mCourseDetails,
                                                                        style: const TextStyle(
                                                                            fontFamily:
                                                                                'ManropeSemiBold',
                                                                            fontSize:
                                                                                18,
                                                                            color:
                                                                                mBlackColor)),
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
                                                                            itemCount:
                                                                                mCoursesDetailsList![0].chapters!.length,
                                                                            itemBuilder: (context, index) {
                                                                              final mgetCoursesDetails = mCoursesDetailsList![0].chapters![index];
                                                                              return MyCourseItem(mChapterList: mgetCoursesDetails);
                                                                            }),
                                                                  )
                                                                ]),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  )),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                  flex: 4,
                                                  child: SingleChildScrollView(
                                                    child: Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 2,
                                                              left: 2,
                                                              right: 2),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    5),
                                                            margin: EdgeInsets
                                                                .fromLTRB(10,
                                                                    100, 10, 0),
                                                            color: Colors.red,
                                                            height: 300,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            child: Text("Test"),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ],
                                      )))),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }

              //  ErrorToast(context: context, text: state.mDashboard.message!);

              //} else if (state is GetPunchInOutFailState) {}
              return Container();
            },
          )),
    );
  }
}
