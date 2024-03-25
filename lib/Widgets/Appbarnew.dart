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
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 5,
                    child: Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width / 2,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: SidemenuTextNew(
                                  menuname: Languages.of(context)!.mDashboard,
                                  textColor:
                                      mFrom == 1 ? mBlackColor : mGreyEigth,
                                  isSelect: mFrom == 1 ? true : false,
                                  fontSize: 14),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: SidemenuTextNew(
                                  menuname: Languages.of(context)!.mFundraising,
                                  textColor:
                                      mFrom == 2 ? mBlackColor : mGreyEigth,
                                  isSelect: mFrom == 2 ? true : false,
                                  fontSize: 14),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: SidemenuTextNew(
                                  menuname: Languages.of(context)!.mResources,
                                  textColor:
                                      mFrom == 3 ? mBlackColor : mGreyEigth,
                                  isSelect: mFrom == 3 ? true : false,
                                  fontSize: 14),
                            ),
                            SidemenuTextNew(
                                menuname: Languages.of(context)!.mServices,
                                textColor:
                                    mFrom == 4 ? mBlackColor : mGreyEigth,
                                isSelect: mFrom == 4 ? true : false,
                                fontSize: 14),
                            Align(
                              alignment: Alignment.center,
                              child: SidemenuTextNew(
                                  menuname: Languages.of(context)!.mTools,
                                  textColor:
                                      mFrom == 5 ? mBlackColor : mGreyEigth,
                                  isSelect: mFrom == 5 ? true : false,
                                  fontSize: 14),
                            ),
                          ]),
                    )),
                Expanded(
                  flex: 5,
                  child: Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width / 2,
                      child: Row(
                        //ROW 1
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Button(
                              mButtonname: Languages.of(context)!.mUpgrade,
                              onpressed: () {},
                              mSelectcolor: mBtnColor,
                              mTextColor: mWhiteColor,
                              mFontSize: 16,
                              mWidth: 130,
                              mHeigth: 40),
                          const SizedBox(
                            width: 15,
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
                            width: 20,
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
                                          width: 30,
                                          height: 30,
                                          fit: BoxFit.fill),
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
                                    border:
                                        Border.all(color: mGreyThree, width: 2),
                                    color: Colors.white,
                                  ),
                                  offset: const Offset(-130, -5),
                                ),
                              ),
                            ),
                          )),
                          Container(
                            width: 30,
                          ),
                        ],
                      )),
                )
              ]),
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(65);

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
