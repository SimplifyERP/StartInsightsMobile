import 'dart:convert';
import 'dart:developer';

import 'package:custom_gif_loading/custom_gif_loading.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Model/CommonResponse.dart';
import 'package:startinsights/Model/GetuserswithroleResponse.dart';
import 'package:startinsights/Model/PitchroomlistResponse.dart';
import 'package:startinsights/Network/api_result_handler.dart';
import 'package:startinsights/Repository/pitchroom_repository.dart';
import 'package:startinsights/Screen/PitchRoom/bloc/pitchroom_bloc.dart';
import 'package:startinsights/Screen/PitchRoom/bloc/pitchroom_state.dart';
import 'package:startinsights/Screen/PitchRoom/web/pichroomItem.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Utils/constant_methods.dart';
import 'package:startinsights/Utils/mandatoryText.dart';
import 'package:startinsights/Utils/screens.dart';
import 'package:startinsights/Utils/utils.dart';
import 'package:startinsights/Widgets/Appbar.dart';
import 'package:startinsights/Widgets/auth_form_field.dart';
import 'package:startinsights/Widgets/primary_button.dart';
import 'package:startinsights/Widgets/sidemenu.dart';
import 'package:table_calendar/table_calendar.dart';

class PitchroomWeb extends StatefulWidget {
  PitchroomWeb({super.key});

  @override
  State<PitchroomWeb> createState() => _PitchroomState();
}

class _PitchroomState extends State<PitchroomWeb> {
  @override
  late PitchroomBloc mPitchroomBloc;
  bool checkedValue = false;
  List<PitchRoomDetail> mPitchroomList = [];
  String mUserImage = "";
  final TextEditingController mRoomnameController = TextEditingController();
  final TextEditingController mmShortDescriptionController =
      TextEditingController();
  late PlatformFile objFile;
  List<PlatformFile>? _paths;

  String mPitchdeck = "", mProjections = "", mExecutivesummary = "";
  String mPitchdeckExt = "", mProjectionsExt = "", mExecutivesummaryExt = "";
  String mPitchdeckFileName = "",
      mProjectionsFileName = "",
      mExecutivesummaryFileName = "";
  String mSelectPeople = "";

  final PitchroomRepository _apiService1 = PitchroomRepository();
  List<String> mUserList = [];
  int _selected = -1;

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  @override
  void dispose() {
    super.dispose();
    mRoomnameController.dispose();
    mmShortDescriptionController.dispose();
  }

