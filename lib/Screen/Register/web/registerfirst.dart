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
import 'package:startinsights/Widgets/auth_form_field.dart';
import 'package:startinsights/Widgets/button.dart';

class RegisterFirst extends StatefulWidget {
  RegisterFirst({
    super.key,
  });

  @override
  State<RegisterFirst> createState() => _RegisterFirstState();
}

class _RegisterFirstState extends State<RegisterFirst> {
  @override
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  late RegisterBloc mRegisterBloc;
  bool checkedValue = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    emailController.dispose();
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
                                              child: AuthFormField(
                                                controller: nameController,
                                                textInputAction:
                                                    TextInputAction.next,
                                                keyboardType:
                                                    TextInputType.text,
                                                hintText: Languages.of(context)!
                                                    .mName,
                                                radius: 30,
                                                maxLength: 80,
                                                labelText:
                                                    Languages.of(context)!
                                                        .mName,
                                                mBorderView: false,
                                                mImageView: true,
                                                isMandatory: true,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              child: AuthFormField(
                                                controller: mobileController,
                                                textInputAction:
                                                    TextInputAction.next,
                                                keyboardType:
                                                    TextInputType.number,
                                                hintText: Languages.of(context)!
                                                    .mMobile,
                                                radius: 30,
                                                maxLength: 10,
                                                labelText:
                                                    Languages.of(context)!
                                                        .mMobile,
                                                mBorderView: false,
                                                mImageView: true,
                                                isMandatory: true,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
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
                                                    .mEmailAddress,
                                                radius: 30,
                                                maxLength: 80,
                                                labelText:
                                                    Languages.of(context)!
                                                        .mEmailAddress,
                                                mBorderView: false,
                                                mImageView: true,
                                                isMandatory: true,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Align(
                                              alignment: Alignment.center,
                                              child: Button(
                                                  mButtonname:
                                                      Languages.of(context)!
                                                          .mContinuetoSignup,
                                                  onpressed: () {
                                                    if (nameController
                                                        .text.isEmpty) {
                                                      ErrorToast(
                                                          context: context,
                                                          text: Languages.of(
                                                                  context)!
                                                              .mEnterName);
                                                    } else if (emailController
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
                                                    } else if (mobileController
                                                        .text.isEmpty) {
                                                      ErrorToast(
                                                          context: context,
                                                          text: Languages.of(
                                                                  context)!
                                                              .mEnterMobile);
                                                    } else if (!isMobileNumberValid(
                                                        mobileController
                                                            .text)) {
                                                      ErrorToast(
                                                          context: context,
                                                          text:
                                                              "Not Valid  Mobile");
                                                    } else {
                                                      mRegisterBloc
                                                          .CreateAccount(
                                                        firstname:
                                                            nameController.text,
                                                        phoneno:
                                                            mobileController
                                                                .text,
                                                        emailid: emailController
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
                                                        // GoRouter.of(context)
                                                        //     .go('/Login');
                                                        //GoRouter.of(context).go('RegisterComplet');
                                                        GoRouter.of(context).go(
                                                            '/Register/RegisterComplet');
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
