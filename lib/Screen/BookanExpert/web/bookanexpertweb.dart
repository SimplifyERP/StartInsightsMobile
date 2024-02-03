import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Model/BookanexpertlistResponse.dart';
import 'package:startinsights/Screen/BookanExpert/bloc/bookanexpert_bloc.dart';
import 'package:startinsights/Screen/BookanExpert/bloc/bookanexpert_state.dart';
import 'package:startinsights/Screen/BookanExpert/web/bookanexpertItem.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Utils/screens.dart';
import 'package:startinsights/Widgets/Appbar.dart';
import 'package:startinsights/Widgets/sidemenu.dart';

class BookanexpertWeb extends StatefulWidget {
  BookanexpertWeb({super.key});

  @override
  State<BookanexpertWeb> createState() => _BookanexpertWebState();
}

class _BookanexpertWebState extends State<BookanexpertWeb> {
  @override
  late BookanExpertBloc mBookanExpertBloc;
  bool checkedValue = false;
  List<BookAnExpertList> mBookAnExpertList = [];
  String mUserImage = "";
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    mBookanExpertBloc = BookanExpertBloc(mContext: context);

    void OnLoadNext() {
      Navigator.pushReplacementNamed(context, dashboardRoute);
    }

    final ScrollController controller = ScrollController();

    return WillPopScope(
      onWillPop: () {
        //trigger leaving and use own data
        //Navigator.pop(context, false);

        OnLoadNext();
        //we need to return a future
        return Future.value(false);
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: Appbar(mText: "TExt", mUserImage: "", mFrom: 7),
          body: BlocConsumer<BookanExpertBloc, BookanExpertStatus>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is GetBookanExpertInfoSuccessState) {
                mBookAnExpertList = state.mBookAnExpertList;

                return SafeArea(
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Container(
                      color: Colors.white,
                      margin: const EdgeInsets.only(top: 0, left: 0, right: 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            //ROW 1
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(0),
                                          color: kBorderColor),
                                      child: SideMenu(mFrom: 7))),
                              Expanded(
                                  flex: 9,
                                  child: Container(
                                      height:
                                          MediaQuery.of(context).size.height,
                                      padding: EdgeInsets.all(15),
                                      child: SingleChildScrollView(
                                          child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: RichText(
                                              text: TextSpan(
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text:
                                                          Languages.of(context)!
                                                              .mStartX,
                                                      style: const TextStyle(
                                                          fontFamily:
                                                              'ManropeBold',
                                                          fontSize: 26,
                                                          color: mBlackColor)),
                                                  TextSpan(
                                                      text:
                                                          Languages.of(context)!
                                                              .mBookanExpert,
                                                      style: const TextStyle(
                                                          fontFamily:
                                                              'ManropeBold',
                                                          fontSize: 26,
                                                          color: mBtnColor)),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          SingleChildScrollView(
                                              child: GridView.count(
                                            crossAxisCount: 3,
                                            crossAxisSpacing: 0,
                                            mainAxisSpacing: 0,
                                            childAspectRatio: (1.1 / .9),
                                            shrinkWrap: true,
                                            children: List.generate(
                                              mBookAnExpertList.length,
                                              (index) {
                                                final mgetCoursesList =
                                                    mBookAnExpertList[index];
                                                return BookanExpertItem(
                                                  mBookAnExpertList:
                                                      mgetCoursesList,
                                                );
                                              },
                                            ),
                                          )),
                                          const SizedBox(
                                            height: 60,
                                          ),
                                        ],
                                      )))),
                            ],
                          ),
                          Container(),
                        ],
                      ),
                    ),
                  ),
                );
              }

              //  ErrorToast(context: context, text: state.mDashboard.message!);

              //} else if (state is GetPunchInOutFailState) {}
              return Container();
            },
          )),
    );
  }
}
