import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../reusableWidgets/Responsive.dart';
import '../../../reusableWidgets/createColor.dart';

Widget shareWidget(result, studentValue, quizValue, context) {
  return Container(
    alignment: Alignment.center,
    color: Colors.white,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        message(result, context),
        progressBarwithScore(studentValue, quizValue, context),
        resultContainer(result, context),
      ],
    ),
  );
}

Widget message(result, context) {
  if (result >= 50) {
    return Container(
      // margin: EdgeInsets.only(bottom: setSize(context, 30)),
      child: Text("Hurray, You Passed the Test !!!",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.green,
              fontSize: setSize(context, 25),
              fontWeight: FontWeight.w600)),
    );
  } else {
    return Container(
        margin: EdgeInsets.only(bottom: setSize(context, 30)),
        child: Text("Whoops! You failed the exam.",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.redAccent, fontSize: setSize(context, 25))));
  }
}

Widget progressBarwithScore(studentValue, quizValue, context) {
  return Container(
    padding: EdgeInsets.all(setSize(context, 20)),
    child: Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 120,
          height: 120,
          child: CircularProgressIndicator(
            value:
                quizValue.totalRight / int.parse(studentValue.totalQuestions),
            backgroundColor: hexToColor("#fc6603"),
            color: hexToColor("#00fa0c"),
            strokeWidth: 15,
          ),
        ),
        Center(
          child: Text("${quizValue.totalRight}/${studentValue.totalQuestions}",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: setSize(context, 20),
                  fontWeight: FontWeight.bold)),
        )
      ],
    ),
  );
}

Widget resultContainer(result, context) {
  return Container(
    padding: EdgeInsets.all(setSize(context, 20)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Result : ",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: setSize(context, 20),
                color: Colors.black)),
        Text(result >= 50 ? "Passed" : "Failed",
            style: TextStyle(
                color:
                    result > 40 ? hexToColor("#0cab44") : hexToColor("#a31a08"),
                fontWeight: FontWeight.w500,
                fontSize: setSize(context, 20))),
      ],
    ),
  );
}

Widget screenshot(studentValue, quizValue, result, sc_controller, context) {
  return result >= 50
      ? Column(
    mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
                textAlign:TextAlign.center,
                'Way to go, champ! You nailed it! Keep up the awesome work!!',
                style: TextStyle(
                    fontSize: setSize(context, 20),
                    color: const Color.fromRGBO(255, 165, 0,100),
                    fontWeight: FontWeight.bold)),
            InkWell(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesomeIcons.shareNodes,
                    color: Colors.blue,
                    size: setSize(context, 30),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Share Your Score",
                      style: TextStyle(
                          fontSize: setSize(context, 20),
                          color: Colors.blue,
                          fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
              onTap: () async {
                final image = await sc_controller.captureFromWidget(
                    shareWidget(result, studentValue, quizValue, context));
                saveAndShare(image);
              },
            ),
          ],
        )
      : Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              textAlign: TextAlign.center,
              "Don't worry! Losing a quiz happens sometimes. Keep learning and having fun..You'll get them next time!",
              style: TextStyle(
                  fontSize: setSize(context, 15),
                  color: const Color.fromRGBO(200, 162, 200,1),
                  fontWeight: FontWeight.w600),
            ),
          ),
        );
}

void saveAndShare(Uint8List bytes) async {
  final directory = await getApplicationDocumentsDirectory();
  final image = File("${directory.path}/flutter.png");
  image.writeAsBytesSync(bytes);
  XFile imageFileAsXFile = XFile(image.path);
  await Share.shareXFiles([imageFileAsXFile],
      text: "This is my score on the quiz i attempted");
}

Widget homePageNaviagte(context) {
  return IconButton(
      onPressed: () => Navigator.pop(context),
      icon: Icon(
        FontAwesomeIcons.house,
        size: setSize(context, 35),
      ));
}
