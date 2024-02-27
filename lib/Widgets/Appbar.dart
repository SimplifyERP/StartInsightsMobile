import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Utils/screens.dart';

import '../Utils/utils.dart';

class Appbar extends StatelessWidget implements PreferredSizeWidget {
  Appbar({
    super.key,
    required this.mText,
    required this.mUserImage,
    required this.mFrom,
    required this.onPressed,
    required this.onPressedLogout,
  });
  final String mText;
  String mUserImage = "";
  int mFrom = 0;
  final VoidCallback onPressed;
  final VoidCallback onPressedLogout;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            width: MediaQuery.of(context).size.width,
            color: mWhiteColor,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: () {
                      if (mFrom == 1) {
                      } else {
                        Navigator.pushReplacementNamed(context, dashboardRoute);
                      }
                    },
                    child: SizedBox(
                      height: 60,
                      width: MediaQuery.of(context).size.width / 2,
                      child: const Row(children: [
                        SizedBox(
                          width: 60,
                        ),
                        Image(
                          width: 200,
                          height: 45,
                          image: AssetImage(
                            "assets/ic_appicon.png",
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 60,
                    child: Row(
                      //ROW 1
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Container(
                        //   width: 150,
                        //   height: 40,
                        //   child: Align(
                        //     alignment: Alignment.center,
                        //     child: Container(
                        //       width: 150,
                        //       child: PrimaryButton(
                        //           mButtonname: Languages.of(context)!.mUpgrade,
                        //           onpressed: () {},
                        //           mSelectcolor: mBtnColor,
                        //           mTextColor: mWhiteColor,
                        //           mFontSize: 16,
                        //           mHeigth: 35),
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(
                        //   width: 120,
                        //   child: Column(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       const Image(
                        //         width: 25,
                        //         height: 25,
                        //         image: AssetImage(
                        //           "assets/ic_chat.png",
                        //         ),
                        //       ),
                        //       Text(
                        //         Languages.of(context)!.mLivechat,
                        //         style: const TextStyle(
                        //           color: mBlackColor,
                        //           fontFamily: 'ManropeSemiBold',
                        //           fontSize: 14,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        SizedBox(
                          width: 120,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Image(
                                width: 25,
                                height: 25,
                                image: AssetImage(
                                  "assets/ic_notifications.png",
                                ),
                              ),
                              Text(
                                Languages.of(context)!.mNotification,
                                style: const TextStyle(
                                  color: mBlackColor,
                                  fontFamily: 'ManropeSemiBold',
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Container(
                          child: InkWell(
                            // onTap: onPressed,
                            onTap: () {
                              showDialog<void>(
                                barrierDismissible: true,
                                context: context,
                                builder: (BuildContext context) {
                                  return StatefulBuilder(
                                      builder: (context1, setState) {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        const SizedBox(
                                          height: 60,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 0, 10, 0),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Colors.white,
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Colors.white,
                                                  blurRadius: 1.0,
                                                ),
                                              ]),
                                          height: 250,
                                          width: 150,
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Material(
                                                      color: Colors.white,
                                                      child: InkWell(
                                                        onTap: onPressed,
                                                        child: const Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Icon(
                                                                // Based on passwordVisible state choose the icon
                                                                Icons
                                                                    .account_circle_outlined,
                                                                color: kGray,
                                                                size: 20,
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              SidemenuText(
                                                                  menuname:
                                                                      "Profile")
                                                            ]),
                                                      )),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Material(
                                                      color: Colors.white,
                                                      child: InkWell(
                                                        onTap: onPressedLogout,
                                                        child: const Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Icon(
                                                                // Based on passwordVisible state choose the icon
                                                                Icons.logout,
                                                                color: kGray,
                                                                size: 20,
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              SidemenuText(
                                                                  menuname:
                                                                      "Logout")
                                                            ]),
                                                      )),
                                                )
                                              ]),
                                        )
                                      ],
                                    );
                                  });
                                },
                              );
                            },
                            child: Row(children: [
                              CircleAvatar(
                                radius: 20.0,
                                backgroundImage: const ExactAssetImage(
                                    'assets/avathar.png',
                                    scale: 30),
                                child: ClipOval(
                                  child: (mUserImage.isNotEmpty)
                                      ? ImageNetwork(
                                          image: mUserImage,
                                          height: 30,
                                          width: 30,
                                        )
                                      : Image.asset('assets/avathar.png',
                                          width: 30,
                                          height: 30,
                                          fit: BoxFit.fill),
                                ),
                              ),
                              const Icon(Icons.arrow_drop_down_outlined,
                                  size: 30)
                            ]),
                            //     () {
                            //   onPressed:
                            //   onPressed;
                            // },
                          ),
                        ),
                        Container(
                          width: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )

            // Row(children: [
            //   const SizedBox(
            //     width: 70,
            //   ),
            //   const Image(
            //     width: 200,
            //     height: 45,
            //     image: AssetImage(
            //       "assets/ic_appicon.png",
            //     ),
            //   ),
            //   Align(
            //     alignment: Alignment.centerRight,
            //     child: MandatoryText(mText: Languages.of(context)!.mEnterMobile),
            //   ),
            // ]),
            ),
        Container(
          color: kBorderColor,
          height: 2,
          width: MediaQuery.of(context).size.width,
        ),
      ],
    );

    //   PreferredSize(
    //   preferredSize: Size.fromHeight(120), // Set this height
    //   child: Container(
    //     color: Colors.orange,
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         Text('One'),
    //         Text('Two'),
    //         Text('Three'),
    //         Text('Four'),
    //       ],
    //     ),
    //   ),
    // )
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(65);
}
