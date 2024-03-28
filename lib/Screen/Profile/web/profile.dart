import 'dart:convert';
import 'dart:typed_data';

import 'package:custom_gif_loading/custom_gif_loading.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_network/image_network.dart';
import 'package:image_picker/image_picker.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Model/LoginResponse.dart';
import 'package:startinsights/Network/api_result_handler.dart';
import 'package:startinsights/Network/di.dart';
import 'package:startinsights/Repository/profile_repo.dart';
import 'package:startinsights/Screen/Login/bloc/login_bloc.dart';
import 'package:startinsights/Screen/Profile/bloc/profile_bloc.dart';
import 'package:startinsights/Screen/Profile/bloc/profile_state.dart';
import 'package:startinsights/Utils/FontSizes.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Utils/StorageServiceConstant.dart';
import 'package:startinsights/Utils/constant_methods.dart';
import 'package:startinsights/Utils/pref_manager.dart';
import 'package:startinsights/Utils/screens.dart';
import 'package:startinsights/Utils/utils.dart';
import 'package:startinsights/Widgets/Appbarnew.dart';
import 'package:startinsights/Widgets/auth_form_field.dart';
import 'package:startinsights/Widgets/servicebutton.dart';
import 'package:startinsights/Widgets/sidemenunew.dart';

class Profile extends StatefulWidget {
  Profile({
    super.key,
  });

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  late ProfileBloc mProfileBloc;
  bool checkedValue = false;

  XFile? _file;
  XFile? Getfile;
  String mUserImage = "";

  final TextEditingController nameController = TextEditingController();
  final TextEditingController companynameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController linedINController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();

  final TextEditingController mPasswordController = TextEditingController();
  final TextEditingController mConfirmPasswordController =
      TextEditingController();

  bool CurrentpasswordVisible = false;
  bool passwordVisible = false;
  bool ConfirmpasswordVisible = false;

  Userinfo muserinfo = Userinfo();
  String mCaptureUserImage = "";

  String selectedFile = '';
  Uint8List? image;

  String mUserId = '';
  String mUserType = '';

  int mSelectView = 1;

