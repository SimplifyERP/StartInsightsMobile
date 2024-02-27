import 'package:flutter/material.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Widgets/expandedview.dart';

class CaptableItemList extends StatelessWidget {
  final int mIndex;

  CaptableItemList({
    required this.mIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      //onTap: (() => selectMeal(context)),
      child: Container(
          // decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(5),
          //     color: Colors.white,
          //     boxShadow: const [
          //       BoxShadow(
          //         color: Colors.grey,
          //         blurRadius: 1.0,
          //       ),
          //     ]),
          // height:
          //     MediaQuery.of(context).size.height * 23 / 100,
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
                ExpandedView(
                  mText: "Shurya Rajendran",
                  mHeight: 40,
                  mSelectcolor: Colors.white,
                  mTextColor: Colors.black,
                  mFontSize: 15,
                  mFontFamily: 'ManropeMedium',
                  mflex: 3,
                  malignment: Alignment.center,
                  mtextalign: TextAlign.center,
                  marqueeView: false,
                ),
                Container(
                  width: 0,
                  height: 40,
                  color: mTabelColor,
                ),
                ExpandedView(
                  mText: "23-12-2023",
                  mHeight: 40,
                  mSelectcolor: Colors.white,
                  mTextColor: Colors.black,
                  mFontSize: 15,
                  mFontFamily: 'ManropeMedium',
                  mflex: 3,
                  malignment: Alignment.center,
                  mtextalign: TextAlign.center,
                  marqueeView: false,
                ),
                Container(
                  width: 0,
                  height: 40,
                  color: mTabelColor,
                ),
                ExpandedView(
                  mText: "₹10,000",
                  mHeight: 40,
                  mSelectcolor: Colors.white,
                  mTextColor: Colors.black,
                  mFontSize: 15,
                  mFontFamily: 'ManropeMedium',
                  mflex: 3,
                  malignment: Alignment.center,
                  mtextalign: TextAlign.center,
                  marqueeView: false,
                ),
                Container(
                  width: 0,
                  height: 40,
                  color: mTabelColor,
                ),
                ExpandedView(
                  mText: "1,000",
                  mHeight: 40,
                  mSelectcolor: Colors.white,
                  mTextColor: Colors.black,
                  mFontSize: 15,
                  mFontFamily: 'ManropeMedium',
                  mflex: 3,
                  malignment: Alignment.center,
                  mtextalign: TextAlign.center,
                  marqueeView: false,
                ),
                Container(
                  width: 0,
                  height: 40,
                  color: mTabelColor,
                ),
                ExpandedView(
                  mText: "1,000",
                  mHeight: 40,
                  mSelectcolor: Colors.white,
                  mTextColor: Colors.black,
                  mFontSize: 15,
                  mFontFamily: 'ManropeMedium',
                  mflex: 3,
                  malignment: Alignment.center,
                  mtextalign: TextAlign.center,
                  marqueeView: false,
                ),
                Container(
                  width: 0,
                  height: 40,
                  color: mTabelColor,
                ),
                ExpandedView(
                  mText: "Equity",
                  mHeight: 40,
                  mSelectcolor: Colors.white,
                  mTextColor: Colors.black,
                  mFontSize: 15,
                  mFontFamily: 'ManropeMedium',
                  mflex: 3,
                  malignment: Alignment.center,
                  mtextalign: TextAlign.center,
                  marqueeView: false,
                ),
                Container(
                  width: 0,
                  height: 40,
                  color: mTabelColor,
                ),
                ExpandedView(
                  mText: "10.33%",
                  mHeight: 40,
                  mSelectcolor: Colors.white,
                  mTextColor: Colors.black,
                  mFontSize: 15,
                  mFontFamily: 'ManropeMedium',
                  mflex: 3,
                  malignment: Alignment.center,
                  mtextalign: TextAlign.center,
                  marqueeView: false,
                ),
              ],
            ),
            const SizedBox(
              height: 2,
            ),
          ])),
    );
  }
}
