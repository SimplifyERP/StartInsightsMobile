import 'dart:collection';

import 'package:custom_gif_loading/custom_gif_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_web/razorpay_web.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Model/ExpertBookingResponse.dart';
import 'package:startinsights/Network/api_result_handler.dart';
import 'package:startinsights/Repository/bookanexpert_repository.dart';
import 'package:startinsights/Screen/ExpertBooking/bloc/expertbooking_bloc.dart';
import 'package:startinsights/Screen/ExpertBooking/bloc/expertbooking_state.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Utils/StorageServiceConstant.dart';
import 'package:startinsights/Utils/constant_methods.dart';
import 'package:startinsights/Utils/screens.dart';
import 'package:startinsights/Widgets/Appbar.dart';
import 'package:startinsights/Widgets/sidemenu.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../Model/CommonResponse.dart';
import '../../../Utils/utils.dart';

class ExpertBookingWeb extends StatefulWidget {
  final String mExpertid;
  ExpertBookingWeb({super.key, required this.mExpertid});

  @override
  State<ExpertBookingWeb> createState() => _ExpertBookingWebState();
}

class _ExpertBookingWebState extends State<ExpertBookingWeb> {
  @override
  late ExpertBookingBloc mExpertBookingBloc;
  bool checkedValue = false;
  List<BookAnExpert> mBookAnExpertList = [];
  String mUserImage = "";
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List> eventsList = {};

  //Map<String, String> mDayeventsList = {};

  List<String> mStartTime = [];
  List<String> mEndTime = [];
  List<bool> mStatus = [];
  List<String> mSelectDate = [];

  CalendarFormat _calendarFormat = CalendarFormat.month;

  BookanexpertListRepository apiService = BookanexpertListRepository();