  final ProfileRepo _apiService1 = ProfileRepo();
  ValueNotifier<bool> setnotifier = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    mLoadMasterData();
  }

  void mLoadMasterData() async {}

  @override
  void dispose() {
    //   _controller.dispose();

    super.dispose();
  }

  Widget build(BuildContext context) {
    mProfileBloc = ProfileBloc(mContext: context);

    void selectFile() async {
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

    void OnLoadNext() {
      Navigator.pushReplacementNamed(context, startupSchoolRoute);
    }

    final ScrollController controller = ScrollController();

    return WillPopScope(
      onWillPop: () {
        //trigger leaving and use own data

        OnLoadNext();
        //we need to return a future
        return Future.value(false);
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: BlocConsumer<ProfileBloc, ProfileStatus>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is GetProfileInfoSuccessState) {
                muserinfo = state.muserinfo;
                nameController.text = muserinfo.fullName ?? "";
                mobileController.text = muserinfo.phoneNo ?? "";
                linedINController.text = muserinfo.linkedin ?? "";
                websiteController.text = muserinfo.website ?? "";
                companynameController.text = muserinfo.companyName ?? "";
                // mDesignationController.text = muserinfo.designation ?? "";
                emailController.text = muserinfo.userEmail ?? "";

                mUserImage = muserinfo.profileImage ?? "";
                mUserId = muserinfo.userEmail ?? "";
                mUserType = muserinfo.role ?? "";

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
                          mFrom: 1,
                          context: context,
                          mchange: (value) {
                            print(value);
                            setnotifier.value = value;
                          },
                          isExpanded: true,
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
                                  mFrom: 1,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    // physics: NeverScrollableScrollPhysics(),
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height -
                                                100,
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
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 60,
                                                width: double.infinity,
                                                padding: const EdgeInsets.only(
                                                    left: 40),
                                                decoration: const BoxDecoration(
                                                  color: mGreyTwo,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  20),
                                                          topRight:
                                                              Radius.circular(
                                                                  20)),
                                                ),
                                                child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Material(
                                                      color: mGreyTwo,
                                                      child: Text(
                                                          Languages.of(context)!
                                                              .mUpdateAccountInformation,
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: const TextStyle(
                                                              fontFamily:
                                                                  'OpenSauceSansBold',
                                                              fontSize:
                                                                  mSizeFive,
                                                              color: mGreyTen)),
                                                    )),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    left: 40),
                                                child: Material(
                                                  color: Colors.white,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          InkWell(
                                                            hoverColor:
                                                                Colors.white,
                                                            onTap: () {
                                                              setState(() {
                                                                mSelectView = 1;
                                                              });
                                                            },
                                                            child: Container(
                                                              width: 150,
                                                              height: 40,
                                                              child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child: Text(
                                                                      Languages.of(
                                                                              context)!
                                                                          .mprofile,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'OpenSauceSansBold',
                                                                          fontSize:
                                                                              mSizeFour,
                                                                          color: (mSelectView == 1)
                                                                              ? mS1GreenNine
                                                                              : mBlackTwo))),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          InkWell(
                                                            hoverColor:
                                                                Colors.white,
                                                            onTap: () {
                                                              setState(() {
                                                                mSelectView = 2;
                                                              });
                                                            },
                                                            child: Container(
                                                              width: 200,
                                                              height: 40,
                                                              child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child: Text(
                                                                      Languages.of(
                                                                              context)!
                                                                          .mAccountSettings,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'OpenSauceSansBold',
                                                                          fontSize:
                                                                              mSizeFour,
                                                                          color: (mSelectView == 2)
                                                                              ? mS1GreenNine
                                                                              : mBlackTwo))),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            width: 150,
                                                            height: 2,
                                                            child: Container(
                                                              color: (mSelectView ==
                                                                      1)
                                                                  ? mS1GreenNine
                                                                  : Colors
                                                                      .transparent,
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                              height: 1,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          Container(
                                                            width: 200,
                                                            height: 2,
                                                            child: Container(
                                                              color: (mSelectView ==
                                                                      2)
                                                                  ? mS1GreenNine
                                                                  : Colors
                                                                      .transparent,
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                              height: 1,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      Material(
                                                        color: Colors.white,
                                                        child: Container(
                                                          color: mGreyFive,
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          height: 1,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Visibility(
                                                  visible: (mSelectView == 1)
                                                      ? true
                                                      : false,
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
                                                                .only(left: 40),
                                                        child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Expanded(
                                                                  flex: 6,
                                                                  child:
                                                                      Material(
                                                                    color: Colors
                                                                        .white,
                                                                    child: Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment
                                                                                .center,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Container(
                                                                            alignment:
                                                                                Alignment.center,
                                                                            child:
                                                                                AuthFormField(
                                                                              controller: nameController,
                                                                              textInputAction: TextInputAction.next,
                                                                              keyboardType: TextInputType.text,
                                                                              hintText: Languages.of(context)!.mName,
                                                                              radius: 30,
                                                                              maxLength: 80,
                                                                              labelText: Languages.of(context)!.mName,
                                                                              mBorderView: false,
                                                                              mImageView: true,
                                                                              isMandatory: true,
                                                                              mTop: 20,
                                                                              mBottom: 20,
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                            height:
                                                                                20,
                                                                          ),
                                                                          Container(
                                                                            alignment:
                                                                                Alignment.center,
                                                                            child:
                                                                                AuthFormField(
                                                                              controller: mobileController,
                                                                              textInputAction: TextInputAction.next,
                                                                              keyboardType: TextInputType.number,
                                                                              hintText: Languages.of(context)!.mMobile,
                                                                              radius: 30,
                                                                              maxLength: 10,
                                                                              labelText: Languages.of(context)!.mMobile,
                                                                              mBorderView: false,
                                                                              mImageView: true,
                                                                              isMandatory: true,
                                                                              mTop: 20,
                                                                              mBottom: 20,
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                            height:
                                                                                20,
                                                                          ),
                                                                          Container(
                                                                            alignment:
                                                                                Alignment.center,
                                                                            child:
                                                                                AuthFormField(
                                                                              controller: emailController,
                                                                              textInputAction: TextInputAction.next,
                                                                              keyboardType: TextInputType.text,
                                                                              hintText: Languages.of(context)!.mEmailAddress,
                                                                              radius: 30,
                                                                              maxLength: 150,
                                                                              labelText: Languages.of(context)!.mEmailAddress,
                                                                              mBorderView: false,
                                                                              mImageView: true,
                                                                              isMandatory: true,
                                                                              mTop: 20,
                                                                              mBottom: 20,
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                            height:
                                                                                20,
                                                                          ),
                                                                          Container(
                                                                            alignment:
                                                                                Alignment.center,
                                                                            child:
                                                                                AuthFormField(
                                                                              controller: companynameController,
                                                                              textInputAction: TextInputAction.next,
                                                                              keyboardType: TextInputType.text,
                                                                              hintText: Languages.of(context)!.mCompanyName,
                                                                              radius: 30,
                                                                              maxLength: 250,
                                                                              labelText: Languages.of(context)!.mCompanyName,
                                                                              mBorderView: false,
                                                                              mImageView: true,
                                                                              isMandatory: false,
                                                                              mTop: 20,
                                                                              mBottom: 20,
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                            height:
                                                                                15,
                                                                          ),
                                                                        ]),
                                                                  )),
                                                              const SizedBox(
                                                                width: 30,
                                                              ),
                                                              Expanded(
                                                                  flex: 4,
                                                                  child:
                                                                      Material(
                                                                    color: Colors
                                                                        .white,
                                                                    child: InkWell(
                                                                        hoverColor: Colors.transparent,
                                                                        onTap: () {
                                                                          setState(
                                                                            () {
                                                                              selectFile();
                                                                            },
                                                                          );
                                                                        },
                                                                        child: Center(
                                                                          child:
                                                                              Column(children: [
                                                                            (mUserImage.isNotEmpty)
                                                                                ? ImageNetwork(
                                                                                    image: mUserImage,
                                                                                    height: 200,
                                                                                    width: 200,
                                                                                  )
                                                                                : (image != null)
                                                                                    ? Image.memory(
                                                                                        image!,
                                                                                        fit: BoxFit.fill,
                                                                                        width: 200,
                                                                                        height: 200,
                                                                                      )
                                                                                    : Image.asset(
                                                                                        'assets/new_ic_profileupload.png',
                                                                                        height: 200,
                                                                                        width: 200,
                                                                                      ),
                                                                            const SizedBox(
                                                                              height: 20,
                                                                            ),
                                                                            Text(Languages.of(context)!.muploadprofile,
                                                                                textAlign: TextAlign.start,
                                                                                style: const TextStyle(fontFamily: 'OpenSauceSansRegular', fontSize: mSizeThree, color: mBlackTwo))
                                                                          ]),
                                                                        )),
                                                                  ))
                                                            ]),
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 40,
                                                                right: 20),
                                                        child: Material(
                                                            color: Colors.white,
                                                            child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      Languages.of(
                                                                              context)!
                                                                          .mSocialMediaLinks,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      style: const TextStyle(
                                                                          fontFamily:
                                                                              'OpenSauceSansSemiBold',
                                                                          fontSize:
                                                                              mSizeFour,
                                                                          color:
                                                                              mBlueOne)),
                                                                  const SizedBox(
                                                                    height: 15,
                                                                  ),
                                                                  Container(
                                                                    color:
                                                                        mGreyFive,
                                                                    width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                    height: 1,
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 20,
                                                                  ),
                                                                  Row(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Expanded(
                                                                          flex:
                                                                              5,
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            children: [
                                                                              Text(Languages.of(context)!.mlinkedinurl, textAlign: TextAlign.start, style: const TextStyle(fontFamily: 'OpenSauceSansRegular', fontSize: mSizeOne, color: mGreyEigth)),
                                                                              SizedBox(
                                                                                height: 20,
                                                                              ),
                                                                              Container(
                                                                                alignment: Alignment.center,
                                                                                child: AuthFormField(
                                                                                  controller: linedINController,
                                                                                  textInputAction: TextInputAction.next,
                                                                                  keyboardType: TextInputType.text,
                                                                                  hintText: Languages.of(context)!.mlinkedinurl,
                                                                                  radius: 30,
                                                                                  maxLength: 250,
                                                                                  labelText: Languages.of(context)!.mlinkedinurl,
                                                                                  mBorderView: false,
                                                                                  mImageView: true,
                                                                                  isMandatory: false,
                                                                                  mTop: 20,
                                                                                  mBottom: 20,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          )),
                                                                      SizedBox(
                                                                        width:
                                                                            20,
                                                                      ),
                                                                      Expanded(
                                                                          flex:
                                                                              5,
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            children: [
                                                                              Text(Languages.of(context)!.mwebsiteurl, textAlign: TextAlign.start, style: const TextStyle(fontFamily: 'OpenSauceSansRegular', fontSize: mSizeOne, color: mGreyEigth)),
                                                                              SizedBox(
                                                                                height: 20,
                                                                              ),
                                                                              Container(
                                                                                alignment: Alignment.center,
                                                                                child: AuthFormField(
                                                                                  controller: websiteController,
                                                                                  textInputAction: TextInputAction.next,
                                                                                  keyboardType: TextInputType.text,
                                                                                  hintText: Languages.of(context)!.mwebsiteurl,
                                                                                  radius: 30,
                                                                                  maxLength: 250,
                                                                                  labelText: Languages.of(context)!.mwebsiteurl,
                                                                                  mBorderView: false,
                                                                                  mImageView: true,
                                                                                  isMandatory: false,
                                                                                  mTop: 20,
                                                                                  mBottom: 20,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          )),
                                                                    ],
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 20,
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerRight,
                                                                    child: ServiceButton(
                                                                        mButtonname: Languages.of(context)!.mSaveProfile,
                                                                        onpressed: () {
                                                                          setState(
                                                                            () {
                                                                              if (nameController.text.isEmpty) {
                                                                                ErrorToast(context: context, text: Languages.of(context)!.mEnterName);
                                                                              } else if (mobileController.text.isEmpty) {
                                                                                ErrorToast(context: context, text: Languages.of(context)!.mEnterMobile);
                                                                              } else if (!isMobileNumberValid(mobileController.text)) {
                                                                                ErrorToast(context: context, text: "Not Valid  Mobile");
                                                                              } else if (emailController.text.isEmpty) {
                                                                                ErrorToast(context: context, text: Languages.of(context)!.mEmailAddresshint);
                                                                              } else if (!emailController.text.isValidEmail()) {
                                                                                ErrorToast(context: context, text: Languages.of(context)!.mVaildEmailAddresshint);
                                                                              } else if (companynameController.text.isEmpty) {
                                                                                ErrorToast(context: context, text: Languages.of(context)!.mentercompanyname);
                                                                              } else {
                                                                                Loading(mLoaderGif).start(context);

                                                                                _apiService1.ProfileUpdate(nameController.text, mobileController.text, emailController.text, "", companynameController.text, linedINController.text, websiteController.text, mCaptureUserImage, ""
                                                                                        //mUserDetails.password ??""
                                                                                        )
                                                                                    .then((value) async {
                                                                                  print(value);

                                                                                  if (value is ApiSuccess) {
                                                                                    if (LoginResponse.fromJson(value.data)!.message!.status ?? false) {
                                                                                      Loading.stop();
                                                                                      String mUserInfo = json.encode(value.data);

                                                                                      sl<StorageService>().setString(StorageServiceConstant.MUSERINFO, mUserInfo);
                                                                                      //GoRouter.of(context).go('/Dashboard');
                                                                                      SucessToast(context: context, text: "Profile Updated");
                                                                                    } else {
                                                                                      Loading.stop();
                                                                                      ErrorToast(context: context, text: LoginResponse.fromJson(value.data)!.message!.message ?? "");
                                                                                    }
                                                                                  } else if (value is ApiFailure) {
                                                                                    Loading.stop();
                                                                                  }
                                                                                });
                                                                              }
                                                                            },
                                                                          );
                                                                        },
                                                                        mTextColor: mWhiteColor,
                                                                        mFontSize: 16,
                                                                        mWidth: 130,
                                                                        mHeigth: 40,
                                                                        mhovercolor: Colors.white),
                                                                  )
                                                                ])),
                                                      )
                                                    ],
                                                  )),
                                              Visibility(
                                                  visible: (mSelectView == 2)
                                                      ? true
                                                      : false,
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            2,
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 40,
                                                            right: 20),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              3,
                                                          alignment:
                                                              Alignment.center,
                                                          child: AuthFormField(
                                                            controller:
                                                                mPasswordController,
                                                            textInputAction:
                                                                TextInputAction
                                                                    .next,
                                                            keyboardType:
                                                                TextInputType
                                                                    .text,
                                                            hintText: Languages
                                                                    .of(context)!
                                                                .mNewPassword,
                                                            radius: 30,
                                                            maxLength: 16,
                                                            labelText: Languages
                                                                    .of(context)!
                                                                .mNewPassword,
                                                            mBorderView: false,
                                                            mImageView: true,
                                                            isMandatory: true,
                                                            mTop: 20,
                                                            mBottom: 20,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 40,
                                                        ),
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              3,
                                                          alignment:
                                                              Alignment.center,
                                                          child: AuthFormField(
                                                            controller:
                                                                mConfirmPasswordController,
                                                            textInputAction:
                                                                TextInputAction
                                                                    .next,
                                                            keyboardType:
                                                                TextInputType
                                                                    .text,
                                                            hintText: Languages
                                                                    .of(context)!
                                                                .mConfirmPassword,
                                                            radius: 30,
                                                            maxLength: 16,
                                                            labelText: Languages
                                                                    .of(context)!
                                                                .mConfirmPassword,
                                                            mBorderView: false,
                                                            mImageView: true,
                                                            isMandatory: true,
                                                            mTop: 20,
                                                            mBottom: 20,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 40,
                                                        ),
                                                        ServiceButton(
                                                            mButtonname: Languages
                                                                    .of(
                                                                        context)!
                                                                .mResetPassword,
                                                            onpressed: () {
                                                              setState(
                                                                () {
                                                                  if (mPasswordController
                                                                      .text
                                                                      .isEmpty) {
                                                                    ErrorToast(
                                                                        context:
                                                                            context,
                                                                        text: Languages.of(context)!
                                                                            .mEnterPassword);
                                                                  } else if (mConfirmPasswordController
                                                                      .text
                                                                      .isEmpty) {
                                                                    ErrorToast(
                                                                        context:
                                                                            context,
                                                                        text: Languages.of(context)!
                                                                            .mEnterConfirmPassword);
                                                                  } else if (mPasswordController
                                                                          .text !=
                                                                      mConfirmPasswordController
                                                                          .text) {
                                                                    ErrorToast(
                                                                        context:
                                                                            context,
                                                                        text: Languages.of(context)!
                                                                            .mConfirmPasswordnotmatch);
                                                                  } else {
                                                                    Loading(mLoaderGif)
                                                                        .start(
                                                                            context);

                                                                    _apiService1.ProfileUpdate(
                                                                            nameController
                                                                                .text,
                                                                            mobileController
                                                                                .text,
                                                                            emailController
                                                                                .text,
                                                                            "",
                                                                            companynameController
                                                                                .text,
                                                                            linedINController
                                                                                .text,
                                                                            websiteController
                                                                                .text,
                                                                            mCaptureUserImage,
                                                                            mConfirmPasswordController
                                                                                .text
                                                                            //mUserDetails.password ??""
                                                                            )
                                                                        .then(
                                                                            (value) async {
                                                                      print(
                                                                          value);

                                                                      if (value
                                                                          is ApiSuccess) {
                                                                        if (LoginResponse.fromJson(value.data)!.message!.status ??
                                                                            false) {
                                                                          Loading
                                                                              .stop();
                                                                          String
                                                                              mUserInfo =
                                                                              json.encode(value.data);

                                                                          sl<StorageService>().setString(
                                                                              StorageServiceConstant.MUSERINFO,
                                                                              mUserInfo);

                                                                          // GoRouter.of(context)
                                                                          //     .go('/Dashboard');

                                                                          SucessToast(
                                                                              context: context,
                                                                              text: "Profile Updated");
                                                                        } else {
                                                                          Loading
                                                                              .stop();
                                                                          ErrorToast(
                                                                              context: context,
                                                                              text: LoginResponse.fromJson(value.data)!.message!.message ?? "");
                                                                        }
                                                                      } else if (value
                                                                          is ApiFailure) {
                                                                        Loading
                                                                            .stop();
                                                                      }
                                                                    });
                                                                  }
                                                                },
                                                              );
                                                            },
                                                            mTextColor:
                                                                mWhiteColor,
                                                            mFontSize: 16,
                                                            mWidth: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                3,
                                                            mHeigth: 40,
                                                            mhovercolor:
                                                                Colors.white)
                                                      ],
                                                    ),
                                                  ))
                                            ])), //
                                  ),
                                ),
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
}
