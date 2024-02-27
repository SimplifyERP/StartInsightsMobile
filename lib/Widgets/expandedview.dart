import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class ExpandedView extends StatelessWidget {
  const ExpandedView(
      {super.key,
      required this.mText,
      required this.mHeight,
      required this.mSelectcolor,
      required this.mTextColor,
      required this.mFontSize,
      required this.mFontFamily,
      required this.mflex,
      required this.malignment,
      required this.mtextalign,
      required this.marqueeView});

  final String mText;
  final AlignmentGeometry malignment;
  final TextAlign mtextalign;
  final double mHeight;
  final Color mSelectcolor;
  final Color mTextColor;
  final double mFontSize;
  final String mFontFamily;
  final int mflex;
  final bool marqueeView;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: mflex,
      child: Container(
        height: mHeight,
        color: mSelectcolor,
        child: Align(
          alignment: malignment,
          child: marqueeView
              ? Marquee(
                  text: mText,
                  style: TextStyle(
                    color: mTextColor,
                    fontFamily: mFontFamily,
                    fontSize: mFontSize,
                  ),
                  scrollAxis: Axis.horizontal,
                  blankSpace: 40.0,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  pauseAfterRound: const Duration(seconds: 2),
                  startPadding: 5,
                )
              : Text(
                  mText,
                  textAlign: mtextalign,
                  style: TextStyle(
                    color: mTextColor,
                    fontFamily: mFontFamily,
                    fontSize: mFontSize,
                  ),
                ),
        ),
      ),
    );
  }
}