  var expertname = "";
  var servicedate = "";
  var starttime = "";
  var endtime = "";
  var bookingid = "";
  var bookingamount = 0;
  var userId = "";
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    loadpref();
  }

  Future<void> loadpref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    userId = (prefs.getString(StorageServiceConstant.MUSEREMAIL) ?? '');
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  Widget build(BuildContext context) {
    mExpertBookingBloc = ExpertBookingBloc(mContext: context);

    void OnLoadNext() {
      Navigator.pushReplacementNamed(context, bookinganexpertRoute);
    }

    final ScrollController controller = ScrollController();

    return WillPopScope(
      onWillPop: () {
        //trigger leaving and use own data
        //Navigator.pop(context, false);

        OnLoadNext();
        //we need to return a future
        return Future.value(false);
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: Appbar(
            mText: "",
            mUserImage: "",
            mFrom: 7,
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
          body: BlocConsumer<ExpertBookingBloc, ExpertBookingStatus>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is GetExpertBookingInfoSuccessState) {
                mBookAnExpertList = state.mBookAnExpertList;

                for (var i = 0; i < mBookAnExpertList[0].booking!.length; i++) {
                  DateTime tempDate = DateFormat("dd-MM-yyyy")
                      .parse(mBookAnExpertList[0].booking![i].date!);
                  Map<DateTime, List> mAddData = {
                    tempDate: ['Event A1'],
                  };
                  eventsList.addAll(mAddData);
                }

                final events = LinkedHashMap<DateTime, List>(
                  equals: isSameDay,
                  hashCode: getHashCode,
                )..addAll(eventsList);

                List getEventForDay(DateTime day) {
                  return events[day] ?? [];
                }

                return SafeArea(
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
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
                                      child: SideMenu(mFrom: 7))),
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
                                                              .mStartX,
                                                      style: const TextStyle(
                                                          fontFamily:
                                                              'ManropeBold',
                                                          fontSize: 26,
                                                          color: mBlackColor)),
                                                  TextSpan(
                                                      text:
                                                          Languages.of(context)!
                                                              .mBookanExpert,
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
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                  flex: 6,
                                                  child: SingleChildScrollView(
                                                    child: Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 20,
                                                              left: 2,
                                                              right: 2),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            child: Column(
                                                                children: [
                                                                  const SizedBox(
                                                                    height: 20,
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center, // set your alignment
                                                                    children: <Widget>[
                                                                      const SizedBox(
                                                                        width:
                                                                            5,
                                                                      ),
                                                                      Expanded(
                                                                        flex:
                                                                            6, // takes 30% of available width
                                                                        child: Container(
                                                                            height: 80,
                                                                            child: Column(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Align(
                                                                                  alignment: Alignment.centerLeft,
                                                                                  child: Text(
                                                                                    mBookAnExpertList[0].expertName ?? "",
                                                                                    style: const TextStyle(fontFamily: 'ManropeSemiBold', fontSize: 20, color: mBlackColor),
                                                                                  ),
                                                                                ),
                                                                                const SizedBox(
                                                                                  height: 10,
                                                                                ),
                                                                                Align(
                                                                                  alignment: Alignment.centerLeft,
                                                                                  child: Text(
                                                                                    mBookAnExpertList[0].designation ?? "",
                                                                                    style: const TextStyle(fontFamily: 'ManropeRegular', fontSize: 16, color: kTextGrayColor),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            )),
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            15,
                                                                      ),
                                                                      const Expanded(
                                                                        flex: 2,
                                                                        child: Text(
                                                                            "") // takes 30% of available width
                                                                        /*child: Container(
                                                                            height: 80,
                                                                            child: Padding(
                                                                                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                                                                child: IconButton(
                                                                                  icon: Image.asset('assets/ic_linkedin.png'),
                                                                                  iconSize: 20,
                                                                                  onPressed: () async {
                                                                                    if (await canLaunchUrl(Uri.parse(mBookAnExpertList[0].linkedinId ?? ""))) {
                                                                                      await launchUrl(Uri.parse(mBookAnExpertList[0].linkedinId ?? ""), mode: LaunchMode.externalApplication);
                                                                                    } else {
                                                                                      throw 'Could not launch ${mBookAnExpertList[0].linkedinId}' ?? "";
                                                                                    }
                                                                                  },
                                                                                )))*/
                                                                        ,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 20,
                                                                  ),
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          Languages.of(context)!
                                                                              .mEventStart,
                                                                          style: const TextStyle(
                                                                              fontFamily: 'ManropeSemiBold',
                                                                              fontSize: 20,
                                                                              color: mBlackColor),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          changeDateFormat(
                                                                              mBookAnExpertList[0].fromDate ?? "",
                                                                              "dd-MM-yyyy"),
                                                                          style: const TextStyle(
                                                                              fontFamily: 'ManropeRegular',
                                                                              fontSize: 20,
                                                                              color: mBlackColor),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 20,
                                                                  ),
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          Languages.of(context)!
                                                                              .mEventend,
                                                                          style: const TextStyle(
                                                                              fontFamily: 'ManropeSemiBold',
                                                                              fontSize: 20,
                                                                              color: mBlackColor),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          changeDateFormat(
                                                                              mBookAnExpertList[0].toDate ?? "",
                                                                              "dd-MM-yyyy"),
                                                                          style: const TextStyle(
                                                                              fontFamily: 'ManropeRegular',
                                                                              fontSize: 20,
                                                                              color: mBlackColor),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 20,
                                                                  ),
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          Languages.of(context)!
                                                                              .mEventStarttime,
                                                                          style: const TextStyle(
                                                                              fontFamily: 'ManropeSemiBold',
                                                                              fontSize: 20,
                                                                              color: mBlackColor),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          changeTimeFormat(mBookAnExpertList[0].startTime ??
                                                                              ""),
                                                                          style: const TextStyle(
                                                                              fontFamily: 'ManropeRegular',
                                                                              fontSize: 20,
                                                                              color: mBlackColor),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 20,
                                                                  ),
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          Languages.of(context)!
                                                                              .mEventendtime,
                                                                          style: const TextStyle(
                                                                              fontFamily: 'ManropeSemiBold',
                                                                              fontSize: 20,
                                                                              color: mBlackColor),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          changeTimeFormat(mBookAnExpertList[0].endTime ??
                                                                              ""),
                                                                          style: const TextStyle(
                                                                              fontFamily: 'ManropeRegular',
                                                                              fontSize: 20,
                                                                              color: mBlackColor),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 20,
                                                                  ),
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          Languages.of(context)!
                                                                              .mDescription,
                                                                          style: const TextStyle(
                                                                              fontFamily: 'ManropeSemiBold',
                                                                              fontSize: 20,
                                                                              color: mBlackColor),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          mBookAnExpertList[0].description ??
                                                                              "",
                                                                          style: const TextStyle(
                                                                              fontFamily: 'ManropeRegular',
                                                                              fontSize: 20,
                                                                              color: mBlackColor),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )
                                                                ]),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  )),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                  flex: 4,
                                                  child: SingleChildScrollView(
                                                    child: Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 2,
                                                              left: 2,
                                                              right: 2),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5),
                                                            margin:
                                                                const EdgeInsets
                                                                    .fromLTRB(
                                                                    10,
                                                                    10,
                                                                    10,
                                                                    0),
                                                            color: Colors.white,
                                                            height:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            child: Column(
                                                              children: [
                                                                TableCalendar(
                                                                  firstDay:
                                                                      kFirstDay,
                                                                  lastDay:
                                                                      kLastDay,
                                                                  focusedDay:
                                                                      _focusedDay,
                                                                  eventLoader:
                                                                      getEventForDay,
                                                                  availableCalendarFormats: const {
                                                                    CalendarFormat
                                                                            .month:
                                                                        'Month'
                                                                  },
                                                                  startingDayOfWeek:
                                                                      StartingDayOfWeek
                                                                          .monday,
                                                                  headerStyle:
                                                                      const HeaderStyle(
                                                                          titleCentered:
                                                                              true),
                                                                  calendarFormat:
                                                                      _calendarFormat,
                                                                  calendarStyle:
                                                                      const CalendarStyle(
                                                                    // Use `CalendarStyle` to customize the UI
                                                                    outsideDaysVisible:
                                                                        false,
                                                                  ),
                                                                  onFormatChanged:
                                                                      (format) {
                                                                    if (_calendarFormat !=
                                                                        format) {
                                                                      setState(
                                                                          () {
                                                                        _calendarFormat =
                                                                            format;
                                                                      });
                                                                    }
                                                                  },
                                                                  selectedDayPredicate:
                                                                      (day) {
                                                                    return isSameDay(
                                                                        _selectedDay,
                                                                        day);
                                                                  },
                                                                  onDaySelected:
                                                                      (selectedDay,
                                                                          focusedDay) {
                                                                    // if (!isSameDay(
                                                                    //     _selectedDay,
                                                                    //     selectedDay)) {
                                                                    setState(
                                                                        () {
                                                                      // mDayeventsList
                                                                      //     .clear();
                                                                      mStartTime
                                                                          .clear();
                                                                      mEndTime
                                                                          .clear();
                                                                      mStatus
                                                                          .clear();
                                                                      mSelectDate
                                                                          .clear();
                                                                      for (var i =
                                                                              0;
                                                                          i < mBookAnExpertList[0].booking!.length;
                                                                          i++) {
                                                                        if (mBookAnExpertList[0].booking![i].date! ==
                                                                                DateFormat("dd-MM-yyyy").format(selectedDay) &&
                                                                            !mBookAnExpertList[0].booking![i].status!) {
                                                                          mStartTime.add(mBookAnExpertList[0]
                                                                              .booking![i]
                                                                              .startTime!);
                                                                          mEndTime.add(mBookAnExpertList[0]
                                                                              .booking![i]
                                                                              .endTime!);
                                                                          mStatus.add(mBookAnExpertList[0]
                                                                              .booking![i]
                                                                              .status!);

                                                                          mSelectDate.add(mBookAnExpertList[0]
                                                                              .booking![i]
                                                                              .date!);
                                                                        }
                                                                      }

                                                                      // print(
                                                                      //     mDayeventsList);
                                                                      _selectedDay =
                                                                          selectedDay;
                                                                      _focusedDay =
                                                                          focusedDay;
                                                                    });
                                                                    //}
                                                                  },
                                                                  onPageChanged:
                                                                      (focusedDay) {
                                                                    _focusedDay =
                                                                        focusedDay;
                                                                  },
                                                                ),
                                                                const SizedBox(
                                                                    height: 15),
                                                                Expanded(
                                                                  child:
                                                                      SingleChildScrollView(
                                                                          child:
                                                                              GridView.count(
                                                                    crossAxisCount:
                                                                        2,
                                                                    crossAxisSpacing:
                                                                        0,
                                                                    mainAxisSpacing:
                                                                        0,
                                                                    childAspectRatio:
                                                                        (1 /
                                                                            .4),
                                                                    shrinkWrap:
                                                                        true,
                                                                    children: List
                                                                        .generate(
                                                                      mStartTime
                                                                          .length,
                                                                      (index) {
                                                                        final mStartTimeList =
                                                                            mStartTime[index];
                                                                        final mEndTimeList =
                                                                            mEndTime[index];
                                                                        final mStatusList =
                                                                            mStatus[index];

                                                                        return Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Container(
                                                                                decoration: BoxDecoration(
                                                                                    borderRadius: BorderRadius.circular(5),
                                                                                    color: Colors.white,
                                                                                    border: Border.all(
                                                                                      color: kGray,
                                                                                      width: 1,
                                                                                    )),
                                                                                padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                                                                margin: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                                                                                child: ListTile(
                                                                                    title: Text("${changeTimeFormat1(mStartTimeList ?? "")} - ${changeTimeFormat1(mEndTimeList ?? "")}", textAlign: TextAlign.center, style: const TextStyle(fontFamily: 'ManropeRegular', fontSize: 14, color: mBlackColor)),
                                                                                    onTap: () {
                                                                                      Loading(mLoaderGif).start(context);
                                                                                      expertname = mBookAnExpertList[0].expertName ?? "";
                                                                                      servicedate = mSelectDate[index];
                                                                                      starttime = changeTimeFormat2(mStartTimeList);
                                                                                      endtime = changeTimeFormat2(mEndTimeList);
                                                                                      bookingid = widget.mExpertid;
                                                                                      bookingamount = mBookAnExpertList[0].price ?? 0;

                                                                                      openCheckout(mBookAnExpertList[0].price);
                                                                                    }))
                                                                          ],
                                                                        );

                                                                        /*BookingView(
                                                                            mStartTime:
                                                                                mStartTimeList,
                                                                            mEndTime:
                                                                                mEndTimeList,
                                                                            mStatus:
                                                                                mStatusList);*/
                                                                      },
                                                                    ),
                                                                  )),

                                                                  /*ListView
                                                                        .builder(
                                                                  scrollDirection:
                                                                      Axis.vertical,
                                                                  iuyi
                                                                  itemBuilder:
                                                                      ((context,
                                                                          index) {
                                                                    final mActivites =
                                                                        mDayeventsList![
                                                                            index];
                                                                    return Container(
                                                                      margin: const EdgeInsets
                                                                          .symmetric(
                                                                        horizontal:
                                                                            12.0,
                                                                        vertical:
                                                                            4.0,
                                                                      ),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        border:
                                                                            Border.all(),
                                                                        borderRadius:
                                                                            BorderRadius.circular(12.0),
                                                                      ),
                                                                      child:
                                                                          ListTile(
                                                                        title: Text(
                                                                            '${mDayeventsList[index]}'),
                                                                      ),
                                                                    );
                                                                    ;
                                                                  }),
                                                                  itemCount:
                                                                      mDayeventsList
                                                                          .length,
                                                                )*/
                                                                ),
                                                                const SizedBox(
                                                                    height: 50),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ],
                                      ))))
                            ],
                          ),
                          Container(),
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

  void openCheckout(int? pricing) async {
    var mTotalPrice = (pricing ?? 0) * 100;
    var options = {
      'key': mRazorpayTestKey,
      'amount': mTotalPrice,
      'name': mRazorpayName,
      'description': 'Expert Booking',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      // 'external': {
      //   'wallets': ['paytm']
      // }
    };

    try {
      _razorpay.open(options);
      Loading.stop();
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Fluttertoast.showToast(
    //     msg: "SUCCESS: ${response.paymentId!}",
    //     toastLength: Toast.LENGTH_SHORT);
    //Loading.stop();

    Loading(mLoaderGif).start(context);

    apiService
        .mExpertBookingpayment(expertname, servicedate, starttime, endtime,
            bookingid, userId, response.paymentId!, bookingamount.toString())
        .then((value) async {
      print(value);

      if (value is ApiSuccess) {
        Loading.stop();
        if (CommonResponse.fromJson(value.data)!.message!.status ?? false) {
          Navigator.pushReplacementNamed(context, dashboardRoute);
        } else {
          ErrorToast(
              context: context,
              text:
                  CommonResponse.fromJson(value.data)!.message!.message ?? "");
        }
      } else if (value is ApiFailure) {
        Loading.stop();
      }
    });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Fluttertoast.showToast(
    //     msg: "ERROR: ${response.code} - ${response.message!}",
    //     toastLength: Toast.LENGTH_SHORT);
    Loading.stop();
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Fluttertoast.showToast(
    //     msg: "EXTERNAL_WALLET: ${response.walletName!}",
    //     toastLength: Toast.LENGTH_SHORT);
    Loading.stop();
  }
}

// class AddEvent {
//   String mStartTime;
//   String mEndTime;
//   Bool mStatus;
//
//   String get StartTime {
//     return mStartTime;
//   }
//
//   set StartTime(String name) {
//     mStartTime = name;
//   }
// }
