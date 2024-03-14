import 'package:custom_gif_loading/custom_gif_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Model/CommonResponse.dart';
import 'package:startinsights/Network/api_result_handler.dart';
import 'package:startinsights/Repository/login_repo.dart';
import 'package:startinsights/Screen/ForgetPassword/bloc/forgetpwd_bloc.dart';
import 'package:startinsights/Screen/ForgetPassword/bloc/forgwtpwd_state.dart';
import 'package:startinsights/Utils/FontSizes.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Utils/constant_methods.dart';
import 'package:startinsights/Utils/utils.dart';
import 'package:startinsights/Widgets/auth_form_field.dart';
import 'package:startinsights/Widgets/button.dart';

class ResetPwd extends StatefulWidget {
  ResetPwd({super.key});

  @override
  State<ResetPwd> createState() => _ResetPwdState();
}

class _ResetPwdState extends State<ResetPwd> {
  @override
  late ForgetPwdBloc mForgetPwdBloc;

  final TextEditingController confirmpasswordController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController AuthCodeController = TextEditingController();

  bool passwordVisible = false;
  bool confirmpasswordVisible = false;

  final LoginRepo _apiService1 = LoginRepo();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    confirmpasswordController.dispose();
    passwordController.dispose();
    AuthCodeController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    mForgetPwdBloc = ForgetPwdBloc(mContext: context, mEmailid: "");

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<ForgetPwdBloc, ForgetPwdStatus>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is GetForgetPwdInfoSuccessState) {}

          return SafeArea(
              child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding:
                const EdgeInsets.only(top: 30, left: 40, right: 20, bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0),
              image: const DecorationImage(
                image: AssetImage("assets/new_login_bg.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: Container(
              child: Stack(children: [
                Image.asset('assets/new_appicon.png', width: 200, height: 60),
                /*Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 200,
                      width: 200,
                      color: Colors.red,
                    )
                  ],
                )*/

                Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2 + 100,
                      height: MediaQuery.of(context).size.height / 2 + 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.white,
                            blurRadius: 1.0,
                          ),
                        ],
                      ),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 5,
                              child: Container(
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 40, right: 30, bottom: 10),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/new_ic_lock.svg',
                                          width: 120,
                                          height: 120,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          Languages.of(context)!.mResetPassword,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontFamily: 'OpenSauceSansBold',
                                              fontSize: mSizeSix,
                                              color: mBlackOne),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: Languages.of(context)!
                                                      .mResetPasswordmsg,
                                                  style: const TextStyle(
                                                      fontFamily:
                                                          'OpenSauceSansRegular',
                                                      fontSize: mSizeTwo,
                                                      color: mGreySeven)),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          child: TextFormField(
                                              keyboardType: TextInputType.text,
                                              controller: passwordController,
                                              obscureText: !passwordVisible,
                                              maxLines: 1,
                                              maxLength:
                                                  16, //This will obscure text dynamically
                                              style: const TextStyle(
                                                  fontSize: mSizeThree,
                                                  fontFamily:
                                                      'OpenSauceSansRegular',
                                                  color: mBlackOne),
                                              decoration: InputDecoration(
                                                  counterText: "",
                                                  label: RichText(
                                                    text: TextSpan(
                                                        text: Languages.of(
                                                                context)!
                                                            .mNewPassword,
                                                        style: const TextStyle(
                                                            color: mGreyEigth,
                                                            fontFamily:
                                                                'OpenSauceSansRegular',
                                                            fontSize: mSizeTwo),
                                                        children: const [
                                                          TextSpan(
                                                              text: ' *',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                  fontFamily:
                                                                      'OpenSauceSansRegular',
                                                                  fontSize:
                                                                      mSizeTwo))
                                                        ]),
                                                  ),
                                                  labelStyle: const TextStyle(
                                                      fontSize: mSizeTwo,
                                                      fontFamily:
                                                          'OpenSauceSansRegular',
                                                      color: mGreyEigth),
                                                  hintText:
                                                      "${Languages.of(context)!.mNewPassword} *",
                                                  suffixIcon: IconButton(
                                                    icon: Icon(
                                                      // Based on passwordVisible state choose the icon
                                                      passwordVisible
                                                          ? Icons.visibility
                                                          : Icons
                                                              .visibility_off,
                                                      color: Theme.of(context)
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
                                                  alignLabelWithHint: true,
                                                  hintStyle: const TextStyle(
                                                    color: mGreyEigth,
                                                  ),
                                                  isDense: true, // Added this

                                                  floatingLabelStyle:
                                                      const TextStyle(
                                                          color: Colors.blue),
                                                  // floatingLabelBehavior: FloatingLabelBehavior.never,
                                                  contentPadding:
                                                      const EdgeInsets.fromLTRB(
                                                          10, 15, 10, 15),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      borderSide:
                                                          const BorderSide(
                                                              color: mGreyFour,
                                                              width: 1)),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: mGreyFour,
                                                            width: 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      borderSide:
                                                          const BorderSide(
                                                              width: 1,
                                                              color: mGreyFour)),
                                                  fillColor: mLightColorOne,
                                                  filled: true)),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          child: TextFormField(
                                              keyboardType: TextInputType.text,
                                              controller:
                                                  confirmpasswordController,
                                              obscureText:
                                                  !confirmpasswordVisible,
                                              maxLines: 1,
                                              maxLength:
                                                  16, //This will obscure text dynamically
                                              style: const TextStyle(
                                                  fontSize: mSizeThree,
                                                  fontFamily:
                                                      'OpenSauceSansRegular',
                                                  color: mBlackOne),
                                              decoration: InputDecoration(
                                                  counterText: "",
                                                  label: RichText(
                                                    text: TextSpan(
                                                        text: Languages.of(
                                                                context)!
                                                            .mConfirmPassword,
                                                        style: const TextStyle(
                                                            color: mGreyEigth,
                                                            fontFamily:
                                                                'OpenSauceSansRegular',
                                                            fontSize: mSizeTwo),
                                                        children: const [
                                                          TextSpan(
                                                              text: ' *',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                  fontFamily:
                                                                      'OpenSauceSansRegular',
                                                                  fontSize:
                                                                      mSizeTwo))
                                                        ]),
                                                  ),
                                                  labelStyle: const TextStyle(
                                                      fontSize: mSizeTwo,
                                                      fontFamily:
                                                          'OpenSauceSansRegular',
                                                      color: mGreyEigth),
                                                  hintText:
                                                      "${Languages.of(context)!.mConfirmPassword} *",
                                                  suffixIcon: IconButton(
                                                    icon: Icon(
                                                      // Based on passwordVisible state choose the icon
                                                      confirmpasswordVisible
                                                          ? Icons.visibility
                                                          : Icons
                                                              .visibility_off,
                                                      color: Theme.of(context)
                                                          .primaryColorDark,
                                                    ),
                                                    onPressed: () {
                                                      // Update the state i.e. toogle the state of passwordVisible variable
                                                      setState(() {
                                                        confirmpasswordVisible =
                                                            !confirmpasswordVisible;
                                                      });
                                                    },
                                                  ),
                                                  alignLabelWithHint: true,
                                                  hintStyle: const TextStyle(
                                                    color: mGreyEigth,
                                                  ),
                                                  isDense: true, // Added this

                                                  floatingLabelStyle:
                                                      const TextStyle(
                                                          color: Colors.blue),
                                                  // floatingLabelBehavior: FloatingLabelBehavior.never,
                                                  contentPadding:
                                                      const EdgeInsets.fromLTRB(
                                                          10, 15, 10, 15),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      borderSide:
                                                          const BorderSide(
                                                              color: mGreyFour,
                                                              width: 1)),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: mGreyFour,
                                                            width: 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      borderSide:
                                                          const BorderSide(
                                                              width: 1,
                                                              color: mGreyFour)),
                                                  fillColor: mLightColorOne,
                                                  filled: true))

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
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          child: AuthFormField(
                                            controller: AuthCodeController,
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType: TextInputType.text,
                                            hintText: Languages.of(context)!
                                                .mAuthcode,
                                            radius: 30,
                                            maxLength: 8,
                                            labelText: Languages.of(context)!
                                                .mAuthcode,
                                            mBorderView: false,
                                            mImageView: true,
                                            isMandatory: true,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Button(
                                            mButtonname: Languages.of(context)!
                                                .mResetPassword,
                                            onpressed: () {
                                              if (passwordController
                                                  .text.isEmpty) {
                                                ErrorToast(
                                                    context: context,
                                                    text: Languages.of(context)!
                                                        .mEnterPassword);
                                              } else if (confirmpasswordController
                                                  .text.isEmpty) {
                                                ErrorToast(
                                                    context: context,
                                                    text: Languages.of(context)!
                                                        .mEnterConfirmPassword);
                                              } else if (passwordController
                                                      .text !=
                                                  confirmpasswordController
                                                      .text) {
                                                ErrorToast(
                                                    context: context,
                                                    text: Languages.of(context)!
                                                        .mConfirmPasswordnotmatch);
                                              } else if (AuthCodeController
                                                  .text.isEmpty) {
                                                ErrorToast(
                                                    context: context,
                                                    text: Languages.of(context)!
                                                        .mEnterAuthcode);
                                              } else {
                                                Loading(mLoaderGif)
                                                    .start(context);

                                                _apiService1
                                                    .resetPwd(
                                                  passwordController.text,
                                                  AuthCodeController.text,

                                                  //mUserDetails.password ??""
                                                )
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
                                                                      .fromJson(
                                                                          value
                                                                              .data)!
                                                                  .message!
                                                                  .message ??
                                                              "");
                                                      GoRouter.of(context)
                                                          .go('/Login');
                                                    } else {
                                                      Loading.stop();
                                                      ErrorToast(
                                                          context: context,
                                                          text: CommonResponse
                                                                      .fromJson(
                                                                          value
                                                                              .data)!
                                                                  .message!
                                                                  .message ??
                                                              "");
                                                    }
                                                  } else if (value
                                                      is ApiFailure) {
                                                    Loading.stop();
                                                  }
                                                });
                                              }
                                            },
                                            mSelectcolor: mBtnColor,
                                            mTextColor: mWhiteColor,
                                            mFontSize: 16,
                                            mWidth: MediaQuery.of(context)!
                                                .size
                                                .width,
                                            mHeigth: 40),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                      ])),
                            ),
                            Expanded(
                              flex: 5,
                              child: Image.asset('assets/ic_forgetpwdbg.png',
                                  fit: BoxFit.fill),
                            )
                          ]),
                    ))
              ]),
            ),
          ));
        },
      ),
    );
  }
}
//const Column(children: [
//                             Align(
//                               alignment: Alignment.center,
//                               child: Image(
//                                 image: AssetImage(
//                                   "assets/loginbg.png",
//                                 ),
//                               ),
//                             ),
//                           ]
