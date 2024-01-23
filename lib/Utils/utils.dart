import 'dart:io';

import 'package:flutter/material.dart';
import 'package:startinsights/Utils/MyColor.dart';
// import 'package:fluttertoast/fluttertoast.dart';

void showSnackBar({
  required BuildContext context,
  required String text,
  VoidCallback? onTapFunction,
  String? actionLabel,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    onTapFunction != null && actionLabel != null
        ? SnackBar(
            content: Text(text),
            action: SnackBarAction(
              label: actionLabel,
              textColor: Colors.white,
              onPressed: onTapFunction,
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: const Color(0xFF7700C6),
          )
        : SnackBar(
            content: Text(text),
            behavior: SnackBarBehavior.floating,
            backgroundColor: const Color(0xFF7700C6),
          ),
  );
}

Future<bool> connectivityChecker() async {
  var connected = false;
  print("Checking internet...");
  try {
    final result = await InternetAddress.lookup('google.com');
    final result2 = await InternetAddress.lookup('facebook.com');
    final result3 = await InternetAddress.lookup('microsoft.com');
    if ((result.isNotEmpty && result[0].rawAddress.isNotEmpty) ||
        (result2.isNotEmpty && result2[0].rawAddress.isNotEmpty) ||
        (result3.isNotEmpty && result3[0].rawAddress.isNotEmpty)) {
      print('connected..');
      connected = true;
    } else {
      print("not connected from else..");
      connected = false;
    }
  } on SocketException catch (_) {
    print('not connected...');
    connected = false;
  }
  return connected;
}

void ErrorToast({
  required BuildContext context,
  required String text,
}) {
  final snackBar = SnackBar(
    content: Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
          fontSize: 16, color: Colors.white, fontFamily: 'OpenSansMedium'),
    ),
    backgroundColor: Colors.red,
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.only(bottom: 40, left: 100, right: 100),
    padding: const EdgeInsets.all(15),
    elevation: 1,
    duration: const Duration(seconds: 2),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void SucessToast({
  required BuildContext context,
  required String text,
}) {
  final snackBar = SnackBar(
    content: Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
          fontSize: 16, color: Colors.white, fontFamily: 'OpenSansMedium'),
    ),
    backgroundColor: Colors.green,
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.only(bottom: 40, left: 100, right: 100),
    padding: const EdgeInsets.all(15),
    elevation: 1,
    duration: const Duration(seconds: 2),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showErrorSnackBar({
  required BuildContext context,
  required String text,
  VoidCallback? onTapFunction,
  String? actionLabel,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    onTapFunction != null && actionLabel != null
        ? SnackBar(
            content: Text(text),
            action: SnackBarAction(
              label: actionLabel,
              textColor: Colors.white,
              onPressed: onTapFunction,
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Color.fromARGB(255, 252, 30, 100),
          )
        : SnackBar(
            content: Text(text),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Color.fromARGB(255, 252, 30, 100),
          ),
  );
}

hideLoading(BuildContext context) {
  Navigator.of(context).pop();
}

showLoading(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Row(
      children: [
        const CircularProgressIndicator(),
        Container(
          margin: const EdgeInsets.only(left: 50),
          child: const Text("Loading",
              style: TextStyle(
                  fontFamily: 'ManropeBold', fontSize: 20, color: mBlackColor)),
        ),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
