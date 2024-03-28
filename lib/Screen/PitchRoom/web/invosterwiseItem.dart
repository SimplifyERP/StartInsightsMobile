import 'package:flutter/material.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Model/InvestorroundwiseResponse.dart';
import 'package:startinsights/Repository/startupdeals_repository.dart';
import 'package:startinsights/Screen/PitchRoom/web/newpitchroom.dart';

class InvosterWiseList extends StatelessWidget {
  final InvestorWise mInvestorWiseList;

  InvosterWiseList({
    required this.mInvestorWiseList,
    super.key,
  });

  void selectMeal(BuildContext context) {}

  final String mUserImage = "";
  final StartupDealsRepository _apiService1 = StartupDealsRepository();
  bool mVisible = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
            flex: 1,
            child: DatacellText(
              menuname: mInvestorWiseList.investorName ?? "",
            )),
        // DateFormat('dd MMM yyyy').format(
        //     mInvestorWiseList.dateOfAllotment ?? DateTime.now()
        Expanded(
            flex: 1,
            child: DatacellText(
              menuname: mInvestorWiseList.dateOfAllotment ?? "",
            )),
        Expanded(
            flex: 1,
            child: DatacellText(
              menuname:
                  "${Languages.of(context)!.rupess} ${mInvestorWiseList.amountInvested}",
            )),
        Expanded(
            flex: 1,
            child: DatacellText(
              menuname: mInvestorWiseList.sharesAllotted ?? "",
            )),
        Expanded(
            flex: 1,
            child: DatacellText(
              menuname: mInvestorWiseList.fullyDilutedShares ?? "",
            )),
        Expanded(
            flex: 1,
            child: DatacellText(
              menuname: mInvestorWiseList.classOfShares ?? "",
            )),
        Expanded(
            flex: 1,
            child: DatacellText(
              menuname: "${mInvestorWiseList.shareholding ?? ""}%",
            )),
      ],
    );
  }
}
