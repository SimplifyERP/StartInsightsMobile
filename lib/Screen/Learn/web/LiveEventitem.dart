import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_network/image_network.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Model/EventListResponse.dart';
import 'package:startinsights/Utils/FontSizes.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Utils/utils.dart';
import 'package:startinsights/Widgets/primary_button.dart';

class LiveEventItem extends StatelessWidget {
  final LiveEvent mLiveEvent;
  final VoidCallback onpressed;
  const LiveEventItem({
    super.key,
    required this.mLiveEvent,
    required this.onpressed,
  });

  void selectMeal(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    final buffer = StringBuffer();
    for (int i = 0; i < mLiveEvent.eventSpeakers!.length; i++) {
      buffer.write(mLiveEvent.eventSpeakers![i].speakersName);
      if ((mLiveEvent.eventSpeakers!.length - 1) != i) {
        buffer.write(" & ");
      }
    }
    return InkWell(
      onTap: () {},
      child: Container(
        width: 300,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.only(top: 10),
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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: ((mLiveEvent.eventImage ?? "").isNotEmpty)
                              ? ImageNetwork(
                                  image: mLiveEvent.eventImage!,
                                  height: 140,
                                  width: 280,
                                )
                              : SvgPicture.asset(
                                  'assets/new_ic_watermarkbg.svg',
                                  height: 140,
                                  width: 280,
                                )

                          // SvgPicture.asset(
                          //   'assets/new_ic_watermarkbg.svg',
                          //   width: 350,
                          //   height: 140,
                          // ),
                          )),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                            alignment: Alignment.topRight,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Container(
                                height: 25,
                                width: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: mRedColorOne,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: mRedColorOne,
                                      blurRadius: 1.0,
                                    ),
                                  ],
                                ),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 15,
                                        width: 15,
                                        //square box; equal height and width so that it won't look like oval
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(Languages.of(context)!.mLive,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontFamily:
                                                  'OpenSauceSansSemiBold',
                                              fontSize: mSizeThree,
                                              color: Colors.white))
                                    ]),
                              ),
                            )),
                        SizedBox(
                          width: 20,
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                child: Center(
                    child: Text(mLiveEvent.title ?? "",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontFamily: 'OpenSauceSansSemiBold',
                            fontSize: mSizeThree,
                            color: mGreyTen))),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(Languages.of(context)!.mSpeaker,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontFamily: 'OpenSauceSansSemiBold',
                          fontSize: mSizeNine,
                          color: mBlueOne)),
                  SizedBox(
                    width: 10,
                  ),
                  Text(buffer.toString(),
                      //Text("Prem Ananth & Rajesh Kumar",
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontFamily: 'OpenSauceSansRegular',
                          fontSize: mSizeNine,
                          color: mBlueOne))
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: mGreyThree,
                height: 1,
                width: MediaQuery.of(context).size.width,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/new_ic_calendar.svg',
                    width: 25,
                    height: 25,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                      "${mLiveEvent.eventStartDate!} | ${mLiveEvent.eventStartTime!} - ${mLiveEvent.eventEndTime!}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontFamily: 'OpenSauceSansRegular',
                          fontSize: mSizeTwo,
                          color: mGreySeven))
                ],
              ),
              SizedBox(
                height: 20,
              ),
              PrimaryButton(
                  mButtonname: (mLiveEvent.isRegistered ?? false)
                      ? Languages.of(context)!.mregistered
                      : Languages.of(context)!.mregister,
                  onpressed: (mLiveEvent.isRegistered ?? false)
                      ? () {
                          SucessToast(
                              context: context, text: "Already Register");
                        }
                      : onpressed,
                  mSelectcolor: mS1Green,
                  mTextColor: mWhiteColor,
                  mFontSize: mSizeTwo,
                  mHeigth: 40),
            ]),
      ),
    );
  }
}
