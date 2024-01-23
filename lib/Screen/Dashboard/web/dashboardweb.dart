import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startinsights/Model/MastersResponse.dart';
import 'package:startinsights/Screen/Dashboard/bloc/dashboard_bloc.dart';
import 'package:startinsights/Screen/Dashboard/bloc/dashboard_state.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Widgets/Appbar.dart';
import 'package:startinsights/Widgets/sidemenu.dart';

class DashboardWeb extends StatefulWidget {
  DashboardWeb({super.key});

  @override
  State<DashboardWeb> createState() => _DashboardWebState();
}

class _DashboardWebState extends State<DashboardWeb> {
  @override
  late DashboardBloc mDashboardBloc;
  bool checkedValue = false;
  List<UserType>? mUserTypeDataList;
  List<UserType> getUserType = <UserType>[];
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    mDashboardBloc = DashboardBloc(mContext: context);

    return WillPopScope(
      onWillPop: () {
        //trigger leaving and use own data
        //Navigator.pop(context, false);

        //  OnLoadNext();
        //we need to return a future
        return Future.value(false);
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: Appbar(mText: "TExt", mUserImage: "", mFrom: 1),
          body: BlocConsumer<DashboardBloc, DashboardStatus>(
            listener: (context, state) {
              if (state is GetDashboardInfoSuccessState) {}
            },
            builder: (context, state) {
              return SafeArea(
                child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
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
                                        borderRadius: BorderRadius.circular(0),
                                        color: kBorderColor),
                                    child: SideMenu(mFrom: 1))),
                            Expanded(
                                flex: 9,
                                child: Container(
                                    height: MediaQuery.of(context).size.height,
                                    child: SingleChildScrollView(
                                        child: Column(
                                      children: [
                                        Text(
                                          "30Test",
                                          style: TextStyle(fontSize: 60),
                                        ),
                                        SizedBox(
                                          height: 50,
                                        )
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

              //  ErrorToast(context: context, text: state.mDashboard.message!);

              //} else if (state is GetPunchInOutFailState) {}
              return Container();
            },
          )),
    );
  }
}
