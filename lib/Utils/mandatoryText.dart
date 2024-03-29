import 'package:flutter/material.dart';
import 'package:startinsights/Utils/FontSizes.dart';
import 'package:startinsights/Utils/MyColor.dart';

class MandatoryText extends StatelessWidget {
  const MandatoryText({
    super.key,
    required this.mText,
  });
  final String mText;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: mText,
          style: const TextStyle(
              color: mGreyNine,
              fontFamily: 'OpenSauceSansMedium',
              fontSize: mSizeThree),
          children: const [
            TextSpan(
                text: ' *',
                style: TextStyle(
                    color: Colors.red,
                    fontFamily: 'OpenSauceSansMedium',
                    fontSize: mSizeThree))
          ]),
    );
  }
}
