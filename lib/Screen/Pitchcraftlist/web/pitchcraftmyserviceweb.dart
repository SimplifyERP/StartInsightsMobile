import 'package:custom_gif_loading/custom_gif_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_network/image_network.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Model/PitchCraftServiceDetailsResponse.dart';
import 'package:startinsights/Model/PitchcraftlistResponse.dart';
import 'package:startinsights/Network/api_result_handler.dart';
import 'package:startinsights/Repository/pitchcraftlist_repo.dart';
import 'package:startinsights/Screen/Pitchcraftlist/bloc/pitchcraftlist_bloc.dart';
import 'package:startinsights/Screen/Pitchcraftlist/bloc/pitchcraftlist_state.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Utils/constant_methods.dart';
import 'package:startinsights/Utils/screens.dart';
import 'package:startinsights/Widgets/Appbar.dart';
import 'package:startinsights/Widgets/primary_button.dart';
import 'package:startinsights/Widgets/sidemenu.dart';

class PitchcraftmyserviceWeb extends StatefulWidget {
  PitchcraftmyserviceWeb({
    super.key,
  });

  @override
  State<PitchcraftmyserviceWeb> createState() => _PitchcraftmyserviceState();
}

class _PitchcraftmyserviceState extends State<PitchcraftmyserviceWeb> {
  @override
  late PitchcraftlistBloc mPitchcraftlistBloc;
  List<PitchCraftServiceDetail> mPitchCraftServiceDetail = [];
  List<MyService> mPitchCraftList = [];
  final PitchcraftListRepo _apiService1 = PitchcraftListRepo();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    mPitchcraftlistBloc = PitchcraftlistBloc(mContext: context);

    void OnLoadNext() {
      Navigator.pushReplacementNamed(context, dashboardRoute);
    }

