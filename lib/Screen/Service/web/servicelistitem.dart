import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_network/image_network.dart';
import 'package:startinsights/Libery/readmore.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Model/PitchcraftlistResponse.dart';
import 'package:startinsights/Utils/FontSizes.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Widgets/servicebutton.dart';

class ServiceListItem extends StatelessWidget {
  final int mIndex;
  final MyService mMyServiceList;
  final VoidCallback onpressed;

  const ServiceListItem({
    required this.mIndex,
    required this.mMyServiceList,
    required this.onpressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      //onTap: (() => selectMeal(context)),
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(15),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  flex: 8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          width: 75,
                          height: 75,
                          padding: EdgeInsets.all(0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: mGreyTwo,
                                blurRadius: 0,
                              ),
                            ],
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              const CircularProgressIndicator(
                                color: mBlueOne,
                              ),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: ((mMyServiceList.pitchCraftImage ??
                                                "")
                                            .isNotEmpty)
                                        ? ImageNetwork(
                                            image:
                                                mMyServiceList.pitchCraftImage!,
                                            height: 75,
                                            width: 75,
                                          )
                                        : SvgPicture.asset(
                                            'assets/new_ic_watermarkbg.svg',
                                            width: 75,
                                            height: 75,
                                          ),
                                  ))
                            ],
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Text(mMyServiceList.serviceName ?? "",
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontFamily: 'OpenSauceSansSemiBold',
                              fontSize: mSizeFour,
                              color: mBlackTwo)),
                      SizedBox(
                        height: 20,
                      ),
                      ReadMoreText(
                        mMyServiceList.shortDescription ?? "",
                        trimLines: 3,
                        preDataTextStyle: const TextStyle(
                            fontFamily: 'OpenSauceSansRegular',
                            fontSize: mSizeTwo,
                            height: 1.5,
                            color: mGreySeven),
                        style: const TextStyle(
                            fontFamily: 'OpenSauceSansRegular',
                            fontSize: mSizeTwo,
                            height: 1.5,
                            color: mGreySeven),
                        colorClickableText: mBlueOne,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'See more',
                        trimExpandedText: ' show less',
                        onpressed: onpressed,
                      ),
                    ],
                  )),
              Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        color: mGreyThree,
                        height: 1,
                        width: MediaQuery.of(context).size.width,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              flex: 5,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(Languages.of(context)!.rupess,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          fontFamily: 'OpenSauceSansSemiBold',
                                          fontSize: mSizeTen,
                                          color: mBlackTwo)),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(mMyServiceList.pricing.toString() ?? "0",
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          fontFamily: 'OpenSauceSansSemiBold',
                                          fontSize: mSizeFive,
                                          color: mBlackTwo))
                                ],
                              )),
                          Expanded(
                              flex: 5,
                              child: Center(
                                child: ServiceButton(
                                    mButtonname:
                                        Languages.of(context)!.mAddtoService,
                                    onpressed: () {},
                                    mTextColor: mWhiteColor,
                                    mFontSize: 16,
                                    mWidth: 130,
                                    mHeigth: 35),
                              ))
                        ],
                      )
                    ],
                  )),
            ]),
      ),
    );
  }
}
