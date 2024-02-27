import 'dart:convert';
import 'dart:typed_data';

import 'package:custom_gif_loading/custom_gif_loading.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_network/image_network.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Model/CommonResponse.dart';
import 'package:startinsights/Model/LoginResponse.dart';
import 'package:startinsights/Network/api_result_handler.dart';
import 'package:startinsights/Network/di.dart';
import 'package:startinsights/Repository/profile_repo.dart';
import 'package:startinsights/Screen/Profile/bloc/profile_bloc.dart';
import 'package:startinsights/Screen/Profile/bloc/profile_state.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Utils/StorageServiceConstant.dart';
import 'package:startinsights/Utils/constant_methods.dart';
import 'package:startinsights/Utils/pref_manager.dart';
import 'package:startinsights/Utils/screens.dart';
import 'package:startinsights/Utils/utils.dart';
import 'package:startinsights/Widgets/ProfileAppbar.dart';
import 'package:startinsights/Widgets/auth_form_field.dart';
import 'package:startinsights/Widgets/mandatoryText.dart';
import 'package:startinsights/Widgets/primary_button.dart';

class ProfileWeb extends StatefulWidget {
  ProfileWeb({
    super.key,
  });

  @override
  State<ProfileWeb> createState() => _ProfileWebState();
}

class _ProfileWebState extends State<ProfileWeb> {
  @override
  late ProfileBloc mProfileBloc;
  bool checkedValue = false;

  XFile? _file;
  XFile? Getfile;
  String mUserImage = "";


  final TextEditingController mNameController = TextEditingController();
  final TextEditingController mMobileController = TextEditingController();
  final TextEditingController mLinkedInController = TextEditingController();
  final TextEditingController mCompanynameController = TextEditingController();
  final TextEditingController mDesignationController = TextEditingController();
  final TextEditingController mEmailController = TextEditingController();
  final TextEditingController mCurrentPasswordController =
      TextEditingController();
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

  final ProfileRepo _apiService1 = ProfileRepo();

  @override
  void initState() {
    super.initState();
    mLoadMasterData();
  }

  void mLoadMasterData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> valueMap =
        json.decode((prefs.getString(StorageServiceConstant.MUSERINFO) ?? ''));
    muserinfo = LoginResponse.fromJson(valueMap).message!.userinfo!;
    muserinfo = LoginResponse.fromJson(valueMap).message!.userinfo!;