  Widget build(BuildContext context) {
    mPitchroomBloc = PitchroomBloc(mContext: context);

    void OnLoadNext() {
      Navigator.pushReplacementNamed(context, dashboardRoute);
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
          appBar:
              Appbar(mText: "TExt", mUserImage: "", mFrom: 7, onPressed: () {}),
          body: BlocConsumer<PitchroomBloc, PitchroomStatus>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is GetPitchroomInfoSuccessState) {
                mPitchroomList = state.mPitchRoomDetail;

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
                                      child: SideMenu(mFrom: 9))),
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
                                                              .mPitchRoom,
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
                                            height: 40,
                                          ),
                                          SingleChildScrollView(
                                              child: GridView.count(
                                            crossAxisCount: 3,
                                            crossAxisSpacing: 0,
                                            mainAxisSpacing: 0,
                                            childAspectRatio: (1.2 / .9),
                                            shrinkWrap: true,
                                            children: List.generate(
                                              mPitchroomList.length,
                                              (index) {
                                                final mgetPitchroomList =
                                                    mPitchroomList[index];
                                                return PitchRoomItem(
                                                    mPitchRoomDetail:
                                                        mgetPitchroomList,
                                                    mPitchroomBloc:
                                                        mPitchroomBloc,
                                                    context: context);
                                              },
                                            ),
                                          )),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                4,
                                            height: 250,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.white,
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Colors.grey,
                                                    blurRadius: 1.0,
                                                  ),
                                                ]),
                                            margin: const EdgeInsets.fromLTRB(
                                                20, 1, 20, 1),
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                      'assets/ic_add.png',
                                                      width: 80,
                                                      height: 80,
                                                      fit: BoxFit.fill),
                                                  const SizedBox(
                                                    height: 40,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .end, // set your alignment
                                                    children: <Widget>[
                                                      Expanded(
                                                        flex:
                                                            10, // takes 30% of available width
                                                        child: Container(
                                                            height: 40,
                                                            margin:
                                                                const EdgeInsets
                                                                    .fromLTRB(
                                                                    20,
                                                                    5,
                                                                    20,
                                                                    5),
                                                            decoration:
                                                                BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    color:
                                                                        mBtnColor,
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color:
                                                                          mBtnColor,
                                                                      width: 1,
                                                                    )),
                                                            child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .fromLTRB(
                                                                        0,
                                                                        0,
                                                                        0,
                                                                        0),
                                                                child: InkWell(
                                                                  child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    child: PrimaryButton(
                                                                        mButtonname: Languages.of(context)!.mCreateNew,
                                                                        onpressed: () {
                                                                          OnLoadDialog();
                                                                        },
                                                                        mSelectcolor: mBtnColor,
                                                                        mTextColor: mWhiteColor,
                                                                        mFontSize: 16,
                                                                        mHeigth: 40),
                                                                  ),
                                                                ))),
                                                      ),
                                                    ],
                                                  )
                                                ]),
                                          ),
                                          const SizedBox(
                                            height: 60,
                                          ),
                                        ],
                                      )))),
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

  void OnLoadDialog() {
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
                                Languages.of(context)!.mCreateNewRoom,
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
                                  mText: Languages.of(context)!.mRoomName),
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
                                controller: mRoomnameController,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.text,
                                hintText: Languages.of(context)!.mEnterRoomName,
                                radius: 30,
                                maxLength: 80,
                                labelText:
                                    Languages.of(context)!.mEnterRoomName,
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
                                  mText: Languages.of(context)!.mDescription),
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
                                controller: mmShortDescriptionController,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.text,
                                hintText:
                                    Languages.of(context)!.mShortDescription,
                                radius: 30,
                                maxLength: 2000,
                                maxLines: 5,
                                labelText:
                                    Languages.of(context)!.mShortDescription,
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
                                      Languages.of(context)!.mUploadDocument),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    height: 150,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white,
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 1.0,
                                          ),
                                        ]),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              Languages.of(context)!
                                                  .mSelectpitchdeckfiles,
                                              style: const TextStyle(
                                                  fontFamily: 'ManropeSemiBold',
                                                  fontSize: 18,
                                                  color: mBlackColor)),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              Languages.of(context)!
                                                  .mValidformet,
                                              style: const TextStyle(
                                                  fontFamily: 'ManropeRegular',
                                                  fontSize: 14,
                                                  color: kColorOne)),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              pickFiles(1, setState, context1);
                                            }, // Handle your callback
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: 200,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: kColorTwo,
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      color: kColorTwo,
                                                      blurRadius: 1.0,
                                                    ),
                                                  ]),
                                              child: Text(
                                                  Languages.of(context)!
                                                      .mSelectFiles,
                                                  style: const TextStyle(
                                                      fontFamily:
                                                          'ManropeSemiBold',
                                                      fontSize: 16,
                                                      color: mBlackColor)),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              RichText(
                                                overflow: TextOverflow.ellipsis,
                                                text: TextSpan(
                                                    style: const TextStyle(
                                                        fontFamily:
                                                            'ManropeRegular',
                                                        fontSize: 14,
                                                        color:
                                                            kprogressbarpitchcraft),
                                                    text: (mPitchdeckFileName
                                                            .isEmpty)
                                                        ? ""
                                                        : mPitchdeckFileName),
                                              )
                                              /* Text(
                                                  (mPitchdeckFileName.isEmpty)
                                                      ? ""
                                                      : mPitchdeckFileName,
                                                  style: const TextStyle(
                                                      fontFamily:
                                                          'ManropeRegular',
                                                      fontSize: 14,
                                                      color: kColorOne))*/
                                              ,
                                              SizedBox(
                                                width: 10,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    mPitchdeck = "";
                                                    mPitchdeckExt = "";
                                                    mPitchdeckFileName = "";
                                                  });
                                                },
                                                child: Icon(Icons.delete_sharp,
                                                    size: (mPitchdeckFileName
                                                            .isEmpty)
                                                        ? 0
                                                        : 20,
                                                    color:
                                                        kprogressbarpitchcraft),
                                              )
                                            ],
                                          ),
                                        ]),
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    height: 150,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white,
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 1.0,
                                          ),
                                        ]),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              Languages.of(context)!
                                                  .mSelectprojectionsfiles,
                                              style: const TextStyle(
                                                  fontFamily: 'ManropeSemiBold',
                                                  fontSize: 18,
                                                  color: mBlackColor)),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              Languages.of(context)!
                                                  .mValidformet,
                                              style: const TextStyle(
                                                  fontFamily: 'ManropeRegular',
                                                  fontSize: 16,
                                                  color: kColorOne)),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              pickFiles(2, setState, context1);
                                            }, // Handle your callback
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: 200,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: kColorTwo,
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      color: kColorTwo,
                                                      blurRadius: 1.0,
                                                    ),
                                                  ]),
                                              child: Text(
                                                  Languages.of(context)!
                                                      .mSelectFiles,
                                                  style: const TextStyle(
                                                      fontFamily:
                                                          'ManropeSemiBold',
                                                      fontSize: 16,
                                                      color: mBlackColor)),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              RichText(
                                                overflow: TextOverflow.ellipsis,
                                                text: TextSpan(
                                                    style: const TextStyle(
                                                        fontFamily:
                                                            'ManropeRegular',
                                                        fontSize: 14,
                                                        color:
                                                            kprogressbarpitchcraft),
                                                    text: (mProjectionsFileName
                                                            .isEmpty)
                                                        ? ""
                                                        : mProjectionsFileName),
                                              )
                                              /*Text(
                                                  (mProjectionsFileName.isEmpty)
                                                      ? ""
                                                      : mProjectionsFileName,
                                                  style: const TextStyle(
                                                      fontFamily:
                                                          'ManropeRegular',
                                                      fontSize: 14,
                                                      color:
                                                          kprogressbarpitchcraft))*/
                                              ,
                                              SizedBox(
                                                width: 10,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    mProjectionsExt = "";
                                                    mProjectionsFileName = "";
                                                    mProjections = "";
                                                  });
                                                },
                                                child: Icon(Icons.delete_sharp,
                                                    size: (mProjectionsFileName
                                                            .isEmpty)
                                                        ? 0
                                                        : 20,
                                                    color:
                                                        kprogressbarpitchcraft),
                                              )
                                            ],
                                          ),
                                        ]),
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    height: 150,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white,
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 1.0,
                                          ),
                                        ]),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              Languages.of(context)!
                                                  .mSelectexecutivesummaryfiles,
                                              style: const TextStyle(
                                                  fontFamily: 'ManropeSemiBold',
                                                  fontSize: 18,
                                                  color: mBlackColor)),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              Languages.of(context)!
                                                  .mValidformet,
                                              style: const TextStyle(
                                                  fontFamily: 'ManropeRegular',
                                                  fontSize: 16,
                                                  color: kColorOne)),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              pickFiles(3, setState, context1);
                                            }, // Handle your callback
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: 200,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: kColorTwo,
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      color: kColorTwo,
                                                      blurRadius: 1.0,
                                                    ),
                                                  ]),
                                              child: Text(
                                                  Languages.of(context)!
                                                      .mSelectFiles,
                                                  style: const TextStyle(
                                                      fontFamily:
                                                          'ManropeSemiBold',
                                                      fontSize: 16,
                                                      color: mBlackColor)),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              RichText(
                                                overflow: TextOverflow.ellipsis,
                                                text: TextSpan(
                                                    style: const TextStyle(
                                                        fontFamily:
                                                            'ManropeRegular',
                                                        fontSize: 14,
                                                        color:
                                                            kprogressbarpitchcraft),
                                                    text: (mExecutivesummaryFileName
                                                            .isEmpty)
                                                        ? ""
                                                        : mExecutivesummaryFileName),
                                              )
                                              /* Text(
                                                  (mExecutivesummaryFileName
                                                          .isEmpty)
                                                      ? ""
                                                      : mExecutivesummaryFileName,
                                                  style: const TextStyle(
                                                      fontFamily:
                                                          'ManropeRegular',
                                                      fontSize: 14,
                                                      color: kColorOne))*/
                                              ,
                                              SizedBox(
                                                width: 10,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    mExecutivesummaryFileName =
                                                        "";
                                                    mExecutivesummaryExt = "";
                                                    mExecutivesummary = "";
                                                  });
                                                },
                                                child: Icon(Icons.delete_sharp,
                                                    size:
                                                        (mExecutivesummaryFileName
                                                                .isEmpty)
                                                            ? 0
                                                            : 20,
                                                    color:
                                                        kprogressbarpitchcraft),
                                              )
                                            ],
                                          ),
                                        ]),
                                  ),
                                ]),
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
                                  mText: Languages.of(context)!.mSharethisroom),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              height: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 1.0,
                                    ),
                                  ]),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        height: 40,
                                        width: 200,
                                        margin:
                                            EdgeInsets.fromLTRB(5, 5, 10, 5),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: mBtnColor,
                                            border: Border.all(
                                              color: mBtnColor,
                                              width: 1,
                                            )),
                                        child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 0),
                                            child: InkWell(
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: PrimaryButton(
                                                    mButtonname:
                                                        Languages.of(context)!
                                                            .mAddPeople,
                                                    onpressed: () {
                                                      if (mUserList.isEmpty) {
                                                        Loading(mLoaderGif)
                                                            .start(context1);

                                                        _apiService1
                                                            .getuserswithroleData(
                                                                "")
                                                            .then(
                                                                (value) async {
                                                          print(value);

                                                          if (value
                                                              is ApiSuccess) {
                                                            Loading.stop();
                                                            mUserList =
                                                                GetuserswithroleResponse
                                                                        .fromJson(
                                                                            value.data)!
                                                                    .message!;

                                                            OnLoadDialogUser(
                                                                mUserList,
                                                                context1,
                                                                setState);
                                                          } else if (value
                                                              is ApiFailure) {
                                                            Loading.stop();
                                                          }
                                                        });
                                                      } else {
                                                        OnLoadDialogUser(
                                                            mUserList,
                                                            context1,
                                                            setState);
                                                      }
                                                    },
                                                    mSelectcolor: mBtnColor,
                                                    mTextColor: mWhiteColor,
                                                    mFontSize: 16,
                                                    mHeigth: 40),
                                              ),
                                            ))),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        RichText(
                                          overflow: TextOverflow.ellipsis,
                                          text: TextSpan(
                                              style: const TextStyle(
                                                  fontFamily: 'ManropeRegular',
                                                  fontSize: 14,
                                                  color:
                                                      kprogressbarpitchcraft),
                                              text: (mSelectPeople.isEmpty)
                                                  ? ""
                                                  : mSelectPeople),
                                        )

                                        /*Text(
                                            (mSelectPeople.isEmpty)
                                                ? ""
                                                : mSelectPeople,
                                            style: const TextStyle(
                                                fontFamily: 'ManropeSemiBold',
                                                fontSize: 18,
                                                color: kprogressbarpitchcraft))*/
                                        ,
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              mSelectPeople = "";
                                            });
                                          },
                                          child: Icon(Icons.delete_sharp,
                                              size: (mSelectPeople.isEmpty)
                                                  ? 0
                                                  : 20,
                                              color: kprogressbarpitchcraft),
                                        )
                                      ],
                                    ),
                                  ]),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: MandatoryText(
                                  mText: Languages.of(context)!.mexpirydate),
                            ),
                            const SizedBox(height: 15),
                            TableCalendar(
                              firstDay: kFirstDay,
                              lastDay: kLastDay,
                              focusedDay: _focusedDay,
                              availableCalendarFormats: const {
                                CalendarFormat.month: 'Month'
                              },
                              startingDayOfWeek: StartingDayOfWeek.monday,
                              headerStyle:
                                  const HeaderStyle(titleCentered: true),
                              calendarFormat: _calendarFormat,
                              calendarStyle: const CalendarStyle(
                                // Use `CalendarStyle` to customize the UI
                                outsideDaysVisible: false,
                              ),
                              onFormatChanged: (format) {
                                if (_calendarFormat != format) {
                                  setState(() {
                                    _calendarFormat = format;
                                  });
                                }
                              },
                              selectedDayPredicate: (day) {
                                return isSameDay(_selectedDay, day);
                              },
                              onDaySelected: (selectedDay, focusedDay) {
                                // if (!isSameDay(
                                //     _selectedDay,
                                //     selectedDay)) {
                                setState(() {
                                  _selectedDay = selectedDay;
                                  _focusedDay = focusedDay;
                                });
                                //}
                              },
                              onPageChanged: (focusedDay) {
                                _focusedDay = focusedDay;
                              },
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment
                                  .center, // set your alignment
                              children: <Widget>[
                                Container(
                                    height: 40,
                                    width: 200,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: mBtnColor,
                                          width: 1,
                                        )),
                                    child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 0),
                                        child: InkWell(
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: PrimaryButton(
                                                mButtonname:
                                                    Languages.of(context)!
                                                        .mCancel,
                                                onpressed: () {
                                                  Navigator.pop(context1);
                                                },
                                                mSelectcolor: mWhiteColor,
                                                mTextColor: mBtnColor,
                                                mFontSize: 16,
                                                mHeigth: 40),
                                          ),
                                        ))),
                                const SizedBox(
                                  width: 30,
                                ),
                                Container(
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
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 0),
                                        child: InkWell(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: PrimaryButton(
                                                mButtonname:
                                                    Languages.of(context)!
                                                        .mSubmit,
                                                onpressed: () {
                                                  Loading(mLoaderGif)
                                                      .start(context1);

                                                  _apiService1.CreatePitchroom(
                                                          "",
                                                          mRoomnameController
                                                              .text,
                                                          mmShortDescriptionController
                                                              .text,
                                                          mSelectPeople,
                                                          mPitchdeck,
                                                          mPitchdeckExt,
                                                          mProjections,
                                                          mProjectionsExt,
                                                          mExecutivesummary,
                                                          mExecutivesummaryExt,
                                                          "21-02-2024")
                                                      .then((value) async {
                                                    print(value);

                                                    if (value is ApiSuccess) {
                                                      Loading.stop();

                                                      if (CommonResponse
                                                                  .fromJson(value
                                                                      .data)!
                                                              .message!
                                                              .status ??
                                                          false) {
                                                        Navigator.pop(context1);
                                                        ErrorToast(
                                                            context: context,
                                                            text: CommonResponse
                                                                        .fromJson(
                                                                            value.data)!
                                                                    .message!
                                                                    .message ??
                                                                "");
                                                      } else {
                                                        Navigator.pop(context1);
                                                        ErrorToast(
                                                            context: context,
                                                            text: CommonResponse
                                                                        .fromJson(
                                                                            value.data)!
                                                                    .message!
                                                                    .message ??
                                                                "");
                                                      }
                                                    } else if (value
                                                        is ApiFailure) {
                                                      Loading.stop();
                                                    }
                                                  });
                                                  // ErrorToast(
                                                  //     context: context,
                                                  //     text: "AAA");

                                                  /* if (mRoomnameController
                                                      .text.isEmpty) {
                                                    ErrorToast(
                                                        context: context2,
                                                        text: Languages.of(
                                                                context)!
                                                            .menterroomname);
                                                  } else if (mmShortDescriptionController
                                                      .text.isEmpty) {
                                                    ErrorToast(
                                                        context: context,
                                                        text: Languages.of(
                                                                context)!
                                                            .menterroomdescription);
                                                  } else if (mPitchdeck
                                                      .isEmpty) {
                                                    ErrorToast(
                                                        context: context,
                                                        text: Languages.of(
                                                                context)!
                                                            .mselectpitchdeckfile);
                                                  } else if (mProjections
                                                      .isEmpty) {
                                                    ErrorToast(
                                                        context: context,
                                                        text: Languages.of(
                                                                context)!
                                                            .mselectprojectionsfile);
                                                  } else if (mExecutivesummary
                                                      .isEmpty) {
                                                    ErrorToast(
                                                        context: context,
                                                        text: Languages.of(
                                                                context)!
                                                            .mselectexecutivesummaryfile);
                                                  } else if (mSelectPeople
                                                      .isEmpty) {
                                                    ErrorToast(
                                                        context: context,
                                                        text: Languages.of(
                                                                context)!
                                                            .maddpeoples);
                                                  }*/
                                                },
                                                mSelectcolor: mBtnColor,
                                                mTextColor: mWhiteColor,
                                                mFontSize: 16,
                                                mHeigth: 40),
                                          ),
                                        ))),
                              ],
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                          ])
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