    return WillPopScope(
      onWillPop: () {
        //trigger leaving and use own data
        //Navigator.pop(context, false);

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
          body: BlocConsumer<PitchcraftlistBloc, PitchcraftlistStatus>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is GetPitchcraftmyServiceInfoSuccessState) {
                mPitchCraftList = state.mMyserviceList;
                return SafeArea(
                  child: SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
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
                                      child: SideMenu(mFrom: 4))),
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
                                                              .mPitchCraft,
                                                      style: const TextStyle(
                                                          fontFamily:
                                                              'ManropeBold',
                                                          fontSize: 26,
                                                          color: mBlackColor)),
                                                  const TextSpan(
                                                      text: " / ",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'ManropeBold',
                                                          fontSize: 26,
                                                          color: mBlackColor)),
                                                  TextSpan(
                                                      text:
                                                          Languages.of(context)!
                                                              .mMyServices,
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
                                          SingleChildScrollView(
                                              child: GridView.count(
                                            crossAxisCount: 3,
                                            crossAxisSpacing: 0,
                                            mainAxisSpacing: 0,
                                            shrinkWrap: true,
                                            children: List.generate(
                                              mPitchCraftList.length,
                                              (index) {
                                                final mgetPitchCraftList =
                                                    mPitchCraftList[index];
                                                return Container(
                                                    height: 350,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    color: Colors.white,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          height: 350,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              color:
                                                                  Colors.white,
                                                              boxShadow: const [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .grey,
                                                                  blurRadius:
                                                                      1.0,
                                                                ),
                                                              ]),
                                                          margin:
                                                              const EdgeInsets
                                                                  .fromLTRB(
                                                                  20, 1, 20, 1),
                                                          child: Column(
                                                              children: <Widget>[
                                                                Container(
                                                                  height: 100,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(0),
                                                                    color:
                                                                        kPitchcraftbg,
                                                                  ),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center, // set your alignment
                                                                    children: <Widget>[
                                                                      const SizedBox(
                                                                        width:
                                                                            20,
                                                                      ),
                                                                      Align(
                                                                          alignment:
                                                                              Alignment.centerLeft,
                                                                          child: ((mgetPitchCraftList.pitchCraftImage ?? "").isNotEmpty)
                                                                              ? ImageNetwork(
                                                                                  image: mgetPitchCraftList.pitchCraftImage!,
                                                                                  height: 60,
                                                                                  width: 60,
                                                                                )
                                                                              : Image.asset('assets/avathar.png', width: 60, height: 60, fit: BoxFit.fill)),
                                                                      const SizedBox(
                                                                        width:
                                                                            20,
                                                                      ),
                                                                      Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          mgetPitchCraftList.serviceName ??
                                                                              "",
                                                                          style: const TextStyle(
                                                                              fontFamily: 'ManropeSemiBold',
                                                                              fontSize: 20,
                                                                              color: mBlackColor),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),

                                                                Container(
                                                                  height: 240,
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .fromLTRB(
                                                                          10,
                                                                          0,
                                                                          10,
                                                                          0),
                                                                  child: Column(
                                                                      children: [
                                                                        Expanded(
                                                                            flex:
                                                                                7,
                                                                            child:
                                                                                Align(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Text(
                                                                                mgetPitchCraftList.shortDescription ?? "",
                                                                                maxLines: 7,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                style: const TextStyle(fontFamily: 'ManropeRegular', fontSize: 16, color: kTextGrayColor),
                                                                              ),
                                                                            )),
                                                                        const SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                        Expanded(
                                                                            flex:
                                                                                3,
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              crossAxisAlignment: CrossAxisAlignment.center, // set your alignment
                                                                              children: <Widget>[
                                                                                Expanded(
                                                                                  flex: 5, // takes 30% of available width
                                                                                  child: Container(
                                                                                      height: 40,
                                                                                      width: MediaQuery.of(context).size.width / 2,
                                                                                      child: Padding(
                                                                                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                                                      )),
                                                                                ),
                                                                                const SizedBox(
                                                                                  width: 15,
                                                                                ),
                                                                                Expanded(
                                                                                  flex: 5, // takes 30% of available width
                                                                                  child: Container(
                                                                                      height: 40,
                                                                                      width: 200,
                                                                                      decoration: BoxDecoration(
                                                                                          borderRadius: BorderRadius.circular(10),
                                                                                          color: mBtnColor,
                                                                                          border: Border.all(
                                                                                            color: mBtnColor,
                                                                                            width: 1,
                                                                                          )),
                                                                                      child: Padding(
                                                                                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                                                          child: InkWell(
                                                                                            child: Align(
                                                                                              alignment: Alignment.centerLeft,
                                                                                              child: PrimaryButton(
                                                                                                  mButtonname: Languages.of(context)!.mKnowMore,
                                                                                                  onpressed: () async {
                                                                                                    if (await checkNetworkStatus()) {
                                                                                                      Loading(mLoaderGif).start(context);

                                                                                                      _apiService1.getPitchcraftservicedetails("", mgetPitchCraftList.id ?? "").then((value) async {
                                                                                                        print(value);

                                                                                                        if (value is ApiSuccess) {
                                                                                                          Loading.stop();
                                                                                                          mPitchCraftServiceDetail = PitchCraftServiceDetailsResponse.fromJson(value.data)!.message!.pitchCraftServiceDetails!;

                                                                                                          OnLoadDialog(mPitchCraftServiceDetail[0]);
                                                                                                        } else if (value is ApiFailure) {
                                                                                                          Loading.stop();
                                                                                                        }
                                                                                                      });
                                                                                                    } else {}
                                                                                                  },
                                                                                                  mSelectcolor: mBtnColor,
                                                                                                  mTextColor: mWhiteColor,
                                                                                                  mFontSize: 16,
                                                                                                  mHeigth: 40),
                                                                                            ),
                                                                                          ))),
                                                                                ),
                                                                              ],
                                                                            ))
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
                                                              ]),
                                                        ),
                                                      ],
                                                    ));
                                              },
                                            ),
                                          )),
                                          const SizedBox(
                                            height: 40,
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

  void OnLoadDialog(PitchCraftServiceDetail mPitchCraftServiceDetail) {
    showDialog(
        context: context,
        barrierDismissible: false,
        //context: _scaffoldKey.currentContext,
        builder: (mContext) {
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
                  padding: EdgeInsets.fromLTRB(30, 5, 5, 10),
                  color: Colors.white,
                  child: Column(children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // set your alignment
                      children: <Widget>[
                        Container(
                          height: 40,
                          child: Row(children: [
                            const Expanded(
                              flex: 9,
                              child: Text(""),
                            ),
                            Expanded(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(mContext);
                                  },
                                  child: Image.asset(
                                    'assets/ic_closecross.png',
                                    height: 30,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                          ]),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment:
                              CrossAxisAlignment.center, // set your alignment
                          children: <Widget>[
                            Expanded(
                                flex: 7,
                                child: Row(
                                  children: [
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: ((mPitchCraftServiceDetail
                                                        .pitchCraftImage ??
                                                    "")
                                                .isNotEmpty)
                                            ? ImageNetwork(
                                                image: mPitchCraftServiceDetail
                                                    .pitchCraftImage!,
                                                height: 40,
                                                width: 40,
                                              )
                                            : Image.asset('assets/avathar.png',
                                                width: 40,
                                                height: 40,
                                                fit: BoxFit.fill)),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        mPitchCraftServiceDetail.serviceName ??
                                            "",
                                        style: const TextStyle(
                                            fontFamily: 'ManropeSemiBold',
                                            fontSize: 20,
                                            color: mBlackColor),
                                      ),
                                    ),
                                  ],
                                )),
                            Expanded(
                              flex: 3,
                              child: Container(
                                  height: 40,
                                  width: MediaQuery.of(mContext).size.width / 2,
                                  child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: RichText(
                                        text: TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(
                                                text:
                                                    "${Languages.of(context)!.rupess} ${mPitchCraftServiceDetail.pricing}" ??
                                                        "",
                                                style: const TextStyle(
                                                    fontFamily: 'ManropeBold',
                                                    fontSize: 24,
                                                    color: mBtnColor)),
                                            TextSpan(
                                                text: Languages.of(context)!
                                                    .mService,
                                                style: const TextStyle(
                                                    fontFamily:
                                                        'ManropeRegular',
                                                    fontSize: 14,
                                                    color: kTextGrayColor)),
                                          ],
                                        ),
                                      ))),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Languages.of(context)!.mBenefits,
                              style: const TextStyle(
                                  fontFamily: 'ManropeBold',
                                  fontSize: 20,
                                  color: kTextColorTwo),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              mPitchCraftServiceDetail.benefits ?? "",
                              style: const TextStyle(
                                  fontFamily: 'ManropeRegular',
                                  fontSize: 16,
                                  color: kTextColorTwo),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Languages.of(context)!.mDescription,
                              style: const TextStyle(
                                  fontFamily: 'ManropeBold',
                                  fontSize: 20,
                                  color: kTextColorTwo),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              mPitchCraftServiceDetail.description ?? "",
                              style: const TextStyle(
                                  fontFamily: 'ManropeRegular',
                                  fontSize: 16,
                                  color: kTextColorTwo),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Languages.of(context)!.mDeliverables,
                              style: const TextStyle(
                                  fontFamily: 'ManropeBold',
                                  fontSize: 20,
                                  color: kTextColorTwo),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              mPitchCraftServiceDetail.deliverables ?? "",
                              style: const TextStyle(
                                  fontFamily: 'ManropeRegular',
                                  fontSize: 16,
                                  color: kTextColorTwo),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Languages.of(context)!.mdocumentsrequired,
                              style: const TextStyle(
                                  fontFamily: 'ManropeBold',
                                  fontSize: 20,
                                  color: kTextColorTwo),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ListView.builder(
                              itemCount: mPitchCraftServiceDetail
                                  .documentsRequired!.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, position) {
                                return Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                    "${position + 1}. ${mPitchCraftServiceDetail.documentsRequired![position].documents}" ??
                                        "",
                                    style: const TextStyle(
                                        fontFamily: 'ManropeRegular',
                                        fontSize: 16,
                                        color: kTextColorTwo),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        )
                      ],
                    ),
                  ]),
                ),
              ),
            ),
          );
        });
  }
}
