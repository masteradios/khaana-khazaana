import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

import '../../../providers/studentProviders/startQuizProvider.dart';
import '../../../providers/studentProviders/studentProvider.dart';
import '../../../reusableWidgets/Responsive.dart';
import '../../../reusableWidgets/appBar.dart';
import 'resultSummaryContent.dart';

class ResultSummary extends StatefulWidget {
  const ResultSummary({Key? key}) : super(key: key);

  @override
  State<ResultSummary> createState() => _ResultSummaryState();
}

class _ResultSummaryState extends State<ResultSummary>
    with SingleTickerProviderStateMixin {
  final sc_controller = ScreenshotController();
  late final AnimationController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: const Text(
              'Your Score',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.white,
          ),
          body: Consumer2<StartQuizProvider, StudentProvider>(
            builder: (context, quizValue, studentValue, child) {
              double result = quizValue.totalRight /
                  int.parse(studentValue.totalQuestions) *
                  100;
              return Container(
                color: Colors.white,
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  // padding: EdgeInsets.symmetric(vertical: setSize(context, 20)),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.zero,
                          height: MediaQuery.of(context).size.height * 0.30,
                          child: Lottie.network(result >= 50
                              ? 'https://lottie.host/77b37267-0ca3-40dc-8fe4-4381481757ce/6KqEELKUYO.json'
                              : 'https://lottie.host/4f7cff73-b765-40ac-aeb3-3a1789784409/f2tcj7vEJD.json')),
                      shareWidget(result, studentValue, quizValue, context),
                      screenshot(studentValue, quizValue, result, sc_controller,
                          context),
                      homePageNaviagte(context),
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }
}
