import 'dart:convert';
import 'dart:developer';

import 'package:custom_gif_loading/custom_gif_loading.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' show Client;
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Model/CommonResponse.dart';
import 'package:startinsights/Model/PitchroomlistResponse.dart';
import 'package:startinsights/Network/api_result_handler.dart';
import 'package:startinsights/Repository/pitchroom_repository.dart';
import 'package:startinsights/Screen/PitchRoom/bloc/pitchroom_bloc.dart';
import 'package:startinsights/Screen/PitchRoom/bloc/pitchroom_state.dart';
import 'package:startinsights/Screen/PitchRoom/web/docview.dart';
import 'package:startinsights/Screen/PitchRoom/web/newpichroomItem.dart';
import 'package:startinsights/Utils/FontSizes.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Utils/constant_methods.dart';
import 'package:startinsights/Utils/mandatoryText.dart';
import 'package:startinsights/Utils/screens.dart';
import 'package:startinsights/Utils/utils.dart';
import 'package:startinsights/Widgets/Appbarnew.dart';
import 'package:startinsights/Widgets/auth_form_field.dart';
import 'package:startinsights/Widgets/button.dart';
import 'package:startinsights/Widgets/deletebutton.dart';
import 'package:startinsights/Widgets/primary_button.dart';
import 'package:startinsights/Widgets/sidemenunew.dart';
import 'package:table_calendar/table_calendar.dart';

class NewPitchRoom extends StatefulWidget {
  NewPitchRoom({super.key});

  @override
  State<NewPitchRoom> createState() => _NewPitchRoomState();
}

class _NewPitchRoomState extends State<NewPitchRoom> {
  @override
  late PitchroomBloc mPitchroomBloc;
  bool checkedValue = false;
  List<PitchRoomDetail> mPitchroomList = [];
  String mUserImage = "";
  final TextEditingController mRoomnameController = TextEditingController();
  final TextEditingController mAboutStartupController = TextEditingController();
  final TextEditingController mUpdateAboutStartupController =
      TextEditingController();
  final TextEditingController mmShortDescriptionController =
      TextEditingController();
  final TextEditingController CompanynameController = TextEditingController();
  final TextEditingController PitchroomController = TextEditingController();
  final TextEditingController mNotesController = TextEditingController();
  late PlatformFile objFile;
  List<PlatformFile>? _paths;

  String mGetCoverImage = "";

  Client client = Client();

  String mCoverImage = "", CoverImageExt = "", CoverImageName = "";

  String mPitchdeck = "", mProjections = "", mExecutivesummary = "";
  String mPitchdeckExt = "", mProjectionsExt = "", mExecutivesummaryExt = "";
  String mPitchdeckFileName = "",
      mProjectionsFileName = "",
      mExecutivesummaryFileName = "";
  String mSelectPeople = "";
  List<UploadFiles> mUploadFiles = [];

  final PitchroomRepository _apiService1 = PitchroomRepository();
  List<String> mUserList = [];
  int _selected = -1;

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  // 1-> Capatable , 2-> Pitchroom , 3 ->  ->
  int mSelectView = 1;

  ValueNotifier<bool> setnotifier = ValueNotifier(true);

  //Cover Image
  String selectedFile = '';
  Uint8List? image;
  String mCaptureUserImage = "";

  bool mReload = false;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  @override
  void dispose() {
    super.dispose();
    mRoomnameController.dispose();
    mAboutStartupController.dispose();
    mUpdateAboutStartupController.dispose();
    mmShortDescriptionController.dispose();
    CompanynameController.dispose();
    PitchroomController.dispose();
    mNotesController.dispose();
  }

