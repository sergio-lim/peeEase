import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'views/intro1.dart';
import 'views/intro2.dart';
import 'views/intro3.dart';
import 'views/intro4.dart';
import '/src/settings/settings_view.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({Key? key}) : super(key: key);
  static const routeName = '/intro';

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  PageController controller = PageController();
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            onPageChanged: ((index) {
              setState(() {
                onLastPage = (index == 3);
              });
            }),
            controller: controller,
            children: [
              Intro1(),
              Intro2(),
              Intro3(),
              Intro4(),
            ],
          ),
          Container(
              alignment: Alignment(0, 0.8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('',
                      style: TextStyle(
                        color: Colors.transparent,
                      )),
                  SmoothPageIndicator(controller: controller, count: 4),
                  onLastPage
                      ? GestureDetector(
                          child: Text(
                            'Done',
                            style: TextStyle(color: Colors.white),
                          ),
                          onTap: () {
                            Navigator.restorablePushNamed(
                              context,
                              SettingsView.routeName,
                            );
                          },
                        )
                      : GestureDetector(
                          child: Text('Skip',
                              style: TextStyle(color: Colors.white)),
                          onTap: () {
                            controller.jumpToPage(3);
                          },
                        )
                ],
              )),
        ],
      ),
    );
  }
}
