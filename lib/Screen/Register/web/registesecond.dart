import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Screen/Register/bloc/register_bloc.dart';
import 'package:startinsights/Screen/Register/bloc/register_state.dart';
import 'package:startinsights/Utils/FontSizes.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Utils/constant_methods.dart';
import 'package:startinsights/Utils/utils.dart';
import 'package:startinsights/Widgets/button.dart';
import 'package:startinsights/Widgets/mandatoryText.dart';

class RegisterSecond extends StatefulWidget {
  RegisterSecond({
    super.key,
  });

  @override
  State<RegisterSecond> createState() => _RegisterSecondState();
}

class _RegisterSecondState extends State<RegisterSecond> {
  @override
  final TextEditingController passwordController = TextEditingController();
  late RegisterBloc mRegisterBloc;
  bool checkedValue = false;
  bool passwordVisible = false;
  int mSelectUser = 0;
  String mSelectedUser = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    mRegisterBloc = RegisterBloc(mContext: context);

    void OnLoadNext() {
      // Navigator.pushReplacementNamed(context, loginRoute);
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
          resizeToAvoidBottomInset: false,
          body: BlocConsumer<RegisterBloc, RegisterStatus>(
            listener: (context, state) {},
            builder: (context, state) {
              return SafeArea(
                  child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.only(
                    top: 30, left: 40, right: 20, bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0),
                  image: const DecorationImage(
                    image: AssetImage("assets/new_login_bg.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Container(
                  child: Stack(children: [
                    Image.asset('assets/new_appicon.png',
                        width: 200, height: 60),
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
                                          top: 10,
                                          left: 40,
                                          right: 30,
                                          bottom: 10),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              Languages.of(context)!
                                                  .mLETSGETYOUSTARTED,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  fontFamily:
                                                      'OpenSauceSansRegular',
                                                  fontSize: mSizeOne,
                                                  color: mGreySeven),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              Languages.of(context)!
                                                  .mCreateanAccount,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  fontFamily:
                                                      'OpenSauceSansBold',
                                                  fontSize: mSizeSix,
                                                  color: mBlackOne),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.text,
                                                  controller:
                                                      passwordController,
                                                  obscureText: !passwordVisible,
                                                  maxLines: 1,
                                                  maxLength:
                                                      16, //This will obscure text dynamically
                                                  decoration: InputDecoration(
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
                                                      suffixIcon: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween, // added line
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            IconButton(
                                                              icon: const Icon(
                                                                // Based on passwordVisible state choose the icon
                                                                Icons
                                                                    .info_outline,
                                                                color:
                                                                    mGreyEigth,
                                                              ),
                                                              onPressed: () {
                                                                showDialog(
                                                                  context:
                                                                      context,
                                                                  builder: (ctx) =>
                                                                      AlertDialog(
                                                                    content: Text(
                                                                        Languages.of(context)!
                                                                            .mpasswordMessage,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontFamily:
                                                                              'OpenSauceSansRegular',
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              mGreyEigth,
                                                                        )),
                                                                    actions: <Widget>[
                                                                      TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(ctx)
                                                                              .pop();
                                                                        },
                                                                        child: Text(
                                                                            Languages.of(context)!
                                                                                .mok,
                                                                            style:
                                                                                const TextStyle(
                                                                              fontFamily: 'OpenSauceSansSemiBold',
                                                                              fontSize: 14,
                                                                              color: mGreyEigth,
                                                                            )),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                );
                                                              },
                                                            ),
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
                                                            )
                                                          ]),
                                                      alignLabelWithHint: true,
                                                      hintStyle:
                                                          const TextStyle(
                                                        color: kGray,
                                                      ),
                                                      isDense:
                                                          true, // Added this

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
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: mGreyFour,
                                                                  width: 1)),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                                color:
                                                                    mGreyFour,
                                                                width: 1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: const BorderSide(width: 1, color: mGreyFour)),
                                                      fillColor: mLightColorOne,
                                                      filled: true)),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Container(
                                              child: MandatoryText(
                                                  mText: Languages.of(context)!
                                                      .mSelectType,
                                                  mFontfamily:
                                                      'OpenSauceSansRegular',
                                                  mFontsize: mSizeThree,
                                                  mColor: mBlackTwo),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  flex: 5,
                                                  child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          mSelectedUser =
                                                              "Startups";
                                                          mSelectUser = 1;
                                                        });
                                                      },
                                                      child: Container(
                                                          height: 40,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            color:
                                                                mLightColorOne,
                                                            border: (mSelectUser ==
                                                                    1)
                                                                ? Border.all(
                                                                    color:
                                                                        mBlueOne)
                                                                : Border.all(
                                                                    color:
                                                                        mGreyFour),
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              Languages.of(
                                                                      context)!
                                                                  .mStartups,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: const TextStyle(
                                                                  fontFamily:
                                                                      'OpenSauceSansRegular',
                                                                  fontSize:
                                                                      mSizeTen,
                                                                  color:
                                                                      mGreyEigth),
                                                            ),
                                                          ))),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  flex: 5,
                                                  child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          mSelectedUser =
                                                              "Investors";
                                                          mSelectUser = 2;
                                                        });
                                                      },
                                                      child: Container(
                                                        height: 40,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          color: mLightColorOne,
                                                          border: (mSelectUser ==
                                                                  2)
                                                              ? Border.all(
                                                                  color:
                                                                      mBlueOne)
                                                              : Border.all(
                                                                  color:
                                                                      mGreyFour),
                                                        ),
                                                        child: Center(
                                                            child: Text(
                                                          Languages.of(context)!
                                                              .mInvestors,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: const TextStyle(
                                                              fontFamily:
                                                                  'OpenSauceSansRegular',
                                                              fontSize:
                                                                  mSizeTen,
                                                              color:
                                                                  mGreyEigth),
                                                        )),
                                                      )),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 60,
                                            ),
                                            Align(
                                              alignment: Alignment.center,
                                              child: Button(
                                                  mButtonname:
                                                      Languages.of(context)!
                                                          .mContinuetoSignup,
                                                  onpressed: () {
                                                    if (passwordController
                                                        .text.isEmpty) {
                                                      ErrorToast(
                                                          context: context,
                                                          text: Languages.of(
                                                                  context)!
                                                              .mEnterPassword);
                                                    } else if (!isPasswordValid(
                                                        passwordController
                                                            .text)) {
                                                      ErrorToast(
                                                          context: context,
                                                          text:
                                                              "Not Valid  Password");
                                                    } else if (mSelectedUser
                                                        .isEmpty) {
                                                      ErrorToast(
                                                          context: context,
                                                          text: Languages.of(
                                                                  context)!
                                                              .mentercompanyname);
                                                    } else {
                                                      mRegisterBloc
                                                          .CreateAccountFinish(
                                                        usertype: mSelectedUser,
                                                        password:
                                                            passwordController
                                                                .text,
                                                      );
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
                                                  border: Border.all(
                                                      color: mGreyOne),
                                                ),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
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
                                                              fontSize:
                                                                  mSizeThree,
                                                              fontFamily:
                                                                  'OpenSauceSansBold',
                                                              color:
                                                                  mBlueColor))
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
                                                            .mAlreadyaMember,
                                                        style: const TextStyle(
                                                            fontSize: mSizeTwo,
                                                            fontFamily:
                                                                'OpenSauceSansRegular',
                                                            color: mGreyEigth)),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        GoRouter.of(context)
                                                            .go('/Login');
                                                      },
                                                      child: Text(
                                                          Languages.of(context)!
                                                              .mLOGIN,
                                                          style: const TextStyle(
                                                              fontSize:
                                                                  mSizeTwo,
                                                              fontFamily:
                                                                  'OpenSauceSansBold',
                                                              color:
                                                                  mBlackOne)),
                                                    ),
                                                  ]),
                                            ),
                                          ])),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Image.asset(
                                      'assets/new_ic_loginimg.png',
                                      fit: BoxFit.fill),
                                )
                              ]),
                        ))
                  ]),
                ),
              ));
            },
          )),
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
