import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.mButtonname,
    required this.onpressed,
    required this.mSelectcolor,
    required this.mTextColor,
    this.mFontSize = 18,
    this.mHeigth = 45,
  });

  final String mButtonname;
  final VoidCallback onpressed;
  final Color mSelectcolor;
  final Color mTextColor;
  final double mFontSize;
  final double mHeigth;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: onpressed,
        elevation: 5.0,
        child: Container(
          decoration: BoxDecoration(
            color: mSelectcolor,
            borderRadius: BorderRadius.circular(8),
          ),
          constraints: BoxConstraints(maxHeight: mHeigth),
          alignment: Alignment.center,
          child: Text(
            mButtonname,
            style: TextStyle(
                color: mTextColor,
                fontFamily: 'ManropeBold',
                fontSize: mFontSize,
                fontWeight: FontWeight.bold),
          ),
        ));
  }
}