  Widget build(BuildContext context) {
    mPitchroomBloc = PitchroomBloc(mContext: context);

    var _crossAxisSpacing = 8;
    var _screenWidth = MediaQuery.of(context).size.width;
    var _crossAxisCount = 2;
    var _width = (_screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    var cellHeight = 650;
    var _aspectRatio = _width / cellHeight;

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
          body: BlocConsumer<PitchroomBloc, PitchroomStatus>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is GetPitchroomInfoSuccessState) {
                if (!mReload) {
                  mPitchroomList = state.mPitchRoomDetail;
                }

                mReload = false;

                return SafeArea(
                    child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                      image: const DecorationImage(
                        image: AssetImage("assets/new_ic_background.png"),
                        fit: BoxFit.fill,
                      )),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SideMenuNew(
                          mFrom: 5,
                          context: context,
                          mchange: (value) {
                            print(value);
                            setnotifier.value = value;
                          },
                        ),
                        //invisibleSubMenus(),
                        ValueListenableBuilder(
                          valueListenable: setnotifier,
                          builder: (context, value, child) => Container(
                            width: value
                                ? MediaQuery.of(context).size.width * 0.78
                                : MediaQuery.of(context).size.width * 0.906,
                            margin: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AppbarNew(
                                  mText: "TExt",
                                  mUserImage: "",
                                  mFrom: 5,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                    child: Column(
                                  children: [
                                    Container(
                                      height: 60,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white,
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.white,
                                            blurRadius: 1.0,
                                          ),
                                        ],
                                      ),
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  const SizedBox(
                                                    width: 30,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      Languages.of(context)!
                                                          .mLearntoRaise,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                          fontFamily:
                                                              'OpenSauceSansSemiBold',
                                                          fontSize: mSizeFive,
                                                          color: mBlackOne),
                                                    ),
                                                  )
                                                ]),
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                              child: Row(
                                                //ROW 1
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  const SizedBox(
                                                    width: 30,
                                                  ),
                                                  Container(
                                                      width: 400,
                                                      height: 45,
                                                      padding: const EdgeInsets
                                                          .fromLTRB(5, 5, 5, 5),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        color: mS1GreenThree,
                                                        boxShadow: const [
                                                          BoxShadow(
                                                            color:
                                                                mS1GreenThree,
                                                            blurRadius: 1.0,
                                                          ),
                                                        ],
                                                      ),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Expanded(
                                                            flex: 5,
                                                            child: InkWell(
                                                                onTap: () {
                                                                  setState(() {
                                                                    mReload =
                                                                        true;
                                                                    mSelectView =
                                                                        1;
                                                                  });
                                                                },
                                                                child:
                                                                    Container(
                                                                  decoration: (mSelectView ==
                                                                              1 ||
                                                                          mSelectView ==
                                                                              4)
                                                                      ? BoxDecoration(
                                                                          gradient:
                                                                              const LinearGradient(
                                                                            colors: [
                                                                              mgradientThree,
                                                                              mgradientFour
                                                                            ],
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(30),
                                                                        )
                                                                      : null,
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          5),
                                                                  child: Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child: Text(
                                                                          Languages.of(context)!
                                                                              .mPitchRoom,
                                                                          textAlign: TextAlign
                                                                              .center,
                                                                          style: TextStyle(
                                                                              fontFamily: 'OpenSauceSansMedium',
                                                                              fontSize: mSizeThree,
                                                                              color: (mSelectView == 1 || mSelectView == 4 ? Colors.white : mS1GreenNine)))),
                                                                )),
                                                          ),
                                                          const SizedBox(
                                                            width: 20,
                                                          ),
                                                          Expanded(
                                                            flex: 5,
                                                            child: InkWell(
                                                                onTap: () {
                                                                  setState(() {
                                                                    mSelectView =
                                                                        2;
                                                                  });
                                                                },
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      mSelectView ==
                                                                              2
                                                                          ? BoxDecoration(
                                                                              gradient: const LinearGradient(
                                                                                colors: [
                                                                                  mgradientThree,
                                                                                  mgradientFour
                                                                                ],
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(30),
                                                                            )
                                                                          : null,
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          5),
                                                                  child: Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child: Text(
                                                                          Languages.of(context)!
                                                                              .mCaptable,
                                                                          textAlign: TextAlign
                                                                              .center,
                                                                          style: TextStyle(
                                                                              fontFamily: 'OpenSauceSansMedium',
                                                                              fontSize: mSizeThree,
                                                                              color: (mSelectView == 2 ? Colors.white : mS1GreenNine)))),
                                                                )),
                                                          )
                                                        ],
                                                      )),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                                const SizedBox(
                                  height: 20,
                                ),
                                Visibility(
                                    visible: mSelectView == 1 ? true : false,
                                    child: Expanded(
                                      child: SingleChildScrollView(
                                        child: Container(
                                            child: Column(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.white,
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Colors.white,
                                                    blurRadius: 1.0,
                                                  ),
                                                ],
                                              ),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
                                                          30, 10, 10, 10),
                                                      child: RichText(
                                                        text: TextSpan(
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                                text: Languages.of(
                                                                        context)!
                                                                    .mtoolsLink,
                                                                style: const TextStyle(
                                                                    fontFamily:
                                                                        'OpenSauceSansMedium',
                                                                    fontSize:
                                                                        mSizeThree,
                                                                    color:
                                                                        mGreyTen)),
                                                            TextSpan(
                                                                text: Languages.of(
                                                                        context)!
                                                                    .mPitchRoom,
                                                                style: const TextStyle(
                                                                    fontFamily:
                                                                        'OpenSauceSansBold',
                                                                    fontSize:
                                                                        mSizeThree,
                                                                    color:
                                                                        mGreyTen)),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    Container(
                                                      height: 65,
                                                      margin: const EdgeInsets
                                                          .fromLTRB(
                                                          30, 0, 30, 0),
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
                                                          30, 10, 10, 10),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        color: mGreenTwo,
                                                        boxShadow: const [
                                                          BoxShadow(
                                                            color: mGreenTwo,
                                                            blurRadius: 1.0,
                                                          ),
                                                        ],
                                                      ),
                                                      child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            SizedBox(
                                                              width: 40,
                                                            ),
                                                            Expanded(
                                                                flex: 8,
                                                                child: Text(
                                                                    "“Start Insights motivational Quotes - Text area”",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: const TextStyle(
                                                                        fontFamily:
                                                                            'OpenSauceSansSemiBold',
                                                                        fontSize:
                                                                            mSizeFour,
                                                                        color:
                                                                            mGreyNine))),
                                                            Expanded(
                                                              flex: 2,
                                                              child: Button(
                                                                  mButtonname:
                                                                      Languages.of(
                                                                              context)!
                                                                          .mHireourteam,
                                                                  onpressed:
                                                                      () {},
                                                                  mSelectcolor:
                                                                      mBtnColor,
                                                                  mTextColor:
                                                                      mWhiteColor,
                                                                  mFontSize: 16,
                                                                  mWidth: 150,
                                                                  mHovercolor:
                                                                      mGreenTwo,
                                                                  mHeigth: 40),
                                                            )
                                                          ]),
                                                    ),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    Container(
                                                      color: mGreyThree,
                                                      height: 1,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Column(
                                                      children: [
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .fromLTRB(30,
                                                                  10, 50, 10),
                                                          child:
                                                              SingleChildScrollView(
                                                                  child: GridView
                                                                      .count(
                                                            crossAxisCount: 3,
                                                            crossAxisSpacing: 5,
                                                            // childAspectRatio: 0.3,
                                                            childAspectRatio:
                                                                _aspectRatio,

                                                            mainAxisSpacing: 5,
                                                            shrinkWrap: true,
                                                            children:
                                                                List.generate(
                                                              mPitchroomList
                                                                  .length,
                                                              (index) {
                                                                final mPitchRoom =
                                                                    mPitchroomList[
                                                                        index];

                                                                return InkWell(
                                                                  onTap: () {},
                                                                  child:
                                                                      NewPitchRoomItem(
                                                                    mPitchRoomDetail:
                                                                        mPitchRoom,
                                                                    mPitchroomBloc:
                                                                        mPitchroomBloc,
                                                                    context:
                                                                        context,
                                                                    mIndex:
                                                                        index,
                                                                    onPressed:
                                                                        () {
                                                                      if (index ==
                                                                          0) {
                                                                        OnCreateRoomDialog(
                                                                            setState);
                                                                      } else {
                                                                        OnLoadDialog(
                                                                            mPitchroomList[index]);
                                                                      }
                                                                    },
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          )),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                  ]),
                                            ),
                                          ],
                                        )), //
                                      ),
                                    )),
                                Visibility(
                                    visible: mSelectView == 2 ? true : false,
                                    child: Expanded(
                                      child: SingleChildScrollView(
                                        child: Container(
                                            child: Column(
                                          children: [],
                                        )), //
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        )
                      ]),
                ));
              }

              //  ErrorToast(context: context, text: state.mDashboard.message!);

              //} else if (state is GetPunchInOutFailState) {}
              return Container();
            },
          )),
    );
  }

  void OnLoadViewPitchRoom(PitchRoomDetail mPitchroomList) {
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
                child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context)
                        .copyWith(scrollbars: false),
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
                                    mPitchroomList.roomName ?? "",
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
                        ],
                      ),
                    ))),
              ),
            );
          },
        );
      },
    );
  }

  void pickFiles(
      int mFrom, StateSetter setState1, BuildContext context1) async {
    try {
      // Loading(mLoaderGif).start(context1);
      _paths = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: true,

        onFileLoading: (FilePickerStatus status) => print(status),
        // allowedExtensions: ['png', 'jpg', 'jpeg', 'heic'],
        allowedExtensions: ['pdf', 'docx', 'doc', 'xlsx'],
      ))
          ?.files;
    } on PlatformException catch (e) {
      log('Unsupported operation' + e.toString());
      // Loading.stop();
    } catch (e) {
      log(e.toString());
      //Loading.stop();
    }
    //Loading.stop();
    // setState1((){});
    setState1(() {
      if (_paths != null) {
        if (_paths != null) {
          //passing file bytes and file name for API call

          for (int i = 0; i < _paths!.length; i++) {
            print(_paths![i].extension);

            UploadFiles objUploadFiles = UploadFiles();

            // mPitchdeck = _paths![i];

            // PlatformFile file = _paths!.first;
            // String fileName = _paths!.first.files!.first.name;
            //   file = File(_paths!.files.single.path!);

            // objUploadFiles.attach = base64Encode(_paths![i].bytes!);
            objUploadFiles.attach = "";
            objUploadFiles.documenttype = _paths![i].extension!;
            objUploadFiles.name = _paths![i].name!;

            // Create file path
            //  final filePath = directory + "/"+_paths![i].name!+ "."+_paths![i].extension!;

            // '${directory}/ .extension'; // Change file_name and extension accordingly

            mUploadFiles.add(objUploadFiles);
          }

          Loading.stop();
          // ApiClient.uploadFile(_paths!.first.bytes!, _paths!.first.name);
        }
      }
    });
  }

  void OnLoadDialog(PitchRoomDetail mPitchroomList) {
    CompanynameController.text = mPitchroomList.companyName ?? "";
    mUpdateAboutStartupController.text = mPitchroomList.aboutStartup ?? "";
    PitchroomController.text = mPitchroomList.roomName ?? "";
    mNotesController.text = mPitchroomList.notes ?? "";
    mGetCoverImage = mPitchroomList.coverImage ?? "";
    showDialog(
      context: context,
      builder: (context2) {
        String contentText = "Content of Dialog";
        return StatefulBuilder(
          builder: (context1, setState) {
            return AlertDialog(
              contentPadding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
              //  title: Center(child: Text("Information")),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),

              content: SizedBox(
                width: MediaQuery.of(context1).size.width / 2,
                height: MediaQuery.of(context1).size.height - 10,
                child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context)
                        .copyWith(scrollbars: false),
                    child: SingleChildScrollView(
                        child: Container(
                      padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
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
                                  flex: 7,
                                  child: Text(
                                    mPitchroomList.roomName ?? "",
                                    style: const TextStyle(
                                        fontFamily: 'OpenSauceSansSemiBold',
                                        fontSize: mSizeFour,
                                        color: mGreyTen),
                                  )),
                              Expanded(
                                  flex: 3,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 150,
                                        height: 30,
                                        padding: const EdgeInsets.only(
                                            right: 20, left: 20),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: mgradientFsix,
                                          boxShadow: const [
                                            BoxShadow(
                                              color: mgradientFsix,
                                              blurRadius: 1.0,
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              'assets/new_ic_edit.svg',
                                              width: 20,
                                              height: 20,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              Languages.of(context)!.mEditRoom,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  fontFamily:
                                                      'OpenSauceSansRegular',
                                                  fontSize: mSizeThree,
                                                  color: mS1GreenNine),
                                            )
                                          ],
                                        )),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pop(context1);
                                          },
                                          child: SvgPicture.asset(
                                            'assets/new_ic_close.svg',
                                            width: 18,
                                            height: 18,
                                          ),
                                        ),
                                      )
                                    ],
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            color: mGreyThree,
                            height: 1,
                            width: MediaQuery.of(context).size.width,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          MandatoryText(
                              mText: Languages.of(context)!.mCompanyName),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: AuthFormField(
                              controller: CompanynameController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              hintText: Languages.of(context)!.mCompanyName,
                              radius: 30,
                              maxLength: 160,
                              labelText: Languages.of(context)!.mCompanyName,
                              mBorderView: false,
                              mImageView: true,
                              isMandatory: false,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  flex: 5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      MandatoryText(
                                          mText: Languages.of(context)!
                                              .mPitchRoomName),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        child: AuthFormField(
                                          controller: PitchroomController,
                                          textInputAction: TextInputAction.next,
                                          keyboardType: TextInputType.text,
                                          hintText: Languages.of(context)!
                                              .mPitchRoomName,
                                          radius: 30,
                                          maxLength: 160,
                                          labelText: Languages.of(context)!
                                              .mPitchRoomName,
                                          mBorderView: false,
                                          mImageView: true,
                                          isMandatory: false,
                                        ),
                                      ),
                                    ],
                                  )),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                  flex: 5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      MandatoryText(
                                          mText: Languages.of(context)!
                                              .mCoverImage),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        height: 40,
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        alignment: Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                          color: mLightColorOne,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              width: 1, color: mGreyFour),
                                        ),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                  flex: 9,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        child:
                                                            ((mGetCoverImage ??
                                                                        "")
                                                                    .isNotEmpty)
                                                                ? Container(
                                                                    height: 30,
                                                                    width: 30,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      image:
                                                                          DecorationImage(
                                                                        image: NetworkImage(
                                                                            mGetCoverImage),
                                                                        //whatever image you can put here
                                                                        fit: BoxFit
                                                                            .fill,
                                                                      ),
                                                                    ),
                                                                  )
                                                                : SvgPicture
                                                                    .asset(
                                                                    'assets/new_ic_watermarkbg.svg',
                                                                    height: 30,
                                                                    width: 30,
                                                                  ),
                                                      ),
                                                      const SizedBox(
                                                        width: 15,
                                                      ),
                                                      Text(
                                                        mGetCoverImage.length >
                                                                30
                                                            ? '${mGetCoverImage.substring(0, 30)}...'
                                                            : mGetCoverImage,
                                                        textAlign:
                                                            TextAlign.center,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                'OpenSauceSansRegular',
                                                            fontSize:
                                                                mSizeThree,
                                                            color: mBlackTwo),
                                                      )
                                                    ],
                                                  )),
                                              Expanded(
                                                  flex: 1,
                                                  child: SvgPicture.asset(
                                                    'assets/new_ic_close.svg',
                                                    height: 15,
                                                    width: 15,
                                                    color: mBlackTwo,
                                                  ))
                                            ]),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          MandatoryText(
                              mText: Languages.of(context)!.mAboutStartup),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: AuthFormField(
                              controller: mUpdateAboutStartupController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              hintText: Languages.of(context)!.mAboutStartup,
                              radius: 30,
                              maxLength: 3000,
                              maxLines: 5,
                              labelText: Languages.of(context)!.mAboutStartup,
                              mBorderView: false,
                              mImageView: true,
                              isMandatory: false,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            color: mGreyThree,
                            height: 1,
                            width: MediaQuery.of(context).size.width,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: AuthFormField(
                                controller: mNotesController,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.text,
                                hintText: Languages.of(context)!.mNotes,
                                radius: 30,
                                maxLength: 3000,
                                maxLines: 5,
                                labelText: Languages.of(context)!.mNotes,
                                mBorderView: false,
                                mImageView: true,
                                isMandatory: false,
                                viewbgColor: mYellowTwo,
                                borderColor: mYellowFive),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (mUploadFiles.isNotEmpty) {
                              } else {
                                Loading(mLoaderGif).start(context);
                                pickFiles(3, setState, context1);
                              }
                            },
                            child: Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: mGreyTwo,
                                border: Border.all(color: mGreyEigth, width: 1),
                              ),
                              child: (mUploadFiles.isNotEmpty)
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                          Container(
                                            height: 190,
                                            padding: EdgeInsets.all(10),
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: ((context, index) {
                                                final mLessonsList =
                                                    mUploadFiles[index];
                                                return DocView(
                                                  mUploadFiles: mLessonsList,
                                                  mRemoveFile: () {
                                                    setState(
                                                      () {
                                                        mUploadFiles
                                                            .removeAt(index);
                                                      },
                                                    );
                                                  },
                                                  mViewFile: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            PDFView(
                                                                pdfData:
                                                                    _paths![0]
                                                                        .bytes!),
                                                      ),
                                                    );
                                                    //OpenFilex.open("");
                                                  },
                                                );
                                              }),
                                              itemCount: mUploadFiles.length,
                                            ),
                                          )
                                        ])
                                  : Text(""),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Visibility(
                              visible: (mUploadFiles.isNotEmpty) ? true : false,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Button(
                                    mButtonname:
                                        Languages.of(context)!.mAddMore,
                                    onpressed: () {
                                      Loading(mLoaderGif).start(context);
                                      pickFiles(3, setState, context1);
                                    },
                                    mSelectcolor: mBtnColor,
                                    mTextColor: mWhiteColor,
                                    mFontSize: 16,
                                    mWidth: 130,
                                    mHeigth: 35),
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            color: mGreyThree,
                            height: 1,
                            width: MediaQuery.of(context).size.width,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 7,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: DeleteButton(
                                        mButtonname:
                                            Languages.of(context)!.mDelete,
                                        onpressed: () {},
                                        mSelectcolor: mBtnColor,
                                        mTextColor: mWhiteColor,
                                        mFontSize: 16,
                                        mWidth: 150,
                                        mHeigth: 40)),
                              ),
                              Expanded(
                                flex: 3,
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Button(
                                        mButtonname:
                                            Languages.of(context)!.mSaveChanges,
                                        onpressed: () {
                                          if (CompanynameController
                                              .text.isEmpty) {
                                            ErrorToast(
                                                context: context,
                                                text: Languages.of(context)!
                                                    .mentercompanyname);
                                          } else if (PitchroomController
                                              .text.isEmpty) {
                                            ErrorToast(
                                                context: context,
                                                text: Languages.of(context)!
                                                    .mEnterCreateaRoom);
                                          } else if (mGetCoverImage.isEmpty) {
                                            ErrorToast(
                                                context: context,
                                                text: Languages.of(context)!
                                                    .mcoverimage);
                                          } else if (mUpdateAboutStartupController
                                              .text.isEmpty) {
                                            ErrorToast(
                                                context: context,
                                                text: Languages.of(context)!
                                                    .mEnterAboutStartup);
                                          } else if (mNotesController
                                              .text.isEmpty) {
                                            ErrorToast(
                                                context: context,
                                                text: Languages.of(context)!
                                                    .mEnterNotes);
                                          } else if (mUploadFiles.isEmpty) {
                                            ErrorToast(
                                                context: context,
                                                text: Languages.of(context)!
                                                    .mUploadFiles);
                                          } else {
                                            Loading(mLoaderGif).start(context);

                                            _apiService1.UpdateCreateRoom(
                                                    mPitchroomList.id ?? "",
                                                    mNotesController.text,
                                                    mUpdateAboutStartupController
                                                        .text,
                                                    CompanynameController.text,
                                                    PitchroomController.text,
                                                    mCaptureUserImage,
                                                    mUploadFiles)
                                                .then((value) async {
                                              print(value);

                                              if (value is ApiSuccess) {
                                                if (CommonResponse.fromJson(
                                                            value.data)!
                                                        .message!
                                                        .status ??
                                                    false) {
                                                  Loading.stop();

                                                  SucessToast(
                                                      context: context,
                                                      text: CommonResponse
                                                                  .fromJson(value
                                                                      .data)!
                                                              .message!
                                                              .message ??
                                                          "");

                                                  setState(
                                                    () {
                                                      GoRouter.of(context1)
                                                          .push('/Pitchroom');
                                                    },
                                                  );
                                                } else {
                                                  Loading.stop();
                                                  ErrorToast(
                                                      context: context,
                                                      text: CommonResponse
                                                                  .fromJson(value
                                                                      .data)!
                                                              .message!
                                                              .message ??
                                                          "");
                                                }
                                              } else if (value is ApiFailure) {
                                                Loading.stop();
                                              }
                                            });
                                          }
                                        },
                                        mSelectcolor: mBtnColor,
                                        mTextColor: mWhiteColor,
                                        mFontSize: 16,
                                        mWidth: 130,
                                        mHeigth: 40)),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ))),
              ),
            );
          },
        );
      },
    );
  }

  //Cover Image Picker View
  void selectFile(StateSetter setState) async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'png',
        'jpg',
        'jpeg',
      ],
    );

    if (result != null) {
      setState(() {
        selectedFile = result.files.first.name;
      });

      image = result.files.first.bytes;

      mCaptureUserImage = base64Encode(image!);
      mCaptureUserImage = base64Encode(image!);
    }
  }

  void OnCreateRoomDialog(void Function(VoidCallback fn) getsetState) {
    showDialog(
      context: context,
      builder: (context2) {
        String contentText = "Content of Dialog";
        return StatefulBuilder(
          builder: (context1, setState) {
            return AlertDialog(
              contentPadding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
              //  title: Center(child: Text("Information")),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),

              content: SizedBox(
                width: MediaQuery.of(context1).size.width / 3,
                child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context)
                        .copyWith(scrollbars: false),
                    child: SingleChildScrollView(
                        child: Container(
                      padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
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
                                  flex: 7,
                                  child: Text(
                                    Languages.of(context)!.mCreateaPitchRoom,
                                    style: const TextStyle(
                                        fontFamily: 'OpenSauceSansSemiBold',
                                        fontSize: mSizeFour,
                                        color: mGreyTen),
                                  )),
                              Expanded(
                                  flex: 3,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pop(context1);
                                          },
                                          child: SvgPicture.asset(
                                            'assets/new_ic_close.svg',
                                            width: 18,
                                            height: 18,
                                          ),
                                        ),
                                      )
                                    ],
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              //Click Cover Image
                              selectFile(setState);
                            },
                            child: Container(
                                height: 250,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: mGreyTwo,
                                  border:
                                      Border.all(color: mGreyEigth, width: 1),
                                ),
                                child: (image != null)
                                    ? Image.memory(
                                        image!,
                                        fit: BoxFit.fill,
                                        width: 200,
                                        height: 200,
                                      )
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            'assets/new_ic_upload.svg',
                                            width: 120,
                                            height: 120,
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            Languages.of(context)!.mcoverimage,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                fontFamily:
                                                    'OpenSauceSansRegular',
                                                fontSize: mSizeTwo,
                                                color: mGreySeven,
                                                height: 1.5),
                                          ),
                                        ],
                                      )),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            color: mGreyThree,
                            height: 1,
                            width: MediaQuery.of(context).size.width,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          MandatoryText(
                              mText: Languages.of(context)!.mPitchRoomName),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: AuthFormField(
                              controller: mRoomnameController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              hintText: Languages.of(context)!.mPitchRoomName,
                              radius: 30,
                              maxLength: 200,
                              labelText: Languages.of(context)!.mPitchRoomName,
                              mBorderView: false,
                              mImageView: true,
                              isMandatory: false,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          MandatoryText(
                              mText: Languages.of(context)!.mAboutStartup),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: AuthFormField(
                              controller: mAboutStartupController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              hintText: Languages.of(context)!.mAboutStartup,
                              radius: 30,
                              maxLength: 3000,
                              maxLines: 5,
                              labelText: Languages.of(context)!.mAboutStartup,
                              mBorderView: false,
                              mImageView: true,
                              isMandatory: false,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            color: mGreyThree,
                            height: 1,
                            width: MediaQuery.of(context).size.width,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 7,
                                child: Text(""),
                              ),
                              Expanded(
                                flex: 3,
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Button(
                                        mButtonname:
                                            Languages.of(context)!.mCreateaRoom,
                                        onpressed: () {
                                          if (mCaptureUserImage.isEmpty) {
                                            ErrorToast(
                                                context: context,
                                                text: Languages.of(context)!
                                                    .mcoverimage);
                                          } else if (mRoomnameController
                                              .text.isEmpty) {
                                            ErrorToast(
                                                context: context,
                                                text: Languages.of(context)!
                                                    .menterroomname);
                                          } else if (mAboutStartupController
                                              .text.isEmpty) {
                                            ErrorToast(
                                                context: context,
                                                text: Languages.of(context)!
                                                    .mEnterAboutStartup);
                                          } else {
                                            Loading(mLoaderGif).start(context);

                                            _apiService1.CreateRoom(
                                              "jagadeesan.a1104@gmail.com",
                                              mRoomnameController.text,
                                              mAboutStartupController.text,
                                              mCaptureUserImage,
                                            ).then((value) async {
                                              print(value);

                                              if (value is ApiSuccess) {
                                                if (CommonResponse.fromJson(
                                                            value.data)!
                                                        .message!
                                                        .status ??
                                                    false) {
                                                  Loading.stop();

                                                  SucessToast(
                                                      context: context,
                                                      text: CommonResponse
                                                                  .fromJson(value
                                                                      .data)!
                                                              .message!
                                                              .message ??
                                                          "");

                                                  setState(
                                                    () {
                                                      GoRouter.of(context1)
                                                          .push('/Pitchroom');

                                                      /* _apiService1
                                                          .getPitchroomData(
                                                        "jagadeesan.a1104@gmail.com",
                                                      )
                                                          .then((value) async {
                                                        if (value
                                                            is ApiSuccess) {
                                                          Loading.stop();

                                                          if (PitchroomlistResponse
                                                                      .fromJson(
                                                                          value
                                                                              .data)!
                                                                  .message!
                                                                  .status ??
                                                              false) {
                                                            getsetState(
                                                              () {
                                                                mReload = true;

                                                                mPitchroomList =
                                                                    PitchroomlistResponse.fromJson(
                                                                            value.data)
                                                                        .message!
                                                                        .pitchRoomDetails!;
                                                                Navigator.pop(
                                                                    context1);
                                                              },
                                                            );
                                                          } else {}
                                                        } else if (value
                                                            is ApiFailure) {
                                                          Loading.stop();
                                                        }
                                                      });*/
                                                    },
                                                  );
                                                } else {
                                                  Loading.stop();
                                                  ErrorToast(
                                                      context: context,
                                                      text: CommonResponse
                                                                  .fromJson(value
                                                                      .data)!
                                                              .message!
                                                              .message ??
                                                          "");
                                                }
                                              } else if (value is ApiFailure) {
                                                Loading.stop();
                                              }
                                            });
                                          }
                                        },
                                        mSelectcolor: mBtnColor,
                                        mTextColor: mWhiteColor,
                                        mFontSize: 16,
                                        mWidth: 130,
                                        mHeigth: 40)),
                              )
                            ],
                          ),
                        ],
                      ),
                    ))),
              ),
            );
          },
        );
      },
    );
  }

