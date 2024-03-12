import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Screen/ForgetPassword/bloc/forgetpwd_bloc.dart';
import 'package:startinsights/Screen/ForgetPassword/bloc/forgwtpwd_state.dart';
import 'package:startinsights/Utils/FontSizes.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Widgets/auth_form_field.dart';

class ForgetPwd extends StatefulWidget {
  ForgetPwd({super.key});

  @override
  State<ForgetPwd> createState() => _ForgetPwdState();
}

class _ForgetPwdState extends State<ForgetPwd> {
  @override
  late ForgetPwdBloc mForgetPwdBloc;

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
    mForgetPwdBloc = ForgetPwdBloc(mContext: context);

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