//3->executivesummaryfiles, 2-> projectionsfiles, 1->pitchdeckfiles
  void pickFiles(
      int mFrom, StateSetter setState1, BuildContext context1) async {
    try {
      Loading(mLoaderGif).start(context1);
      _paths = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) => print(status),
        // allowedExtensions: ['png', 'jpg', 'jpeg', 'heic'],
        allowedExtensions: ['pdf', 'docx', 'doc', 'xlsx'],
      ))
          ?.files;
    } on PlatformException catch (e) {
      log('Unsupported operation' + e.toString());
    } catch (e) {
      log(e.toString());
    }

    // setState1((){});
    setState1(() {
      if (_paths != null) {
        if (_paths != null) {
          //passing file bytes and file name for API call
          var aa = _paths!.first.bytes!;
          var aaa = _paths!.first.bytes!;
          print(_paths!.first.extension);
          Uint8List _bytes = aaa;
          String _base64String = base64.encode(_bytes);
          // print(_base64String);

          if (mFrom == 1) {
            mPitchdeck = base64.encode(_bytes);
            mPitchdeckExt = _paths!.first.extension!;
            mPitchdeckFileName = _paths!.first.name!;
            mPitchdeckFileName = _paths!.first.name!;
          } else if (mFrom == 2) {
            mProjections = base64.encode(_bytes);
            mProjectionsExt = _paths!.first.extension!;
            mProjectionsFileName = _paths!.first.name!;
          } else if (mFrom == 3) {
            mExecutivesummary = base64.encode(_bytes);
            mExecutivesummaryExt = _paths!.first.extension!;
            mExecutivesummaryFileName = _paths!.first.name!;
          }
          Loading.stop();
          // ApiClient.uploadFile(_paths!.first.bytes!, _paths!.first.name);
        }
      }
    });
  }

  void OnLoadDialogUser(List<String> mUserList, BuildContext mGetcontext,
      StateSetter getsetState) {
    showDialog(
      context: context,
      builder: (context3) {
        String contentText = "Content of Dialog";
        return StatefulBuilder(
          builder: (context4, setState) {
            return AlertDialog(
              contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              //  title: Center(child: Text("Information")),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),

              content: SizedBox(
                width: MediaQuery.of(context4).size.width / 3,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: mUserList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return RadioListTile(
                                title: Text(mUserList[index],
                                    style: const TextStyle(
                                        fontFamily: 'ManropeSemiBold',
                                        fontSize: 16,
                                        color: mBlackColor)),
                                value: index,
                                groupValue: _selected,
                                onChanged: (value) {
                                  setState(() {
                                    _selected = index;
                                  });
                                });
                          }),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment:
                              CrossAxisAlignment.center, // set your alignment
                          children: <Widget>[
                            Container(
                                height: 40,
                                width: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
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
                                        alignment: Alignment.center,
                                        child: PrimaryButton(
                                            mButtonname:
                                                Languages.of(context)!.mCancel,
                                            onpressed: () {
                                              Navigator.pop(context4);
                                            },
                                            mSelectcolor: mBtnColor,
                                            mTextColor: mWhiteColor,
                                            mFontSize: 16,
                                            mHeigth: 40),
                                      ),
                                    ))),
                            const SizedBox(
                              width: 15,
                            ),
                            Container(
                                height: 40,
                                width: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
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
                                                Languages.of(context)!.mok,
                                            onpressed: () {
                                              Navigator.pop(context4);
                                              getsetState(
                                                () {
                                                  mSelectPeople =
                                                      mUserList[_selected];
                                                },
                                              );
                                            },
                                            mSelectcolor: mBtnColor,
                                            mTextColor: mWhiteColor,
                                            mFontSize: 16,
                                            mHeigth: 40),
                                      ),
                                    ))),
                            const SizedBox(
                              width: 15,
                            ),
                          ],
                        ),
                      )
                    ]),
              ),
            );
          },
        );
      },
    );
  }
}
