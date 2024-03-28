import 'package:custom_gif_loading/custom_gif_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_network/image_network.dart';
import 'package:startinsights/Libery/dashed_border.dart';
import 'package:startinsights/Libery/readmore.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Model/CommonResponse.dart';
import 'package:startinsights/Model/StartupDealsResponse.dart';
import 'package:startinsights/Model/StartupRedeemcodeResponse.dart';
import 'package:startinsights/Network/api_result_handler.dart';
import 'package:startinsights/Repository/startupdeals_repository.dart';
import 'package:startinsights/Screen/StartupDeals/bloc/startupdeals_bloc.dart';
import 'package:startinsights/Utils/FontSizes.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Utils/constant_methods.dart';
import 'package:startinsights/Utils/utils.dart';
import 'package:startinsights/Widgets/servicebutton.dart';
import 'package:url_launcher/url_launcher.dart';

class StartupDealsItem extends StatelessWidget {
  final DealList mDatumList;
  final StartupdealsBloc mStartupdealsBloc;
  final BuildContext context;
  final String userId;
  final int mIndex;
  final VoidCallback onpressed;
  StartupDealsItem({
    required this.mDatumList,
    required this.mStartupdealsBloc,
    required this.context,
    required this.userId,
    required this.mIndex,
    required this.onpressed,
    super.key,
  });

  void selectMeal(BuildContext context) {}

