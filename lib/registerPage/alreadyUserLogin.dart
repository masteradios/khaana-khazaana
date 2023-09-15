import 'package:flutter/material.dart';

import '../loginPage/mainScreen.dart';
import '../reusableWidgets/Responsive.dart';

Widget alreadyUserLogin(context) {
  return Container(
    margin: const EdgeInsets.only(top: 20),
    child: SizedBox(
      width: 300,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginPage()));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green
        ),
        child: Text("Already a User?",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: setSize(context, 20))),
      ),
    ),
  );
}
