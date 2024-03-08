import 'package:flutter/material.dart';
import 'package:startinsights/Utils/MyColor.dart';

class ServiceButton extends StatelessWidget {
  const ServiceButton({
    super.key,
    required this.mButtonname,
    required this.onpressed,
    this.mSelectcolor = mgradientThree,
    this.mhovercolor = mGreyTwo,
    required this.mTextColor,
    this.mFontSize = 18,
    this.mWidth = 200,
    this.mHeigth = 45,
  });

  final String mButtonname;
  final VoidCallback onpressed;
  final Color mSelectcolor;
  final Color mhovercolor;
  final Color mTextColor;
  final double mFontSize;
  final double mWidth;
  final double mHeigth;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: onpressed,
        textColor: Colors.white,
        hoverColor: mhovercolor,
        child: Container(
          width: mWidth,
          height: mHeigth,
          decoration: BoxDecoration(
            color: mSelectcolor,
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.all(5),
          child: Align(
              alignment: Alignment.center,
              child: Text(mButtonname,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'OpenSauceSansMedium',
                      fontSize: 14,
                      color: mTextColor))),
        ));
  }
}
