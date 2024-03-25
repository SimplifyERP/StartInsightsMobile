import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileScreenLayout;
  final Widget webScreenLayout;
  const ResponsiveLayout({
    Key? key,
    required this.mobileScreenLayout,
    required this.webScreenLayout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 950) {
          //936 950
          print("Webview 123");
          return webScreenLayout;
        }
        return mobileScreenLayout;
      },
    );
  }
}

/// mobile < 650
/// tablet >= 650
///
/// class Responsive extends StatelessWidget {
///   final Widget mobile;
///   final Widget tablet;
///   final Widget desktop;
///   const Responsive({
///     Key? key,
///     required this.desktop,
///     required this.mobile,
///     required this.tablet,
//   }) : super(key: key);
//
//   /// mobile < 650
//   static bool isMobile(BuildContext context) =>
//       MediaQuery.of(context).size.width < 650;
//
//   /// tablet >= 650
//   static bool isTablet(BuildContext context) =>
//       MediaQuery.of(context).size.width >= 650;
//
//   ///desktop >= 1100
//   static bool isDesktop(BuildContext context) =>
//       MediaQuery.of(context).size.width >= 1100;
//
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(builder: (context, constraints) {
//       if (constraints.maxWidth >= 1100) {
//         return desktop;
//       } else if (constraints.maxWidth >= 650) {
//         return tablet;
//       } else {
//         return mobile;
//       }
//     });
//   }
// }
