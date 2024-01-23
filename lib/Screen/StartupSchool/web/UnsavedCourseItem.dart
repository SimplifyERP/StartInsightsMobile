import 'package:flutter/material.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Model/CoursesListResponse.dart';
import 'package:startinsights/Screen/StartupSchool/bloc/startupschool_bloc.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Utils/screens.dart';
import 'package:startinsights/Widgets/primary_button.dart';

class UnSavedCourseItem extends StatelessWidget {
  final CoursesList mCoursesList;
  final StartupSchoolBloc mStartupSchoolBloc;
  const UnSavedCourseItem({
    required this.mCoursesList,
    required this.mStartupSchoolBloc,
    super.key,
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
              height: 330,
              width: 500,
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
              margin: const EdgeInsets.fromLTRB(10, 1, 1, 1),
              child: Column(children: <Widget>[
                Image.network(mCoursesList.image ?? "",
                    height: 150, fit: BoxFit.fill),

                //  Image(
                //   height: 150,
                //   fit: BoxFit.fill,
                //   image: Image.network(mUserImage,
                //       width: 30, height: 30, fit: BoxFit.fill),
                //
                //   // AssetImage(
                //   //   "assets/ic_courseimg.png",
                //   // ),
                // ),
                const SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    mCoursesList.title ?? "",
                    style: const TextStyle(
                        fontFamily: 'ManropeSemiBold',
                        fontSize: 20,
                        color: mBlackColor),
                  ),
                ),
                const SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    mCoursesList.shortIntroduction ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontFamily: 'ManropeRegular',
                        fontSize: 16,
                        color: kTextGrayColor),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment:
                      CrossAxisAlignment.center, // set your alignment
                  children: <Widget>[
                    Container(
                        height: 40,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.white,
                                blurRadius: 0,
                              ),
                            ]),
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                            child: InkWell(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row(children: [
                                  Expanded(
                                      flex: 2,
                                      child: Image.asset(
                                        'assets/ic_event_note.png',
                                        height: 18,
                                      )),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                      flex: 8,
                                      child: Text(
                                          "${mCoursesList.lessonCount} Lessons",
                                          style: TextStyle(
                                              fontFamily: 'ManropeRegular',
                                              fontSize: 16,
                                              color: kTextGrayColor))),
                                ]),
                              ),
                            ))),
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                        height: 40,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.white,
                                blurRadius: 0,
                              ),
                            ]),
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                            child: InkWell(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row(children: [
                                  Expanded(
                                      flex: 2,
                                      child: Image.asset(
                                        'assets/ic_computer.png',
                                        height: 18,
                                      )),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                      flex: 8,
                                      child: Text(
                                          "${mCoursesList.quizCount} Quizzes",
                                          style: TextStyle(
                                              fontFamily: 'ManropeRegular',
                                              fontSize: 16,
                                              color: kTextGrayColor))),
                                ]),
                              ),
                            ))),
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                        height: 40,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.white,
                                blurRadius: 0,
                              ),
                            ]),
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                            child: InkWell(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row(children: [
                                  Expanded(
                                      flex: 2,
                                      child: Image.asset(
                                        'assets/ic_play_circle.png',
                                        height: 18,
                                      )),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                      flex: 8,
                                      child: Text(
                                          "${mCoursesList.videosCount} Videos",
                                          style: TextStyle(
                                              fontFamily: 'ManropeRegular',
                                              fontSize: 16,
                                              color: kTextGrayColor))),
                                ]),
                              ),
                            ))),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment:
                      CrossAxisAlignment.center, // set your alignment
                  children: <Widget>[
                    Expanded(
                      flex: 5, // takes 30% of available width
                      child: Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: mBtnColor,
                                width: 1,
                              )),
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: InkWell(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: PrimaryButton(
                                      mButtonname:
                                          Languages.of(context)!.mRemove,
                                      onpressed: () {
                                        mStartupSchoolBloc.SaveCoursesData(
                                            mCoursesList!.id!, "Unsaved");
                                      },
                                      mSelectcolor: mWhiteColor,
                                      mTextColor: mBtnColor,
                                      mFontSize: 16,
                                      mHeigth: 40),
                                ),
                              ))),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      flex: 5, // takes 30% of available width
                      child: Container(
                          height: 40,
                          width: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: mBtnColor,
                              border: Border.all(
                                color: mBtnColor,
                                width: 1,
                              )),
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: InkWell(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: PrimaryButton(
                                      mButtonname:
                                          Languages.of(context)!.mStart,
                                      onpressed: () {
                                        Navigator.pushReplacementNamed(
                                            context, myCoursesRoute,
                                            arguments: [mCoursesList!.id!]);
                                      },
                                      mSelectcolor: mBtnColor,
                                      mTextColor: mWhiteColor,
                                      mFontSize: 16,
                                      mHeigth: 40),
                                ),
                              ))),
                    ),
                  ],
                )
              ]))
        ],
      ),
    );
  }
}
