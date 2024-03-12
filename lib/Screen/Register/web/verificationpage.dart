import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Screen/Register/bloc/register_bloc.dart';
import 'package:startinsights/Screen/Register/bloc/register_state.dart';
import 'package:startinsights/Utils/FontSizes.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Utils/utils.dart';
import 'package:startinsights/Widgets/auth_form_field.dart';
import 'package:startinsights/Widgets/button.dart';

class VerificationPage extends StatefulWidget {
  VerificationPage({
    super.key,
  });

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  @override
  final TextEditingController VerifyCodeController = TextEditingController();
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
    VerifyCodeController.dispose();
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
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              Languages.of(context)!
                                                  .mWelcometoStartInsights,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  fontFamily:
                                                      'OpenSauceSansBold',
                                                  fontSize: mSizeSix,
                                                  color: mBlackOne),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              Languages.of(context)!
                                                  .mWelcomemsg,
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                  fontFamily:
                                                      'OpenSauceSansRegular',
                                                  fontSize: mSizeThree,
                                                  color: mGreySeven),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              child: AuthFormField(
                                                controller:
                                                    VerifyCodeController,
                                                textInputAction:
                                                    TextInputAction.next,
                                                keyboardType:
                                                    TextInputType.text,
                                                hintText: Languages.of(context)!
                                                    .mVerifyCode,
                                                radius: 30,
                                                maxLength: 80,
                                                labelText:
                                                    Languages.of(context)!
                                                        .mVerifyCode,
                                                mBorderView: false,
                                                mImageView: true,
                                                isMandatory: true,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            const SizedBox(
                                              height: 60,
                                            ),
                                            Align(
                                              alignment: Alignment.center,
                                              child: Button(
                                                  mButtonname:
                                                      Languages.of(context)!
                                                          .mVerifyCode,
                                                  onpressed: () {
                                                    if (VerifyCodeController
                                                        .text.isEmpty) {
                                                      ErrorToast(
                                                          context: context,
                                                          text: Languages.of(
                                                                  context)!
                                                              .mEnterVerifyCode);
                                                    } else {
                                                      mRegisterBloc
                                                          .CreateInvestorsAccount(
                                                        Verfiycode:
                                                            VerifyCodeController
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
