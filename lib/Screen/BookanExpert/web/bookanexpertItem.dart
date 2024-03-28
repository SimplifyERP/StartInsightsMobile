import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:startinsights/Libery/readmore.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Model/BookanexpertlistResponse.dart';
import 'package:startinsights/Utils/FontSizes.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Utils/utils.dart';
import 'package:startinsights/Widgets/servicebutton.dart';

class BookanExpertItem extends StatelessWidget {
  final FundraisingExpert mBookAnExpertList;
  const BookanExpertItem({
    required this.mBookAnExpertList,
    super.key,
  });

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
                borderRadius: BorderRadius.circular(8),
                color: mGreyTwo,
              ),
              padding: const EdgeInsets.fromLTRB(10, 1, 10, 1),
              margin: const EdgeInsets.fromLTRB(5, 1, 1, 1),
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
                                              .attachImage!.isNotEmpty)
                                          ? ImageNetwork(
                                              image: mBookAnExpertList
                                                      .attachImage ??
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
                      flex: 8, // takes 30% of available width
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
                                      fontFamily: 'OpenSauceSansSemiBold',
                                      fontSize: mSizeFour,
                                      color: mBlackTwo),
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
                                      fontFamily: 'OpenSauceSansRegular',
                                      fontSize: mSizeTwo,
                                      color: mGreySeven),
                                ),
                              ),
                            ],
                          )),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                  ],
                ),
                Container(
                  color: mGreyFour,
                  width: MediaQuery.of(context).size.width,
                  height: 1,
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  height: 240,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 7,
                            child: ReadMoreText(
                              mBookAnExpertList.description ?? "",
                              //"There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.",
                              trimLines: 8,
                              preDataTextStyle: const TextStyle(
                                  fontFamily: 'OpenSauceSansRegular',
                                  fontSize: mSizeTwo,
                                  height: 1.5,
                                  color: mGreySeven),
                              style: const TextStyle(
                                  fontFamily: 'OpenSauceSansRegular',
                                  fontSize: mSizeTwo,
                                  height: 1.5,
                                  color: mGreySeven),
                              colorClickableText: mBlueOne,
                              trimMode: TrimMode.Line,
                              trimCollapsedText: 'See more',
                              trimExpandedText: ' show less',
                              onpressed: () {
                                showAlert(
                                    context, mBookAnExpertList.description ?? ""
                                    //"There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.",
                                    );
                              },
                            )),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          color: mGreyFour,
                          width: MediaQuery.of(context).size.width,
                          height: 1,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Expanded(
                            flex: 3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment
                                  .center, // set your alignment
                              children: <Widget>[
                                Expanded(
                                  flex: 5, // takes 30% of available width
                                  child: Container(
                                      height: 40,
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 0),
                                          child: RichText(
                                            text: TextSpan(
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text:
                                                        "${Languages.of(context)!.rupess} ${mBookAnExpertList.price}" ??
                                                            "",
                                                    style: const TextStyle(
                                                        fontFamily:
                                                            'OpenSauceSansSemiBold',
                                                        fontSize: mSizeFive,
                                                        color: mBlackTwo)),
                                                TextSpan(
                                                    text: Languages.of(context)!
                                                        .mService,
                                                    style: const TextStyle(
                                                        fontFamily:
                                                            'OpenSauceSansRegular',
                                                        fontSize: mSizeThree,
                                                        color: mBlackTwo)),
                                              ],
                                            ),
                                          ))),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  flex: 5, // takes 30% of available width
                                  child: ServiceButton(
                                      mButtonname:
                                          Languages.of(context)!.mBookanExpert,
                                      //onpressed: onPaymentClick,
                                      onpressed: () {},
                                      mTextColor: mWhiteColor,
                                      mFontSize: 16,
                                      mWidth: 150,
                                      mHeigth: 35),

                                  /*Container(
                                      height: 40,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 0),
                                          child: InkWell(
                                            child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: ServiceButton(
                                                    mButtonname:
                                                        Languages.of(context)!
                                                            .mBookanExpert,
                                                    //onpressed: onPaymentClick,
                                                    onpressed: () {},
                                                    mTextColor: mWhiteColor,
                                                    mFontSize: 16,
                                                    mWidth: 150,
                                                    mHeigth: 35)

                                                // PrimaryButton(
                                                //     mButtonname:
                                                //         Languages.of(context)!
                                                //             .mBookanExpert,
                                                //     onpressed: () {
                                                //       Navigator
                                                //           .pushReplacementNamed(
                                                //               context,
                                                //               expertbookingRoute,
                                                //               arguments: [
                                                //             mBookAnExpertList!.id!
                                                //           ]);
                                                //     },
                                                //     mSelectcolor: mBtnColor,
                                                //     mTextColor: mWhiteColor,
                                                //     mFontSize: 16,
                                                //     mHeigth: 40),
                                                ),
                                          ))),*/
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
