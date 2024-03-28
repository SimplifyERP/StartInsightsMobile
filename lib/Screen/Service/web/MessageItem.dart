import 'package:flutter/material.dart';
import 'package:startinsights/Utils/FontSizes.dart';
import 'package:startinsights/Utils/MyColor.dart';

class MessageItem extends StatelessWidget {
  bool mMessageFrom;

  MessageItem({
    required this.mMessageFrom,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      //onTap: (() => selectMeal(context)),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment:
                  (mMessageFrom) ? Alignment.centerLeft : Alignment.centerRight,
              child: Container(
                width: 400,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: mBlueTwo,
                  border: Border.all(width: 1, color: mBlueTwo),
                ),
                child: Column(children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("You",
                        style: const TextStyle(
                            fontFamily: 'OpenSauceSansSemiBold',
                            fontSize: mSizeTen,
                            color: mBlueColor)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal ",
                        style: const TextStyle(
                            fontFamily: 'OpenSauceSansRegular',
                            fontSize: mSizeThree,
                            color: mGreyNine)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text("10-03-2022 10:55 AM",
                        style: const TextStyle(
                            fontFamily: 'OpenSauceSansMedium',
                            fontSize: mSizeNine,
                            color: mGreyNine)),
                  ),
                ]),
              ),
            ),
            SizedBox(
              height: 20,
            )
          ]),
    );
  }
}
