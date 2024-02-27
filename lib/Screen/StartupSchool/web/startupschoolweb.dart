import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Model/CoursesListResponse.dart';
import 'package:startinsights/Model/MastersResponse.dart';
import 'package:startinsights/Screen/StartupSchool/bloc/startupschool_bloc.dart';
import 'package:startinsights/Screen/StartupSchool/bloc/startupschool_state.dart';
import 'package:startinsights/Screen/StartupSchool/web/CourseItem.dart';
import 'package:startinsights/Screen/StartupSchool/web/UnsavedCourseItem.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Utils/screens.dart';
import 'package:startinsights/Widgets/Appbar.dart';
import 'package:startinsights/Widgets/sidemenu.dart';

class StartupSchoolWeb extends StatefulWidget {
  StartupSchoolWeb({super.key});

  @override
  State<StartupSchoolWeb> createState() => _StartupSchoolWebState();
}

class _StartupSchoolWebState extends State<StartupSchoolWeb> {
  @override
  late StartupSchoolBloc mStartupSchoolBloc;
  bool checkedValue = false;
  List<UserType>? mUserTypeDataList;
  List<UserType> getUserType = <UserType>[];
  List<CoursesList> mCoursesList = [];
  List<CoursesList> mUnsavedCoursesList = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    mStartupSchoolBloc = StartupSchoolBloc(mContext: context);

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
          appBar: Appbar(
            mText: "TExt",
            mUserImage: "",
            mFrom: 6,
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
              Navigator.pushReplacementNamed(context, profileRoute);
              //ErrorToast(context: context, text: "Test");
            },
            onPressedLogout: () {
              Navigator.of(context, rootNavigator: true).pop();
              Navigator.pushReplacementNamed(context, loginRoute);
            },
          ),
          body: BlocConsumer<StartupSchoolBloc, StartupSchoolStatus>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is GetStartupSchoolInfoSuccessState) {
                mCoursesList = state.mCoursesList.coursesList ?? [];
                mUnsavedCoursesList = state.mCoursesList.savedCourses ?? [];
                return SafeArea(
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
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
                                                          color: mBtnColor)),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Stack(
                                            children: [
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    Languages.of(context)!
                                                        .mCourses,
                                                    style: const TextStyle(
                                                        fontFamily:
                                                            'ManropeBold',
                                                        fontSize: 26,
                                                        color: mBlackColor),
                                                  ),
                                                ),
                                              ),
                                              Visibility(
                                                visible: false,
                                                child: Align(
                                                  alignment: Alignment.topRight,
                                                  child: Container(
                                                    width: 400,
                                                    height: 40,
                                                    margin: const EdgeInsets
                                                        .fromLTRB(0, 0, 20, 0),
                                                    child: SearchBar(
                                                      padding:
                                                          MaterialStateProperty
                                                              .all(
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 10,
                                                                      right:
                                                                          10)),
                                                      //controller: _textEditingController,
                                                      elevation:
                                                          MaterialStateProperty
                                                              .all(1.0),
                                                      side: MaterialStateProperty
                                                          .all(const BorderSide(
                                                              color: kGray)),
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(
                                                                  Colors.white),
                                                      hintText:
                                                          Languages.of(context)!
                                                              .mSave,
                                                      shape: MaterialStateProperty
                                                          .all(
                                                              const ContinuousRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20)),
                                                        // side: BorderSide(color: Colors.pinkAccent),
                                                      )),
                                                      hintStyle:
                                                          MaterialStateProperty
                                                              .all(
                                                                  const TextStyle(
                                                        color: kTextBorder,
                                                        fontSize: 16,
                                                        fontFamily:
                                                            'OpenSansRegular',
                                                      )),
                                                      textStyle:
                                                          MaterialStateProperty
                                                              .all(
                                                                  const TextStyle(
                                                        fontSize: 16,
                                                        fontFamily:
                                                            'OpenSansRegular',
                                                        color: mBlackColor,
                                                      )),
                                                      onChanged:
                                                          (String value) {
                                                        print('value: $value');
                                                        // filterSearchResults(value);
                                                      },
                                                      onTap: () {
                                                        print('tapped');
                                                        // The code below only works with SearchAnchor
                                                        // _searchController.openView();
                                                      },
                                                      leading: const Icon(
                                                          Icons.search,
                                                          size: 20,
                                                          color: kTextBorder),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                              height: mCoursesList.isEmpty
                                                  ? 0
                                                  : 350,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              color: Colors.white,
                                              child: ScrollConfiguration(
                                                behavior:
                                                    ScrollConfiguration.of(
                                                            context)
                                                        .copyWith(dragDevices: {
                                                  PointerDeviceKind.touch,
                                                  PointerDeviceKind.mouse,
                                                }),
                                                child: ListView.builder(
                                                  controller: controller,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemBuilder:
                                                      ((context, index) {
                                                    final mgetCoursesList =
                                                        mCoursesList[index];
                                                    return CourseItem(
                                                        mCoursesList:
                                                            mgetCoursesList,
                                                        mStartupSchoolBloc:
                                                            mStartupSchoolBloc);
                                                  }),
                                                  itemCount:
                                                      mCoursesList.length,
                                                ),
                                              )),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              Languages.of(context)!
                                                  .mSavedCourses,
                                              style: const TextStyle(
                                                  fontFamily: 'ManropeBold',
                                                  fontSize: 26,
                                                  color: mBlackColor),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                              height:
                                                  mUnsavedCoursesList.isEmpty
                                                      ? 0
                                                      : 350,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              color: Colors.white,
                                              child: ScrollConfiguration(
                                                behavior:
                                                    ScrollConfiguration.of(
                                                            context)
                                                        .copyWith(dragDevices: {
                                                  PointerDeviceKind.touch,
                                                  PointerDeviceKind.mouse,
                                                }),
                                                child: ListView.builder(
                                                  controller: controller,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemBuilder:
                                                      ((context, index) {
                                                    final mgetCoursesList =
                                                        mUnsavedCoursesList[
                                                            index];

                                                    return UnSavedCourseItem(
                                                        mCoursesList:
                                                            mgetCoursesList,
                                                        mStartupSchoolBloc:
                                                            mStartupSchoolBloc);
                                                  }),
                                                  itemCount: mUnsavedCoursesList
                                                      .length,
                                                ),
                                              )),
                                          const SizedBox(
                                            height: 100,
                                          )
                                        ],
                                      )))),
                            ],
                          ),
                          Container(),
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
