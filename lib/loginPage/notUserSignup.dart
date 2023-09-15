import 'package:flutter/material.dart';

import '../registerPage/mainScreen.dart';
import '../reusableWidgets/Responsive.dart';

Widget notUserSignup(context) {
  return Container(
    margin: const EdgeInsets.only(top: 20),
    child: SizedBox(
      width: 250,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const Register()));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
        ),
        child: Text("Not a User?",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: setSize(context, 22))),
      ),
    ),
  );
}
