import 'package:custom_gif_loading/custom_gif_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_network/image_network.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Model/CommonResponse.dart';
import 'package:startinsights/Model/StartupDealsResponse.dart';
import 'package:startinsights/Model/StartupRedeemcodeResponse.dart';
import 'package:startinsights/Network/api_result_handler.dart';
import 'package:startinsights/Repository/startupdeals_repository.dart';
import 'package:startinsights/Screen/StartupDeals/bloc/startupdeals_bloc.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Utils/constant_methods.dart';
import 'package:startinsights/Utils/screens.dart';
import 'package:startinsights/Utils/utils.dart';
import 'package:startinsights/Widgets/primary_button.dart';

class StartupDealsItem extends StatelessWidget {
  final Datum mDatumList;
  final StartupdealsBloc mStartupdealsBloc;
  final BuildContext context;
  final String userId;
  StartupDealsItem({
    required this.mDatumList,
    required this.mStartupdealsBloc,
    required this.context,
    required this.userId,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 1.0,
                    ),
                  ]),
              padding: const EdgeInsets.fromLTRB(10, 1, 10, 1),
              margin: const EdgeInsets.fromLTRB(10, 1, 1, 1),
              child: Column(children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment:
                      CrossAxisAlignment.center, // set your alignment
                  children: <Widget>[
                    Expanded(
                      flex: 2, // takes 30% of available width
                      child: Container(
                          height: 90,
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: InkWell(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: CircleAvatar(
                                    radius: 30.0,
                                    backgroundColor: Colors.white,
                                    child: ClipOval(
                                      child: (mDatumList
                                              .attachImage!.isNotEmpty)
                                          ? ImageNetwork(
                                              image:
                                                  mDatumList.attachImage ?? "",
                                              height: 80,
                                              width: 100,
                                            )
                                          : Image.asset('assets/avathar.png',
                                              width: 80,
                                              height: 100,
                                              fit: BoxFit.fill),
                                    ),
                                  ),
                                ),
                              ))),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      flex: 6, // takes 30% of available width
                      child: Container(
                          height: 90,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  mDatumList.serviceProviderName ?? "",
                                  maxLines: 2,
                                  style: const TextStyle(
                                      fontFamily: 'ManropeSemiBold',
                                      fontSize: 20,
                                      color: mBlackColor),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  mDatumList.serviceHeadline ?? "",
                                  style: const TextStyle(
                                      fontFamily: 'ManropeRegular',
                                      fontSize: 16,
                                      color: kTextGrayColor),
                                ),
                              ),
                            ],
                          )),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    const Expanded(
                      flex: 2,
                      child: Text("") // takes 30% of available width
                      /*child: Container(
                          height: 80,
                          child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: IconButton(
                                icon: Image.asset('assets/ic_linkedin.png'),
                                iconSize: 20,
                                onPressed: () async {
                                  if (await canLaunchUrl(Uri.parse(
                                      mBookAnExpertList.linkedinId ?? ""))) {
                                    await launchUrl(
                                        Uri.parse(
                                            mBookAnExpertList.linkedinId ?? ""),
                                        mode: LaunchMode.externalApplication);
                                  } else {
                                    throw 'Could not launch ${mBookAnExpertList.linkedinId}' ??
                                        "";
                                  }
                                },
                              )))*/
                      ,
                    ),
                  ],
                ),
                Container(
                  height: 300,
                  child: Column(children: [
                    Expanded(
                        flex: 7,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            mDatumList.shortDescription ?? "",
                            maxLines: 6,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontFamily: 'ManropeRegular',
                                fontSize: 16,
                                color: kTextColorTwo),
                          ),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                        flex: 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment:
                              CrossAxisAlignment.center, // set your alignment
                          children: <Widget>[
                            Visibility(
                                visible:
                                    (((mDatumList.popularService ?? 0) == 1)
                                        ? true
                                        : false),
                                child: Container(
                                    width: 170,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: mCardColorThree),
                                    child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 5, 20, 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Image.asset(
                                                'assets/ic_recommend.png',
                                                width: 20,
                                                height: 20,
                                                fit: BoxFit.fill),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              Languages.of(context)!.mFeatured,
                                              style: const TextStyle(
                                                  fontFamily: 'ManropeRegular',
                                                  fontSize: 18,
                                                  color: mBlackColor),
                                            )
                                          ],
                                        )))),
                            const SizedBox(
                              width: 15,
                            ),
                            Visibility(
                                visible:
                                    (((mDatumList.featureService ?? 0) == 1)
                                        ? true
                                        : false),
                                child: Container(
                                    width: 170,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: mCardColorThree),
                                    child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 5, 20, 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Image.asset('assets/ic_popular.png',
                                                width: 20,
                                                height: 20,
                                                fit: BoxFit.fill),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              Languages.of(context)!.mPopular,
                                              style: const TextStyle(
                                                  fontFamily: 'ManropeRegular',
                                                  fontSize: 18,
                                                  color: mBlackColor),
                                            )
                                          ],
                                        )))),
                          ],
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                        flex: 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment:
                              CrossAxisAlignment.center, // set your alignment
                          children: <Widget>[
                            Expanded(
                              flex: 5, // takes 30% of available width
                              child: Container(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                              'assets/ic_startupdeals.png',
                                              width: 20,
                                              height: 20,
                                              fit: BoxFit.fill),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            mDatumList.startup![0]
                                                    .typeOfService ??
                                                "",
                                            style: const TextStyle(
                                                fontFamily: 'ManropeRegular',
                                                fontSize: 16,
                                                color: mBlackColor),
                                          )
                                        ],
                                      ))),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              flex: 5, // takes 30% of available width
                              child: Container(
                                  height: 35,
                                  width: 200,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: mBtnColor,
                                      border: Border.all(
                                        color: mBtnColor,
                                        width: 1,
                                      )),
                                  child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: InkWell(
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: PrimaryButton(
                                              mButtonname:
                                                  Languages.of(context)!
                                                      .mGetDeal,
                                              onpressed: () async {
                                                // Navigator.pushReplacementNamed(
                                                //     context, expertbookingRoute,
                                                //     arguments: [
                                                //       mDatumList!
                                                //           .serviceProviderName!
                                                //     ]);

                                                Loading(mLoaderGif)
                                                    .start(context);

                                                _apiService1
                                                    .getStartupDealsRedeem(
                                                        userId,
                                                        mDatumList.id ?? "")
                                                    .then((value) async {
                                                  print(value);

                                                  if (value is ApiSuccess) {
                                                    if (StartupRedeemcodeResponse
                                                                .fromJson(
                                                                    value.data)!
                                                            .message!
                                                            .status ??
                                                        false) {
                                                      Loading.stop();
                                                      OnLoadDialog(
                                                          StartupRedeemcodeResponse
                                                                  .fromJson(value
                                                                      .data)!
                                                              .message!
                                                              .redeemCode![0]);
                                                    } else {
                                                      Loading.stop();
                                                      ErrorToast(
                                                          context: context,
                                                          text:
                                                              "Redeem Code not found");
                                                    }
                                                  } else if (value
                                                      is ApiFailure) {
                                                    Loading.stop();
                                                  }
                                                });

                                                // await Clipboard.setData(
                                                //     const ClipboardData(
                                                //         text: "your text"));

                                                // ignore: use_build_context_synchronously
                                                // SucessToast(
                                                //     context: context,
                                                //     text:
                                                //         "Copied successfully");
                                              },
                                              mSelectcolor: mBtnColor,
                                              mTextColor: mWhiteColor,
                                              mFontSize: 16,
                                              mHeigth: 40),
                                        ),
                                      ))),
                            ),
                          ],
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Visibility(
                            visible: ((mDatumList.redeem_status ?? false))
                                ? true
                                : false,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                Languages.of(context)!.mAlreadyRedeemed,
                                style: const TextStyle(
                                    fontFamily: 'ManropeSemiBold',
                                    fontSize: 14,
                                    color: Colors.red),
                              ),
                            )),
                        SizedBox(
                          width: 20,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ]),
                ),
                // Row(
                //     mainAxisAlignment:
                //         MainAxisAlignment
                //             .center,
                //     crossAxisAlignment:
                //         CrossAxisAlignment
                //             .center,
                //     children: [
                //
                //     ]),
              ]))
        ],
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
                  borderRadius: BorderRadius.all(Radius.circular(5))),

              content: SizedBox(
                width: MediaQuery.of(mContext).size.width / 3,
                child: SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(mContext).size.width - 10,
                    padding: const EdgeInsets.fromLTRB(20, 5, 5, 10),
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
                                      Navigator.pushReplacementNamed(
                                          context, startupdealsRoute);
                                    },
                                    child: Image.asset(
                                      'assets/ic_closecross.png',
                                      height: 30,
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
                                    fontFamily: 'ManropeBold',
                                    fontSize: 20,
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                mRedeemCode.redeemCode ?? "",
                                style: const TextStyle(
                                    fontFamily: 'ManropeBold',
                                    fontSize: 20,
                                    color: kTextColorTwo),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                child: Image.asset('assets/ic_copy.png',
                                    width: 30, height: 30, fit: BoxFit.fill),
                                onTap: () async {
                                  await Clipboard.setData(ClipboardData(
                                      text: (mRedeemCode.redeemCode ?? "")));

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
                                            context: context,
                                            text: "Redeem Code update error");
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
                                  /*SucessToast(
                                    context: mContext,
                                    text: "Copied successfully");*/
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
  }
}
