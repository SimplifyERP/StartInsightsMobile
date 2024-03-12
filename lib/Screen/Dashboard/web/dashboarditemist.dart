import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:startinsights/Libery/readmore.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Model/DashboardResponse.dart';
import 'package:startinsights/Utils/FontSizes.dart';
import 'package:startinsights/Utils/MyColor.dart';

class DashboardItemList extends StatelessWidget {
  final int mIndex;
  final MessageElement mMessageElement;

  const DashboardItemList({
    required this.mIndex,
    required this.mMessageElement,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      //onTap: (() => selectMeal(context)),
      child: Container(
        height: 260,
        width: 260,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(right: 10, left: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: mGreyTwo,
          boxShadow: const [
            BoxShadow(
              color: mGreyTwo,
              blurRadius: 0,
            ),
          ],
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  height: 100,
                  width: double.infinity,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Stack(children: [
                            Align(
                              alignment: Alignment.center,
                              child: CircleAvatar(
                                radius: 35,
                                backgroundColor: Colors.white,
                                child: ClipOval(
                                  child: (mMessageElement.logo!.isNotEmpty)
                                      ? ImageNetwork(
                                          image: mMessageElement.logo ?? "",
                                          height: 100,
                                          width: 100,
                                        )
                                      : Image.asset('assets/avathar.png',
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.fill),
                                ),
                              ),
                            ),
                            (mMessageElement!.investorVerified! == 1)
                                ? Align(
                                    alignment: Alignment.topRight,
                                    child: Image.asset(
                                        'assets/new_ic_check.png',
                                        width: 30,
                                        height: 30,
                                        fit: BoxFit.fill),
                                  )
                                : const Text("")
                          ]),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          flex: 6,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 70,
                                  child: ListView.builder(
                                    itemCount: (mMessageElement
                                                .fundingStagesTable!.length >
                                            2)
                                        ? 2
                                        : mMessageElement
                                            .fundingStagesTable!.length,
                                    itemBuilder: (context, position) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: mGreyThree,
                                          boxShadow: const [
                                            BoxShadow(
                                              color: mGreyThree,
                                              blurRadius: 0,
                                            ),
                                          ],
                                        ),
                                        padding: const EdgeInsets.only(
                                            left: 5, right: 5),
                                        margin: const EdgeInsets.only(
                                            left: 0,
                                            right: 0,
                                            bottom: 5,
                                            top: 5),
                                        height: 20,
                                        width: double.maxFinite,
                                        child: (position > 0)
                                            ? Center(
                                                child: Text(
                                                    "+ ${mMessageElement.fundingStagesTable!.length - 1}",
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        fontFamily:
                                                            'OpenSauceSansRegular',
                                                        fontSize: mSizeNine,
                                                        color: mGreyNine)))
                                            : Center(
                                                child: Text(
                                                    mMessageElement
                                                            .fundingStagesTable![
                                                                position]
                                                            .fundingStages! ??
                                                        "",
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        fontFamily:
                                                            'OpenSauceSansRegular',
                                                        fontSize: mSizeNine,
                                                        color: mGreyNine))),
                                      );
                                    },
                                  ),
                                )
                              ]),
                        )
                      ]),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                flex: 7,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(right: 8, left: 8),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(mMessageElement.title ?? "",
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontFamily: 'OpenSauceSansBold',
                                fontSize: mSizeThree,
                                color: mBlackOne)),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(mMessageElement.firmType ?? "",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontFamily: 'OpenSauceSansRegular',
                                fontSize: mSizeTwo,
                                color: mGreySeven)),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 1,
                          color: mGreyThree,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ReadMoreText(
                          mMessageElement.aboutUs ?? "",
                          trimLines: 3,
                          preDataTextStyle: const TextStyle(
                              fontFamily: 'OpenSauceSansRegular',
                              fontSize: mSizeOne,
                              height: 1.5,
                              color: mGreySeven),
                          style: const TextStyle(
                              fontFamily: 'OpenSauceSansRegular',
                              fontSize: mSizeOne,
                              height: 1.5,
                              color: mGreySeven),
                          colorClickableText: mBlueOne,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: 'See more',
                          trimExpandedText: ' show less',
                          onpressed: () {
                            showAlert(context, mMessageElement.aboutUs ?? "");
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 1,
                          color: mGreyThree,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset('assets/new_ic_money_bag.png',
                                width: 20, height: 20, fit: BoxFit.fill),
                            const SizedBox(
                              width: 5,
                            ),
                            Center(
                              child: Text(
                                  "${Languages.of(context)!.rupess} ${mMessageElement.minCheckSize} - ${mMessageElement.maxCheckSize}",
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      fontFamily: 'OpenSauceSansRegular',
                                      fontSize: mSizeTwo,
                                      color: mGreySeven)),
                            ),
                          ],
                        )
                      ]),
                ),
              )
            ]),
      ),
    );
  }

  void showAlert(BuildContext context, String message) {
    Widget okButton = TextButton(
      child: const Text("Ok",
          style: TextStyle(
              fontFamily: 'ManropeRegular', fontSize: 16, color: mBlackColor)),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text(
        message,
        style: const TextStyle(
            fontFamily: 'ManropeRegular', fontSize: 16, color: mBlackColor),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
