import 'package:flutter/material.dart';

import '../reusableWidgets/Responsive.dart';
import 'alreadyUserLogin.dart';
import 'submitButton.dart';
import 'textFields.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        width: screenWidth(context),
        height: screenHeight(context),
        decoration: pageDecoration(),

        /// See Below.............................
        child: SingleChildScrollView(child: bodyContainer()),
      ),
    );
  }

  Container bodyContainer() {
    return Container(
      width: ResponsiveWidget.isSmallScreen(context)
          ? screenWidth(context)
          : screenWidth(context) / 2,
      margin: EdgeInsets.symmetric(vertical: setSize(context, 20)),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// See Below.............................
          registerText(),
          textFieldName(),
          textFieldEmail(),
          textFieldPassword(),
          buttonSubmit(),
          //termsConditions(),
          alreadyUserLogin(context),
        ],
      ),
    );
  }

  Widget registerText() {
    return Text(
      "REGISTER NOW",
      style: TextStyle(
          fontSize: setSize(context, 35),
          fontWeight: FontWeight.w800,
          color: Colors.white),
    );
  }

  BoxDecoration pageDecoration() {
    return const BoxDecoration(
        gradient: LinearGradient(colors: [
      Colors.teal,
      Colors.blue,
    ], begin: Alignment.bottomRight, end: Alignment.topLeft));
  }
}
