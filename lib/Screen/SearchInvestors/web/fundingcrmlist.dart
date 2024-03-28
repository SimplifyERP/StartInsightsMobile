import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:startinsights/Model/FundingCrmResponse.dart';
import 'package:startinsights/Utils/FontSizes.dart';
import 'package:startinsights/Utils/MyColor.dart';

class FundingCRMList extends StatelessWidget {
  final int mIndex;
  final Investor mInvestor;

  const FundingCRMList({
    required this.mIndex,
    required this.mInvestor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      //onTap: (() => selectMeal(context)),
      child: Column(children: [
        Container(
          height: 80,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.white,
                blurRadius: 0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        child: ClipOval(
                          child: (mInvestor.logo!.isNotEmpty)
                              ? ImageNetwork(
                                  image: mInvestor.logo ?? "",
                                  height: 100,
                                  width: 100,
                                )
                              : Image.asset('assets/avathar.png',
                                  width: 100, height: 100, fit: BoxFit.fill),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      flex: 7,
                      child: Text(mInvestor.investorname ?? "",
                          textAlign: TextAlign.left,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontFamily: 'OpenSauceSansSemiBold',
                              fontSize: mSizeTwo,
                              color: mGreyTen)))
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(""),
                  ),
                  Expanded(
                      flex: 7,
                      child: Text(mInvestor.status ?? "",
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontFamily: 'OpenSauceSansRegular',
                              fontSize: mSizeTwo,
                              color: mRedSix)))
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        )
      ]),
    );
  }
}
