import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Utils/FontSizes.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Widgets/button.dart';

class DashboardFundabilitylist extends StatelessWidget {
  final int mIndex;
  final bool isExpanded;
  const DashboardFundabilitylist({
    required this.mIndex,
    required this.isExpanded,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      //onTap: (() => selectMeal(context)),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                //  width: MediaQuery.of(context).size.width / 3 - 50,
                width: isExpanded
                    ? ((MediaQuery.of(context).size.width * 0.75)) / 3
                    : ((MediaQuery.of(context).size.width * 0.9)) / 3,
                padding: const EdgeInsets.all(10),
                //  margin: const EdgeInsets.only(right: 10, left: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.white,
                      blurRadius: 0,
                    ),
                  ],
                ),
                child: (mIndex == 0)
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                            SizedBox(
                              height: 5,
                            ),
                            Text(Languages.of(context)!.mCheckyourFundability,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: 'OpenSauceSansSemiBold',
                                  fontSize: mSizeFive,
                                )),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              height: 200,
                              width: double.infinity,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: mGreyTwo,
                                boxShadow: const [
                                  BoxShadow(
                                    color: mGreyTwo,
                                    blurRadius: 1.0,
                                  ),
                                ],
                              ),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/new_ic_checkscore.png',
                                      height: 120,
                                      width: 150,
                                    ),
                                    Button(
                                      mButtonname: Languages.of(context)!
                                          .mCheckyourScore,
                                      onpressed: () {},
                                      mSelectcolor: mBtnColor,
                                      mTextColor: mWhiteColor,
                                      mFontSize: mSizeTen,
                                      mWidth: 200,
                                      mHeigth: 40,
                                      mHovercolor: mGreyTwo,
                                    ),
                                  ]),
                            )
                          ])
                    : (mIndex == 1)
                        ? InkWell(
                            onTap: () {
                              GoRouter.of(context).go('/ReviewDeck');
                            },
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      Languages.of(context)!
                                          .mReviewYouPitchDeck,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontFamily: 'OpenSauceSansSemiBold',
                                        fontSize: mSizeFive,
                                      )),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    height: 200,
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: mGreyTwo,
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.white,
                                          blurRadius: 1.0,
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/new_ic_upload.png',
                                            height: 80,
                                            width: 80,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              Languages.of(context)!
                                                  .mUploadyourpitchdeckordraganddrophere,
                                              style: const TextStyle(
                                                  fontFamily:
                                                      'OpenSauceSansRegular',
                                                  fontSize: mSizeTwo,
                                                  color: mGreySeven)),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              Languages.of(context)!
                                                  .mAcceptsPDFfilesupto,
                                              style: const TextStyle(
                                                  fontFamily:
                                                      'OpenSauceSansRegular',
                                                  fontSize: mSizeTwo,
                                                  color: mGreySeven)),
                                        ]),
                                  )
                                ]),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Text(Languages.of(context)!.mBuildyourPitchroom,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontFamily: 'OpenSauceSansSemiBold',
                                      fontSize: mSizeFive,
                                    )),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  height: 200,
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: mGreyTwo,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.white,
                                        blurRadius: 1.0,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/new_ic_upload.png',
                                          height: 80,
                                          width: 80,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                            Languages.of(context)!
                                                .mUploadyourpitchdeckordraganddrophere,
                                            style: const TextStyle(
                                                fontFamily:
                                                    'OpenSauceSansRegular',
                                                fontSize: mSizeTwo,
                                                color: mGreySeven)),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                            Languages.of(context)!
                                                .mAcceptsPDFfilesupto,
                                            style: const TextStyle(
                                                fontFamily:
                                                    'OpenSauceSansRegular',
                                                fontSize: mSizeTwo,
                                                color: mGreySeven)),
                                      ]),
                                )
                              ])),
            SizedBox(
              width: 20,
            )
          ]),
    );
  }
}
