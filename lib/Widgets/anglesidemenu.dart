import 'package:flutter/material.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Network/di.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Utils/StorageServiceConstant.dart';
import 'package:startinsights/Utils/pref_manager.dart';
import 'package:startinsights/Utils/screens.dart';
import 'package:startinsights/Widgets/primary_button.dart';

// MFrom 1-> dashboard  6->startupschool
class AngleSideMenu extends StatelessWidget {
  int mFrom = 0;
  AngleSideMenu({
    super.key,
    required this.mFrom,
  });

  Future<void> onLoad() async {
    mClickPich = await sl<StorageService>()
            .getString(StorageServiceConstant.MCLICKPITCH) ??
        false;
  }

  bool mClickPich = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBorderColor,
      margin: const EdgeInsets.only(top: 0, left: 0, right: 2),
      child: Container(
          color: mWhiteColor,
          height: MediaQuery.of(context).size.height,
          child: Container(
            margin: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
            child: Column(
              children: [
                Expanded(
                  flex: 8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(
                                  color:
                                      mFrom == 1 ? Colors.black : Colors.white,
                                  border: Border.all(
                                    color: mStatusbar,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                    child: InkWell(
                                      onTap: () {},
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(children: [
                                          Expanded(
                                              flex: 2,
                                              child: mFrom == 1
                                                  ? const sidemenuImage(
                                                      menuicon:
                                                          'assets/ic_dashboardwhite.png')
                                                  : const sidemenuImage(
                                                      menuicon:
                                                          'assets/ic_dashboard.png')), //ic_dashboardwhite
                                          Expanded(
                                              flex: 8,
                                              child: SidemenuText(
                                                  menuname:
                                                      Languages.of(context)!
                                                          .mDashboard,
                                                  textColor: mFrom == 1
                                                      ? mWhiteColor
                                                      : mBlackColor)),
                                        ]),
                                      ),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(
                                  color:
                                      mFrom == 2 ? Colors.black : Colors.white,
                                  border: Border.all(
                                    color: mStatusbar,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                    child: InkWell(
                                      onTap: () {
                                        sl<StorageService>().setBool(
                                            StorageServiceConstant.MCLICKPITCH,
                                            false);
                                        Navigator.pushReplacementNamed(
                                            context, startupSchoolRoute);
                                      },
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(children: [
                                          Expanded(
                                              flex: 2,
                                              child: mFrom == 2
                                                  ? const sidemenuImage(
                                                      menuicon:
                                                          'assets/ic_angelinvestingwhite.png')
                                                  : const sidemenuImage(
                                                      menuicon:
                                                          'assets/ic_angelinvesting.png')), //ic_schoolwhite
                                          Expanded(
                                              flex: 8,
                                              child: SidemenuText(
                                                  menuname:
                                                      Languages.of(context)!
                                                          .mBAngelInvesting,
                                                  textColor: mFrom == 2
                                                      ? mWhiteColor
                                                      : mBlackColor)),
                                        ]),
                                      ),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(
                                  color:
                                      mFrom == 3 ? Colors.black : Colors.white,
                                  border: Border.all(
                                    color: mStatusbar,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                    child: InkWell(
                                      onTap: () {
                                        sl<StorageService>().setBool(
                                            StorageServiceConstant.MCLICKPITCH,
                                            false);
                                        Navigator.pushReplacementNamed(
                                            context, investmentdealsRoute);
                                      },
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(children: [
                                          Expanded(
                                              flex: 2,
                                              child: mFrom == 3
                                                  ? const sidemenuImage(
                                                      menuicon:
                                                          'assets/ic_investmentdeals_white.png')
                                                  : const sidemenuImage(
                                                      menuicon:
                                                          'assets/ic_investmentdeals.png')),
                                          Expanded(
                                              flex: 8,
                                              child: SidemenuText(
                                                  menuname:
                                                      Languages.of(context)!
                                                          .mInvestmentDeals,
                                                  textColor: mFrom == 3
                                                      ? mWhiteColor
                                                      : mBlackColor)),
                                        ]),
                                      ),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            Languages.of(context)!.mHireourteam,
                            style: const TextStyle(
                                fontFamily: 'OpenSansBold',
                                fontSize: 22.0,
                                color: mBlackColor),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                              width: 150,
                              child: PrimaryButton(
                                  mButtonname:
                                      Languages.of(context)!.mContactUs,
                                  onpressed: () {},
                                  mSelectcolor: mBtnColor,
                                  mTextColor: mWhiteColor,
                                  mFontSize: 16,
                                  mHeigth: 40)),
                        ),
                      ]),
                )
              ],
            ),
          )),
    );
  }
}

class sidemenuImage extends StatelessWidget {
  const sidemenuImage({
    super.key,
    required this.menuicon,
  });
  final String menuicon;
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      menuicon,
      height: 20,
    );
  }
}

class SidemenuText extends StatelessWidget {
  const SidemenuText({
    super.key,
    required this.menuname,
    required this.textColor,
  });

  final String menuname;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      child: Text(menuname,
          style: TextStyle(
              fontFamily: 'ManropeBold', fontSize: 18, color: textColor)),
    );
  }
}
