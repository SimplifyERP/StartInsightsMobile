import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_network/image_network.dart';
import 'package:startinsights/Libery/readmore.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Model/SearchinvestorslistResponse.dart';
import 'package:startinsights/Utils/FontSizes.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Utils/utils.dart';
import 'package:startinsights/Widgets/primary_button.dart';

class SearchInvestorsItemList extends StatelessWidget {
  final int mIndex;
  final SearchInvestorsList mSearchInvestorsList;
  final VoidCallback RemoveFavonpressed;
  final VoidCallback AddFavonpressed;

  const SearchInvestorsItemList({
    required this.mIndex,
    required this.mSearchInvestorsList,
    required this.RemoveFavonpressed,
    required this.AddFavonpressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      //onTap: (() => selectMeal(context)),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: mGreyTwo,
          boxShadow: const [
            BoxShadow(
              color: mGreyTwo,
              blurRadius: 0,
            ),
          ],
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  height: 100,
                  width: double.infinity,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Stack(children: [
                            Align(
                              alignment: Alignment.center,
                              child: CircleAvatar(
                                radius: 40.0,
                                backgroundColor: Colors.white,
                                child: ClipOval(
                                  child: (mSearchInvestorsList.logo!.isNotEmpty)
                                      ? ImageNetwork(
                                          image:
                                              mSearchInvestorsList.logo ?? "",
                                          height: 100,
                                          width: 100,
                                        )
                                      : Image.asset('assets/avathar.png',
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.fill),
                                ),
                              ),
                            ),
                            (mSearchInvestorsList!.investorVerified! == 1)
                                ? Align(
                                    alignment: Alignment.topRight,
                                    child: Image.asset(
                                        'assets/new_ic_check.png',
                                        width: 30,
                                        height: 30,
                                        fit: BoxFit.fill),
                                  )
                                : const Text("")
                          ]),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          flex: 6,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 90,
                                  child: ListView.builder(
                                    itemCount: (mSearchInvestorsList
                                                .fundingStagesTable!.length >
                                            3)
                                        ? 3
                                        : mSearchInvestorsList
                                            .fundingStagesTable!.length,
                                    itemBuilder: (context, position) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: mGreyThree,
                                          boxShadow: const [
                                            BoxShadow(
                                              color: mGreyThree,
                                              blurRadius: 0,
                                            ),
                                          ],
                                        ),
                                        padding: const EdgeInsets.only(
                                            left: 5, right: 5),
                                        margin: const EdgeInsets.only(
                                            left: 0,
                                            right: 0,
                                            bottom: 5,
                                            top: 5),
                                        height: 20,
                                        width: double.maxFinite,
                                        child: (position > 1)
                                            ? Center(
                                                child: Text(
                                                    "+ ${mSearchInvestorsList.fundingStagesTable!.length - 2}",
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        fontFamily:
                                                            'OpenSauceSansRegular',
                                                        fontSize: mSizeNine,
                                                        color: mGreyNine)))
                                            : Center(
                                                child: Text(
                                                    mSearchInvestorsList
                                                            .fundingStagesTable![
                                                                position]
                                                            .fundingStages! ??
                                                        "",
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        fontFamily:
                                                            'OpenSauceSansRegular',
                                                        fontSize: mSizeNine,
                                                        color: mGreyNine))),
                                      );
                                    },
                                  ),
                                )

                                /* Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: mGreyThree,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: mGreyThree,
                                        blurRadius: 0,
                                      ),
                                    ],
                                  ),
                                  padding:
                                      const EdgeInsets.only(left: 5, right: 5),
                                  height: 25,
                                  width: (double.infinity),
                                  child: const Center(
                                      child: Text("Early Stage",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily:
                                                  'OpenSauceSansRegular',
                                              fontSize: mSizeThree,
                                              color: mGreyNine))),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: mGreyThree,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: mGreyThree,
                                        blurRadius: 0,
                                      ),
                                    ],
                                  ),
                                  height: 25,
                                  width: (double.infinity),
                                  child: const Center(
                                      child: Text("Early Stage",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily:
                                                  'OpenSauceSansRegular',
                                              fontSize: mSizeThree,
                                              color: mGreyNine))),
                                )*/
                              ]),
                        )
                      ]),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                flex: 7,
                child: Container(
                  padding: const EdgeInsets.only(right: 8, left: 8),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(mSearchInvestorsList.title ?? "",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontFamily: 'OpenSauceSansBold',
                                fontSize: mSizeThree,
                                color: mBlackOne)),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(mSearchInvestorsList.firmType ?? "",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontFamily: 'OpenSauceSansRegular',
                                fontSize: mSizeTwo,
                                color: mGreySeven)),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 1,
                          color: mGreyThree,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ReadMoreText(
                          mSearchInvestorsList.aboutUs ?? "",
                          trimLines: 3,
                          preDataTextStyle: const TextStyle(
                              fontFamily: 'OpenSauceSansRegular',
                              fontSize: mSizeOne,
                              height: 1.5,
                              color: mGreySeven),
                          style: const TextStyle(
                              fontFamily: 'OpenSauceSansRegular',
                              fontSize: mSizeOne,
                              height: 1.5,
                              color: mGreySeven),
                          colorClickableText: mBlueOne,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: 'See more',
                          trimExpandedText: ' show less',
                          onpressed: () {
                            ErrorToast(context: context, text: "Testt");
                          },
                        ),

                        /* Text(mSearchInvestorsList.aboutUs ?? "",
                            textAlign: TextAlign.start,
                            maxLines: 3,
                            style: const TextStyle(
                                fontFamily: 'OpenSauceSansRegular',
                                fontSize: mSizeOne,
                                height: 1.5,
                                color: mGreySeven)),*/
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 1,
                          color: mGreyThree,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset('assets/new_ic_money_bag.png',
                                width: 20, height: 20, fit: BoxFit.fill),
                            const SizedBox(
                              width: 5,
                            ),
                            Center(
                              child: Text(
                                  "${Languages.of(context)!.rupess} ${mSearchInvestorsList.minCheckSize} - ${mSearchInvestorsList.maxCheckSize}",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontFamily: 'OpenSauceSansRegular',
                                      fontSize: mSizeTwo,
                                      color: mGreySeven)),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 8,
                              child: PrimaryButton(
                                  mButtonname: Languages.of(context)!.mSendDeck,
                                  onpressed: () async {},
                                  mSelectcolor: mBlueOne,
                                  mTextColor: mWhiteColor,
                                  mFontSize: mSizeTwo,
                                  mHeigth: 40),
                            ),
                            Expanded(
                              flex: 2,
                              child: Align(
                                  alignment: Alignment.center,
                                  child: InkWell(
                                    onTap: (mSearchInvestorsList!
                                            .favouritesStatus!)
                                        ? RemoveFavonpressed
                                        : AddFavonpressed,
                                    child: (mSearchInvestorsList!
                                            .favouritesStatus!)
                                        ? SvgPicture.asset(
                                            'assets/new_ic_heart.svg',
                                            width: 25,
                                            height: 25,
                                          )
                                        // Image.asset('assets/new_ic_heart.png',
                                        //         width: 25,
                                        //         height: 25,
                                        //         fit: BoxFit.fill)
                                        : SvgPicture.asset(
                                            'assets/new_ic_emptyheart.svg',
                                            width: 25,
                                            height: 25,
                                            fit: BoxFit.fill),
                                  )),
                            )
                          ],
                        ),
                      ]),
                ),
              )
            ]),
      ),
    );
  }
}
