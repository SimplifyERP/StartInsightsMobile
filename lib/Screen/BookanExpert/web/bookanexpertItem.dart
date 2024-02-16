import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Model/BookanexpertlistResponse.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Utils/screens.dart';
import 'package:startinsights/Widgets/primary_button.dart';

class BookanExpertItem extends StatelessWidget {
  final BookAnExpertList mBookAnExpertList;
  const BookanExpertItem({
    required this.mBookAnExpertList,
    super.key,
  });

  void selectMeal(BuildContext context) {}

  final String mUserImage = "";

  @override
  Widget build(BuildContext context) {
    return InkWell(
      //onTap: (() => selectMeal(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 1.0,
                    ),
                  ]),
              padding: const EdgeInsets.fromLTRB(10, 1, 10, 1),
              margin: const EdgeInsets.fromLTRB(10, 1, 1, 1),
              child: Column(children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment:
                      CrossAxisAlignment.center, // set your alignment
                  children: <Widget>[
                    Expanded(
                      flex: 2, // takes 30% of available width
                      child: Container(
                          height: 80,
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: InkWell(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: CircleAvatar(
                                    radius: 30.0,
                                    backgroundColor: Colors.white,
                                    child: ClipOval(
                                      child: (mBookAnExpertList
                                              .attachimage!.isNotEmpty)
                                          ? ImageNetwork(
                                              image: mBookAnExpertList
                                                      .attachimage ??
                                                  "",
                                              height: 80,
                                              width: 100,
                                            )
                                          : Image.asset('assets/avathar.png',
                                              width: 80,
                                              height: 100,
                                              fit: BoxFit.fill),
                                    ),
                                  ),
                                ),
                              ))),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      flex: 6, // takes 30% of available width
                      child: Container(
                          height: 80,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  mBookAnExpertList.expertName ?? "",
                                  style: const TextStyle(
                                      fontFamily: 'ManropeSemiBold',
                                      fontSize: 20,
                                      color: mBlackColor),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  mBookAnExpertList.designation ?? "",
                                  style: const TextStyle(
                                      fontFamily: 'ManropeRegular',
                                      fontSize: 16,
                                      color: kTextGrayColor),
                                ),
                              ),
                            ],
                          )),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    const Expanded(
                      flex: 2,
                      child: Text("") // takes 30% of available width
                      /*child: Container(
                          height: 80,
                          child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: IconButton(
                                icon: Image.asset('assets/ic_linkedin.png'),
                                iconSize: 20,
                                onPressed: () async {
                                  if (await canLaunchUrl(Uri.parse(
                                      mBookAnExpertList.linkedinId ?? ""))) {
                                    await launchUrl(
                                        Uri.parse(
                                            mBookAnExpertList.linkedinId ?? ""),
                                        mode: LaunchMode.externalApplication);
                                  } else {
                                    throw 'Could not launch ${mBookAnExpertList.linkedinId}' ??
                                        "";
                                  }
                                },
                              )))*/
                      ,
                    ),
                  ],
                ),
                Container(
                  height: 240,
                  child: Column(children: [
                    Expanded(
                        flex: 7,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            mBookAnExpertList.description ?? "",
                            maxLines: 7,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontFamily: 'ManropeRegular',
                                fontSize: 16,
                                color: kTextColorTwo),
                          ),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                        flex: 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment:
                              CrossAxisAlignment.center, // set your alignment
                          children: <Widget>[
                            Expanded(
                              flex: 5, // takes 30% of available width
                              child: Container(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: RichText(
                                        text: TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(
                                                text:
                                                    "${Languages.of(context)!.rupess} ${mBookAnExpertList.price}" ??
                                                        "",
                                                style: const TextStyle(
                                                    fontFamily: 'ManropeBold',
                                                    fontSize: 24,
                                                    color: mBtnColor)),
                                            TextSpan(
                                                text: Languages.of(context)!
                                                    .mService,
                                                style: const TextStyle(
                                                    fontFamily:
                                                        'ManropeRegular',
                                                    fontSize: 14,
                                                    color: kTextGrayColor)),
                                          ],
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
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: InkWell(
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: PrimaryButton(
                                              mButtonname:
                                                  Languages.of(context)!
                                                      .mBookanExpert,
                                              onpressed: () {
                                                Navigator.pushReplacementNamed(
                                                    context, expertbookingRoute,
                                                    arguments: [
                                                      mBookAnExpertList!.id!
                                                    ]);
                                              },
                                              mSelectcolor: mBtnColor,
                                              mTextColor: mWhiteColor,
                                              mFontSize: 16,
                                              mHeigth: 40),
                                        ),
                                      ))),
                            ),
                          ],
                        ))
                  ]),
                ),
                // Row(
                //     mainAxisAlignment:
                //         MainAxisAlignment
                //             .center,
                //     crossAxisAlignment:
                //         CrossAxisAlignment
                //             .center,
                //     children: [
                //
                //     ]),
              ]))
        ],
      ),
    );
  }
}
