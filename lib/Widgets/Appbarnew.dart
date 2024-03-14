import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Utils/FontSizes.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Widgets/button.dart';
import 'package:startinsights/Widgets/sidemenunew.dart';

class AppbarNew extends StatelessWidget implements PreferredSizeWidget {
  AppbarNew({
    super.key,
    required this.mText,
    required this.mUserImage,
    required this.mFrom,
    // required this.onPressed,
    // required this.onPressedLogout,
  });
  final String mText;
  String mUserImage = "";
  int mFrom = 0;
  // final VoidCallback onPressed;
  // final VoidCallback onPressedLogout;

  @override
  Widget build(BuildContext context) {
    List<ProfileMenuItem> firstItems = [
      ProfileMenuItem(
          text: Languages.of(context)!.mprofile,
          icon: 'assets/new_ic_user.png',
          space: false),
      ProfileMenuItem(
          text: Languages.of(context)!.mAccountSettings,
          icon: 'assets/new_ic_settings.png',
          space: false),
      ProfileMenuItem(
          text: Languages.of(context)!.mCustomerSupport,
          icon: 'assets/new_ic_support.png',
          space: false),
    ];

    List<ProfileMenuItem> mLogoutItems = [
      ProfileMenuItem(
          text: Languages.of(context)!.mLogout,
          icon: 'assets/new_ic_signout.png',
          space: true),
    ];

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
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                GoRouter.of(context).go('/Deals');
                              },
                              child: mFrom == 10
                                  ? SvgPicture.asset(
                                      'assets/new_ic_dealsselect.svg',
                                      width: 40,
                                      height: 40,
                                    )
                                  : SvgPicture.asset(
                                      'assets/new_ic_deals.svg',
                                      width: 40,
                                      height: 40,
                                    ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
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
                          child: Center(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            customButton: Row(children: [
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
                            items: [
                              ...firstItems.map(
                                (item) => DropdownMenuItem<ProfileMenuItem>(
                                  value: item,
                                  child: buildItem(item),
                                ),
                              ),
                              DropdownMenuItem<Divider>(
                                alignment: Alignment.center,
                                enabled: false,
                                child: Container(
                                  width: 200,
                                  height: 1,
                                  color: mGreyFive,
                                ),
                              ),
                              ...mLogoutItems.map(
                                (item) => DropdownMenuItem<ProfileMenuItem>(
                                  value: item,
                                  child: buildItem(item),
                                ),
                              ),
                            ],
                            onChanged: (value) {
                              // print(value!.text);
                              onValueChanged(
                                  context, value! as ProfileMenuItem);
                            },
                            dropdownStyleData: DropdownStyleData(
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: mGreyThree, width: 2),
                                color: Colors.white,
                              ),
                              offset: const Offset(-130, -5),
                            ),
                          ),
                        ),
                      )

                          // InkWell(
                          //   // onTap: onPressed,
                          //   onTap: () {
                          //     OnLoadDialog(context);
                          //   },
                          //   child: Row(children: [
                          //     CircleAvatar(
                          //       radius: 20.0,
                          //       backgroundImage: const ExactAssetImage(
                          //           'assets/avathar.png',
                          //           scale: 30),
                          //       child: ClipOval(
                          //         child: Image.asset('assets/avathar.png',
                          //             width: 30, height: 30, fit: BoxFit.fill),
                          //       ),
                          //     ),
                          //   ]),
                          //   //     () {
                          //   //   onPressed:
                          //   //   onPressed;
                          //   // },
                          // ),
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
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(65);

  /* void OnLoadDialog(BuildContext context) {
    showDialog<void>(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context1, setState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              const SizedBox(
                height: 60,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.fromLTRB(0, 20, 20, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  border: Border.all(color: mGreyThree, width: 2),
                ),
                height: 220,
                width: 200,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Material(
                        child: InkWell(
                          hoverColor: Colors.white,
                          onTap: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/new_ic_user.png',
                                width: 20,
                                height: 20,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(Languages.of(context)!.mprofile,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontFamily: 'OpenSauceSansRegular',
                                      fontSize: mSizeThree,
                                      color: mGreyTen))
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Material(
                        child: InkWell(
                          hoverColor: Colors.white,
                          onTap: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/new_ic_settings.png',
                                width: 20,
                                height: 20,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(Languages.of(context)!.mAccountSettings,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontFamily: 'OpenSauceSansRegular',
                                      fontSize: mSizeThree,
                                      color: mGreyTen))
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Material(
                        child: InkWell(
                          hoverColor: Colors.white,
                          onTap: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/new_ic_support.png',
                                width: 20,
                                height: 20,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(Languages.of(context)!.mCustomerSupport,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontFamily: 'OpenSauceSansRegular',
                                      fontSize: mSizeThree,
                                      color: mGreyTen))
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 200,
                        height: 2,
                        color: mGreyFive,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Material(
                        child: InkWell(
                          hoverColor: Colors.white,
                          //onTap: onPressedLogout,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              Image.asset(
                                'assets/new_ic_signout.png',
                                width: 20,
                                height: 20,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(Languages.of(context)!.mLogout,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontFamily: 'OpenSauceSansRegular',
                                      fontSize: mSizeThree,
                                      color: mRedSix))
                            ],
                          ),
                        ),
                      ),
                    ]),
              )
            ],
          );
        });
      },
    );
  }*/

  static Widget buildItem(ProfileMenuItem item) {
    return Row(
      children: [
        Visibility(
            visible: item.space ? true : false,
            child: const SizedBox(
              width: 40,
            )),
        Image(
          width: 20,
          height: 20,
          image: AssetImage(
            item.icon,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child: Text(item.text,
                textAlign: TextAlign.start,
                style: const TextStyle(
                    fontFamily: 'OpenSauceSansRegular',
                    fontSize: mSizeThree,
                    color: mGreyTen))
            // Text(
            //   item.text,
            //   style: const TextStyle(
            //     color: Colors.white,
            //   ),
            // ),
            ),
      ],
    );
  }

  static void onValueChanged(BuildContext context, ProfileMenuItem item) {
    if (item.text == Languages.of(context)!.mprofile) {
      GoRouter.of(context).go('/Profile');
    } else if (item.text == Languages.of(context)!.mAccountSettings) {
    } else if (item.text == Languages.of(context)!.mCustomerSupport) {
    } else if (item.text == Languages.of(context)!.mLogout) {
      GoRouter.of(context).go('/Login');
    }
  }
}

