import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Repository/startupdeals_repository.dart';
import 'package:startinsights/Utils/FontSizes.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Widgets/primary_button.dart';

class LearnItem extends StatelessWidget {
  // final PitchRoomDetail mPitchRoomDetail;
  // final PitchroomBloc mPitchroomBloc;
  // final BuildContext context;
  // int mIndex;
  final VoidCallback onPressed;
  // final VoidCallback onShareLink;
  LearnItem({
    // required this.mPitchRoomDetail,
    // required this.mPitchroomBloc,
    // required this.context,
    required this.onPressed,
    // required this.onShareLink,
    // required this.mIndex,
    super.key,
  });

  void selectMeal(BuildContext context) {}

  final String mUserImage = "";
  final StartupDealsRepository _apiService1 = StartupDealsRepository();
  bool mVisible = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8, left: 8),
      child: Column(
        children: [
          Container(
            width: 300,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: mGreyTwo,
              boxShadow: const [
                BoxShadow(
                  color: mGreyTwo,
                  blurRadius: 0,
                ),
              ],
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: SvgPicture.asset(
                          'assets/new_ic_watermarkbg.svg',
                          width: 280,
                          height: 140,
                        ),
                      )),
                  Center(
                      child: Text(
                          "1.1 Understand the investor's mind in startups",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontFamily: 'OpenSauceSansSemiBold',
                              fontSize: mSizeThree,
                              color: mGreyTen))),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 3,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/new_ic_chapters.svg',
                                width: 15,
                                height: 15,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(Languages.of(context)!.mChapters,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontFamily: 'OpenSauceSansRegular',
                                      fontSize: mSizeTwo,
                                      color: mGreySeven))
                            ],
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          flex: 3,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/new_ic_video.svg',
                                width: 15,
                                height: 15,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(Languages.of(context)!.mVideos,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontFamily: 'OpenSauceSansRegular',
                                      fontSize: mSizeTwo,
                                      color: mGreySeven))
                            ],
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          flex: 3,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/new_ic_quizze.svg',
                                width: 15,
                                height: 15,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(Languages.of(context)!.mQuizzes,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontFamily: 'OpenSauceSansRegular',
                                      fontSize: mSizeTwo,
                                      color: mGreySeven))
                            ],
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    color: mGreyThree,
                    height: 1,
                    width: MediaQuery.of(context).size.width,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 8,
                        child: PrimaryButton(
                            mButtonname: Languages.of(context)!.mViewCourse,
                            onpressed: onPressed,
                            mSelectcolor: mBlueOne,
                            mTextColor: mWhiteColor,
                            mFontSize: mSizeTwo,
                            mHeigth: 40),
                      ),
                      Expanded(
                        flex: 2,
                        child: Align(
                            alignment: Alignment.center,
                            child: InkWell(
                                onTap: () {},
                                child: SvgPicture.asset(
                                  'assets/new_ic_heart.svg',
                                  width: 25,
                                  height: 25,
                                )
                                // Image.asset('assets/new_ic_heart.png',
                                //         width: 25,
                                //         height: 25,
                                //         fit: BoxFit.fill)
                                //     : SvgPicture.asset(
                                //     'assets/new_ic_emptyheart.svg',
                                //     width: 25,
                                //     height: 25,
                                //     fit: BoxFit.fill),
                                )),
                      )
                    ],
                  ),
                ]),
          )
        ],
      ),
    );
  }
}
