import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/constantString.dart';
import 'Responsive.dart';
import 'profileSection/provider.dart';

drawerHeader(context) {
  return Container(
    margin: const EdgeInsets.only(bottom: 20),
    padding: const EdgeInsets.only(bottom: 20, top: 10),
    width: double.infinity,
    color: Colors.blue,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [userImage(), userName(context), userEmail(context)],
    ),
  );
}

userEmail(context) {
  return Container(
      alignment: Alignment.center,
      child: Text(
        "${FirebaseAuth.instance.currentUser?.email}",
        style: TextStyle(
            fontSize: setSize(context, 17),
            fontWeight: FontWeight.w500,
            color: Colors.white),
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
      ));
}

userName(context) {
  return Consumer<ProfilePageProvider>(
    builder: (context, providerValue, child) {
      return Container(
          margin: const EdgeInsets.only(bottom: 5, top: 10),
          alignment: Alignment.center,
          child: Text(
            providerValue.userName == ""
                ? "${FirebaseAuth.instance.currentUser?.displayName}"
                : providerValue.userName,
            style: TextStyle(
                fontSize: setSize(context, 20),
                fontWeight: FontWeight.bold,
                color: Colors.white),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ));
    },
  );
}

userImage() {
  String? imgUrl = FirebaseAuth.instance.currentUser?.photoURL.toString();
  return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          //border: Border.all(color: Colors.black, width: 1.7),
      ),
      margin: const EdgeInsets.only(top: 40, bottom: 10),
      width: 120,
      child: imgUrl == "null"
          ? ClipOval(
            child: Image.asset(
                appLogo,
                height: 120,
                width: 120,
        fit: BoxFit.cover,
              ),
          )
          : Image.asset(
              imgUrl!,
              height: 150,
              width: 150,
            ));
}
