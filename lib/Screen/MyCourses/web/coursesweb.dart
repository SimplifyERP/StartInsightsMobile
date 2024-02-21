import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Screen/MyCourses/bloc/mycourses_bloc.dart';
import 'package:startinsights/Screen/MyCourses/bloc/mycourses_state.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Utils/screens.dart';
import 'package:startinsights/Widgets/primary_button.dart';

class CoursesWeb extends StatefulWidget {
  final String mCourseid;
  const CoursesWeb({super.key, required this.mCourseid});

  @override
  State<CoursesWeb> createState() => _CoursesWebState();
}

class _CoursesWebState extends State<CoursesWeb> {
  @override
  late MyCoursesBloc mMyCoursesBloc;
  bool SidemenuVisble = true;

  Widget build(BuildContext context) {
    mMyCoursesBloc = MyCoursesBloc(mContext: context);

    void OnLoadNext() {
      Navigator.pushReplacementNamed(context, startupSchoolRoute);
    }

    final ScrollController controller = ScrollController();

    return WillPopScope(
      onWillPop: () {
        //trigger leaving and use own data

        OnLoadNext();
        //we need to return a future
        return Future.value(false);
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: BlocConsumer<MyCoursesBloc, MyCoursesStatus>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is GetMyCoursesInfoSuccessState) {
                return SafeArea(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                            visible: SidemenuVisble,
                            child: Expanded(
                                flex: 2,
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(0),
                                        color: kBorderColor),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: double.infinity,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          10, 0, 5, 0),
                                                  child: InkWell(
                                                    onTap: () {},
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Row(children: [
                                                        const Expanded(
                                                          flex: 2,
                                                          child: Icon(
                                                              Icons.arrow_back,
                                                              size: 20,
                                                              color:
                                                                  kprogressbarpitchcraft),
                                                        ), //ic_dashboardwhite
                                                        Expanded(
                                                            flex: 8,
                                                            child: Text(
                                                                Languages.of(
                                                                        context)!
                                                                    .mbacktocourses,
                                                                style: const TextStyle(
                                                                    fontFamily:
                                                                        'ManropeSemiBold',
                                                                    fontSize:
                                                                        18,
                                                                    color:
                                                                        kprogressbarpitchcraft))),
                                                      ]),
                                                    ),
                                                  )),
                                            )),
                                        Expanded(
                                            flex: 8,
                                            child: SingleChildScrollView(
                                              child: Container(
                                                color: Colors.white,
                                                margin: const EdgeInsets.only(
                                                    top: 0, left: 0, right: 0),
                                                child: const Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text("My data"),
                                                    Text("My data"),
                                                    Text("My data"),
                                                    Text("My data"),
                                                    Text("My data"),
                                                    Text("My data"),
                                                    Text("My data"),
                                                    Text("My data"),
                                                    Text("My data"),
                                                    Text("My data"),
                                                    Text("My data"),
                                                    Text("My data"),
                                                    Text("My data"),
                                                    Text("My data"),
                                                    Text("My data"),
                                                    Text("My data"),
                                                    Text("My data"),
                                                    Text("My data"),
                                                    Text("My data"),
                                                    Text("My data"),
                                                    Text("My data"),
                                                    Text("My data"),
                                                    Text("My data"),
                                                    Text("My data"),
                                                    Text("My data"),
                                                    Text("My data"),
                                                    Text("My data"),
                                                    Text("My data"),
                                                    Text("My data"),
                                                    Text("My data"),
                                                    Text("My data"),
                                                    Text("My data"),
                                                    Text("My data"),
                                                    Text("My data"),
                                                    Text("My data"),
                                                    Text("My data"),
                                                    Text("My data"),
                                                    Text("My data"),
                                                    Text("My data"),
                                                    Text("My data"),
                                                    Text("My data"),
                                                    Text("My data"),
                                                    Text("My data"),
                                                    Text("My data"),
                                                    Text("My data"),
                                                    Text("My data"),
                                                    Text("My data"),
                                                    Text("My data"),
                                                    Text("My data"),
                                                    Text("My data"),
                                                    Text("My data"),
                                                    Text("My data"),
                                                    Text("My data"),
                                                    Text("My data"),
                                                    Text("My data"),
                                                    Text("My data")
                                                  ],
                                                ),
                                              ),
                                            )),
                                        SizedBox(
                                          height: 1,
                                          child: Center(
                                            child: Container(
                                              height: 1,
                                              color: kGray,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: double.infinity,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          10, 0, 5, 0),
                                                  child: InkWell(
                                                    onTap: () {},
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Row(children: [
                                                        Expanded(
                                                          flex: 2,
                                                          child: Image.asset(
                                                            'assets/ic_ceritificate.png',
                                                            height: 30,
                                                          ),
                                                        ),
                                                        //ic_dashboardwhite

                                                        Expanded(
                                                            flex: 8,
                                                            child: Text(
                                                                Languages.of(
                                                                        context)!
                                                                    .mcertification,
                                                                style: const TextStyle(
                                                                    fontFamily:
                                                                        'ManropeSemiBold',
                                                                    fontSize:
                                                                        18,
                                                                    color:
                                                                        kprogressbarpitchcraft))),
                                                      ]),
                                                    ),
                                                  )),
                                            ))
                                      ],
                                    )))),
                        Expanded(
                            flex: 8,
                            child: Column(
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width,
                                    color: mWhiteColor,
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Row(children: [
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  if (SidemenuVisble) {
                                                    SidemenuVisble = false;
                                                  } else {
                                                    SidemenuVisble = true;
                                                  }
                                                });
                                              },
                                              child: const SizedBox(
                                                height: 60,
                                                child: Row(children: [
                                                  SizedBox(
                                                    width: 60,
                                                  ),
                                                  Icon(
                                                    Icons.menu,
                                                    size: 40,
                                                    color:
                                                        kprogressbarpitchcraft,
                                                  ),
                                                ]),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 30,
                                            ),
                                            Text(
                                              Languages.of(context)!
                                                  .mNotification,
                                              style: const TextStyle(
                                                color: mBlackColor,
                                                fontFamily: 'ManropeSemiBold',
                                                fontSize: 18,
                                              ),
                                            )
                                          ]),
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Container(
                                            height: 60,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .center, // set your alignment
                                              children: <Widget>[
                                                Container(
                                                    height: 40,
                                                    width: 150,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        color: mBtnColor,
                                                        border: Border.all(
                                                          color: mBtnColor,
                                                          width: 1,
                                                        )),
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                0, 0, 0, 0),
                                                        child: InkWell(
                                                          child: Align(
                                                            alignment: Alignment
                                                                .center,
                                                            child: PrimaryButton(
                                                                mButtonname:
                                                                    Languages.of(
                                                                            context)!
                                                                        .mPrevious,
                                                                onpressed:
                                                                    () {},
                                                                mSelectcolor:
                                                                    mBtnColor,
                                                                mTextColor:
                                                                    mWhiteColor,
                                                                mFontSize: 16,
                                                                mHeigth: 40),
                                                          ),
                                                        ))),
                                                const SizedBox(
                                                  width: 15,
                                                ),
                                                Container(
                                                    height: 40,
                                                    width: 150,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        color: mBtnColor,
                                                        border: Border.all(
                                                          color: mBtnColor,
                                                          width: 1,
                                                        )),
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                0, 0, 0, 0),
                                                        child: InkWell(
                                                          child: Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: PrimaryButton(
                                                                mButtonname:
                                                                    Languages.of(
                                                                            context)!
                                                                        .mNext,
                                                                onpressed:
                                                                    () {},
                                                                mSelectcolor:
                                                                    mBtnColor,
                                                                mTextColor:
                                                                    mWhiteColor,
                                                                mFontSize: 16,
                                                                mHeigth: 40),
                                                          ),
                                                        ))),
                                                const SizedBox(
                                                  width: 15,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                                Container(
                                  color: kBorderColor,
                                  height: 2,
                                  width: MediaQuery.of(context).size.width,
                                ),
                              ],
                            ))
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
}