  final String mUserImage = "";
  final StartupDealsRepository _apiService1 = StartupDealsRepository();
  bool mVisible = false;
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
                      /* Stack(
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
                                          child: ((mDatumList.attachImage ?? "")
                                                  .isNotEmpty)
                                              ? ImageNetwork(
                                                  image:
                                                      mDatumList.attachImage!,
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
                        ],
                      ),*/
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
                                          child: ((mDatumList.attachImage ?? "")
                                                  .isNotEmpty)
                                              ? ImageNetwork(
                                                  image:
                                                      mDatumList.attachImage!,
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
                          Visibility(
                              visible: mDatumList.redeemStatus ?? false,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  width: 150,
                                  height: 30,
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: mRedThree,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: mGreyTwo,
                                        blurRadius: 0,
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                      child: Text(
                                    Languages.of(context)!.mAlreadyUsed,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'OpenSauceSansMedium',
                                        fontSize: mSizeTwo,
                                        color: Colors.red),
                                  )),
                                ),
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(mDatumList.serviceProviderName ?? "",
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontFamily: 'OpenSauceSansSemiBold',
                              fontSize: mSizeFour,
                              color: mBlackTwo)),
                      const SizedBox(
                        height: 20,
                      ),
                      ReadMoreText(
                        mDatumList.shortDescription ?? "",
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
                        onpressed: () {
                          showAlert(context, mDatumList.shortDescription ?? "");
                        },
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
                                    Text("1000",
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
                                    mButtonname: Languages.of(context)!.mredeem,
                                    //  onpressed: onpressed,
                                    onpressed: () {
                                      Loading(mLoaderGif).start(context);

                                      _apiService1
                                          .getStartupDealsRedeem(
                                              userId, mDatumList.id ?? "")
                                          .then((value) async {
                                        print(value);

                                        if (value is ApiSuccess) {
                                          if (StartupRedeemcodeResponse
                                                      .fromJson(value.data)!
                                                  .message!
                                                  .status ??
                                              false) {
                                            Loading.stop();
                                            OnLoadDialog(
                                                StartupRedeemcodeResponse
                                                        .fromJson(value.data)!
                                                    .message!
                                                    .redeemCode![0]);
                                          } else {
                                            Loading.stop();
                                            ErrorToast(
                                                context: context,
                                                text: "Redeem Code not found");
                                          }
                                        } else if (value is ApiFailure) {
                                          Loading.stop();
                                        }
                                      });
                                    },
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

  void OnLoadDialog(RedeemCode mRedeemCode) {
    showDialog(
      context: context,
      builder: (mContext) {
        String contentText = "Content of Dialog";
        return StatefulBuilder(
          builder: (context1, setState) {
            return AlertDialog(
              contentPadding: const EdgeInsets.only(left: 25, right: 10),
              //  title: Center(child: Text("Information")),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),

              content: SizedBox(
                width: 460,
                child: SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(mContext).size.width - 10,
                    padding: const EdgeInsets.fromLTRB(20, 15, 5, 10),
                    color: Colors.white,
                    child: Column(children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment:
                            CrossAxisAlignment.start, // set your alignment
                        children: <Widget>[
                          SizedBox(
                            height: 30,
                            child: Row(children: [
                              const Expanded(
                                flex: 9,
                                child: Text(""),
                              ),
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: InkWell(
                                    onTap: () {
                                      //  Navigator.pop(mContext);

                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                    },
                                    child: SvgPicture.asset(
                                      'assets/new_ic_close.svg',
                                      width: 20,
                                      height: 20,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ]),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Align(
                                  alignment: Alignment.center,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: ((mDatumList.attachImage ?? "")
                                            .isNotEmpty)
                                        ? ImageNetwork(
                                            image: mDatumList.attachImage!,
                                            height: 75,
                                            width: 75,
                                          )
                                        : SvgPicture.asset(
                                            'assets/new_ic_watermarkbg.svg',
                                            width: 75,
                                            height: 75,
                                          ),
                                  )),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                mDatumList.name ?? "",
                                style: const TextStyle(
                                    fontFamily: 'OpenSauceSansSemiBold',
                                    fontSize: mSizeSix,
                                    color: kTextColorTwo),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              (mRedeemCode.redeemCode!.isNotEmpty)
                                  ? Text(
                                      Languages.of(context)!.mcopypastecode,
                                      style: const TextStyle(
                                          fontFamily: 'OpenSauceSansRegular',
                                          fontSize: mSizeThree,
                                          color: mGreySeven),
                                    )
                                  : Text(
                                      Languages.of(context)!.mclickcoupon,
                                      style: const TextStyle(
                                          fontFamily: 'OpenSauceSansRegular',
                                          fontSize: mSizeThree,
                                          color: mGreySeven),
                                    ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          (mRedeemCode.redeemCode!.isNotEmpty)
                              ? Container(
                                  height: 45,
                                  margin: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  padding: const EdgeInsets.all(5),
                                  decoration: const BoxDecoration(
                                      color: mBlueTwo,
                                      border: DashedBorder.fromBorderSide(
                                          dashLength: 5,
                                          strokeCap: StrokeCap.square,
                                          side: BorderSide(
                                              color: mBlueSix, width: 2)),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(1))),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        /* (mRedeemCode.redeemCode!.isNotEmpty)
                                      ? mRedeemCode.redeemCode ?? ""
                                      : mRedeemCode.redeemurl ?? "",*/
                                        Text(
                                          mRedeemCode.redeemCode ?? "",
                                          style: const TextStyle(
                                              fontFamily:
                                                  'OpenSauceSansSemiBold',
                                              fontSize: mSizeTen,
                                              color: kTextColorTwo),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        InkWell(
                                          child: SvgPicture.asset(
                                            'assets/new_ic_copy.svg',
                                            width: 30,
                                            height: 30,
                                          ),
                                          onTap: () async {
                                            await Clipboard.setData(
                                                ClipboardData(
                                                    text: ((mRedeemCode
                                                            .redeemCode!
                                                            .isNotEmpty)
                                                        ? mRedeemCode
                                                                .redeemCode ??
                                                            ""
                                                        : mRedeemCode
                                                                .redeemurl ??
                                                            "")));

                                            setState(() {
                                              mVisible = true;
                                            });

                                            Loading(mLoaderGif).start(context);

                                            _apiService1.Redeemstatusupdate(
                                                    userId, mDatumList.id ?? "")
                                                .then((value) async {
                                              print(value);

                                              if (value is ApiSuccess) {
                                                if (CommonResponse.fromJson(
                                                            value.data)!
                                                        .message!
                                                        .status ??
                                                    false) {
                                                  Loading.stop();
                                                } else {
                                                  Loading.stop();
                                                  ErrorToast(
                                                      context: mContext,
                                                      text: CommonResponse
                                                              .fromJson(
                                                                  value.data)!
                                                          .message!
                                                          .message!);
                                                }
                                              } else if (value is ApiFailure) {
                                                Loading.stop();
                                              }
                                            });

                                            Future.delayed(
                                                const Duration(seconds: 2), () {
                                              setState(() {
                                                mVisible = false;
                                              });
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Container(
                                  height: 45,
                                  margin: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  padding: const EdgeInsets.all(5),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            launchUrl(
                                                Uri.parse(
                                                    mRedeemCode.redeemurl ??
                                                        ""),
                                                mode: LaunchMode
                                                    .externalApplication);

                                            setState(() {
                                              mVisible = true;
                                            });

                                            Loading(mLoaderGif).start(context);

                                            _apiService1.Redeemstatusupdate(
                                                    userId, mDatumList.id ?? "")
                                                .then((value) async {
                                              print(value);

                                              if (value is ApiSuccess) {
                                                if (CommonResponse.fromJson(
                                                            value.data)!
                                                        .message!
                                                        .status ??
                                                    false) {
                                                  Loading.stop();
                                                } else {
                                                  Loading.stop();
                                                }
                                              } else if (value is ApiFailure) {
                                                Loading.stop();
                                              }
                                            });

                                            Future.delayed(
                                                const Duration(seconds: 2), () {
                                              setState(() {
                                                mVisible = false;
                                              });
                                            });
                                          },
                                          child: Text(
                                            mRedeemCode.redeemurl ?? "",
                                            style: const TextStyle(
                                                fontFamily:
                                                    'OpenSauceSansSemiBold',
                                                fontSize: mSizeTen,
                                                color: mBlueSix),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                Languages.of(context)!.mSteptofollow,
                                style: const TextStyle(
                                    fontFamily: 'OpenSauceSansSemiBold',
                                    fontSize: mSizeThree,
                                    color: mGreyEigth),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                mRedeemCode.redeemdescription ?? "",
                                style: const TextStyle(
                                    fontFamily: 'OpenSauceSansRegular',
                                    fontSize: mSizeThree,
                                    color: mGreyEigth),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ]),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  /*void OnLoadDialog(RedeemCode mRedeemCode) {
    showDialog(
      context: context,
      builder: (mContext) {
        String contentText = "Content of Dialog";
        return StatefulBuilder(
          builder: (context1, setState) {
            return AlertDialog(
              contentPadding: const EdgeInsets.only(left: 25, right: 10),
              //  title: Center(child: Text("Information")),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),

              content: SizedBox(
                width: MediaQuery.of(mContext).size.width / 2,
                child: SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(mContext).size.width - 10,
                    padding: const EdgeInsets.fromLTRB(20, 15, 5, 10),
                    color: Colors.white,
                    child: Column(children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment:
                        CrossAxisAlignment.start, // set your alignment
                        children: <Widget>[
                          SizedBox(
                            height: 30,
                            child: Row(children: [
                              const Expanded(
                                flex: 9,
                                child: Text(""),
                              ),
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: InkWell(
                                    onTap: () {
                                      //  Navigator.pop(mContext);

                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                    },
                                    child: SvgPicture.asset(
                                      'assets/new_ic_close.svg',
                                      width: 20,
                                      height: 20,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ]),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Languages.of(context)!.myourredeem,
                                style: const TextStyle(
                                    fontFamily: 'OpenSauceSansSemiBold',
                                    fontSize: mSizeTen,
                                    color: kTextColorTwo),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                (mRedeemCode.redeemCode!.isNotEmpty)
                                    ? mRedeemCode.redeemCode ?? ""
                                    : mRedeemCode.redeemurl ?? "",
                                style: const TextStyle(
                                    fontFamily: 'OpenSauceSansSemiBold',
                                    fontSize: mSizeTen,
                                    color: kTextColorTwo),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              InkWell(
                                child: Image.asset('assets/ic_copy.png',
                                    width: 30, height: 30, fit: BoxFit.fill),
                                onTap: () async {
                                  await Clipboard.setData(ClipboardData(
                                      text:
                                      ((mRedeemCode.redeemCode!.isNotEmpty)
                                          ? mRedeemCode.redeemCode ?? ""
                                          : mRedeemCode.redeemurl ?? "")));

                                  setState(() {
                                    mVisible = true;
                                  });

                                  Loading(mLoaderGif).start(context);

                                  _apiService1.Redeemstatusupdate(
                                      userId, mDatumList.id ?? "")
                                      .then((value) async {
                                    print(value);

                                    if (value is ApiSuccess) {
                                      if (CommonResponse.fromJson(value.data)!
                                          .message!
                                          .status ??
                                          false) {
                                        Loading.stop();
                                      } else {
                                        Loading.stop();
                                        ErrorToast(
                                            context: mContext,
                                            text: CommonResponse.fromJson(
                                                value.data)!
                                                .message!
                                                .message!);
                                      }
                                    } else if (value is ApiFailure) {
                                      Loading.stop();
                                    }
                                  });

                                  Future.delayed(const Duration(seconds: 2),
                                          () {
                                        setState(() {
                                          mVisible = false;
                                        });
                                      });
                                  */ /*SucessToast(
                                    context: mContext,
                                    text: "Copied successfully");*/ /*
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Visibility(
                                visible: true,
                                child: Text((mRedeemCode.redeemurl!.isNotEmpty
                                    ? mRedeemCode.redeemdescription ?? ""
                                    : "")),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Visibility(
                                visible: mVisible,
                                child: Text(
                                    Languages.of(context)!.mCopiedsuccessfully),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ]),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }*/
}
