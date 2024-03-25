import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:startinsights/Model/CourseDetailsResponse.dart';
import 'package:startinsights/Utils/FontSizes.dart';
import 'package:startinsights/Utils/MyColor.dart';

class LearnVideoItem extends StatelessWidget {
  final Lesson mLessonList;
  final VoidCallback onpressed;
  const LearnVideoItem({
    super.key,
    required this.mLessonList,
    required this.onpressed,
  });

  void selectMeal(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpressed,
      // onTap: () {
      //   WebEngagePlugin.userLogin('9SBOkLVMWvPX');
      //   //9SBOkLVMWvPX is the unique user identifier being used here
      //   WebEngagePlugin.setUserOptIn('in_app', false);
      // },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              margin: const EdgeInsets.fromLTRB(10, 1, 1, 1),
              child: Row(children: <Widget>[
                //ic_dashboardwhite
                const Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text("• ",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontFamily: 'OpenSauceSansSemiBold',
                              fontSize: mSizeFour,
                              height: 1.5,
                              color: kTextColorOne)),
                    )),
                Expanded(
                    flex: 7,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(mLessonList.lessonName ?? "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontFamily: 'OpenSauceSansSemiBold',
                              fontSize: mSizeTwo,
                              height: 1.5,
                              color: kTextColorOne)),
                    )),
                Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        'assets/new_ic_play.svg',
                        width: 20,
                        height: 20,
                      ),
                    )),
              ]))
        ],
      ),
    );
  }
}
