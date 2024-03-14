import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Model/MastersResponse.dart';
import 'package:startinsights/Screen/Login/bloc/login_bloc.dart';
import 'package:startinsights/Screen/Login/bloc/login_state.dart';
import 'package:startinsights/Utils/FontSizes.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Utils/utils.dart';
import 'package:startinsights/Widgets/auth_form_field.dart';
import 'package:startinsights/Widgets/button.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late LoginBloc mLoginBloc;
  bool checkedValue = false;
  List<UserType>? mUserTypeDataList;
  List<UserType> getUserType = <UserType>[];
  bool passwordVisible = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    mLoginBloc = LoginBloc(mContext: context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<LoginBloc, LoginStatus>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is GetLoginInfoSuccessState) {
            mUserTypeDataList = state.mMastersDataList.userType;
            getUserType.clear();
            List.generate(mUserTypeDataList!.length,
                (index) => getUserType.add(mUserTypeDataList![index]));
          }

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
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          Languages.of(context)!.mWelcomeback,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontFamily: 'OpenSauceSansBold',
                                              fontSize: mSizeSix,
                                              color: mBlackOne),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          Languages.of(context)!.mLogmsg,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontFamily:
                                                  'OpenSauceSansRegular',
                                              fontSize: mSizeTwo,
                                              color: mGreySeven),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          child: AuthFormField(
                                            controller: emailController,
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType: TextInputType.text,
                                            hintText: Languages.of(context)!
                                                .mEmailAddresshint,
                                            radius: 30,
                                            maxLength: 80,
                                            labelText: Languages.of(context)!
                                                .mEmailAddresshint,
                                            mBorderView: false,
                                            mImageView: true,
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
                                                  labelText: Languages.of(context)!
                                                      .mPassword,
                                                  labelStyle: const TextStyle(
                                                      fontSize: mSizeTwo,
                                                      fontFamily:
                                                          'OpenSauceSansRegular',
                                                      color: mGreyEigth),
                                                  hintText: Languages.of(context)!
                                                      .mPassword,
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

                                                  floatingLabelStyle: const TextStyle(
                                                      color: Colors.blue),
                                                  // floatingLabelBehavior: FloatingLabelBehavior.never,
                                                  contentPadding:
                                                      const EdgeInsets.fromLTRB(
                                                          10, 15, 10, 15),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      borderSide: const BorderSide(
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
                                                      borderRadius: BorderRadius.circular(5),
                                                      borderSide: const BorderSide(width: 1, color: mGreyFour)),
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
                                          height: 10,
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: InkWell(
                                              onTap: () {
                                                if (emailController
                                                    .text.isEmpty) {
                                                  ErrorToast(
                                                      context: context,
                                                      text: Languages.of(
                                                              context)!
                                                          .mVaildEmailAddresshint);
                                                } else if (!emailController.text
                                                    .isValidEmail()) {
                                                  ErrorToast(
                                                      context: context,
                                                      text: Languages.of(
                                                              context)!
                                                          .mVaildEmailAddresshint);
                                                } else {
                                                  GoRouter.of(context).go(
                                                      '/ForgetPwd',
                                                      extra:
                                                          emailController.text);
                                                }
                                              },
                                              child: Text(
                                                Languages.of(context)!
                                                    .mForgetpassword,
                                                style: const TextStyle(
                                                    fontSize: mSizeTwo,
                                                    fontFamily:
                                                        'OpenSauceSansRegular',
                                                    color: mRedColorOne),
                                              )),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: Button(
                                              mButtonname:
                                                  Languages.of(context)!.mLogin,
                                              onpressed: () {
                                                if (emailController
                                                    .text.isEmpty) {
                                                  ErrorToast(
                                                      context: context,
                                                      text: Languages.of(
                                                              context)!
                                                          .mVaildEmailAddresshint);
                                                } else if (!emailController.text
                                                    .isValidEmail()) {
                                                  ErrorToast(
                                                      context: context,
                                                      text: Languages.of(
                                                              context)!
                                                          .mVaildEmailAddresshint);
                                                } else if (passwordController
                                                    .text.isEmpty) {
                                                  ErrorToast(
                                                      context: context,
                                                      text:
                                                          Languages.of(context)!
                                                              .mEnterPassword);
                                                } else {
                                                  FirebaseAnalytics.instance
                                                      .logEvent(
                                                          name: 'Login Event');

                                                  mLoginBloc.login(
                                                      userid:
                                                          emailController.text,
                                                      password:
                                                          passwordController
                                                              .text,
                                                      checkedValue:
                                                          checkedValue);
                                                }
                                              },
                                              mSelectcolor: mBtnColor,
                                              mTextColor: mWhiteColor,
                                              mFontSize: 16,
                                              mWidth: 400,
                                              mHeigth: 45),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 1,
                                                width: 100,
                                                color: mGreySeven,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                  Languages.of(context)!
                                                      .mOrLoginusing,
                                                  style: const TextStyle(
                                                      fontSize: mSizeTwo,
                                                      fontFamily:
                                                          'OpenSauceSansRegular',
                                                      color: mGreySeven)),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                height: 1,
                                                width: 100,
                                                color: mGreySeven,
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: Container(
                                            height: 40,
                                            width: 250,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.white,
                                              border:
                                                  Border.all(color: mGreyOne),
                                            ),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    'assets/new_ic_linkedin.png',
                                                    width: 20,
                                                    height: 20,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                      Languages.of(context)!
                                                          .mLoginwithLinkedIn,
                                                      style: const TextStyle(
                                                          fontSize: mSizeThree,
                                                          fontFamily:
                                                              'OpenSauceSansBold',
                                                          color: mBlueColor))
                                                ]),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                    Languages.of(context)!
                                                        .mnoaccount,
                                                    style: const TextStyle(
                                                        fontSize: mSizeTwo,
                                                        fontFamily:
                                                            'OpenSauceSansRegular',
                                                        color: mGreyEigth)),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                InkWell(
                                                  child: Text(
                                                      Languages.of(context)!
                                                          .mCreateanAccount,
                                                      style: const TextStyle(
                                                          fontSize: mSizeTwo,
                                                          fontFamily:
                                                              'OpenSauceSansBold',
                                                          color: mBlackOne)),
                                                  onTap: () {
                                                    // GoRouter.of(context).go(
                                                    //   '/Dashboard',
                                                    //   queryParameters: {
                                                    //     'isRegister': true,
                                                    //   },
                                                    // );

                                                    GoRouter.of(context)
                                                        .go('/Register');
                                                  },
                                                ),
                                              ]),
                                        ),
                                      ])),
                            ),
                            Expanded(
                              flex: 5,
                              child: Image.asset('assets/new_ic_loginimg.png',
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
