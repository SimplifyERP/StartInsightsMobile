import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Model/InvestorroundwiseResponse.dart';
import 'package:startinsights/Repository/startupdeals_repository.dart';
import 'package:startinsights/Screen/PitchRoom/web/newpitchroom.dart';

class RoundWiseList extends StatelessWidget {
  final RoundWise mRoundWise;

  RoundWiseList({
    required this.mRoundWise,
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
              menuname: mRoundWise.roundName ?? "",
            )),
        // DateFormat('dd MMM yyyy').format(
        //     mInvestorWiseList.dateOfAllotment ?? DateTime.now()
        Expanded(
            flex: 1,
            child: DatacellText(
              menuname: DateFormat('dd MMM yyyy')
                  .format(mRoundWise.roundClosingDate ?? DateTime.now()),
            )),
        Expanded(
            flex: 1,
            child: DatacellText(
              menuname:
                  "${Languages.of(context)!.rupess} ${mRoundWise.amountRaised}",
            )),
        Expanded(
            flex: 1,
            child: DatacellText(
              menuname: "",
            )),
        Expanded(
            flex: 1,
            child: DatacellText(
              menuname: mRoundWise.dilutionForThisRound ?? "",
            )),
        Expanded(
            flex: 1,
            child: DatacellText(
              menuname: "",
            )),
        Expanded(
            flex: 1,
            child: DatacellText(
              menuname: "${"0"}%",
            )),
      ],
    );
  }
}
