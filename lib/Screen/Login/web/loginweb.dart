import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Model/MastersResponse.dart';
import 'package:startinsights/Screen/Login/bloc/login_bloc.dart';
import 'package:startinsights/Screen/Login/bloc/login_state.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Utils/screens.dart';
import 'package:startinsights/Utils/utils.dart';
import 'package:startinsights/Widgets/auth_form_field.dart';
import 'package:startinsights/Widgets/mandatoryText.dart';
import 'package:startinsights/Widgets/primary_button.dart';

class LoginWeb extends StatefulWidget {
  LoginWeb({super.key});

  @override
  State<LoginWeb> createState() => _LoginWebState();
}

class _LoginWebState extends State<LoginWeb> {
  @override
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late LoginBloc mLoginBloc;
  bool checkedValue = false;
  List<UserType>? mUserTypeDataList;
  List<UserType> getUserType = <UserType>[];
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
              child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 5,
                              child: Container(
                                  width: double.infinity,
                                  height: MediaQuery.of(context).size.height,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(0),
                                    gradient: const LinearGradient(
                                      colors: [mStartColor, mEndColor],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      tileMode: TileMode.repeated,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: RichText(
                                            text: TextSpan(
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: Languages.of(context)!
                                                        .mLoginTextOne,
                                                    style: const TextStyle(
                                                        fontFamily:
                                                            'ManropeBold',
                                                        fontSize: 26,
                                                        color: mBtnColor)),
                                                TextSpan(
                                                    text: Languages.of(context)!
                                                        .mLoginTextTwo,
                                                    style: const TextStyle(
                                                        fontFamily:
                                                            'ManropeBold',
                                                        fontSize: 26,
                                                        color: mBlackColor)),
                                                TextSpan(
                                                    text: Languages.of(context)!
                                                        .mLoginTextThree,
                                                    style: const TextStyle(
                                                        fontFamily:
                                                            'ManropeBold',
                                                        fontSize: 26,
                                                        color: mBtnColor)),
                                                TextSpan(
                                                    text: Languages.of(context)!
                                                        .mLoginTextFour,
                                                    style: const TextStyle(
                                                        fontFamily:
                                                            'ManropeBold',
                                                        fontSize: 26,
                                                        color: mBlackColor))
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Expanded(
                                        flex: 7,
                                        child: Align(
                                          alignment: Alignment.topCenter,
                                          child: Image(
                                            width: 400,
                                            height: 400,
                                            image: AssetImage(
                                              "assets/loginicon.png",
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ))),
                          Expanded(
                              flex: 5,
                              child: Container(
                                  width: double.infinity,
                                  height: MediaQuery.of(context).size.height,
                                  color: Colors.white,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 100,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(Languages.of(context)!.mWelcom,
                                                style: const TextStyle(
                                                  fontFamily: 'ManropeSemiBold',
                                                  fontSize: 36,
                                                  color: mBlackColor,
                                                ))
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              top: 2.0,
                                              left: 150.0,
                                              right: 2.0),
                                          child: Column(children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                RichText(
                                                  text: TextSpan(
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text: Languages.of(
                                                                  context)!
                                                              .mnoaccount,
                                                          style: const TextStyle(
                                                              fontFamily:
                                                                  'ManropeLight',
                                                              fontSize: 24,
                                                              color:
                                                                  mTextOneColor)),
                                                      const TextSpan(
                                                          text: " ",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'ManropeLight',
                                                              fontSize: 22,
                                                              color:
                                                                  mTextOneColor)),
                                                      TextSpan(
                                                        text: Languages.of(
                                                                context)!
                                                            .mregister,
                                                        recognizer: TapGestureRecognizer()
                                                          ..onTap = () =>
                                                              Navigator.pushReplacementNamed(
                                                                  context,
                                                                  registerRoute,
                                                                  arguments: [
                                                                    getUserType
                                                                  ]),
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                'ManropeBold',
                                                            fontSize: 22,
                                                            color: mBtnColor),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )
                                          ]),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              top: 10, left: 80, right: 40),
                                          child: Column(children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: MandatoryText(
                                                  mText: Languages.of(context)!
                                                      .mEmailAddress),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              child: AuthFormField(
                                                controller: emailController,
                                                textInputAction:
                                                    TextInputAction.next,
                                                keyboardType:
                                                    TextInputType.text,
                                                hintText: Languages.of(context)!
                                                    .mEmailAddresshint,
                                                radius: 30,
                                                maxLength: 80,
                                                labelText:
                                                    Languages.of(context)!
                                                        .mEmailAddresshint,
                                                mBorderView: false,
                                                mImageView: true,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: MandatoryText(
                                                  mText: Languages.of(context)!
                                                      .mPassword),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              child: AuthFormField(
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
                                              ),
                                            ),
                                          ]),
                                        ),
                                        Container(
                                            margin: const EdgeInsets.only(
                                                top: 2.0,
                                                left: 60.0,
                                                right: 40.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 5,
                                                      child: ListTileTheme(
                                                        minLeadingWidth: 2,
                                                        child: CheckboxListTile(
                                                          activeColor:
                                                              mPrimaryColor,
                                                          title: Text(
                                                              Languages.of(
                                                                      context)!
                                                                  .mStaysignedin,
                                                              style: const TextStyle(
                                                                  fontFamily:
                                                                      'ManropeRegular',
                                                                  fontSize: 16,
                                                                  color:
                                                                      mBlackColor)),
                                                          value: checkedValue,
                                                          onChanged:
                                                              (newValue) {
                                                            setState(() {
                                                              checkedValue =
                                                                  newValue ??
                                                                      false;
                                                            });
                                                          },
                                                          controlAffinity:
                                                              ListTileControlAffinity
                                                                  .leading, //  <-- leading Checkbox
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Expanded(
                                                      flex: 5,
                                                      child: Align(
                                                        alignment: Alignment
                                                            .bottomRight,
                                                        child: InkWell(
                                                          onTap: () {
                                                            // Navigator.pushReplacementNamed(
                                                            //     context, "/dashboard");
                                                          },
                                                          child: Text(
                                                              Languages.of(
                                                                      context)!
                                                                  .mForgotpassword,
                                                              style: const TextStyle(
                                                                  fontFamily:
                                                                      'ManropeRegular',
                                                                  fontSize: 16,
                                                                  color:
                                                                      mBlackColor)),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            )),
                                        const SizedBox(
                                          height: 40,
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: Container(
                                            width: 300,
                                            child: PrimaryButton(
                                                mButtonname:
                                                    Languages.of(context)!
                                                        .mLogin,
                                                onpressed: () {
                                                  if (emailController
                                                      .text.isEmpty) {
                                                    ErrorToast(
                                                        context: context,
                                                        text: Languages.of(
                                                                context)!
                                                            .mVaildEmailAddresshint);
                                                  } else if (!emailController
                                                      .text
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
                                                        text: Languages.of(
                                                                context)!
                                                            .mEnterPassword);
                                                  } else {
                                                    mLoginBloc.login(
                                                        userid: emailController
                                                            .text,
                                                        password:
                                                            passwordController
                                                                .text,
                                                        checkedValue:
                                                            checkedValue);
                                                  }
                                                },
                                                mSelectcolor: mBtnColor,
                                                mTextColor: mWhiteColor),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 40,
                                        ),
                                        Container(
                                            margin: const EdgeInsets.only(
                                                top: 2.0,
                                                left: 60.0,
                                                right: 20.0),
                                            child: const Align(
                                              alignment: Alignment.center,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Dash(
                                                      direction:
                                                          Axis.horizontal,
                                                      dashLength: 3,
                                                      length: 250,
                                                      dashColor: kGray),
                                                  Text(" OR "),
                                                  Dash(
                                                      direction:
                                                          Axis.horizontal,
                                                      dashLength: 3,
                                                      length: 250,
                                                      dashColor: kGray)
                                                ],
                                              ),
                                            )),
                                      ],
                                    ),
                                  ))),
                        ],
                      )
                    ],
                  )));
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
