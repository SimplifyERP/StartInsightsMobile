import 'package:flutter/material.dart';
import 'package:startinsights/Model/SearchinvestorslistResponse.dart';
import 'package:startinsights/Utils/FontSizes.dart';
import 'package:startinsights/Utils/MyColor.dart';

class SearchInvestorsItemList extends StatelessWidget {
  final int mIndex;
  final SearchInvestorsList mSearchInvestorsList;

  SearchInvestorsItemList({
    required this.mIndex,
    required this.mSearchInvestorsList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      //onTap: (() => selectMeal(context)),
      child: Container(
        height: 260,
        width: 260,
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
                                radius: 35.0,
                                backgroundColor: Colors.white,
                                child: ClipOval(
                                  child: Image.asset('assets/avathar.png',
                                      fit: BoxFit.fill),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Image.asset('assets/new_ic_check.png',
                                  width: 30, height: 30, fit: BoxFit.fill),
                            )
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
                                )
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
                  width: double.infinity,
                  padding: const EdgeInsets.only(right: 8, left: 8),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Arkstons Capital",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'OpenSauceSansBold',
                                fontSize: mSizeThree,
                                color: mBlackOne)),
                        SizedBox(
                          height: 5,
                        ),
                        Text("Arkstons Capital",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'OpenSauceSansRegular',
                                fontSize: mSizeTwo,
                                color: mGreySeven)),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 1,
                          color: mGreyThree,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                            "We invest in IoT, Fintech, SaaS, Tech, EdTech across stages. We invest in IoT, Fintech, SaaS, Tech, EdTech..........See more",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontFamily: 'OpenSauceSansRegular',
                                fontSize: mSizeTwo,
                                color: mGreySeven)),
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
                            const Center(
                              child: Text(" 10,000 -  50,000",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontFamily: 'OpenSauceSansRegular',
                                      fontSize: mSizeTwo,
                                      color: mGreySeven)),
                            ),
                          ],
                        )
                      ]),
                ),
              )
            ]),
      ),
    );
  }
}
