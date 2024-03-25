import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:startinsights/Model/EventListResponse.dart';
import 'package:startinsights/Utils/FontSizes.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:url_launcher/url_launcher.dart';

class RecordedEventItem extends StatelessWidget {
  final RecordedEvent mRecordedEvent;
  final VoidCallback onpressed;
  const RecordedEventItem({
    super.key,
    required this.mRecordedEvent,
    required this.onpressed,
  });

  void selectMeal(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpressed,
      child: Container(
        width: 300,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: mGreyTwo,
          boxShadow: const [
            BoxShadow(
              color: Colors.white,
              blurRadius: 1.0,
            ),
          ],
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  launchUrl(Uri.parse(mRecordedEvent.eventUrl ?? ""),
                      mode: LaunchMode.externalApplication);
                },
                child: Align(
                    alignment: Alignment.center,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: ((mRecordedEvent.eventImage ?? "").isNotEmpty)
                            ? GestureDetector(
                                onTap: onpressed,
                                child: Container(
                                  height: 140,
                                  width: 350,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          mRecordedEvent.eventImage!),
                                      //whatever image you can put here
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              )
                            : SvgPicture.asset(
                                'assets/new_ic_watermarkbg.svg',
                                height: 140,
                                width: 350,
                              )

                        // SvgPicture.asset(
                        //   'assets/new_ic_watermarkbg.svg',
                        //   width: 350,
                        //   height: 140,
                        // ),
                        )),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                  child: Text(mRecordedEvent.title ?? "",
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontFamily: 'OpenSauceSansSemiBold',
                          fontSize: mSizeThree,
                          color: mGreyTen))),
              SizedBox(
                height: 20,
              ),
            ]),
      ),
    );
  }
}
