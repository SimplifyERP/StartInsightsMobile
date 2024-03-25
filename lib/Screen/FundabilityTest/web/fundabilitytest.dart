import 'dart:html';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Screen/FundabilityTest/bloc/fundabilitytest_bloc.dart';
import 'package:startinsights/Screen/FundabilityTest/bloc/fundabilitytest_state.dart';
import 'package:startinsights/Utils/FontSizes.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Utils/screens.dart';
import 'package:startinsights/Widgets/Appbarnew.dart';
import 'package:startinsights/Widgets/sidemenunew.dart';

class FundabilityTest extends StatefulWidget {
  FundabilityTest({super.key});

  @override
  State<FundabilityTest> createState() => _FundabilityTestState();
}

class _FundabilityTestState extends State<FundabilityTest> {
  @override
  late FundabilityTestBloc mFundabilityTestBloc;

  ValueNotifier<bool> setnotifier = ValueNotifier(true);

  late Widget _iframeWidget;
  final IFrameElement _iframeElement = IFrameElement();
  final String _htmlElementViewType = '_htmlElementViewType';

  @override
  void initState() {
    super.initState();

    _iframeElement.height = '100%';
    _iframeElement.width = '100%';

    _iframeElement.style.margin = '0';
    _iframeElement.style.padding = '0';
    _iframeElement.style.position = 'fixed';
    _iframeElement.src = 'https://nhrykdvxf2v.typeform.com/to/GHXaoEIg';
    _iframeElement.style.border = 'none';

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'iframeElement',
      (int viewId) => _iframeElement,
    );

    _iframeWidget = HtmlElementView(
      key: UniqueKey(),
      viewType: 'iframeElement',
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    mFundabilityTestBloc = FundabilityTestBloc(mContext: context);

    void OnLoadNext() {
      Navigator.pushReplacementNamed(context, dashboardRoute);
    }

    final ScrollController controller = ScrollController();

    return WillPopScope(
      onWillPop: () {
        //trigger leaving and use own data
        //Navigator.pop(context, false);

        OnLoadNext();
        //we need to return a future
        return Future.value(false);
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: BlocConsumer<FundabilityTestBloc, FundabilityTestStatus>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is GetFundabilityTestInfoSuccessState) {}
              return SafeArea(
                  child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    image: const DecorationImage(
                      image: AssetImage("assets/new_ic_background.png"),
                      fit: BoxFit.fill,
                    )),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SideMenuNew(
                        mFrom: 0,
                        context: context,
                        mchange: (value) {
                          print(value);
                          setnotifier.value = value;
                        },
                        isExpanded: true,
                      ),
                      //invisibleSubMenus(),
                      ValueListenableBuilder(
                        valueListenable: setnotifier,
                        builder: (context, value, child) => Container(
                          width: value
                              ? MediaQuery.of(context).size.width * 0.78
                              : MediaQuery.of(context).size.width * 0.906,
                          margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                          padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AppbarNew(
                                mText: "TExt",
                                mUserImage: "",
                                mFrom: 0,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                  child: Column(
                                children: [
                                  Container(
                                    height: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.white,
                                          blurRadius: 1.0,
                                        ),
                                      ],
                                    ),
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const SizedBox(
                                                  width: 30,
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    Languages.of(context)!
                                                        .mCheckFundabilityTest,
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        fontFamily:
                                                            'OpenSauceSansSemiBold',
                                                        fontSize: mSizeFive,
                                                        color: mBlackOne),
                                                  ),
                                                )
                                              ]),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                              const SizedBox(
                                height: 20,
                              ),
                              Expanded(
                                  child: Container(
                                height:
                                    MediaQuery.of(context).size.height + 200,
                                color: Colors.white,
                                child: _iframeWidget,
                                /*WebView(
                                  initialUrl: 'about:blank',
                                  javascriptMode: JavascriptMode.unrestricted,
                                  onWebViewCreated:
                                      (WebViewController webViewController) {
                                    // Load the Typeform embed code
                                    webViewController.loadUrl(
                                      Uri.dataFromString(
                                        '<html><body><iframe src="https://nhrykdvxf2v.typeform.com/to/GHXaoEIg" width="100%" height="100%" frameborder="0" allowfullscreen="true"></iframe></body></html>',
                                        mimeType: 'text/html',
                                      ).toString(),
                                    );
                                  },
                                )*/
                                // WebView(
                                //   initialUrl: 'assets/myfile.html',
                                //   javascriptMode: JavascriptMode.unrestricted,
                                // ),
                              )
                                  // child: InAppWebView(
                                  //   initialFile: "assets/index.html",
                                  // ),

                                  // SingleChildScrollView(
                                  //   child: Container(
                                  //       height:
                                  //           MediaQuery.of(context).size.height +
                                  //               200,
                                  //       color: Colors.yellow,
                                  //       child: _iframeWidget), //
                                  // ),
                                  ),
                            ],
                          ),
                        ),
                      )
                    ]),
              ));
              //  ErrorToast(context: context, text: state.mDashboard.message!);

              //} else if (state is GetPunchInOutFailState) {}
              return Container();
            },
          )),
    );
  }
}
