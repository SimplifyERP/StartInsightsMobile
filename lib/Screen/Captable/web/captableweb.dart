import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Model/InvestorroundwiseResponse.dart';
import 'package:startinsights/Screen/Captable/bloc/captable_bloc.dart';
import 'package:startinsights/Screen/Captable/bloc/captable_state.dart';
import 'package:startinsights/Screen/Pitchcraftlist/bloc/pitchcraftlist_state.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Utils/constant_methods.dart';
import 'package:startinsights/Utils/screens.dart';
import 'package:startinsights/Widgets/Appbar.dart';
import 'package:startinsights/Widgets/auth_form_field.dart';
import 'package:startinsights/Widgets/default_icon_button.dart';
import 'package:startinsights/Widgets/default_text.dart';
import 'package:startinsights/Widgets/mandatoryText.dart';
import 'package:startinsights/Widgets/primary_button.dart';
import 'package:startinsights/Widgets/sidemenu.dart';

class CaptableWeb extends StatefulWidget {
  CaptableWeb({
    super.key,
  });

  @override
  State<CaptableWeb> createState() => _CaptableState();
}

class _CaptableState extends State<CaptableWeb> {
  @override
  late CaptableBloc mCaptableBloc;

  //final PitchcraftListRepo _apiService1 = PitchcraftListRepo();

  List<Color> InvestedcolorList = [
    mColorOne,
    mColorTwo,
    mColorThree,
    mColorFour,
    mColorFive,
    mColorSix,
    mColorSeven,
  ];

  List<Color> RoundWisecolorList = [
    mColorSeven,
    mColorTwo,
    mColorOne,
    mColorFour,
    mColorThree,
    mColorSix,
    mColorFive
  ];

  var mFrom = 1;
  bool? isRowSelected;
  int selectedIndex = -1;

  List<DataColumn> InvesteddataColumns = [];

  List<DataColumn> RoundWiseColumns = [];

  List<InvestorWiseList> mInvestorWiseList = [];
  List<WiseGraph> mInvestorWiseGraphList = [];
  List<WiseGraph> mRoundWiseGraphList = [];
  List<RoundWiseList> mRoundWiseList = [];

  Map<String, double> InvesteddataMap = {};
  Map<String, double> RoundWisedataMap = {};

  final TextEditingController mNameController = TextEditingController();
  final TextEditingController mTagnameController = TextEditingController();
  final TextEditingController mamountinvestedController =
      TextEditingController();
  final TextEditingController mdistinctivesharenoController =
      TextEditingController();
  final TextEditingController msharesallottedController =
      TextEditingController();
  final TextEditingController mpricepershareController =
      TextEditingController();
  final TextEditingController mfullydilutedsharesController =
      TextEditingController();
  final TextEditingController mclassofsharesController =
      TextEditingController();
  final TextEditingController mfolionumberController = TextEditingController();
  final TextEditingController mshareholdingController = TextEditingController();

