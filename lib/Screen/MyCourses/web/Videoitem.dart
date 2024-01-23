import 'package:flutter/material.dart';
import 'package:startinsights/Model/CoursesDetailsResponse.dart';
import 'package:startinsights/Utils/MyColor.dart';

class VideoItem extends StatelessWidget {
  final Lesson mLessonList;
  const VideoItem({
    super.key,
    required this.mLessonList,
  });

  void selectMeal(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return InkWell(
      //onTap: (() => selectMeal(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              margin: const EdgeInsets.fromLTRB(10, 1, 1, 1),
              child: Row(children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/ic_video.png',
                        height: 20,
                      )),
                ), //ic_dashboardwhite
                Expanded(
                    flex: 7,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(mLessonList.lessonName ?? "",
                          style: const TextStyle(
                              fontFamily: 'ManropeRegular',
                              fontSize: 14,
                              color: kTextColorOne)),
                    )),
                Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Test"),
                    )),
              ]))
        ],
      ),
    );
  }
}
