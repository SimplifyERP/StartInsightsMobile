import 'package:flutter/material.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Utils/screens.dart';

class ProfileAppbar extends StatelessWidget implements PreferredSizeWidget {
  ProfileAppbar({
    super.key,
    required this.mText,
    required this.mUserImage,
    required this.mFrom,
    required this.onPressed,
  });
  final String mText;
  String mUserImage = "";
  int mFrom = 0;
  final VoidCallback onPressed;

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
                      Navigator.pushReplacementNamed(context, dashboardRoute);
                    },
                    child: SizedBox(
                      height: 60,
                      width: MediaQuery.of(context).size.width / 2,
                      child: Row(children: [
                        const SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, dashboardRoute);
                          },
                          child: Icon(Icons.arrow_back,
                              size: 30, color: kprogressbarpitchcraft),
                        ),
                        const SizedBox(
                          width: 60,
                        ),
                        const Image(
                          width: 150,
                          height: 40,
                          image: AssetImage(
                            "assets/ic_appicon.png",
                          ),
                        ),
                        const SizedBox(
                          width: 60,
                        ),
                        Text(
                          Languages.of(context)!.mprofile,
                          style: const TextStyle(
                            color: mBlackColor,
                            fontFamily: 'ManropeBold',
                            fontSize: 22,
                          ),
                        )
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
                        SizedBox(
                          width: 120,
                          child: InkWell(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, loginRoute);
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    // Based on passwordVisible state choose the icon
                                    Icons.logout,
                                    color: mBlackColor,
                                    size: 25,
                                  ),
                                  Text(
                                    Languages.of(context)!.mLogout,
                                    style: const TextStyle(
                                      color: mBlackColor,
                                      fontFamily: 'ManropeSemiBold',
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              )),
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
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(65);
}
