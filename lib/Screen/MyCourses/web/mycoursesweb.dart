// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Model/CoursesDetailsResponse.dart';
import 'package:startinsights/Network/api_result_handler.dart';
import 'package:startinsights/Repository/courselistdetails_repository.dart';
import 'package:startinsights/Screen/MyCourses/bloc/mycourses_bloc.dart';
import 'package:startinsights/Screen/MyCourses/bloc/mycourses_state.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Utils/StorageServiceConstant.dart';
import 'package:startinsights/Utils/screens.dart';
import 'package:startinsights/Utils/utils.dart';
import 'package:startinsights/Widgets/Appbar.dart';
import 'package:startinsights/Widgets/primary_button.dart';
import 'package:startinsights/Widgets/sidemenu.dart';
import 'package:video_player/video_player.dart';

import '../../../Model/CommonResponse.dart';

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
  late ChewieController _chewieController;

  List<String> mLessonName = [];
  List<bool> mLessonStatus = [];

  bool showcertificate = false;
  bool showVideoview = false;
  var userId = "";

  final CoursesDetailsRepository _apiService1 = CoursesDetailsRepository();

  @override
  void initState() {
    super.initState();
    /* _controller = YoutubePlayerController(
      initialVideoId: 'Y_kfP5vobV8Onpzt',
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
      ),
    );*/

    // _controller = VideoPlayerController.networkUrl(Uri.parse(''))
    //   ..initialize().then((_) {
    //     // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    //     setState(() {});
    //   });
    // _controller.value.isInitialized;
//http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4
    _chewieController = ChewieController(
      videoPlayerController: VideoPlayerController.networkUrl(Uri.parse("")),
      aspectRatio: 16 / 9,
      autoInitialize: true,
      autoPlay: true,
      looping: true,
      errorBuilder: (context, errorMessage) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Select Video to play",
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );

    _chewieController.addListener(() {
      if (_chewieController.isFullScreen) {
      } else {
        setState(() {
          _chewieController.dispose();
          ErrorToast(context: context, text: "Error");
        });
      }
    });
    loadpref();
  }

  Future<void> loadpref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    userId = (prefs.getString(StorageServiceConstant.MUSEREMAIL) ?? '');
  }

  @override
  void dispose() {
    //   _controller.dispose();
    _chewieController.dispose();

    super.dispose();
  }

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
          body: BlocConsumer<MyCoursesBloc, MyCoursesStatus>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is GetMyCoursesInfoSuccessState) {
                mCoursesDetailsList = state.mCoursesDetails;

                mDescriptionText = mCoursesDetailsList![0].description ?? "";

                // mCoursesDetailsList![0].description!

                for (var i = 0;
                    i < mCoursesDetailsList![0].chapters!.length;
                    i++) {
                  for (var j = 0;
                      j < mCoursesDetailsList![0].chapters![i].lessons!.length;
                      j++) {
                    mLessonName.add(mCoursesDetailsList![0]
                            .chapters![i]
                            .lessons![j]
                            .lessonName ??
                        "");
                    mLessonStatus.add(mCoursesDetailsList![0]
                            .chapters![i]
                            .lessons![j]
                            .status ??
                        false);
                  }
                }

                if (mLessonStatus.isNotEmpty) {
                  showVideoview = true;
                  showcertificate = mLessonStatus.every((e) => true);
                }

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
                                                                              return Card(
                                                                                color: mCardColorOne,
                                                                                child: ExpansionTile(
                                                                                    iconColor: Colors.black,
                                                                                    collapsedIconColor: Colors.black,
                                                                                    title: Text(
                                                                                      mgetCoursesDetails.chapterName ?? "",
                                                                                      style: const TextStyle(fontFamily: 'ManropeSemiBold', fontSize: 16, color: mBlackColor),
                                                                                    ),
                                                                                    children: [
                                                                                      Container(
                                                                                        height: mgetCoursesDetails.lessons!.length * 40,
                                                                                        color: mWhiteColor,
                                                                                        child: ListView.builder(
                                                                                          itemBuilder: ((context, index) {
                                                                                            final mLessonsList = mgetCoursesDetails.lessons![index];
                                                                                            return ListTile(
                                                                                                leading: Image.asset(
                                                                                                  'assets/ic_video.png',
                                                                                                  height: 20,
                                                                                                ),
                                                                                                // Align(
                                                                                                //     alignment: Alignment.center,
                                                                                                //     child: Image.asset(
                                                                                                //       'assets/ic_video.png',
                                                                                                //       height: 20,
                                                                                                //     )),
                                                                                                title: Align(
                                                                                                  alignment: Alignment.centerLeft,
                                                                                                  child: Text(mLessonsList.lessonName ?? "", style: const TextStyle(fontFamily: 'ManropeRegular', fontSize: 14, color: kTextColorOne)),
                                                                                                ),
                                                                                                onTap: () {
                                                                                                  setState(() {
                                                                                                    //https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4
                                                                                                    var mVideoId = (mLessonsList.body ?? "").replaceAll('%3A', ':');

                                                                                                    _apiService1.getCoursesVideoProgress(mLessonsList.lessonName ?? "", userId).then((value) async {
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
                                                                                                    });

                                                                                                    _chewieController = ChewieController(
                                                                                                      videoPlayerController: VideoPlayerController.networkUrl(Uri.parse(mVideoId)),
                                                                                                      //  aspectRatio: 16 / 9,
                                                                                                      autoInitialize: true,
                                                                                                      autoPlay: true,
                                                                                                      // playbackSpeeds: ,
                                                                                                      additionalOptions: (context) {
                                                                                                        return <OptionItem>[
                                                                                                          OptionItem(
                                                                                                            onTap: () => debugPrint('My option works!'),
                                                                                                            iconData: Icons.chat,
                                                                                                            title: 'My localized title',
                                                                                                          ),
                                                                                                          OptionItem(
                                                                                                            onTap: () => debugPrint('Another option that works!'),
                                                                                                            iconData: Icons.chat,
                                                                                                            title: 'Another localized title',
                                                                                                          ),
                                                                                                        ];
                                                                                                      },
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
                                                                                                    );

                                                                                                    /* _controller = VideoPlayerController.networkUrl(Uri.parse(mVideoId))
                                                                                                      ..initialize().then((_) {
                                                                                                        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
                                                                                                        setState(() {
                                                                                                          _controller.play();
                                                                                                        });
                                                                                                      });*/
                                                                                                    // _controller.value.isInitialized;
                                                                                                  });
                                                                                                  //ErrorToast(context: context, text: mStartTimeList);
                                                                                                });

                                                                                            //VideoItem(mLessonList: mLessonsList);
                                                                                          }),
                                                                                          itemCount: mgetCoursesDetails.lessons!.length,
                                                                                        ),
                                                                                      ),
                                                                                    ]),
                                                                              );

                                                                              //MyCourseItem(mChapterList: mgetCoursesDetails);
                                                                            }),
                                                                  ),
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
                                                          SizedBox(
                                                            height: 100,
                                                          ),
                                                          Visibility(
                                                              visible:
                                                                  showVideoview,
                                                              child: Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          5),
                                                                  margin: const EdgeInsets
                                                                      .fromLTRB(
                                                                      10,
                                                                      10,
                                                                      10,
                                                                      0),
                                                                  child: Text(
                                                                      Languages.of(
                                                                              context)!
                                                                          .mPreview,
                                                                      style: const TextStyle(
                                                                          fontFamily:
                                                                              'ManropeSemiBold',
                                                                          fontSize:
                                                                              16,
                                                                          color:
                                                                              mBlackColor)),
                                                                ),
                                                              )),
                                                          Visibility(
                                                            visible:
                                                                showVideoview,
                                                            child: Center(
                                                              child: Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(5),
                                                                margin: EdgeInsets
                                                                    .fromLTRB(
                                                                        10,
                                                                        10,
                                                                        10,
                                                                        0),
                                                                color: Colors
                                                                    .white,
                                                                height: 300,
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                child: Scaffold(
                                                                    body:
                                                                        AspectRatio(
                                                                  aspectRatio:
                                                                      16 / 9,
                                                                  child: Chewie(
                                                                    controller:
                                                                        _chewieController,
                                                                  ),
                                                                )
                                                                    // Chewie(
                                                                    //   controller:
                                                                    //       _chewieController,
                                                                    // ),
                                                                    // Center(
                                                                    //     child: _controller
                                                                    //             .value
                                                                    //             .isInitialized
                                                                    //         ? AspectRatio(
                                                                    //             aspectRatio: _controller.value.aspectRatio,
                                                                    //             child: VideoPlayer(_controller),
                                                                    //           )
                                                                    //         : Container(
                                                                    //             color: Colors.white,
                                                                    //           )
                                                                    //
                                                                    //     // VideoPlayer(
                                                                    //     //     _controller),
                                                                    //     ),
                                                                    // floatingActionButton:
                                                                    //     Visibility(
                                                                    //   visible: _controller
                                                                    //           .value
                                                                    //           .isInitialized
                                                                    //       ? true
                                                                    //       : false,
                                                                    //   child:
                                                                    //       FloatingActionButton(
                                                                    //     onPressed:
                                                                    //         () {
                                                                    //       setState(
                                                                    //           () {
                                                                    //         _controller.value.isPlaying
                                                                    //             ? _controller.pause()
                                                                    //             : _controller.play();
                                                                    //       });
                                                                    //     },
                                                                    //     child:
                                                                    //         Icon(
                                                                    //       _controller.value.isPlaying
                                                                    //           ? Icons.pause
                                                                    //           : Icons.play_arrow,
                                                                    //     ),
                                                                    //   ),
                                                                    // )
                                                                    ),
                                                                /*YoutubePlayerBuilder(
                                                              player:
                                                                  YoutubePlayer(
                                                                controller:
                                                                    _controller,
                                                                showVideoProgressIndicator:
                                                                    true,
                                                                progressIndicatorColor:
                                                                    Colors
                                                                        .amber,
                                                                progressColors:
                                                                    ProgressBarColors(
                                                                  playedColor:
                                                                      Colors
                                                                          .amber,
                                                                  handleColor:
                                                                      Colors
                                                                          .amberAccent,
                                                                ),
                                                                onReady: () {
                                                                  _controller
                                                                      .addListener(
                                                                          () {
                                                                    _controller
                                                                        .initialVideoId;
                                                                  });
                                                                },
                                                              ),
                                                              builder: (context,
                                                                      player) =>
                                                                  player,
                                                            )*/
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 20,
                                                          ),
                                                          Visibility(
                                                              visible:
                                                                  showcertificate,
                                                              child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                  child:
                                                                      Container(
                                                                    width: 300,
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      child: PrimaryButton(
                                                                          mButtonname: Languages.of(context)!.mDownloadcerificate,
                                                                          onpressed: () {
                                                                            /*   html.AnchorElement
                                                                                anchorElement =
                                                                                html.AnchorElement(href: "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf");
                                                                            anchorElement.download =
                                                                                "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf";
                                                                            anchorElement.click();
                                                                            anchorElement.remove();*/

                                                                            html.window.open('https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
                                                                                'new tab');

                                                                            // _apiService1.getLmsCertificate(widget.mCourseid, "jagadeesan.a1104@gmail.com").then((value) async {
                                                                            //   print(value);
                                                                            //
                                                                            //   if (value is ApiSuccess) {
                                                                            //     if (CertificateResponse.fromJson(value.data)!.message!.status ?? false) {
                                                                            //       setState(() {
                                                                            //         showcertificate = mLessonStatus.every((e) => true);
                                                                            //       });
                                                                            //     } else {
                                                                            //       ErrorToast(context: context, text: CommonResponse.fromJson(value.data)!.message!.message ?? "");
                                                                            //     }
                                                                            //   } else if (value is ApiFailure) {}
                                                                            // });
                                                                          },
                                                                          mSelectcolor: mBtnColor,
                                                                          mTextColor: mWhiteColor,
                                                                          mFontSize: 16,
                                                                          mHeigth: 40),
                                                                    ),
                                                                  )))
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
