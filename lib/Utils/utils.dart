import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:startinsights/Screen/Profile/web/profileweb.dart';
import 'package:startinsights/Utils/FontSizes.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Utils/screens.dart';
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

SetTrackingTextColor(String mType) {
  Color mSetcolor = mBlackOne;
  switch (mType) {
    case "Under Progress":
      {
        mSetcolor = mBlueOne;
      }
      break;

    case "Completed":
      {
        mSetcolor = mGreenSeven;
      }
      break;

    case "Hold":
      {
        mSetcolor = mOrangeSeven;
      }
      break;

    default:
      {
        mSetcolor = mBlackOne;
      }
      break;
  }

  return mSetcolor;
}

SetTextColor(String mType) {
  Color mSetcolor = mBlackOne;
  switch (mType) {
    case "Under Progress":
      {
        mSetcolor = mS1GreenNine;
      }
      break;

    case "Completed":
      {
        mSetcolor = Colors.white;
      }
      break;

    case "Hold":
      {
        mSetcolor = mOrangeSeven;
      }
      break;

    default:
      {
        mSetcolor = mBlackOne;
      }
      break;
  }

  return mSetcolor;
}

//Under Progress
// Hold
//Completed
SetBackgroungColor(String mType) {
  Color mSetcolor = mBlackOne;
  switch (mType) {
    case "Under Progress":
      {
        mSetcolor = mGreenThree;
      }
      break;

    case "Completed":
      {
        mSetcolor = mGreyTen;
      }
      break;

    case "Hold":
      {
        mSetcolor = mOrangeThree;
      }
      break;

    default:
      {
        mSetcolor = mBlackOne;
      }
      break;
  }

  return mSetcolor;
}

void ErrorToast({
  required BuildContext context,
  required String text,
}) {
  // final snackBar = SnackBar(
  //   content: Text(
  //     text,
  //     textAlign: TextAlign.center,
  //     style: const TextStyle(
  //         fontSize: 16, color: Colors.white, fontFamily: 'ManropeRegular'),
  //   ),
  //   backgroundColor: Colors.red,
  //   behavior: SnackBarBehavior.floating,
  //   margin: const EdgeInsets.only(bottom: 40, left: 100, right: 100),
  //   padding: const EdgeInsets.all(15),
  //   elevation: 1,
  //   duration: const Duration(seconds: 2),
  // );

  final snackBar = SnackBar(
    width: 400,
    content: Center(
        child: Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
          fontSize: mSizeThree,
          color: Colors.white,
          fontFamily: 'OpenSauceSansRegular'),
    )),
    backgroundColor: Colors.red,
    elevation: 1,
    duration: const Duration(seconds: 2),
    behavior: SnackBarBehavior.floating,
    padding: const EdgeInsets.all(15),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void SucessToast({
  required BuildContext context,
  required String text,
}) {
  /*final snackBar = SnackBar(
    content: Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
          fontSize: 16, color: Colors.white, fontFamily: 'ManropeRegular'),
    ),
    backgroundColor: Colors.green,
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.only(bottom: 40, left: 100, right: 100),
    padding: const EdgeInsets.all(15),
    elevation: 1,
    duration: const Duration(seconds: 2),
  );*/

  final snackBar = SnackBar(
    width: 400,
    content: Center(
        child: Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
          fontSize: mSizeThree,
          color: Colors.white,
          fontFamily: 'OpenSauceSansRegular'),
    )),
    backgroundColor: Colors.green,
    elevation: 1,
    duration: const Duration(seconds: 2),
    behavior: SnackBarBehavior.floating,
    padding: const EdgeInsets.all(15),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    ),
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
            backgroundColor: const Color.fromARGB(255, 252, 30, 100),
          )
        : SnackBar(
            content: Text(text),
            behavior: SnackBarBehavior.floating,
            backgroundColor: const Color.fromARGB(255, 252, 30, 100),
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

class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
/*final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
    key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5),
    value: (item) => List.generate(
        item % 4 + 1, (index) => Event('Event $item | ${index + 1}')))
  ..addAll({
    kToday: [
      Event('Today\'s Event 1'),
      Event('Today\'s Event 2'),
    ],
  });



final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);*/

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
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

void OnProfileload(BuildContext context1) {
  showDialog<void>(
    barrierDismissible: true,
    context: context1,
    builder: (BuildContext context) {
      return StatefulBuilder(builder: (context1, setState) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            const SizedBox(
              height: 60,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.white,
                      blurRadius: 1.0,
                    ),
                  ]),
              height: 250,
              width: 150,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Material(
                          color: Colors.white,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ProfileWeb()));
                            },
                            child: const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    // Based on passwordVisible state choose the icon
                                    Icons.account_circle_outlined,
                                    color: kGray,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SidemenuText(menuname: "Profile")
                                ]),
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Material(
                          color: Colors.white,
                          child: InkWell(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context1, profileRoute);
                            },
                            child: const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    // Based on passwordVisible state choose the icon
                                    Icons.logout,
                                    color: kGray,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SidemenuText(menuname: "Logout")
                                ]),
                          )),
                    )
                  ]),
            )
          ],
        );
      });
    },
  );

  /*showDialog(
    context: context,
    builder: (context2) {
      String contentText = "Content of Dialog";
      return StatefulBuilder(
        builder: (context1, setState) {
          return AlertDialog(
            content: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                const SizedBox(
                  height: 60,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 1.0,
                        ),
                      ]),
                  height: 250,
                  width: 150,
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, profileRoute);
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            SidemenuText(
                                menuname: "Languages.of(context)!.mprofile")
                          ],
                        ),
                      ),
                      const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          sidemenuImage(menuicon: 'assets/ic_chat.png'),
                          SizedBox(
                            width: 10,
                          ),
                          SidemenuText(menuname: "Logout")
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      );
    },
  );*/
}

class sidemenuImage extends StatelessWidget {
  const sidemenuImage({
    super.key,
    required this.menuicon,
  });
  final String menuicon;
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      menuicon,
      height: 25,
    );
  }
}

class SidemenuText extends StatelessWidget {
  const SidemenuText({
    super.key,
    required this.menuname,
  });

  final String menuname;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(
          fontFamily: 'ManropeBold', fontSize: 16, color: kGray),
      child: Text(menuname),
    );
  }
}
