import 'package:flutter/material.dart';
import 'package:startinsights/Model/CoursesDetailsResponse.dart';
import 'package:startinsights/Screen/MyCourses/web/Videoitem.dart';
import 'package:startinsights/Utils/MyColor.dart';

class MyCourseItem extends StatelessWidget {
  final Chapter mChapterList;

  MyCourseItem({
    super.key,
    required this.mChapterList,
  });

  void selectMeal(BuildContext context) {}
  final ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Card(
      color: mCardColorOne,
      child: ExpansionTile(
          iconColor: Colors.black,
          collapsedIconColor: Colors.black,
          title: Text(
            mChapterList.chapterName ?? "",
            style: const TextStyle(
                fontFamily: 'ManropeSemiBold',
                fontSize: 16,
                color: mBlackColor),
          ),
          children: [
            Container(
              height: mChapterList.lessons!.length * 40,
              color: mWhiteColor,
              child: ListView.builder(
                itemBuilder: ((context, index) {
                  final mLessonsList = mChapterList.lessons![index];
                  return VideoItem(mLessonList: mLessonsList);
                }),
                itemCount: mChapterList.lessons!.length,
              ),
            ),
          ]),
    );
  }
}
