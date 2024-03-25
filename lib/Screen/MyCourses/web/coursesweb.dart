import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pod_player/pod_player.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Model/CourseDetailsResponse.dart';
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
  List<CourseDetail> mCoursesDetailsList = [];

  late PodPlayerController controller;
  bool? isVideoPlaying;
  bool alwaysShowProgressBar = true;

  List<String> mLessonNameList = [];
  List<bool> mLessonViewedList = [];
  List<String> mLessonURLList = [];

  var mPlayedpostion = 0;

  var VideototalDuration = "";
  var totalHour = "";
  var totalMinute = "";
  var totalSeconds = "";
  bool mPlayfirsttime = true;
  bool mAPICall = true;

//https://startinsights.ai//files/Introduction to Computers.mp4
  @override
  void initState() {
    super.initState();
//https://startinsights.ai//files/Introduction to Computers.mp4
    controller = PodPlayerController(
      playVideoFrom: PlayVideoFrom.network(''),
    )..initialise().then((value) {
        setState(() {
          isVideoPlaying = controller.isVideoPlaying;
          controller.mute();
        });
      });
    controller.addListener(_listner);
  }

  @override
  void dispose() {
    controller.removeListener(_listner);
    controller.dispose();
    super.dispose();
  }

  void _listner() {
    if (controller.isVideoPlaying != isVideoPlaying) {
      isVideoPlaying = controller.isVideoPlaying;

      //  controller.doubleTapVideoBackward(10);
      // controller.doubleTapVideoForward(10);
    }

    if (mounted) setState(() {});
  }

  Widget build(BuildContext context) {
    mMyCoursesBloc = MyCoursesBloc(mContext: context);

    void OnLoadNext() {
      Navigator.pushReplacementNamed(context, startupSchoolRoute);
    }

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
                mCoursesDetailsList = state.mCoursesDetails;
                mLessonNameList.clear();
                mLessonViewedList.clear();
                mLessonURLList.clear();
                for (int i = 0;
                    i < mCoursesDetailsList![0].chapters!.length;
                    i++) {
                  for (int j = 0;
                      j < mCoursesDetailsList![0].chapters![i].lessons!.length;
                      j++) {
                    mLessonURLList.add(mCoursesDetailsList![0]
                        .chapters![i]
                        .lessons![j]
                        .body!
                        .replaceAll('%3A', ':'));

                    mLessonNameList.add(mCoursesDetailsList![0]
                        .chapters![i]
                        .lessons![j]
                        .lessonName!);

                    mLessonViewedList.add(mCoursesDetailsList![0]
                        .chapters![i]
                        .lessons![j]
                        .courseSeenStatus!);
                  }
                }

                if (mPlayfirsttime) {
                  controller.changeVideo(
                      playVideoFrom: PlayVideoFrom.network(mLessonURLList[0]));
                  mPlayfirsttime = false;
                }

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

                totalHour =
                    controller.currentVideoPosition.inSeconds.toString();

                VideototalDuration =
                    controller.totalVideoLength.inSeconds.toString();

                if ((int.parse(VideototalDuration) - 10) ==
                    int.parse(totalHour)) {
                  if (mAPICall) {
                    mAPICall = false;
                    print("API CAll");
                  }

                  // ErrorToast(context: context, text: "API CAll");
                }

                controller.addListener(_listner);

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
                                                    onTap: () {
                                                      OnLoadNext();
                                                    },
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
                                            child: ListView.builder(
                                                itemCount:
                                                    mCoursesDetailsList![0]
                                                        .chapters!
                                                        .length,
                                                itemBuilder: (context, index) {
                                                  final mgetCoursesDetails =
                                                      mCoursesDetailsList![0]
                                                          .chapters![index];
                                                  return ExpansionTile(
                                                      backgroundColor:
                                                          kBorderColor,
                                                      iconColor: Colors.black,
                                                      collapsedIconColor:
                                                          Colors.black,
                                                      title: Text(
                                                        mgetCoursesDetails
                                                                .chapterName ??
                                                            "",
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                'ManropeSemiBold',
                                                            fontSize: 14,
                                                            color: mBlackColor),
                                                      ),
                                                      children: [
                                                        Container(
                                                          height:
                                                              mgetCoursesDetails
                                                                      .lessons!
                                                                      .length *
                                                                  50,
                                                          color: kBorderColor,
                                                          child:
                                                              ListView.builder(
                                                            itemBuilder:
                                                                ((context,
                                                                    index1) {
                                                              final mLessonsList =
                                                                  mgetCoursesDetails
                                                                          .lessons![
                                                                      index1];
                                                              return ListTile(
                                                                  leading: (mLessonsList
                                                                              .courseSeenStatus ??
                                                                          false)
                                                                      ? Image
                                                                          .asset(
                                                                          'assets/ic_videoview.png',
                                                                          height:
                                                                              15,
                                                                        )
                                                                      : Image
                                                                          .asset(
                                                                          'assets/ic_video.png',
                                                                          height:
                                                                              15,
                                                                        ),
                                                                  // Align(
                                                                  //     alignment: Alignment.center,
                                                                  //     child: Image.asset(
                                                                  //       'assets/ic_video.png',
                                                                  //       height: 20,
                                                                  //     )),
                                                                  title: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    child: Text(
                                                                        mLessonsList.lessonName ??
                                                                            "",
                                                                        style: const TextStyle(
                                                                            fontFamily:
                                                                                'ManropeRegular',
                                                                            fontSize:
                                                                                13,
                                                                            color:
                                                                                kTextColorOne)),
                                                                  ),
                                                                  onTap: () {
                                                                    for (int i =
                                                                            0;
                                                                        i < mLessonNameList.length;
                                                                        i++) {
                                                                      var aa = (mLessonsList.lessonName ??
                                                                              "")
                                                                          .replaceAll(
                                                                              '%3A',
                                                                              ':');
                                                                      var aaa =
                                                                          mLessonNameList[
                                                                              i];

                                                                      if ((mLessonsList.lessonName ??
                                                                              "") ==
                                                                          mLessonNameList[
                                                                              i]) {
                                                                        mPlayedpostion =
                                                                            i;
                                                                        controller.changeVideo(
                                                                            playVideoFrom:
                                                                                PlayVideoFrom.network(mLessonURLList[mPlayedpostion]));
                                                                      }
                                                                    }

                                                                    // setState(
                                                                    //     () {

                                                                    //https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4
                                                                    /*  var mVideoId = (mLessonsList.body ??
                                                                              "")
                                                                          .replaceAll(
                                                                              '%3A',
                                                                              ':');

                                                                      try {
                                                                        FocusScope.of(context)
                                                                            .unfocus();
                                                                        await controller
                                                                            .changeVideo(
                                                                          playVideoFrom:
                                                                              PlayVideoFrom.network('https://startinsights.ai//files/9 Dart concepts to know before you jump into Flutter __ for super beginners in Flutter.mp4'),
                                                                        );
                                                                        controller
                                                                            .addListener(_listner);
                                                                        if (!mounted)
                                                                          return;
                                                                        ScaffoldMessenger.of(context)
                                                                            .hideCurrentSnackBar();
                                                                      } catch (e) {
                                                                        ErrorToast(
                                                                            context:
                                                                                context,
                                                                            text:
                                                                                e.toString());
                                                                      }*/

                                                                    /*  _apiService1.getCoursesVideoProgress(mLessonsList.lessonName ?? "", "jagadeesan.a1104@gmail.com").then((value) async {
                                                                              print(value);

                                                                              if (value is ApiSuccess) {
                                                                                if (CommonResponse.fromJson(value.data)!.message!.status ?? false) {
                                                                                  for (var j = 0; j < mLessonName.length; j++) {
                                                                                    if (mLessonName[j] == (mLessonsList.lessonName ?? "")) {
                                                                                      mLessonStatus[j] = true;
                                                                                    }
                                                                                  }

                                                                                  setState(() {
                                                                                    showcertificate = mLessonStatus.every((e) => true);
                                                                                  });
                                                                                } else {
                                                                                  // ErrorToast(context: context, text: CommonResponse.fromJson(value.data)!.message!.message ?? "");
                                                                                }
                                                                              } else if (value is ApiFailure) {}
                                                                            });*/

                                                                    /*_chewieController = ChewieController(
                                                                              videoPlayerController: VideoPlayerController.networkUrl(Uri.parse(mVideoId)),
                                                                              //  aspectRatio: 16 / 9,
                                                                              autoInitialize: true,
                                                                              autoPlay: true,
                                                                              looping: true,
                                                                              errorBuilder: (context, errorMessage) {
                                                                                return Center(
                                                                                  child: Padding(
                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                    child: Text(
                                                                                      errorMessage,
                                                                                      style: const TextStyle(color: Colors.white),
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              },
                                                                            );*/

                                                                    /* _controller = VideoPlayerController.networkUrl(Uri.parse(mVideoId))
                                                                                                      ..initialize().then((_) {
                                                                                                        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
                                                                                                        setState(() {
                                                                                                          _controller.play();
                                                                                                        });
                                                                                                      });*/
                                                                    // _controller.value.isInitialized;
                                                                    //  });
                                                                    //ErrorToast(context: context, text: mStartTimeList);
                                                                  });

                                                              //VideoItem(mLessonList: mLessonsList);
                                                            }),
                                                            itemCount:
                                                                mgetCoursesDetails
                                                                    .lessons!
                                                                    .length,
                                                          ),
                                                        ),
                                                      ]);

                                                  /*Card(
                                                    color: kBorderColor,
                                                    child: ,
                                                  );*/

                                                  //MyCourseItem(mChapterList: mgetCoursesDetails);
                                                })),
                                        SizedBox(
                                          height: 1,
                                          child: Center(
                                            child: Container(
                                              height: 1,
                                              color: kGray,
                                            ),
                                          ),
                                        ),
                                        Container(
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
                                                                fontSize: 18,
                                                                color:
                                                                    kprogressbarpitchcraft))),
                                                  ]),
                                                ),
                                              )),
                                        )
                                        /*Expanded(
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
                                            ))*/
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
                                                    size: 30,
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
                                              Languages.of(context)!.mCourses,
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
                                                            child:
                                                                PrimaryButton(
                                                                    mButtonname:
                                                                        Languages.of(context)!
                                                                            .mPrevious,
                                                                    onpressed:
                                                                        () {
                                                                      if (mPlayedpostion >
                                                                          0) {
                                                                        mPlayedpostion =
                                                                            mPlayedpostion -
                                                                                1;

                                                                        controller.changeVideo(
                                                                            playVideoFrom:
                                                                                PlayVideoFrom.network(mLessonURLList[mPlayedpostion]));
                                                                      }
                                                                    },
                                                                    mSelectcolor:
                                                                        mBtnColor,
                                                                    mTextColor:
                                                                        mWhiteColor,
                                                                    mFontSize:
                                                                        16,
                                                                    mHeigth:
                                                                        40),
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
                                                            child:
                                                                PrimaryButton(
                                                                    mButtonname:
                                                                        Languages.of(context)!
                                                                            .mNext,
                                                                    onpressed:
                                                                        () {
                                                                      mPlayedpostion =
                                                                          mPlayedpostion +
                                                                              1;
                                                                      if (mPlayedpostion <
                                                                          14) {
                                                                        controller.changeVideo(
                                                                            playVideoFrom:
                                                                                PlayVideoFrom.network(mLessonURLList[mPlayedpostion]));
                                                                      }
                                                                    },
                                                                    mSelectcolor:
                                                                        mBtnColor,
                                                                    mTextColor:
                                                                        mWhiteColor,
                                                                    mFontSize:
                                                                        16,
                                                                    mHeigth:
                                                                        40),
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
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width - 100,
                                  height:
                                      MediaQuery.of(context).size.height - 140,
                                  color: Colors.white,
                                  padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                                  child: Stack(
                                    children: [
                                      PodVideoPlayer(
                                        alwaysShowProgressBar:
                                            alwaysShowProgressBar,
                                        controller: controller,
                                        matchFrameAspectRatioToVideo: true,
                                        matchVideoAspectRatioToFrame: true,
                                        // videoTitle: "Test",
                                      ),

                                      Center(
                                        child: Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              15, 10, 15, 10),
                                          height: 70,
                                          child: Row(children: [
                                            Expanded(
                                                flex: 2,
                                                child: Center(
                                                  child: Visibility(
                                                    visible: controller
                                                        .isVideoPlaying,
                                                    child: InkWell(
                                                        onTap: () {
                                                          controller
                                                              .doubleTapVideoBackward(
                                                                  10);
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
                                                    visible: controller
                                                        .isVideoPlaying,
                                                    child: InkWell(
                                                        onTap: () {
                                                          controller
                                                              .doubleTapVideoForward(
                                                                  10);
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
                                  ),
                                ),
                                Text('$VideototalDuration seconds',
                                    style: const TextStyle(
                                      fontFamily: 'ManropeRegular',
                                      fontSize: 14,
                                    )),
                                Container(
                                  child: Text(
                                    '$totalHour hour: '
                                    '$totalMinute minute: '
                                    '$totalSeconds seconds',
                                  )
                                  /*Text(
                                      'Total Video length: ${controller.totalVideoLength}' +
                                          'Total Video length: ${controller.currentVideoPosition}')*/
                                  ,
                                )
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
