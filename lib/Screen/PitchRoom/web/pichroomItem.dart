import 'package:flutter/material.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Model/PitchroomlistResponse.dart';
import 'package:startinsights/Repository/startupdeals_repository.dart';
import 'package:startinsights/Screen/PitchRoom/bloc/pitchroom_bloc.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Widgets/primary_button.dart';

class PitchRoomItem extends StatelessWidget {
  final PitchRoomDetail mPitchRoomDetail;
  final PitchroomBloc mPitchroomBloc;
  final BuildContext context;
  final VoidCallback onPressed;
  PitchRoomItem({
    required this.mPitchRoomDetail,
    required this.mPitchroomBloc,
    required this.context,
    required this.onPressed,
    super.key,
  });

  void selectMeal(BuildContext context) {}

  final String mUserImage = "";
  final StartupDealsRepository _apiService1 = StartupDealsRepository();
  bool mVisible = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      //onTap: (() => selectMeal(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 250,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 1.0,
                  ),
                ]),
            margin: const EdgeInsets.fromLTRB(20, 1, 20, 1),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 5,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                          color: kPitchcraftbg,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 1.0,
                            ),
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/ic_pichroomtitle.png',
                              width: 20, height: 20, fit: BoxFit.fill),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            mPitchRoomDetail.roomName ?? "",
                            style: const TextStyle(
                                fontFamily: 'ManropeSemiBold',
                                fontSize: 20,
                                color: mBlackColor),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment:
                          CrossAxisAlignment.end, // set your alignment
                      children: <Widget>[
                        Expanded(
                          flex: 5, // takes 30% of available width
                          child: Container(
                              margin: EdgeInsets.fromLTRB(10, 5, 5, 5),
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: mBtnColor,
                                    width: 1,
                                  )),
                              child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: InkWell(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: PrimaryButton(
                                          mButtonname:
                                              Languages.of(context)!.mViewRoom,
                                          onpressed: onPressed,
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
                              margin: EdgeInsets.fromLTRB(5, 5, 10, 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: mBtnColor,
                                  border: Border.all(
                                    color: mBtnColor,
                                    width: 1,
                                  )),
                              child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: InkWell(
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: PrimaryButton(
                                          mButtonname:
                                              Languages.of(context)!.mShare,
                                          onpressed: () {},
                                          mSelectcolor: mBtnColor,
                                          mTextColor: mWhiteColor,
                                          mFontSize: 16,
                                          mHeigth: 40),
                                    ),
                                  ))),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
