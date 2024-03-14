import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Screen/ForgetPassword/bloc/forgetpwd_bloc.dart';
import 'package:startinsights/Screen/ForgetPassword/bloc/forgwtpwd_state.dart';
import 'package:startinsights/Utils/FontSizes.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Widgets/button.dart';

class ForgetPwd extends StatefulWidget {
  final String? mEmailid;
  ForgetPwd({super.key, required this.mEmailid});

  @override
  State<ForgetPwd> createState() => _ForgetPwdState();
}

class _ForgetPwdState extends State<ForgetPwd> {
  @override
  late ForgetPwdBloc mForgetPwdBloc;

  bool mMailcall = true;

  final TextEditingController emailController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    mForgetPwdBloc =
        ForgetPwdBloc(mContext: context, mEmailid: widget.mEmailid);

    if (mMailcall) {
      mForgetPwdBloc.forgetPwd(mEmailid: widget.mEmailid ?? "");
      mMailcall = false;
    }

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
                                          'assets/new_ic_panda.svg',
                                          width: 120,
                                          height: 120,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          Languages.of(context)!.mCheckyourMail,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontFamily: 'OpenSauceSansBold',
                                              fontSize: mSizeSix,
                                              color: mBlackOne),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: Languages.of(context)!
                                                      .mforgetpwdmsg,
                                                  style: const TextStyle(
                                                      fontFamily:
                                                          'OpenSauceSansMedium',
                                                      fontSize: mSizeThree,
                                                      color: mGreySeven)),
                                              TextSpan(
                                                  text: widget.mEmailid,
                                                  style: const TextStyle(
                                                      fontFamily:
                                                          'OpenSauceSansSemiBold',
                                                      fontSize: mSizeThree,
                                                      color: mBlackTwo)),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: Languages.of(context)!
                                                      .mnotreceiveMail,
                                                  style: const TextStyle(
                                                      fontFamily:
                                                          'OpenSauceSansMedium',
                                                      fontSize: mSizeTwo,
                                                      color: mGreySeven)),
                                              TextSpan(
                                                text: Languages.of(context)!
                                                    .mResentEmail,
                                                style: const TextStyle(
                                                    fontFamily:
                                                        'OpenSauceSansSemiBold',
                                                    fontSize: mSizeTwo,
                                                    color: mBlackTwo),
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () {
                                                        // Single tapped.
                                                      },
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Button(
                                            mButtonname: Languages.of(context)!
                                                .mBacktoLogin,
                                            onpressed: () {
                                              GoRouter.of(context).go('/Login');
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
