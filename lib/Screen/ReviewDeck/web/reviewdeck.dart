import 'dart:html';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Screen/ReviewDeck/bloc/reviewdeck_bloc.dart';
import 'package:startinsights/Screen/ReviewDeck/bloc/reviewdeck_state.dart';
import 'package:startinsights/Utils/FontSizes.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Utils/screens.dart';
import 'package:startinsights/Widgets/Appbarnew.dart';
import 'package:startinsights/Widgets/sidemenunew.dart';

class ReviewDeck extends StatefulWidget {
  ReviewDeck({super.key});

  @override
  State<ReviewDeck> createState() => _ReviewDeckState();
}

class _ReviewDeckState extends State<ReviewDeck> {
  @override
  late ReviewDeckBloc mReviewDeckBloc;

  ValueNotifier<bool> setnotifier = ValueNotifier(true);

  late Widget iframeWidget;
  final IFrameElement iframeElement = IFrameElement();

  @override
  void initState() {
    super.initState();

    iframeElement.height = '100%';
    iframeElement.width = '100%';

    iframeElement.style.margin = '0';
    iframeElement.style.padding = '0';
    iframeElement.style.position = 'fixed';
    iframeElement.src = 'https://startinsights.fornax.ai/';
    iframeElement.style.border = 'none';

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'iframeElement1',
      (int viewId) => iframeElement,
    );

    iframeWidget = HtmlElementView(
      key: UniqueKey(),
      viewType: 'iframeElement1',
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    mReviewDeckBloc = ReviewDeckBloc(mContext: context);

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
          body: BlocConsumer<ReviewDeckBloc, ReviewDeckStatus>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is GetReviewDeckInfoSuccessState) {}
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
                                                        .mReviewYouPitchDeck,
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
                                          MediaQuery.of(context).size.height +
                                              200,
                                      color: Colors.white,
                                      child: iframeWidget)
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