    mNameController.text = muserinfo.fullName ?? "";
    mMobileController.text = muserinfo.phoneNo ?? "";
    mLinkedInController.text = muserinfo.linkedin ?? "";
    mCompanynameController.text = muserinfo.companyName ?? "";
    mDesignationController.text = muserinfo.designation ?? "";
    mEmailController.text = muserinfo.userEmail ?? "";
    mUserImage = muserinfo.profileImage ?? "";
    mUserId = muserinfo.userEmail ?? "";
    mUserType = muserinfo.role ?? "";
  }

  @override
  void dispose() {
    //   _controller.dispose();

    super.dispose();
  }

  Widget build(BuildContext context) {
    mProfileBloc = ProfileBloc(mContext: context);


    void _selectFile() async {

      final FilePickerResult? result = await FilePicker.platform.pickFiles( type: FileType.custom,allowedExtensions: ['png', 'jpg', 'jpeg', ],);

      if (result != null) {

        setState(() {

          selectedFile = result.files.first.name;

        });

        image = result.files.first.bytes;

        mCaptureUserImage = base64Encode(image!);
        mCaptureUserImage = base64Encode(image!);

      }}

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
          appBar: ProfileAppbar(
              mText: "TExt", mUserImage: "", mFrom: 1, onPressed: () {}),
          body: BlocConsumer<ProfileBloc, ProfileStatus>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is GetProfileInfoSuccessState) {}

              return SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.fromLTRB(30, 1, 30, 1),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            height: 300,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                    flex: 3,
                                    child: Text(
                                      Languages.of(context)!.mProfilePicture,
                                      style: const TextStyle(
                                          fontFamily: 'ManropeBold',
                                          fontSize: 22,
                                          color: Colors.black),
                                    )),
                                Expanded(
                                    flex: 7,
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        height: 200,
                                        width: 200,
                                        child: Stack(children: [
                                          CircleAvatar(
                                            radius: (100),
                                            backgroundColor: kBorderColor,
                                            child: ClipOval(
                                              child:
                                                  /*Image.asset(
                                                  'assets/avathar.png',
                                                  width: 200,
                                                  height: 200,
                                                  fit: BoxFit.fill)*/
                                              (image != null) ? Image.memory(
                                                image!,
                                                fit: BoxFit.fill,
                                                width: 200,
                                                height: 200,
                                              ) :
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
                                                              'assets/avathar.png',
                                                              width: 200,
                                                              height: 200,
                                                              fit: BoxFit.fill),
                                            ),
                                          ),
                                          Align(
                                              alignment: Alignment.bottomRight,
                                              child: InkWell(
                                                onTap: ()  {

                                                  _selectFile();
                                                  // _file = await ImagePicker()
                                                  //     .pickImage(
                                                  //         source: ImageSource
                                                  //             .gallery,
                                                  //         imageQuality: 60,
                                                  //         preferredCameraDevice:
                                                  //             CameraDevice
                                                  //                 .front);
                                                  // setState(() {
                                                  //   Getfile = _file;
                                                  //   // mProfileBloc!.UploadProfileImage(
                                                  //   //     File(_file!.path));
                                                  // });
                                                },
                                                child: const Icon(
                                                  Icons.camera_alt_rounded,
                                                  size: 50,
                                                  color: kGray,
                                                ),
                                              )),

                                          /* Align(
                                              alignment: Alignment.bottomRight,
                                              child: DefaultIconButton(
                                                  onPressed: () async {
                                                    // onClickCamera;

                                                    _file = await ImagePicker()
                                                        .pickImage(
                                                            source: ImageSource
                                                                .camera,
                                                            imageQuality: 60,
                                                            preferredCameraDevice:
                                                                CameraDevice
                                                                    .front);
                                                    setState(() {
                                                      // mProfileBloc!.UploadProfileImage(
                                                      //     File(_file!.path));
                                                    });
                                                  },
                                                  icon: const Icon(
                                                    Icons.camera_alt_rounded,
                                                    size: 50,
                                                    color: kGray,
                                                  ))),*/
                                          //Positioned
                                        ]),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),


                          Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                    flex: 3,
                                    child: Text(
                                      Languages.of(context)!
                                          .mUpdateProfileDetails,
                                      style: const TextStyle(
                                          fontFamily: 'ManropeBold',
                                          fontSize: 22,
                                          color: Colors.black),
                                    )),
                                Expanded(
                                  flex: 7,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: mColorEigth,
                                        boxShadow: const [
                                          BoxShadow(
                                            color: mColorEigth,
                                            blurRadius: 1.0,
                                          ),
                                        ]),
                                    padding: EdgeInsets.all(10),
                                    margin:
                                        const EdgeInsets.fromLTRB(20, 1, 20, 1),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: MandatoryText(
                                                      mText:
                                                          Languages.of(context)!
                                                              .mName),
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
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    keyboardType:
                                                        TextInputType.text,
                                                    hintText:
                                                        Languages.of(context)!
                                                            .mEnterName,
                                                    radius: 30,
                                                    maxLength: 80,
                                                    maxLines: 1,
                                                    labelText:
                                                        Languages.of(context)!
                                                            .mEnterName,
                                                    mBorderView: false,
                                                    mImageView: true,
                                                    mIncreshHeight: true,
                                                  ),
                                                ),
                                              ]),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: MandatoryText(
                                                      mText:
                                                          Languages.of(context)!
                                                              .mEmailAddress),
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
                                                    controller:
                                                        mEmailController,
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    keyboardType: TextInputType
                                                        .emailAddress,
                                                    hintText:
                                                        Languages.of(context)!
                                                            .mEmailAddresshint,
                                                    radius: 30,
                                                    maxLength: 80,
                                                    maxLines: 1,
                                                    labelText:
                                                        Languages.of(context)!
                                                            .mEmailAddresshint,
                                                    mBorderView: false,
                                                    mImageView: true,
                                                    mIncreshHeight: true,
                                                  ),
                                                ),
                                              ]),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: MandatoryText(
                                                      mText:
                                                          Languages.of(context)!
                                                              .mMobile),
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
                                                    controller:
                                                        mMobileController,
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    hintText:
                                                        Languages.of(context)!
                                                            .mEnterMobile,
                                                    radius: 30,
                                                    maxLength: 10,
                                                    maxLines: 1,
                                                    labelText:
                                                        Languages.of(context)!
                                                            .mEnterMobile,
                                                    mBorderView: false,
                                                    mImageView: true,
                                                    mIncreshHeight: true,
                                                  ),
                                                ),
                                              ]),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: MandatoryText(
                                                      mText:
                                                          Languages.of(context)!
                                                              .mLinkedInURL),
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
                                                    controller:
                                                        mLinkedInController,
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    keyboardType:
                                                        TextInputType.text,
                                                    hintText:
                                                        Languages.of(context)!
                                                            .mLinkedInURL,
                                                    radius: 30,
                                                    maxLength: 200,
                                                    maxLines: 1,
                                                    labelText:
                                                        Languages.of(context)!
                                                            .mLinkedInURL,
                                                    mBorderView: false,
                                                    mImageView: true,
                                                    mIncreshHeight: true,
                                                  ),
                                                ),
                                              ]),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: MandatoryText(
                                                      mText:
                                                          Languages.of(context)!
                                                              .mCompanyName),
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
                                                    controller:
                                                        mCompanynameController,
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    keyboardType:
                                                        TextInputType.text,
                                                    hintText:
                                                        Languages.of(context)!
                                                            .mCompanyName,
                                                    radius: 30,
                                                    maxLength: 80,
                                                    maxLines: 1,
                                                    labelText:
                                                        Languages.of(context)!
                                                            .mCompanyName,
                                                    mBorderView: false,
                                                    mImageView: true,
                                                    mIncreshHeight: true,
                                                  ),
                                                ),
                                              ]),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: MandatoryText(
                                                      mText:
                                                          Languages.of(context)!
                                                              .mDesignation),
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
                                                    controller:
                                                        mDesignationController,
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    keyboardType:
                                                        TextInputType.text,
                                                    hintText:
                                                        Languages.of(context)!
                                                            .mDesignation,
                                                    radius: 30,
                                                    maxLength: 80,
                                                    maxLines: 1,
                                                    labelText:
                                                        Languages.of(context)!
                                                            .mDesignation,
                                                    mBorderView: false,
                                                    mImageView: true,
                                                    mIncreshHeight: true,
                                                  ),
                                                ),
                                              ]),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                              height: 45,
                                              width: 200,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: mBtnColor,
                                                  border: Border.all(
                                                    color: mBtnColor,
                                                    width: 1,
                                                  )),
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 0, 0, 0),
                                                  child: InkWell(
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: PrimaryButton(
                                                          mButtonname: Languages
                                                                  .of(context)!
                                                              .mSave,
                                                          onpressed:
                                                              () async {

                                                                if (mNameController
                                                                    .text.isEmpty) {
                                                                  ErrorToast(
                                                                      context: context,
                                                                      text: Languages.of(
                                                                          context)!
                                                                          .mEnterName);
                                                                }

                                                                else if (mMobileController
                                                                    .text.isEmpty) {
                                                                  ErrorToast(
                                                                      context: context,
                                                                      text: Languages.of(
                                                                          context)!
                                                                          .mEnterMobile);
                                                                } else if (!isMobileNumberValid(
                                                                    mMobileController
                                                                        .text)) {
                                                                  ErrorToast(
                                                                      context: context,
                                                                      text:
                                                                      "Not Valid  Mobile");
                                                                }
                                                                else if (mCompanynameController
                                                                    .text.isEmpty) {
                                                                  ErrorToast(
                                                                      context: context,
                                                                      text: Languages.of(
                                                                          context)!
                                                                          .mentercompanyname);
                                                                }
                                                                else if (mDesignationController
                                                                    .text.isEmpty) {
                                                                  ErrorToast(
                                                                      context: context,
                                                                      text: Languages.of(
                                                                          context)!
                                                                          .mEnterDesignation);
                                                                }
                                                                else
                                                                {


                                                                  Loading(mLoaderGif)
                                                                      .start(context);

                                                                  _apiService1
                                                                      .ProfileUpdate(
                                                                      mNameController
                                                                          .text,
                                                                      mUserId,mMobileController
                                                                      .text,
                                                                      mDesignationController
                                                                          .text,
                                                                      mCompanynameController
                                                                          .text,
                                                                      mLinkedInController
                                                                          .text,
                                                                      mCaptureUserImage,
                                                                      mUserType)
                                                                      .then((value) async {
                                                                    print(value);

                                                                    if (value is ApiSuccess) {
                                                                      if (LoginResponse
                                                                          .fromJson(
                                                                          value.data)!
                                                                          .message!
                                                                          .status ??
                                                                          false) {
                                                                        Loading.stop();
                                                                        String mUserInfo = json.encode(value.data);

                                                                        sl<StorageService>()
                                                                            .setString(StorageServiceConstant.MUSERINFO, mUserInfo);
                                                                        SucessToast(
                                                                            context: context,
                                                                            text:
                                                                            "Profile Updated");
                                                                      } else {
                                                                        Loading.stop();
                                                                        ErrorToast(
                                                                            context: context,
                                                                            text:
                                                                            CommonResponse
                                                                                .fromJson(
                                                                                value.data)!
                                                                                .message!.message ?? "");
                                                                      }
                                                                    } else if (value
                                                                    is ApiFailure) {
                                                                      Loading.stop();
                                                                    }
                                                                  });

                                                                }




                                                              },
                                                          mSelectcolor:
                                                              mBtnColor,
                                                          mTextColor:
                                                              mWhiteColor,
                                                          mFontSize: 16,
                                                          mHeigth: 40),
                                                    ),
                                                  ))),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ]),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                    flex: 3,
                                    child: Text(
                                      Languages.of(context)!.mChangePassword,
                                      style: const TextStyle(
                                          fontFamily: 'ManropeBold',
                                          fontSize: 22,
                                          color: Colors.black),
                                    )),
                                Expanded(
                                  flex: 7,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: mColorEigth,
                                        boxShadow: const [
                                          BoxShadow(
                                            color: mColorEigth,
                                            blurRadius: 1.0,
                                          ),
                                        ]),
                                    padding: EdgeInsets.all(10),
                                    margin:
                                        const EdgeInsets.fromLTRB(20, 1, 20, 1),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: MandatoryText(
                                                      mText: Languages.of(
                                                              context)!
                                                          .mCurrentPassword),
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
                                                  child: TextFormField(
                                                      keyboardType:
                                                          TextInputType.text,
                                                      controller:
                                                          mCurrentPasswordController,
                                                      obscureText:
                                                          !CurrentpasswordVisible,
                                                      maxLines: 1,
                                                      maxLength:
                                                          16, //This will obscure text dynamically
                                                      decoration:
                                                          InputDecoration(
                                                              counterText: "",
                                                              labelText:
                                                                  Languages.of(context)!
                                                                      .mPassword,
                                                              labelStyle: const TextStyle(
                                                                  fontSize: 15,
                                                                  fontFamily:
                                                                      'ManropeMedium',
                                                                  color: kGray),
                                                              hintText:
                                                                  Languages.of(context)!
                                                                      .mPassword,
                                                              suffixIcon:
                                                                  IconButton(
                                                                icon: Icon(
                                                                  // Based on passwordVisible state choose the icon
                                                                  CurrentpasswordVisible
                                                                      ? Icons
                                                                          .visibility
                                                                      : Icons
                                                                          .visibility_off,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColorDark,
                                                                ),
                                                                onPressed: () {
                                                                  // Update the state i.e. toogle the state of passwordVisible variable
                                                                  setState(() {
                                                                    CurrentpasswordVisible =
                                                                        !CurrentpasswordVisible;
                                                                  });
                                                                },
                                                              ),
                                                              alignLabelWithHint:
                                                                  true,
                                                              hintStyle:
                                                                  const TextStyle(
                                                                color: kGray,
                                                              ),
                                                              isDense:
                                                                  true, // Added this

                                                              floatingLabelStyle:
                                                                  const TextStyle(
                                                                      color: Colors
                                                                          .blue),
                                                              // floatingLabelBehavior: FloatingLabelBehavior.never,
                                                              contentPadding:
                                                                  const EdgeInsets.fromLTRB(
                                                                      10,
                                                                      15,
                                                                      10,
                                                                      15),
                                                              enabledBorder: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          8),
                                                                  borderSide: const BorderSide(
                                                                      color: kTextBorder,
                                                                      width: 1)),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderSide:
                                                                    const BorderSide(
                                                                        color:
                                                                            kTextBorder,
                                                                        width:
                                                                            1),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                              ),
                                                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: const BorderSide(width: 1, color: kTextBorder))))

                                                  /*AuthFormField(
                                                controller: passwordController,
                                                obscureText: true,
                                                maxLines: 1,
                                                textInputAction:
                                                    TextInputAction.next,
                                                keyboardType:
                                                    TextInputType.text,
                                                hintText: Languages.of(context)!
                                                    .mPassword,
                                                radius: 30,
                                                maxLength: 80,
                                                labelText:
                                                    Languages.of(context)!
                                                        .mPassword,
                                                mBorderView: false,
                                                mImageView: true,
                                              )*/
                                                  ,
                                                ),
                                              ]),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: MandatoryText(
                                                      mText:
                                                          Languages.of(context)!
                                                              .mNewPassword),
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
                                                  child: TextFormField(
                                                      keyboardType:
                                                          TextInputType.text,
                                                      controller:
                                                          mPasswordController,
                                                      obscureText:
                                                          !passwordVisible,
                                                      maxLines: 1,
                                                      maxLength:
                                                          16, //This will obscure text dynamically
                                                      decoration:
                                                          InputDecoration(
                                                              counterText: "",
                                                              labelText: Languages.of(context)!
                                                                  .mNewPassword,
                                                              labelStyle: const TextStyle(
                                                                  fontSize: 15,
                                                                  fontFamily:
                                                                      'ManropeMedium',
                                                                  color: kGray),
                                                              hintText:
                                                                  Languages.of(context)!
                                                                      .mPassword,
                                                              suffixIcon:
                                                                  IconButton(
                                                                icon: Icon(
                                                                  // Based on passwordVisible state choose the icon
                                                                  passwordVisible
                                                                      ? Icons
                                                                          .visibility
                                                                      : Icons
                                                                          .visibility_off,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColorDark,
                                                                ),
                                                                onPressed: () {
                                                                  // Update the state i.e. toogle the state of passwordVisible variable
                                                                  setState(() {
                                                                    passwordVisible =
                                                                        !passwordVisible;
                                                                  });
                                                                },
                                                              ),
                                                              alignLabelWithHint:
                                                                  true,
                                                              hintStyle:
                                                                  const TextStyle(
                                                                color: kGray,
                                                              ),
                                                              isDense:
                                                                  true, // Added this

                                                              floatingLabelStyle:
                                                                  const TextStyle(
                                                                      color: Colors
                                                                          .blue),
                                                              // floatingLabelBehavior: FloatingLabelBehavior.never,
                                                              contentPadding:
                                                                  const EdgeInsets.fromLTRB(
                                                                      10,
                                                                      15,
                                                                      10,
                                                                      15),
                                                              enabledBorder: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          8),
                                                                  borderSide: const BorderSide(
                                                                      color:
                                                                          kTextBorder,
                                                                      width: 1)),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderSide:
                                                                    const BorderSide(
                                                                        color:
                                                                            kTextBorder,
                                                                        width:
                                                                            1),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                              ),
                                                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: const BorderSide(width: 1, color: kTextBorder))))

                                                  /*AuthFormField(
                                                controller: passwordController,
                                                obscureText: true,
                                                maxLines: 1,
                                                textInputAction:
                                                    TextInputAction.next,
                                                keyboardType:
                                                    TextInputType.text,
                                                hintText: Languages.of(context)!
                                                    .mPassword,
                                                radius: 30,
                                                maxLength: 80,
                                                labelText:
                                                    Languages.of(context)!
                                                        .mPassword,
                                                mBorderView: false,
                                                mImageView: true,
                                              )*/
                                                  ,
                                                ),
                                              ]),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: MandatoryText(
                                                      mText: Languages.of(
                                                              context)!
                                                          .mConfirmPassword),
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
                                                  child: TextFormField(
                                                      keyboardType:
                                                          TextInputType.text,
                                                      controller:
                                                          mConfirmPasswordController,
                                                      obscureText:
                                                          !ConfirmpasswordVisible,
                                                      maxLines: 1,
                                                      maxLength:
                                                          16, //This will obscure text dynamically
                                                      decoration:
                                                          InputDecoration(
                                                              counterText: "",
                                                              labelText: Languages.of(context)!
                                                                  .mNewPassword,
                                                              labelStyle: const TextStyle(
                                                                  fontSize: 15,
                                                                  fontFamily:
                                                                      'ManropeMedium',
                                                                  color: kGray),
                                                              hintText:
                                                                  Languages.of(context)!
                                                                      .mConfirmPassword,
                                                              suffixIcon:
                                                                  IconButton(
                                                                icon: Icon(
                                                                  // Based on passwordVisible state choose the icon
                                                                  ConfirmpasswordVisible
                                                                      ? Icons
                                                                          .visibility
                                                                      : Icons
                                                                          .visibility_off,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColorDark,
                                                                ),
                                                                onPressed: () {
                                                                  // Update the state i.e. toogle the state of passwordVisible variable
                                                                  setState(() {
                                                                    ConfirmpasswordVisible =
                                                                        !ConfirmpasswordVisible;
                                                                  });
                                                                },
                                                              ),
                                                              alignLabelWithHint:
                                                                  true,
                                                              hintStyle:
                                                                  const TextStyle(
                                                                color: kGray,
                                                              ),
                                                              isDense:
                                                                  true, // Added this

                                                              floatingLabelStyle:
                                                                  const TextStyle(
                                                                      color: Colors
                                                                          .blue),
                                                              // floatingLabelBehavior: FloatingLabelBehavior.never,
                                                              contentPadding:
                                                                  const EdgeInsets.fromLTRB(
                                                                      10,
                                                                      15,
                                                                      10,
                                                                      15),
                                                              enabledBorder: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          8),
                                                                  borderSide: const BorderSide(
                                                                      color:
                                                                          kTextBorder,
                                                                      width: 1)),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderSide:
                                                                    const BorderSide(
                                                                        color:
                                                                            kTextBorder,
                                                                        width:
                                                                            1),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                              ),
                                                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: const BorderSide(width: 1, color: kTextBorder))))

                                                  /*AuthFormField(
                                                controller: passwordController,
                                                obscureText: true,
                                                maxLines: 1,
                                                textInputAction:
                                                    TextInputAction.next,
                                                keyboardType:
                                                    TextInputType.text,
                                                hintText: Languages.of(context)!
                                                    .mPassword,
                                                radius: 30,
                                                maxLength: 80,
                                                labelText:
                                                    Languages.of(context)!
                                                        .mPassword,
                                                mBorderView: false,
                                                mImageView: true,
                                              )*/
                                                  ,
                                                ),
                                              ]),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                              height: 45,
                                              width: 200,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: mBtnColor,
                                                  border: Border.all(
                                                    color: mBtnColor,
                                                    width: 1,
                                                  )),
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 0, 0, 0),
                                                  child: InkWell(
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: PrimaryButton(
                                                          mButtonname: Languages
                                                                  .of(context)!
                                                              .mSave,
                                                          onpressed:
                                                              () async {},
                                                          mSelectcolor:
                                                              mBtnColor,
                                                          mTextColor:
                                                              mWhiteColor,
                                                          mFontSize: 16,
                                                          mHeigth: 40),
                                                    ),
                                                  ))),
                                          const SizedBox(
                                            height: 20,
                                          )
                                        ]),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ]),
                  ),
                ),
              );
              //  ErrorToast(context: context, text: state.mDashboard.message!);

              //} else if (state is GetPunchInOutFailState) {}
              return Container();
            },
          )),
    );
  }


}
