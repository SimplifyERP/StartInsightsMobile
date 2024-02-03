import 'package:flutter/material.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Utils/constant_methods.dart';

class BookingView extends StatelessWidget {
  // Map<String, String> mDayeventsList;
  String mStartTime;
  String mEndTime;
  bool mStatus;
  BookingView({
    required this.mStartTime,
    required this.mEndTime,
    required this.mStatus,
    super.key,
  });

  void selectMeal(BuildContext context) {}

  final String mUserImage = "";

  @override
  Widget build(BuildContext context) {
    return InkWell(
      //onTap: (() => selectMeal(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: 160,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 1.0,
                    ),
                  ]),
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              margin: const EdgeInsets.fromLTRB(10, 1, 5, 1),
              child: Column(children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment:
                      CrossAxisAlignment.center, // set your alignment
                  children: <Widget>[
                    Text(
                        "${changeTimeFormat1(mStartTime ?? "")} - ${changeTimeFormat1(mEndTime ?? "")}",
                        style: const TextStyle(
                            fontFamily: 'ManropeRegular',
                            fontSize: 14,
                            color: mBlackColor))
                  ],
                ),
              ]))
        ],
      ),
    );
  }
}
