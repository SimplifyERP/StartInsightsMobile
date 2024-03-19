import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Repository/startupdeals_repository.dart';
import 'package:startinsights/Screen/PitchRoom/web/newpitchroom.dart';
import 'package:startinsights/Utils/FontSizes.dart';
import 'package:startinsights/Utils/MyColor.dart';

class DocView extends StatelessWidget {
  UploadFiles mUploadFiles;

  final VoidCallback mRemoveFile;
  final VoidCallback mViewFile;
  DocView({
    required this.mUploadFiles,
    required this.mRemoveFile,
    required this.mViewFile,
    super.key,
  });

  void selectMeal(BuildContext context) {}

  final String mUserImage = "";
  final StartupDealsRepository _apiService1 = StartupDealsRepository();
  bool mVisible = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 10, left: 10),
      margin: EdgeInsets.only(right: 10, left: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(color: mGreyEigth, width: 1),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: 140,
                ),
                InkWell(
                  onTap: mRemoveFile,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: SvgPicture.asset(
                      'assets/new_ic_docclose.svg',
                      width: 18,
                      height: 18,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.center,
              child: SvgPicture.asset(
                SetImageView(mUploadFiles.documenttype ?? ""),
                width: 70,
                height: 70,
              ),
            ),
            Text(
              (mUploadFiles.name ?? "").length > 30
                  ? '${(mUploadFiles.name ?? "").substring(0, 30)}...'
                  : (mUploadFiles.name ?? ""),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontFamily: 'OpenSauceSansRegular',
                  fontSize: mSizeOne,
                  color: mBlackTwo),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.center,
              child: InkWell(
                  onTap: mViewFile,
                  child: Container(
                      width: 170,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: mGreyTwo,
                        border: Border.all(color: mGreyTwo, width: 1),
                      ),
                      child: Center(
                        child: Text(Languages.of(context)!.mView),
                      ))),
            ),
          ]),
    );
  }

  SetImageView(String mType) {
    String mSetcolor = 'assets/new_ic_pdf.svg';
    switch (mType) {
      case "pdf":
        {
          mSetcolor = 'assets/new_ic_pdf.svg';
        }
        break;

      case "docx":
        {
          mSetcolor = 'assets/new_ic_world.svg';
        }
        break;

      case "doc":
        {
          mSetcolor = 'assets/new_ic_world.svg';
        }
        break;
      case "xlsx":
        {
          mSetcolor = 'assets/new_ic_excel.svg';
        }
        break;

      default:
        {
          mSetcolor = 'assets/new_ic_pdf.svg';
        }
        break;
    }

    return mSetcolor;
  }
}
