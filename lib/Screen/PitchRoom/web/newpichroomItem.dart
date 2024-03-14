import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_network/image_network.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Model/PitchroomlistResponse.dart';
import 'package:startinsights/Repository/startupdeals_repository.dart';
import 'package:startinsights/Screen/PitchRoom/bloc/pitchroom_bloc.dart';
import 'package:startinsights/Utils/FontSizes.dart';
import 'package:startinsights/Utils/MyColor.dart';

class NewPitchRoomItem extends StatelessWidget {
  final PitchRoomDetail mPitchRoomDetail;
  final PitchroomBloc mPitchroomBloc;
  final BuildContext context;
  int mIndex;
  final VoidCallback onPressed;
  NewPitchRoomItem({
    required this.mPitchRoomDetail,
    required this.mPitchroomBloc,
    required this.context,
    required this.onPressed,
    required this.mIndex,
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
      onTap: onPressed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          (mIndex == 0)
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: 270,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: mGreyTwo,
                    border: Border.all(color: mGreyEigth, width: 1),
                  ),
                  margin: const EdgeInsets.fromLTRB(20, 1, 20, 1),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/new_ic_upload.svg',
                          width: 120,
                          height: 120,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          Languages.of(context)!.mcreateroom,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontFamily: 'OpenSauceSansSemiBold',
                              fontSize: mSizeThree,
                              color: mGreySeven,
                              height: 1.5),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ]),
                )
              : Container(
                  width: MediaQuery.of(context).size.width,
                  height: 270,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: mGreyTwo,
                  ),
                  margin: const EdgeInsets.fromLTRB(20, 1, 20, 1),
                  padding: EdgeInsets.all(10),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                            alignment: Alignment.center,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: ((mPitchRoomDetail.coverImage ?? "")
                                      .isNotEmpty)
                                  ? ImageNetwork(
                                      image: mPitchRoomDetail.coverImage!,
                                      height: 150,
                                      width: 300,
                                    )
                                  : SvgPicture.asset(
                                      'assets/new_ic_watermarkbg.svg',
                                      height: 150,
                                      width: 300,
                                    ),
                            )),
                        SizedBox(
                          height: 15,
                        ),
                        Align(
                            alignment: Alignment.center,
                            child: Text(
                              mPitchRoomDetail.roomName ?? "",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontFamily: 'OpenSauceSansSemiBold',
                                  fontSize: mSizeFour,
                                  color: mBlackOne),
                            )),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          color: mGreyThree,
                          width: MediaQuery.of(context).size.width,
                          height: 1,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              height: 35,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: ((mPitchRoomDetail.companyName ?? "")
                                        .isNotEmpty)
                                    ? mgradientThree
                                    : mgradientFive,
                              ),
                              child: Center(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/new_ic_sharelink.svg',
                                    width: 20,
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    Languages.of(context)!.mShareLink,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontFamily: 'OpenSauceSansMedium',
                                        fontSize: mSizeThree,
                                        color: Colors.white),
                                  )
                                ],
                              )),
                            )),
                      ]),
                ),
        ],
      ),
    );
  }
}
