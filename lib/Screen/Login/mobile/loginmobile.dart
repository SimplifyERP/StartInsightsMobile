import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startinsights/Model/MastersResponse.dart';
import 'package:startinsights/Screen/Login/bloc/login_bloc.dart';
import 'package:startinsights/Screen/Login/bloc/login_state.dart';

class LoginMobile extends StatefulWidget {
  LoginMobile({super.key});

  @override
  State<LoginMobile> createState() => _LoginMobileState();
}

class _LoginMobileState extends State<LoginMobile> {
  @override
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late LoginBloc mLoginBloc;
  bool checkedValue = false;
  List<UserType>? mUserTypeDataList;
  List<UserType> getUserType = <UserType>[];
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    mLoginBloc = LoginBloc(mContext: context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<LoginBloc, LoginStatus>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is GetLoginInfoSuccessState) {
            mUserTypeDataList = state.mMastersDataList.userType;
            getUserType.clear();
            List.generate(mUserTypeDataList!.length,
                (index) => getUserType.add(mUserTypeDataList![index]));
          }

          return SafeArea(
              child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [],
                      )
                    ],
                  )));
        },
      ),
    );
  }
}
//const Column(children: [
//                             Align(
//                               alignment: Alignment.center,
//                               child: Image(
//                                 image: AssetImage(
//                                   "assets/loginbg.png",
//                                 ),
//                               ),
//                             ),
//                           ]
