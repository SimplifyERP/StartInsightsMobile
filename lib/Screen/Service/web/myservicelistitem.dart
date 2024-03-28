import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_network/image_network.dart';
import 'package:startinsights/Libery/readmore.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Model/ServiceListResponse.dart';
import 'package:startinsights/Utils/FontSizes.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Utils/utils.dart';
import 'package:startinsights/Widgets/servicebutton.dart';

class MyServiceListItem extends StatelessWidget {
  final int mIndex;
  final MyServices mMyServiceList;
  final VoidCallback onpressed;

  const MyServiceListItem({
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
                      Stack(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
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
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child:
                                              ((mMyServiceList.serviceImage ??
                                                          "")
                                                      .isNotEmpty)
                                                  ? ImageNetwork(
                                                      image: mMyServiceList
                                                          .serviceImage!,
                                                      height: 75,
                                                      width: 75,
                                                    )
                                                  : SvgPicture.asset(
                                                      'assets/new_ic_watermarkbg.svg',
                                                      width: 75,
                                                      height: 75,
                                                    ),
                                        )),
                                  ],
                                )),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              width: 150,
                              height: 30,
                              padding: EdgeInsets.only(left: 10, right: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: SetBackgroungColor(
                                    mMyServiceList.servicestatus ?? ""),
                                boxShadow: const [
                                  BoxShadow(
                                    color: mGreyTwo,
                                    blurRadius: 0,
                                  ),
                                ],
                              ),
                              child: Center(
                                  child: Text(
                                mMyServiceList.servicestatus ?? "",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'OpenSauceSansMedium',
                                    fontSize: mSizeThree,
                                    color: SetTextColor(
                                        mMyServiceList.servicestatus ?? "")),
                              )),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                          // mMyServiceList.serviceName ?? "",
                          mMyServiceList.id ?? "",
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontFamily: 'OpenSauceSansSemiBold',
                              fontSize: mSizeFour,
                              color: mBlackTwo)),
                      const SizedBox(
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
                        //     () {
                        //   //showAlert(context, mMyServiceList.shortDescription ?? "");
                        // },
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
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              flex: 5,
                              child: Visibility(
                                visible: false,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(Languages.of(context)!.rupess,
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                            fontFamily: 'OpenSauceSansSemiBold',
                                            fontSize: mSizeTen,
                                            color: mBlackTwo)),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                        mMyServiceList.pricing.toString() ??
                                            "0",
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                            fontFamily: 'OpenSauceSansSemiBold',
                                            fontSize: mSizeFive,
                                            color: mBlackTwo))
                                  ],
                                ),
                              )),
                          Expanded(
                              flex: 5,
                              child: Center(
                                child: ServiceButton(
                                    mButtonname:
                                        Languages.of(context)!.mViewUpdates,
                                    onpressed: onpressed,
                                    mSelectcolor: mBlueOne,
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
