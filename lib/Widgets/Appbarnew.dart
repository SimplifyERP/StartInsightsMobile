import 'package:flutter/material.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Widgets/button.dart';
import 'package:startinsights/Widgets/sidemenunew.dart';

class AppbarNew extends StatelessWidget implements PreferredSizeWidget {
  AppbarNew({
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
          height: 80,
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.white,
                blurRadius: 1.0,
              ),
            ],
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 30,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: SidemenuTextNew(
                            menuname: Languages.of(context)!.mDashboard,
                            textColor: mFrom == 1 ? mBlackColor : mGreyEigth,
                            isSelect: mFrom == 1 ? true : false,
                            fontSize: 14),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: SidemenuTextNew(
                            menuname: Languages.of(context)!.mFundraising,
                            textColor: mFrom == 2 ? mBlackColor : mGreyEigth,
                            isSelect: mFrom == 2 ? true : false,
                            fontSize: 14),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: SidemenuTextNew(
                            menuname: Languages.of(context)!.mResources,
                            textColor: mFrom == 3 ? mBlackColor : mGreyEigth,
                            isSelect: mFrom == 3 ? true : false,
                            fontSize: 14),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SidemenuTextNew(
                          menuname: Languages.of(context)!.mServices,
                          textColor: mFrom == 4 ? mBlackColor : mGreyEigth,
                          isSelect: mFrom == 4 ? true : false,
                          fontSize: 14),
                      const SizedBox(
                        width: 10,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: SidemenuTextNew(
                            menuname: Languages.of(context)!.mTools,
                            textColor: mFrom == 5 ? mBlackColor : mGreyEigth,
                            isSelect: mFrom == 5 ? true : false,
                            fontSize: 14),
                      ),
                    ]),
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
                      const SizedBox(
                        width: 30,
                      ),
                      Button(
                          mButtonname: Languages.of(context)!.mUpgrade,
                          onpressed: () {},
                          mSelectcolor: mBtnColor,
                          mTextColor: mWhiteColor,
                          mFontSize: 16,
                          mWidth: 130,
                          mHeigth: 40),
                      const SizedBox(
                        width: 20,
                      ),
                      const SizedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              width: 40,
                              height: 40,
                              image: AssetImage(
                                "assets/new_ic_notifications.png",
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
                          onTap: () {},
                          child: Row(children: [
                            CircleAvatar(
                              radius: 20.0,
                              backgroundImage: const ExactAssetImage(
                                  'assets/avathar.png',
                                  scale: 30),
                              child: ClipOval(
                                child: Image.asset('assets/avathar.png',
                                    width: 30, height: 30, fit: BoxFit.fill),
                              ),
                            ),
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
          ),
        ),
      ],
    );

    /*Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          height: 80,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.white,
                blurRadius: 1.0,
              ),
            ],
          ),
          child: Text("dkgslkhg"),
        ),
      ],
    );*/

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
