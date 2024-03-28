import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Model/ServiceDetailsResponse.dart';
import 'package:startinsights/Utils/FontSizes.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Utils/utils.dart';

class TrackingItem extends StatelessWidget {
  var mTotalview;
  var mCurrentview;
  ServiceTracking mServiceTracking;
  ServiceDetailsMessage mServiceDetailsMessage;
  final VoidCallback mDocUpload;
  TrackingItem({
    required this.mTotalview,
    required this.mCurrentview,
    required this.mServiceTracking,
    required this.mServiceDetailsMessage,
    required this.mDocUpload,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      //onTap: (() => selectMeal(context)),
      child: SizedBox(
        height: (mServiceTracking.docstatus ?? false) ? 120 : 90,
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    SvgPicture.asset(
                      'assets/new_ic_round.svg',
                      width: 15,
                      height: 15,
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Visibility(
                      visible:
                          ((mTotalview! - 1) == mCurrentview!) ? false : true,
                      child: Dash(
                          direction: Axis.vertical,
                          length:
                              (mServiceTracking.docstatus ?? false) ? 97 : 68,
                          dashLength: 5,
                          dashColor: mGreySix),
                    ),
                  ],
                )),
            const SizedBox(
              width: 1,
            ),
            Expanded(
                flex: 9,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        flex: 6,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                      flex: 6,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          (mServiceTracking.status ?? false)
                                              ? SvgPicture.asset(
                                                  'assets/new_ic_greenround.svg',
                                                  width: 15,
                                                  height: 15,
                                                )
                                              : Text(""),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            mServiceTracking.steps ?? "",
                                            style: const TextStyle(
                                              color: mBlackTwo,
                                              fontFamily:
                                                  'OpenSauceSansSemiBold',
                                              fontSize: mSizeFour,
                                            ),
                                          ),
                                        ],
                                      )),
                                  Expanded(
                                      flex: 4,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            mServiceTracking.currentStatus ??
                                                "",
                                            style: TextStyle(
                                              color: SetTrackingTextColor(
                                                  mServiceTracking
                                                          .currentStatus ??
                                                      ""),
                                              fontFamily:
                                                  'OpenSauceSansRegular',
                                              fontSize: mSizeThree,
                                            ),
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  (mServiceTracking.status ?? false)
                                      ? (mServiceTracking.steps! ==
                                              "Payment Received")
                                          ? Text(
                                              "Payment id " +
                                                  mServiceDetailsMessage
                                                      .paymentDetails!
                                                      .paymentId!,
                                              style: const TextStyle(
                                                color: mGreyEigth,
                                                fontFamily:
                                                    'OpenSauceSansRegular',
                                                fontSize: mSizeThree,
                                              ),
                                            )
                                          : Text("")
                                      : Text(
                                          ("${mServiceTracking.tat} Days") ??
                                              "",
                                          style: const TextStyle(
                                            color: mGreyEigth,
                                            fontFamily: 'OpenSauceSansRegular',
                                            fontSize: mSizeThree,
                                          ),
                                        ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Visibility(
                                  visible: (mServiceTracking.docstatus ?? false)
                                      ? true
                                      : false,
                                  child: InkWell(
                                    onTap: mDocUpload,
                                    child: Container(
                                      width: 140,
                                      height: 40,
                                      margin: const EdgeInsets.only(left: 20),
                                      padding: const EdgeInsets.only(
                                          right: 10, left: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: mBlackOne,
                                        boxShadow: const [
                                          BoxShadow(
                                            color: mBlackOne,
                                            blurRadius: 1.0,
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                          child: Text(
                                        Languages.of(context)!.mUploadDoc,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontFamily: 'OpenSauceSansMedium',
                                            fontSize: mSizeThree,
                                            color: Colors.white),
                                      )),
                                    ),
                                  )),
                            ]),
                      ),
                    ])),
          ],
        ),
      ),
    );
  }
}