  DateTime currentDate = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  Future<void> selectFromDate(
      BuildContext context, StateSetter setState1) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));
    if (pickedDate != null && pickedDate != currentDate) {
      setState1(() {
        currentDate = pickedDate;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    mNameController.dispose();
    mTagnameController.dispose();
    mamountinvestedController.dispose();
    mdistinctivesharenoController.dispose();
    msharesallottedController.dispose();
    mpricepershareController.dispose();
    mfullydilutedsharesController.dispose();
    mclassofsharesController.dispose();
    mfolionumberController.dispose();
    mshareholdingController.dispose();
  }

  Widget build(BuildContext context) {
    mCaptableBloc = CaptableBloc(mContext: context);
    InvesteddataColumns.clear();
    RoundWiseColumns.clear();
    //mInvestorName
    InvesteddataColumns.add(DataColumn(
        label: DataTitleText(
      menuname: Languages.of(context)!.mInvestorName,
    )));

    //   mTagName;
    InvesteddataColumns.add(DataColumn(
        label: DataTitleText(
      menuname: Languages.of(context)!.mTagName,
    )));

    //   mDateofAllotment;
    InvesteddataColumns.add(DataColumn(
        label: DataTitleText(
      menuname: Languages.of(context)!.mDateofAllotment,
    )));

    //   mInvestedRound;

    InvesteddataColumns.add(DataColumn(
        label: DataTitleText(
      menuname: Languages.of(context)!.mInvestedRound,
    )));

    //   mAmountInvested;
    InvesteddataColumns.add(DataColumn(
        label: DataTitleText(
      menuname: Languages.of(context)!.mAmountInvested,
    )));

    //   mDistinctiveShareNo;
    InvesteddataColumns.add(DataColumn(
        label: DataTitleText(
      menuname: Languages.of(context)!.mDistinctiveShareNo,
    )));

    //   mShareCertificate;
    InvesteddataColumns.add(DataColumn(
        label: DataTitleText(
      menuname: Languages.of(context)!.mShareCertificate,
    )));

    //   mSharesAllotted;
    InvesteddataColumns.add(DataColumn(
        label: DataTitleText(
      menuname: Languages.of(context)!.mSharesAllotted,
    )));

    //   mPricePerShare;
    InvesteddataColumns.add(DataColumn(
        label: DataTitleText(
      menuname: Languages.of(context)!.mPricePerShare,
    )));

    //   mFullyDilutedShares;
    InvesteddataColumns.add(DataColumn(
        label: DataTitleText(
      menuname: Languages.of(context)!.mFullyDilutedShares,
    )));

    //   mClassOfShares;
    InvesteddataColumns.add(DataColumn(
        label: DataTitleText(
      menuname: Languages.of(context)!.mClassOfShares,
    )));

    //   mFolioNumber;
    InvesteddataColumns.add(DataColumn(
        label: DataTitleText(
      menuname: Languages.of(context)!.mFolioNumber,
    )));

    //   mShareholding;
    InvesteddataColumns.add(DataColumn(
        label: DataTitleText(
      menuname: Languages.of(context)!.mShareholding,
    )));

    //   mCreationPersonID;
    InvesteddataColumns.add(DataColumn(
        label: DataTitleText(
      menuname: Languages.of(context)!.mCreationPersonID,
    )));

    //mNameoftheround;
    RoundWiseColumns.add(DataColumn(
        label: DataTitleText(
      menuname: Languages.of(context)!.mNameoftheround,
    )));

    //mRoundType;
    RoundWiseColumns.add(DataColumn(
        label: DataTitleText(
      menuname: Languages.of(context)!.mRoundType,
    )));

    //mClosingdateoftheRound;
    RoundWiseColumns.add(DataColumn(
        label: DataTitleText(
      menuname: Languages.of(context)!.mClosingdateoftheRound,
    )));

    //mRoundDescription;
    RoundWiseColumns.add(DataColumn(
        label: DataTitleText(
      menuname: Languages.of(context)!.mRoundDescription,
    )));

    //mSelectSecurityPrefix;
    RoundWiseColumns.add(DataColumn(
        label: DataTitleText(
      menuname: Languages.of(context)!.mSelectSecurityPrefix,
    )));

    //mAmountRaised;
    RoundWiseColumns.add(DataColumn(
        label: DataTitleText(
      menuname: Languages.of(context)!.mAmountRaised,
    )));

    //mPricepershare;
    RoundWiseColumns.add(DataColumn(
        label: DataTitleText(
      menuname: Languages.of(context)!.mPricepershare,
    )));

    //mPreMoneyValuation;
    RoundWiseColumns.add(DataColumn(
        label: DataTitleText(
      menuname: Languages.of(context)!.mPreMoneyValuation,
    )));

    //mDilutionforthisround;
    RoundWiseColumns.add(DataColumn(
        label: DataTitleText(
      menuname: Languages.of(context)!.mDilutionforthisround,
    )));

    //mDilutionforthisround;
    RoundWiseColumns.add(DataColumn(
        label: DataTitleText(
      menuname: Languages.of(context)!.mCreationPersonID,
    )));

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
          body: BlocConsumer<CaptableBloc, CaptableStatus>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is GetCaptableInfoSuccessState) {
                mInvestorWiseList = state.mInvestorWiseList;
                mInvestorWiseGraphList = state.mInvestorWiseGraphList;
                mRoundWiseGraphList = state.mRoundWiseGraphList;
                mRoundWiseList = state.mRoundWiseList;

                final returnsMapInvested = Map.fromIterables(
                    mInvestorWiseGraphList.map((e) => e.name!),
                    mInvestorWiseGraphList
                        .map((e) => double.parse(e.percentage!)));

                InvesteddataMap.addAll(returnsMapInvested);

                final returnsMapRoundWise = Map.fromIterables(
                    mRoundWiseGraphList.map((e) => e.name!),
                    mRoundWiseGraphList
                        .map((e) => double.parse(e.percentage!)));

                RoundWisedataMap.addAll(returnsMapRoundWise);

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
                                      child: SideMenu(mFrom: 10))),
                              Expanded(
                                  flex: 9,
                                  child: Container(
                                      height:
                                          MediaQuery.of(context).size.height,
                                      padding: EdgeInsets.all(15),
                                      child: SingleChildScrollView(
                                          child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Expanded(
                                                flex:
                                                    5, // takes 30% of available width
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: RichText(
                                                    text: TextSpan(
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                            text: Languages.of(
                                                                    context)!
                                                                .mInvestorOverview,
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    'ManropeBold',
                                                                fontSize: 18,
                                                                color:
                                                                    mBlackColor)),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              Expanded(
                                                flex:
                                                    5, // takes 30% of available width
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: RichText(
                                                    text: TextSpan(
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                            text: Languages.of(
                                                                    context)!
                                                                .mRoundwiseOverview,
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    'ManropeBold',
                                                                fontSize: 18,
                                                                color:
                                                                    mBlackColor)),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Expanded(
                                                flex:
                                                    5, // takes 30% of available width
                                                child: Container(
                                                    height: 400,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: Colors.white10,
                                                        border: Border.all(
                                                          color: kTextBorder,
                                                          width: 1,
                                                        )),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(0, 0, 0, 0),
                                                      child:
                                                          (mInvestorWiseGraphList
                                                                  .isNotEmpty)
                                                              ? PieChart(
                                                                  dataMap:
                                                                      InvesteddataMap,
                                                                  animationDuration:
                                                                      const Duration(
                                                                          milliseconds:
                                                                              800),
                                                                  chartLegendSpacing:
                                                                      32,
                                                                  chartRadius:
                                                                      300,
                                                                  colorList:
                                                                      InvestedcolorList,
                                                                  initialAngleInDegree:
                                                                      0,
                                                                  chartType:
                                                                      ChartType
                                                                          .disc,
                                                                  ringStrokeWidth:
                                                                      80,
                                                                  centerText:
                                                                      "",
                                                                  legendOptions:
                                                                      const LegendOptions(
                                                                    showLegendsInRow:
                                                                        false,
                                                                    legendPosition:
                                                                        LegendPosition
                                                                            .right,
                                                                    showLegends:
                                                                        true,
                                                                    legendShape:
                                                                        BoxShape
                                                                            .circle,
                                                                    legendTextStyle: TextStyle(
                                                                        fontFamily:
                                                                            'ManropeRegular',
                                                                        fontSize:
                                                                            14,
                                                                        color:
                                                                            mBlackColor),
                                                                  ),
                                                                  chartValuesOptions:
                                                                      const ChartValuesOptions(
                                                                    showChartValueBackground:
                                                                        true,
                                                                    showChartValues:
                                                                        true,
                                                                    showChartValuesInPercentage:
                                                                        true,
                                                                    showChartValuesOutside:
                                                                        false,
                                                                    decimalPlaces:
                                                                        1,
                                                                  ),
                                                                  // gradientList: ---To add gradient colors---
                                                                  // emptyColorGradient: ---Empty Color gradient---
                                                                )
                                                              : const Center(
                                                                  child: Text(
                                                                      "No Data found",
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'ManropeBold',
                                                                          fontSize:
                                                                              20,
                                                                          color:
                                                                              Colors.black)),
                                                                )

                                                      /*PieChart(
                                                      // Pass in the data for
                                                      // the pie chart
                                                      dataMap: dataMap,
                                                      // Set the colors for the
                                                      // pie chart segments
                                                      colorList: colorList,
                                                      // Set the radius of the pie chart
                                                      chartRadius: 250,
                                                      // Set the center text of the pie chart
                                                      centerText: "",
                                                      // Set the width of the
                                                      // ring around the pie chart
                                                      //ringStrokeWidth: 2,
                                                      // Set the animation duration of the pie chart
                                                      animationDuration:
                                                          const Duration(
                                                              seconds: 2),
                                                      // Set the options for the chart values (e.g. show percentages, etc.)
                                                      chartValuesOptions:
                                                          const ChartValuesOptions(
                                                              showChartValues:
                                                                  false,
                                                              showChartValuesOutside:
                                                                  false,
                                                              showChartValuesInPercentage:
                                                                  false,
                                                              showChartValueBackground:
                                                                  false),
                                                      // Set the options for the legend of the pie chart
                                                      legendOptions:
                                                          const LegendOptions(
                                                        showLegends: true,
                                                      ),
                                                      // Set the list of gradients for
                                                      // the background of the pie chart
                                                      // gradientList: gradientList,
                                                    )*/
                                                      ,
                                                    )),
                                              ),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              Expanded(
                                                flex:
                                                    5, // takes 30% of available width
                                                child: Container(
                                                    height: 400,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: Colors.white10,
                                                        border: Border.all(
                                                          color: kTextBorder,
                                                          width: 1,
                                                        )),
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                0, 0, 0, 0),
                                                        child: InkWell(
                                                          child: Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: (mRoundWiseGraphList
                                                                    .isNotEmpty)
                                                                ? PieChart(
                                                                    dataMap:
                                                                        RoundWisedataMap,
                                                                    animationDuration:
                                                                        const Duration(
                                                                            milliseconds:
                                                                                800),
                                                                    chartLegendSpacing:
                                                                        32,
                                                                    chartRadius:
                                                                        300,
                                                                    colorList:
                                                                        RoundWisecolorList,
                                                                    initialAngleInDegree:
                                                                        0,
                                                                    chartType:
                                                                        ChartType
                                                                            .disc,
                                                                    ringStrokeWidth:
                                                                        80,
                                                                    centerText:
                                                                        "",
                                                                    legendOptions:
                                                                        const LegendOptions(
                                                                      showLegendsInRow:
                                                                          false,
                                                                      legendPosition:
                                                                          LegendPosition
                                                                              .right,
                                                                      showLegends:
                                                                          true,
                                                                      legendShape:
                                                                          BoxShape
                                                                              .circle,
                                                                      legendTextStyle: TextStyle(
                                                                          fontFamily:
                                                                              'ManropeRegular',
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              mBlackColor),
                                                                    ),
                                                                    chartValuesOptions:
                                                                        const ChartValuesOptions(
                                                                      showChartValueBackground:
                                                                          true,
                                                                      showChartValues:
                                                                          true,
                                                                      showChartValuesInPercentage:
                                                                          true,
                                                                      showChartValuesOutside:
                                                                          false,
                                                                      decimalPlaces:
                                                                          1,
                                                                    ),
                                                                    // gradientList: ---To add gradient colors---
                                                                    // emptyColorGradient: ---Empty Color gradient---
                                                                  )
                                                                : const Center(
                                                                    child: Text(
                                                                        "No Data found",
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'ManropeBold',
                                                                            fontSize:
                                                                                20,
                                                                            color:
                                                                                Colors.black)),
                                                                  ),
                                                          ),
                                                        ))),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              color: mWhiteColor,
                                              child: Stack(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      (mFrom == 1)
                                                          ? Languages.of(
                                                                  context)!
                                                              .mInvestorCaptableDetails
                                                          : Languages.of(
                                                                  context)!
                                                              .mRoundwiseCaptableDetails,
                                                      style: const TextStyle(
                                                          fontFamily:
                                                              'ManropeBold',
                                                          fontSize: 18,
                                                          color: mBlackColor),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2,
                                                      child: Row(
                                                        //ROW 1
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                mFrom = 1;
                                                              });
                                                            },
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  Languages.of(
                                                                          context)!
                                                                      .mInvestorwise,
                                                                  style: const TextStyle(
                                                                      fontFamily:
                                                                          'ManropeSemiBold',
                                                                      fontSize:
                                                                          18,
                                                                      color:
                                                                          mBtnColor),
                                                                ),
                                                                const SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Visibility(
                                                                    visible: (mFrom ==
                                                                            1)
                                                                        ? true
                                                                        : false,
                                                                    child:
                                                                        Container(
                                                                      height: 3,
                                                                      width:
                                                                          120,
                                                                      color:
                                                                          mBtnColor,
                                                                    )),
                                                              ],
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 20,
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                mFrom = 2;
                                                              });
                                                            },
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  Languages.of(
                                                                          context)!
                                                                      .mRoundwise,
                                                                  style: const TextStyle(
                                                                      fontFamily:
                                                                          'ManropeSemiBold',
                                                                      fontSize:
                                                                          18,
                                                                      color:
                                                                          mBtnColor),
                                                                ),
                                                                const SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Visibility(
                                                                    visible: (mFrom ==
                                                                            2)
                                                                        ? true
                                                                        : false,
                                                                    child:
                                                                        Container(
                                                                      height: 3,
                                                                      width:
                                                                          120,
                                                                      color:
                                                                          mBtnColor,
                                                                    )),
                                                              ],
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 20,
                                                          ),
                                                          Container(
                                                              height: 35,
                                                              width: 200,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color:
                                                                            mWhiteColor,
                                                                        width:
                                                                            1,
                                                                      )),
                                                              child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                  child:
                                                                      InkWell(
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child: PrimaryButton(
                                                                          mButtonname: Languages.of(context)!.mAddFundingRound,
                                                                          onpressed: () {
                                                                            if (mFrom ==
                                                                                1) {
                                                                              OnCreateInvestorDialog();
                                                                            }
                                                                          },
                                                                          mSelectcolor: mBtnColor,
                                                                          mTextColor: mWhiteColor,
                                                                          mFontSize: 16,
                                                                          mHeigth: 40),
                                                                    ),
                                                                  ))),
                                                          const SizedBox(
                                                            width: 20,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Visibility(
                                              visible:
                                                  (mFrom == 1) ? true : false,
                                              child: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 0,
                                                          left: 0,
                                                          right: 0,
                                                          bottom: 0),
                                                  alignment:
                                                      Alignment.topCenter,
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: kTextBorder,
                                                      width: 0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            1),
                                                  ),
                                                  child: (mFrom == 1)
                                                      ? SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          child:
                                                              SingleChildScrollView(
                                                                  scrollDirection:
                                                                      Axis
                                                                          .horizontal,
                                                                  child:
                                                                      DataTable(
                                                                    headingRowColor:
                                                                        MaterialStateColor.resolveWith((states) =>
                                                                            mTabelHeader),
                                                                    border:
                                                                        const TableBorder(
                                                                      top: BorderSide(
                                                                          color: Colors
                                                                              .grey,
                                                                          width:
                                                                              0.5),
                                                                      bottom: BorderSide(
                                                                          color: Colors
                                                                              .grey,
                                                                          width:
                                                                              0.5),
                                                                      left: BorderSide(
                                                                          color: Colors
                                                                              .grey,
                                                                          width:
                                                                              0.5),
                                                                      right: BorderSide(
                                                                          color: Colors
                                                                              .grey,
                                                                          width:
                                                                              0.5),
                                                                      horizontalInside: BorderSide(
                                                                          color: Colors
                                                                              .grey,
                                                                          width:
                                                                              0.5),
                                                                      verticalInside: BorderSide(
                                                                          color: Colors
                                                                              .grey,
                                                                          width:
                                                                              0.5),
                                                                    ),
                                                                    columns:
                                                                        InvesteddataColumns,
                                                                    rows: List
                                                                        .generate(
                                                                      mInvestorWiseList
                                                                          .length,
                                                                      (index) {
                                                                        var getmInvestorWiseList =
                                                                            mInvestorWiseList![index];
                                                                        return DataRow(
                                                                            cells: [
                                                                              DataCell(
                                                                                DatacellText(
                                                                                  menuname: getmInvestorWiseList.investorName ?? "",
                                                                                ),
                                                                              ),
                                                                              DataCell(DatacellText(
                                                                                menuname: getmInvestorWiseList.tagName ?? "",
                                                                              )),
                                                                              DataCell(
                                                                                DatacellText(menuname: DateFormat('dd MMM yyyy').format(getmInvestorWiseList.dateOfAllotment ?? DateTime.now())),
                                                                              ),
                                                                              DataCell(DatacellText(
                                                                                menuname: getmInvestorWiseList.investedRound ?? "",
                                                                              )),
                                                                              DataCell(DatacellText(
                                                                                menuname: getmInvestorWiseList.amountInvested.toString() ?? "",
                                                                              )),
                                                                              DataCell(DatacellText(
                                                                                menuname: getmInvestorWiseList.distinctiveShareNo ?? "",
                                                                              )),
                                                                              DataCell(DatacellText(
                                                                                menuname: getmInvestorWiseList.shareCertificate ?? "",
                                                                              )),
                                                                              DataCell(DatacellText(
                                                                                menuname: getmInvestorWiseList.sharesAllotted ?? "",
                                                                              )),
                                                                              DataCell(DatacellText(
                                                                                menuname: getmInvestorWiseList.pricePerShare.toString() ?? "",
                                                                              )),
                                                                              DataCell(DatacellText(
                                                                                menuname: getmInvestorWiseList.fullyDilutedShares ?? "",
                                                                              )),
                                                                              DataCell(DatacellText(
                                                                                menuname: getmInvestorWiseList.classOfShares ?? "",
                                                                              )),
                                                                              DataCell(DatacellText(
                                                                                menuname: getmInvestorWiseList.folioNumber ?? "",
                                                                              )),
                                                                              DataCell(DatacellText(
                                                                                menuname: getmInvestorWiseList.shareholding ?? "",
                                                                              )),
                                                                              DataCell(DatacellText(
                                                                                menuname: getmInvestorWiseList.creationPersonId ?? "",
                                                                              )),
                                                                            ]);
                                                                      },
                                                                    ).toList(),
                                                                    showBottomBorder:
                                                                        true,
                                                                  )))
                                                      : Text(""))),
                                          Visibility(
                                              visible:
                                                  (mFrom == 2) ? true : false,
                                              child: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 0,
                                                          left: 0,
                                                          right: 0,
                                                          bottom: 0),
                                                  alignment:
                                                      Alignment.topCenter,
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: kTextBorder,
                                                      width: 0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            1),
                                                  ),
                                                  child: (mFrom == 2)
                                                      ? SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          child:
                                                              SingleChildScrollView(
                                                                  scrollDirection:
                                                                      Axis
                                                                          .horizontal,
                                                                  child:
                                                                      DataTable(
                                                                    headingRowColor:
                                                                        MaterialStateColor.resolveWith((states) =>
                                                                            mTabelHeader),
                                                                    border:
                                                                        const TableBorder(
                                                                      top: BorderSide(
                                                                          color: Colors
                                                                              .grey,
                                                                          width:
                                                                              0.5),
                                                                      bottom: BorderSide(
                                                                          color: Colors
                                                                              .grey,
                                                                          width:
                                                                              0.5),
                                                                      left: BorderSide(
                                                                          color: Colors
                                                                              .grey,
                                                                          width:
                                                                              0.5),
                                                                      right: BorderSide(
                                                                          color: Colors
                                                                              .grey,
                                                                          width:
                                                                              0.5),
                                                                      horizontalInside: BorderSide(
                                                                          color: Colors
                                                                              .grey,
                                                                          width:
                                                                              0.5),
                                                                      verticalInside: BorderSide(
                                                                          color: Colors
                                                                              .grey,
                                                                          width:
                                                                              0.5),
                                                                    ),
                                                                    columns:
                                                                        RoundWiseColumns,
                                                                    rows: List
                                                                        .generate(
                                                                      mRoundWiseList
                                                                          .length,
                                                                      (index) {
                                                                        var getmInvestorWiseList =
                                                                            mRoundWiseList![index];
                                                                        return DataRow(
                                                                            cells: [
                                                                              DataCell(
                                                                                DatacellText(
                                                                                  menuname: getmInvestorWiseList.nameOfTheRound ?? "",
                                                                                ),
                                                                              ),
                                                                              DataCell(DatacellText(
                                                                                menuname: getmInvestorWiseList.roundType ?? "",
                                                                              )),
                                                                              DataCell(
                                                                                DatacellText(menuname: DateFormat('dd MMM yyyy').format(getmInvestorWiseList.closingDateOfTheRound!)),
                                                                              ),
                                                                              DataCell(DatacellText(
                                                                                menuname: getmInvestorWiseList.description ?? "",
                                                                              )),
                                                                              DataCell(DatacellText(
                                                                                menuname: getmInvestorWiseList.selectSecurityPrefix ?? "",
                                                                              )),
                                                                              DataCell(DatacellText(
                                                                                menuname: getmInvestorWiseList.amountRaised.toString() ?? "",
                                                                              )),
                                                                              DataCell(DatacellText(
                                                                                menuname: getmInvestorWiseList.pricePerShare.toString() ?? "",
                                                                              )),
                                                                              DataCell(DatacellText(
                                                                                menuname: getmInvestorWiseList.preMoneyValuation.toString() ?? "",
                                                                              )),
                                                                              DataCell(DatacellText(
                                                                                menuname: getmInvestorWiseList.dilutionForThisRound.toString() ?? "",
                                                                              )),
                                                                              DataCell(DatacellText(
                                                                                menuname: getmInvestorWiseList.creationPersonId ?? "",
                                                                              )),
                                                                            ]);
                                                                      },
                                                                    ).toList(),
                                                                    showBottomBorder:
                                                                        true,
                                                                  )))
                                                      : Text(""))),
                                          const SizedBox(
                                            height: 80,
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

              if (state is GetPitchcraftlistInfoSuccessState) {}

              //  ErrorToast(context: context, text: state.mDashboard.message!);

              //} else if (state is GetPunchInOutFailState) {}
              return Container();
            },
          )),
    );
  }

  void OnCreateInvestorDialog() {
    showDialog(
      context: context,
      builder: (context2) {
        String contentText = "Content of Dialog";
        return StatefulBuilder(
          builder: (context1, setState) {
            return AlertDialog(
              contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              //  title: Center(child: Text("Information")),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),

              content: SizedBox(
                width: MediaQuery.of(context1).size.width - 20,
                height: MediaQuery.of(context1).size.height - 10,
                child: SingleChildScrollView(
                    child: Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 9,
                              child: Text(
                                Languages.of(context)!.mAddFundingRound,
                                style: const TextStyle(
                                    fontFamily: 'ManropeBold',
                                    fontSize: 20,
                                    color: kTextColorTwo),
                              )),
                          Expanded(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context1);
                                  },
                                  child: Image.asset(
                                    'assets/ic_closecross.png',
                                    height: 30,
                                  ),
                                ),
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: MandatoryText(
                                  mText: Languages.of(context)!.mName),
                              // Text(Languages.of(context)!.OutletName,
                              //     style: const TextStyle(
                              //         fontFamily: 'OpenSansSemiBold',
                              //         fontSize: 18,
                              //         color: kBlack)),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              child: AuthFormField(
                                // validator: (value) =>
                                //     emailController.text.isEmpty
                                //         ? ""
                                //         : null,

                                controller: mNameController,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.text,
                                hintText: Languages.of(context)!.mEnterName,
                                radius: 30,
                                maxLength: 150,
                                labelText: Languages.of(context)!.mEnterName,
                                mBorderView: false,
                                mImageView: true,
                              ),
                            ),
                          ]),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: MandatoryText(
                                  mText: Languages.of(context)!.mtagname),
                              // Text(Languages.of(context)!.OutletName,
                              //     style: const TextStyle(
                              //         fontFamily: 'OpenSansSemiBold',
                              //         fontSize: 18,
                              //         color: kBlack)),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              child: AuthFormField(
                                // validator: (value) =>
                                //     emailController.text.isEmpty
                                //         ? ""
                                //         : null,
                                controller: mTagnameController,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.text,
                                hintText: Languages.of(context)!.mentertagname,
                                radius: 30,
                                maxLength: 250,
                                maxLines: 1,
                                labelText: Languages.of(context)!.mentertagname,
                                mBorderView: false,
                                mImageView: true,
                                mIncreshHeight: true,
                              ),
                            ),
                          ]),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: MandatoryText(
                                  mText:
                                      Languages.of(context)!.mDateofAllotment),
                              // Text(Languages.of(context)!.OutletName,
                              //     style: const TextStyle(
                              //         fontFamily: 'OpenSansSemiBold',
                              //         fontSize: 18,
                              //         color: kBlack)),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            /*Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              child: AuthFormField(
                                // validator: (value) =>
                                //     emailController.text.isEmpty
                                //         ? ""
                                //         : null,
                                controller: mTagnameController,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.text,
                                hintText: Languages.of(context)!
                                    .mselectDateofAllotment,
                                radius: 30,
                                maxLength: 250,
                                maxLines: 1,
                                labelText: Languages.of(context)!
                                    .mselectDateofAllotment,
                                mBorderView: false,
                                mImageView: true,
                                mIncreshHeight: true,
                              ),
                            )*/

                            InkWell(
                              onTap: () {
                                selectFromDate(context, setState);
                              },
                              child: Container(
                                  margin: const EdgeInsets.only(
                                    left: 2.0,
                                  ),
                                  padding:
                                      const EdgeInsets.only(left: 10, right: 5),
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 2.0,
                                        ),
                                      ]),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: DefaultText(
                                          text:
                                              mFirstFormat.format(currentDate),
                                          color: Colors.black,
                                          fontSize: 16,
                                          mFontFamily: 'OpenSansMedium',
                                        ),
                                      ),
                                      DefaultIconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.calendar_month_sharp,
                                          ),
                                          iconSize: 30),
                                    ],
                                  )),
                            ),
                          ]),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: MandatoryText(
                                  mText: Languages.of(context)!.mInvestedRound),
                              // Text(Languages.of(context)!.OutletName,
                              //     style: const TextStyle(
                              //         fontFamily: 'OpenSansSemiBold',
                              //         fontSize: 18,
                              //         color: kBlack)),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              child: AuthFormField(
                                // validator: (value) =>
                                //     emailController.text.isEmpty
                                //         ? ""
                                //         : null,
                                controller: mTagnameController,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.text,
                                hintText:
                                    Languages.of(context)!.menterInvestedRound,
                                radius: 30,
                                maxLength: 250,
                                maxLines: 1,
                                labelText:
                                    Languages.of(context)!.menterInvestedRound,
                                mBorderView: false,
                                mImageView: true,
                                mIncreshHeight: true,
                              ),
                            ),
                          ]),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: MandatoryText(
                                  mText:
                                      Languages.of(context)!.mAmountInvested),
                              // Text(Languages.of(context)!.OutletName,
                              //     style: const TextStyle(
                              //         fontFamily: 'OpenSansSemiBold',
                              //         fontSize: 18,
                              //         color: kBlack)),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              child: AuthFormField(
                                // validator: (value) =>
                                //     emailController.text.isEmpty
                                //         ? ""
                                //         : null,
                                controller: mamountinvestedController,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                hintText:
                                    Languages.of(context)!.menterAmountInvested,
                                radius: 30,
                                maxLength: 250,
                                maxLines: 1,
                                labelText:
                                    Languages.of(context)!.menterAmountInvested,
                                mBorderView: false,
                                mImageView: true,
                                mIncreshHeight: true,
                              ),
                            ),
                          ]),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: MandatoryText(
                                  mText: Languages.of(context)!
                                      .mDistinctiveShareNo),
                              // Text(Languages.of(context)!.OutletName,
                              //     style: const TextStyle(
                              //         fontFamily: 'OpenSansSemiBold',
                              //         fontSize: 18,
                              //         color: kBlack)),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              child: AuthFormField(
                                // validator: (value) =>
                                //     emailController.text.isEmpty
                                //         ? ""
                                //         : null,
                                controller: mdistinctivesharenoController,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                hintText: Languages.of(context)!
                                    .menterDistinctiveShareNo,
                                radius: 30,
                                maxLength: 250,
                                maxLines: 1,
                                labelText: Languages.of(context)!
                                    .menterDistinctiveShareNo,
                                mBorderView: false,
                                mImageView: true,
                                mIncreshHeight: true,
                              ),
                            ),
                          ]),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: MandatoryText(
                                  mText:
                                      Languages.of(context)!.mSharesAllotted),
                              // Text(Languages.of(context)!.OutletName,
                              //     style: const TextStyle(
                              //         fontFamily: 'OpenSansSemiBold',
                              //         fontSize: 18,
                              //         color: kBlack)),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              child: AuthFormField(
                                // validator: (value) =>
                                //     emailController.text.isEmpty
                                //         ? ""
                                //         : null,
                                controller: msharesallottedController,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                hintText:
                                    Languages.of(context)!.menterSharesAllotted,
                                radius: 30,
                                maxLength: 250,
                                maxLines: 1,
                                labelText:
                                    Languages.of(context)!.menterSharesAllotted,
                                mBorderView: false,
                                mImageView: true,
                                mIncreshHeight: true,
                              ),
                            ),
                          ]),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: MandatoryText(
                                  mText: Languages.of(context)!.mPricePerShare),
                              // Text(Languages.of(context)!.OutletName,
                              //     style: const TextStyle(
                              //         fontFamily: 'OpenSansSemiBold',
                              //         fontSize: 18,
                              //         color: kBlack)),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              child: AuthFormField(
                                // validator: (value) =>
                                //     emailController.text.isEmpty
                                //         ? ""
                                //         : null,
                                controller: mpricepershareController,
                                textInputAction: TextInputAction.next,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true, signed: false),
                                hintText:
                                    Languages.of(context)!.menterPricePerShare,
                                radius: 30,
                                maxLength: 6,
                                maxLines: 1,
                                labelText:
                                    Languages.of(context)!.menterPricePerShare,
                                mBorderView: false,
                                mImageView: true,
                                mIncreshHeight: true,
                              ),
                            ),
                          ]),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: MandatoryText(
                                  mText: Languages.of(context)!
                                      .mFullyDilutedShares),
                              // Text(Languages.of(context)!.OutletName,
                              //     style: const TextStyle(
                              //         fontFamily: 'OpenSansSemiBold',
                              //         fontSize: 18,
                              //         color: kBlack)),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              child: AuthFormField(
                                // validator: (value) =>
                                //     emailController.text.isEmpty
                                //         ? ""
                                //         : null,
                                controller: mfullydilutedsharesController,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.text,
                                hintText: Languages.of(context)!
                                    .menterFullyDilutedShares,
                                radius: 30,
                                maxLength: 3,
                                maxLines: 1,
                                labelText: Languages.of(context)!
                                    .menterFullyDilutedShares,
                                mBorderView: false,
                                mImageView: true,
                                mIncreshHeight: true,
                              ),
                            ),
                          ]),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: MandatoryText(
                                  mText: Languages.of(context)!.mClassOfShares),
                              // Text(Languages.of(context)!.OutletName,
                              //     style: const TextStyle(
                              //         fontFamily: 'OpenSansSemiBold',
                              //         fontSize: 18,
                              //         color: kBlack)),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              child: AuthFormField(
                                // validator: (value) =>
                                //     emailController.text.isEmpty
                                //         ? ""
                                //         : null,
                                controller: mclassofsharesController,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                hintText:
                                    Languages.of(context)!.menterClassOfShares,
                                radius: 30,
                                maxLength: 3,
                                maxLines: 1,
                                labelText:
                                    Languages.of(context)!.menterClassOfShares,
                                mBorderView: false,
                                mImageView: true,
                                mIncreshHeight: true,
                              ),
                            ),
                          ]),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: MandatoryText(
                                  mText: Languages.of(context)!.mFolioNumber),
                              // Text(Languages.of(context)!.OutletName,
                              //     style: const TextStyle(
                              //         fontFamily: 'OpenSansSemiBold',
                              //         fontSize: 18,
                              //         color: kBlack)),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              child: AuthFormField(
                                // validator: (value) =>
                                //     emailController.text.isEmpty
                                //         ? ""
                                //         : null,
                                controller: mfolionumberController,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                hintText:
                                    Languages.of(context)!.menterFolioNumber,
                                radius: 30,
                                maxLength: 25,
                                maxLines: 1,
                                labelText:
                                    Languages.of(context)!.menterFolioNumber,
                                mBorderView: false,
                                mImageView: true,
                                mIncreshHeight: true,
                              ),
                            ),
                          ]),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: MandatoryText(
                                  mText: Languages.of(context)!.mShareholding),
                              // Text(Languages.of(context)!.OutletName,
                              //     style: const TextStyle(
                              //         fontFamily: 'OpenSansSemiBold',
                              //         fontSize: 18,
                              //         color: kBlack)),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              child: AuthFormField(
                                // validator: (value) =>
                                //     emailController.text.isEmpty
                                //         ? ""
                                //         : null,
                                controller: mshareholdingController,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                hintText:
                                    Languages.of(context)!.menterShareholding,
                                radius: 30,
                                maxLength: 3,
                                maxLines: 1,
                                labelText:
                                    Languages.of(context)!.menterShareholding,
                                mBorderView: false,
                                mImageView: true,
                                mIncreshHeight: true,
                              ),
                            ),
                          ]),
                    ],
                  ),
                )),
              ),
            );
          },
        );
      },
    );
  }
}

class DatacellText extends StatelessWidget {
  const DatacellText({
    super.key,
    required this.menuname,
  });

  final String menuname;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      child: Text(menuname,
          style: const TextStyle(
              fontFamily: 'ManropeMedium', fontSize: 14, color: Colors.black)),
    );
  }
}

class DataTitleText extends StatelessWidget {
  const DataTitleText({
    super.key,
    required this.menuname,
  });

  final String menuname;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      child: Text(menuname,
          style: const TextStyle(
              fontFamily: 'ManropeBold', fontSize: 14, color: Colors.white)),
    );
  }
}
