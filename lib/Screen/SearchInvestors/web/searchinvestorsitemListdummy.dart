import 'package:flutter/material.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Model/SearchinvestorslistResponse.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Widgets/expandedview.dart';
import 'package:startinsights/Widgets/primary_button.dart';

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
          width: double.infinity,
          //padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
          margin: const EdgeInsets.fromLTRB(1, 1, 1, 1),
          child: Column(children: <Widget>[
            Row(
              children: [
                Container(
                  width: 0,
                  height: 40,
                  color: mTabelColor,
                ),
                mTableTitle(
                    mSearchInvestorsList.title ?? "", 14, 4, mBlackColor),
                mTableSpace(),
                mTableTitle(mSearchInvestorsList.hq ?? "", 14, 3, mBlackColor),
                mTableSpace(),
                mTableTitle(
                    "${mSearchInvestorsList.minCheckSize.toString() ?? ""} to \n${mSearchInvestorsList.maxCheckSize.toString() ?? ""}",
                    14,
                    2,
                    mBlackColor),
                mTableSpace(),
                mTableTitle(
                    interpolate(mSearchInvestorsList!.fundingStagesTable!),
                    14,
                    3,
                    mBlackColor),
                mTableSpace(),
                mTableTitle(
                    mSearchInvestorsList.aboutUs ?? "", 14, 6, mBlackColor),
                mTableSpace(),
                Expanded(
                    flex: 3,
                    child: Container(
                        height: 40,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: mBtnColor,
                            border: Border.all(
                              color: mBtnColor,
                              width: 1,
                            )),
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: InkWell(
                              child: Align(
                                alignment: Alignment.center,
                                child: PrimaryButton(
                                    mButtonname:
                                        Languages.of(context)!.mPrevious,
                                    onpressed: () {},
                                    mSelectcolor: mBtnColor,
                                    mTextColor: mWhiteColor,
                                    mFontSize: 16,
                                    mHeigth: 40),
                              ),
                            )))),
                mTableSpace(),
              ],
            ),
            const SizedBox(
              height: 2,
            ),
          ])),
    );
  }

  String interpolate(List<FundingStagesTable> params) {
    String result = "";
    for (int i = 1; i < params.length + 1; i++) {
      result = "$result $i . ${params[i - 1].fundingStages ?? ""}\n";
    }

    return result;
  }

  Widget mTableTitle(String title, double textsize, int flexsize, Color black) {
    return ExpandedView(
      mText: title,
      mHeight: 40,
      mSelectcolor: Colors.white,
      mTextColor: black,
      mFontSize: textsize,
      mFontFamily: 'ManropeRegular',
      mflex: flexsize,
      malignment: Alignment.center,
      mtextalign: TextAlign.left,
      marqueeView: false,
    );
    ;
  }

  Widget mTableSpace() {
    return Container(
      width: 0,
      height: 40,
      color: mTabelColor,
    );
  }
}