class ProfileMenuItem {
  ProfileMenuItem({
    required this.text,
    required this.icon,
    required this.space,
  });

  final String text;
  final String icon;
  final bool space;
}

/*class ProfileMenuItems {
  static const List<ProfileMenuItem> firstItems = [
    like,
    share,
    download,
    download1,
    download2,
    download3
  ];

  static const like =
      ProfileMenuItem(text: Languages.of(context)!.mprofile, icon: 'assets/new_ic_user.png');
  static const share = ProfileMenuItem(text: 'Share', icon: "fsd");
  static const download = ProfileMenuItem(text: 'Downloaddgsgs', icon: "fsd");

  static Widget buildItem(ProfileMenuItem item) {
    return Row(
      children: [
        Image(
          width: 20,
          height: 20,
          image: AssetImage(
            item.icon,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child: Text(item.text,
                textAlign: TextAlign.start,
                style: const TextStyle(
                    fontFamily: 'OpenSauceSansRegular',
                    fontSize: mSizeThree,
                    color: mGreyTen))
            // Text(
            //   item.text,
            //   style: const TextStyle(
            //     color: Colors.white,
            //   ),
            // ),
            ),
      ],
    );
  }

  static void onValueChanged(BuildContext context, ProfileMenuItem item) {
    switch (item) {
      case ProfileMenuItems.like:
        //Do something
        print("like");
        break;
      case ProfileMenuItems.share:
        //Do something
        break;
      case ProfileMenuItems.download:
        //Do something
        break;
    }
  }
}*/