//3->executivesummaryfiles, 2-> projectionsfiles, 1->pitchdeckfiles

  showAlertDialog(BuildContext context, String message) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("Ok",
          style: TextStyle(
              fontFamily: 'ManropeRegular', fontSize: 16, color: mBlackColor)),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text(
        message,
        style: const TextStyle(
            fontFamily: 'ManropeRegular', fontSize: 16, color: mBlackColor),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
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

  // void OnLoadList(void Function(VoidCallback fn) getsetState) {
  //   _apiService1
  //       .getPitchroomData(
  //     "jagadeesan.a1104@gmail.com",
  //   )
  //       .then((value) async {
  //     if (value is ApiSuccess) {
  //       Loading.stop();
  //
  //       if (PitchroomlistResponse.fromJson(value.data)!.message!.status ??
  //           false) {
  //         setState(
  //           () {
  //             mPitchroomList = PitchroomlistResponse.fromJson(value.data)
  //                 .message!
  //                 .pitchRoomDetails!;
  //
  //           },
  //         );
  //       } else {}
  //     } else if (value is ApiFailure) {
  //       Loading.stop();
  //     }
  //   });
  // }
}

class UploadFiles {
  // String? Image;
  // String? ImageExtension;

  String? documenttype;
  String? attach;
  String? name;

  UploadFiles({
    this.documenttype,
    this.attach,
    this.name,
  });

  factory UploadFiles.fromJson(Map<String, dynamic> json) => UploadFiles(
        documenttype: json["document_type"],
        attach: json["attach"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "document_type": documenttype,
        "attach": attach,
        "name": name,
      };
}
