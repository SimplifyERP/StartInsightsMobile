import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Model/InvestmentdealsdetailsResponse.dart';
import 'package:startinsights/Repository/pitchcraftlist_repo.dart';
import 'package:startinsights/Screen/InvestmentDeals/bloc/investmentdeals_bloc.dart';
import 'package:startinsights/Screen/InvestmentDeals/bloc/investmentdeals_state.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Utils/screens.dart';
import 'package:startinsights/Widgets/Appbar.dart';
import 'package:startinsights/Widgets/anglesidemenu.dart';
import 'package:startinsights/Widgets/primary_button.dart';

class InvestmentDealsWeb extends StatefulWidget {
  InvestmentDealsWeb({
    super.key,
  });

  @override
  State<InvestmentDealsWeb> createState() => _InvestmentDealsState();
}

class _InvestmentDealsState extends State<InvestmentDealsWeb> {
  @override
  late InvestmentDealsBloc mInvestmentDealsBloc;
  List<InvestmentDeal> mInvestmentDealList = [];
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
    mInvestmentDealsBloc = InvestmentDealsBloc(mContext: context);

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
          appBar: Appbar(mText: "TExt", mUserImage: "", mFrom: 6),
          body: BlocConsumer<InvestmentDealsBloc, InvestmentDealsStatus>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is GetInvestmentDealsInfoSuccessState) {
                mInvestmentDealList = state.mInvestmentDealList;
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
                                      child: AngleSideMenu(mFrom: 3))),
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
                                                              .mInvestmentDeals,
                                                      style: const TextStyle(
                                                          fontFamily:
                                                              'ManropeBold',
                                                          fontSize: 26,
                                                          color: mBlackColor)),
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
                                              mInvestmentDealList.length,
                                              (index) {
                                                final mgetPitchCraftList =
                                                    mInvestmentDealList[index];
                                                return Container(
                                                    height: 275,
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
                                                          height: 275,
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
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: <Widget>[
                                                                Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: ((mgetPitchCraftList.companyLogo ?? "")
                                                                            .isNotEmpty)
                                                                        ? Image.network(
                                                                            mgetPitchCraftList
                                                                                .companyLogo!,
                                                                            width:
                                                                                100,
                                                                            height:
                                                                                100,
                                                                            fit: BoxFit
                                                                                .fill)
                                                                        : Image.asset(
                                                                            'assets/avathar.png',
                                                                            width:
                                                                                100,
                                                                            height:
                                                                                100,
                                                                            fit:
                                                                                BoxFit.fill)),
                                                                const SizedBox(
                                                                  height: 20,
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(
                                                                    mgetPitchCraftList
                                                                            .legalName ??
                                                                        "",
                                                                    style: const TextStyle(
                                                                        fontFamily:
                                                                            'ManropeSemiBold',
                                                                        fontSize:
                                                                            22,
                                                                        color:
                                                                            mBtnColor),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 30,
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child:
                                                                      Container(
                                                                    width: 200,
                                                                    child: PrimaryButton(
                                                                        mButtonname: Languages.of(context)!.mViewDetails,
                                                                        onpressed: () async {
                                                                          OnLoadDialog(
                                                                              mgetPitchCraftList);
                                                                        },
                                                                        mSelectcolor: mBtnColor,
                                                                        mTextColor: mWhiteColor,
                                                                        mFontSize: 16,
                                                                        mHeigth: 40),
                                                                  ),
                                                                )
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

  void OnLoadDialog(InvestmentDeal mInvestmentDeal) {
    showGeneralDialog(
        context: context,
        barrierDismissible: false,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.transparent,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Scaffold(
            body: Center(
                child: SingleChildScrollView(
                    child: Container(
              width: MediaQuery.of(context).size.width - 10,
              padding: const EdgeInsets.fromLTRB(30, 5, 5, 10),
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
                                Navigator.pop(buildContext);
                              },
                              child: Image.asset(
                                'assets/ic_close.png',
                                height: 20,
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: ((mInvestmentDeal.companyLogo ?? "")
                                        .isNotEmpty)
                                    ? Image.network(
                                        mInvestmentDeal.companyLogo!,
                                        width: 40,
                                        height: 40,
                                        fit: BoxFit.fill)
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
                                mInvestmentDeal.legalName ?? "",
                                style: const TextStyle(
                                    fontFamily: 'ManropeSemiBold',
                                    fontSize: 20,
                                    color: mBlackColor),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${Languages.of(context)!.mAbout} ${mInvestmentDeal.legalName ?? ""}",
                          style: const TextStyle(
                              fontFamily: 'ManropeBold',
                              fontSize: 20,
                              color: kTextColorTwo),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          mInvestmentDeal.description ?? "",
                          style: const TextStyle(
                              fontFamily: 'ManropeRegular',
                              fontSize: 16,
                              color: kTextColorTwo),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      Languages.of(context)!.minvestmentdetails,
                      style: const TextStyle(
                          fontFamily: 'ManropeBold',
                          fontSize: 20,
                          color: kTextColorTwo),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        ListView.builder(
                          itemCount: mInvestmentDeal.investmentDetails!.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, position) {
                            return Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                "${position + 1}. ${mInvestmentDeal.investmentDetails![position].investorName}" ??
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
            ))),
          );
        });
  }
}
