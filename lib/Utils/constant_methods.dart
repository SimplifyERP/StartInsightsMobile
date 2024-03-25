//import 'dart:ui' as ui;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

void printResponse(String text) {
  if (kDebugMode) {
    print('\x1B[33m$text\x1B[0m');
  }
}

void printError(String text) {
  if (kDebugMode) {
    print('\x1B[31m$text\x1B[0m');
  }
}

void printTest(String text) {
  if (kDebugMode) {
    print('\x1B[32m$text\x1B[0m');
  }
}

void showToastMsg({required String msg, required ToastStates toastState}) {
  Toast.show(msg,
      duration: Toast.lengthShort,
      gravity: Toast.bottom,
      backgroundColor: chooseToastColor(state: toastState),
      textStyle: const TextStyle(fontSize: 16, color: Colors.white));
}

Color chooseToastColor({required ToastStates state}) {
  Color color;
  switch (state) {
    case ToastStates.success:
      color = Colors.white;
      break;
    case ToastStates.warning:
      color = Colors.white;
      break;
    case ToastStates.error:
      color = Colors.red;
      break;
  }
  return color;
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

// Future<Uint8List> getBytesFromAsset(String path, double width) async {
//   ByteData data = await rootBundle.load(path);
//   ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
//       targetWidth: width.toInt());
//   ui.FrameInfo fi = await codec.getNextFrame();
//   return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
//       .buffer
//       .asUint8List();
// }

Future multipartConvertImage({
  required XFile image,
}) async {
  return MultipartFile.fromFileSync(image.path,
      filename: image.path.split('/').last);
}

Future<XFile?> pickImage(ImageSource source) async {
  XFile? image = await ImagePicker().pickImage(
      source: source, maxHeight: 1024, maxWidth: 1024, imageQuality: 50);
  if (image != null) {
    return image;
  } else {
    return null;
  }
}

Color darkOrLightColor(Color lightColor, Color darkColor) {
  return lightColor;
}

checkNetworkStatus() async {
  // bool isNetworkConnected =
  //     await FlutterNetworkConnectivity().isNetworkConnectionAvailable();

  bool isNetworkConnected = true;
  // SizerUtil.deviceType == DeviceType.mobile
  //     ? isNetworkConnected =
  //         await FlutterNetworkConnectivity().isNetworkConnectionAvailable()
  //     : isNetworkConnected = true;
  //
  // //bool isNetworkConnected = true;
  // if (isNetworkConnected) {
  //   print('Mobile network are disabled. Please enable the services');
  // }
  return isNetworkConnected;
}

String changeDateFormat(String mdate, String mDateformat) {
  DateTime parseDate = DateFormat(mDateformat).parse(mdate);
  var inputDate = DateTime.parse(parseDate.toString());
  var outputFormat = DateFormat('dd MMM yyyy');
  var mSelecteddate = outputFormat.format(inputDate);

  return mSelecteddate;
}

String changeTimeFormat(String mdate) {
  DateTime parseDate = DateFormat('HH:mm:ss').parse(mdate);
  var inputDate = DateTime.parse(parseDate.toString());
  var outputFormat = DateFormat('HH:mm a');
  var mSelecteddate = outputFormat.format(inputDate);

  return mSelecteddate;
}

String changeTimeFormat1(String mdate) {
  DateTime parseDate = DateFormat('HH:mm:ss').parse(mdate);
  var inputDate = DateTime.parse(parseDate.toString());
  var outputFormat = DateFormat('hh:mm a');
  var mSelecteddate = outputFormat.format(inputDate);

  return mSelecteddate;
}

String changeTimeFormat2(String mdate) {
  DateTime parseDate = DateFormat('HH:mm:ss').parse(mdate);
  var inputDate = DateTime.parse(parseDate.toString());
  var outputFormat = DateFormat('HH:mm');
  var mSelecteddate = outputFormat.format(inputDate);

  return mSelecteddate;
}

bool isMobileNumberValid(String phoneNumber) {
  //String regexPattern = r'^(?:[+0][1-9])?[0-9]{10}$';
  // String regexPattern = r'^(?:[+0][1-9])?[0-9]{10}$';
  String regexPattern = r'[6-9][0-9]{9}$';

  var regExp = RegExp(regexPattern);

  if (phoneNumber.isEmpty) {
    return false;
  } else if (regExp.hasMatch(phoneNumber)) {
    return true;
  }
  return false;
}

bool isPasswordValid(String value) {
  RegExp regex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  if (value.isEmpty) {
    return false;
  } else {
    if (!regex.hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }
  return false;
}

String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';

String mRazorpayTestKey = 'rzp_test_s2QKOArJgFxKfp';
String mRazorpayLiveKey = 'rzp_test_s2QKOArJgFxKfp';
String mRazorpayName = 'StartInsights';

//final kFirstDay = DateTime(DateTime.now().year, DateTime.now().month , DateTime.now().day);
final kFirstDay =
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
final kLastDay = DateTime(2100, 12, 31);

enum ToastStates { success, error, warning }

enum BookingStatus { upcomming, cancelled, completed }

const String mAndroidMapKey = 'AIzaSyC3YjVtveQqk7Qr7sG5D1rUAAwsRapEcLE';
//const String miOSMapKey = 'AIzaSyAs-r7zIOV4PUeibHUDcaOGohi7aTvtQjY';
const String miOSMapKey = 'AIzaSyAl86jRqzZt54vmiXaJiEusRTAKkKmbAeo';

//String httpSC = 'http:';
Image mLoaderGif = Image.asset('assets/ic_loader.gif');

DateFormat mFirstFormat = DateFormat('dd-MM-yyyy');
DateFormat mDisplayFirstFormat = DateFormat('dd MMM yyyy');
DateFormat mLeaveDateFormat = DateFormat('yyyy-MM-dd');
DateFormat mGetyearFormat = DateFormat('yy');
double mTabelText = 15;
double mLeaveTabelText = 16;
double mTabelTitleText = 18;
double mCaptableTabelText = 14;

sharedPreferencesStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs;
}
