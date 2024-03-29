import 'package:flutter/material.dart';
import 'package:flutter_project/Student/activityPage/home_page.dart';
import 'package:flutter_project/Student/screen/home_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../aboutPage/mainPage.dart';
import '../../constants/constantString.dart';
import '../../reusableWidgets/Responsive.dart';
import '../../reusableWidgets/alertDialogs/alertDialogLogout.dart';
import '../../reusableWidgets/profileSection/getProfileInfo.dart';
import '../../reusableWidgets/profileSection/mainPage.dart';
import '../../reusableWidgets/profileSection/provider.dart';
import '../Course_Resourse/course_section.dart';
import '../checkScores/checkScores.dart';

ListTile listTileMyQuiz(context) {
  return ListTile(
    contentPadding: const EdgeInsets.only(left: 20),
    leading:
        const Icon(FontAwesomeIcons.receipt, size: 20, color: Colors.black),
    title: Text(
      "Course",
      style: TextStyle(
        fontSize: setSize(context, 17),
        fontWeight: FontWeight.w400,
      ),
    ),
    onTap: () {
      Navigator.pop(context);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const CourseSection()));
    },
  );
}

ListTile listTileCheckScore(context) {
  return ListTile(
    contentPadding: const EdgeInsets.only(top: 15, left: 20),
    leading: Icon(FontAwesomeIcons.squarePollVertical,
        size: setSize(context, 17), color: Colors.black),
    title: Text(
      "Check My Score",
      style: TextStyle(
        fontSize: setSize(context, 17),
        fontWeight: FontWeight.w400,
      ),
    ),
    onTap: () {
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const CheckScore()));
    },
  );
}

ListTile listTileLogout(context) {
  return ListTile(
      style: ListTileStyle.drawer,
      contentPadding: const EdgeInsets.only(top: 15, left: 20),
      leading: const Icon(FontAwesomeIcons.arrowRightFromBracket,
          size: 20, color: Colors.black),
      title: Text(
        "Sign out",
        style: TextStyle(
            fontSize: setSize(context, 18), fontWeight: FontWeight.w400),
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return alertDialogSignOut(context);
          },
        );
      });
}

Container listTileProfile(context) {
  return Container(
    child: Consumer<ProfilePageProvider>(
      builder: (context, providervalue, child) {
        return ListTile(
          contentPadding: const EdgeInsets.only(top: 15, left: 20),
          leading: const Icon(FontAwesomeIcons.userPen,
              size: 20, color: Colors.black),
          title: Text(
            "My Profile",
            style: TextStyle(
                fontSize: setSize(context, 17), fontWeight: FontWeight.w400),
          ),
          onTap: () {
            getProfileInfo(providervalue);
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ProfilePage()));
          },
        );
      },
    ),
  );
}

ListTile listTileAbout(context) {
  return ListTile(
    style: ListTileStyle.drawer,
    contentPadding: const EdgeInsets.only(top: 15, left: 20),
    leading:
        const Icon(FontAwesomeIcons.circleInfo, size: 20, color: Colors.black),
    title: Text(
      "About Us",
      style: TextStyle(
          fontSize: setSize(context, 17), fontWeight: FontWeight.w400),
    ),
    onTap: () {
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AboutPage(),
          ));
    },
  );
}

listTilePrivacyPolicy(context) {
  return ListTile(
    style: ListTileStyle.drawer,
    contentPadding: const EdgeInsets.only(top: 15, left: 20),
    leading:
        const Icon(FontAwesomeIcons.userShield, size: 20, color: Colors.black),
    title: Text(
      "Privacy Policy",
      style: TextStyle(
          fontSize: setSize(context, 17), fontWeight: FontWeight.w400),
    ),
    onTap: () async {
      Navigator.pop(context);
      await launchUrlString(privacyPolicyURL);
    },
  );
}

listTileTerms(context) {
  return ListTile(
    style: ListTileStyle.drawer,
    contentPadding: const EdgeInsets.only(top: 15, left: 20),
    leading: const Icon(FontAwesomeIcons.bookOpenReader,
        size: 20, color: Colors.black),
    title: Text(
      "Terms and Conditions",
      style: TextStyle(
          fontSize: setSize(context, 17), fontWeight: FontWeight.w400),
    ),
    onTap: () async {
      await launchUrlString(termsConditionsURL,
          webOnlyWindowName: "Terms And Conditions");
      Navigator.pop(context);
    },
  );
}

ListTile listTileShare(context) {
  return ListTile(
    contentPadding: const EdgeInsets.only(top: 15, left: 20),
    leading:
        const Icon(FontAwesomeIcons.shareNodes, size: 20, color: Colors.black),
    title: Text(
      "Share",
      style: TextStyle(
          fontSize: setSize(context, 17), fontWeight: FontWeight.w400),
    ),
    onTap: () async {
      String mailto =
          "mailto:aniketpradhan2110@gmail.com?subject=Query Regarding Gyan Saathi";
      await launchUrlString(mailto, mode: LaunchMode.externalApplication);
    },
  );
}

ListTile Game(context) {
  return ListTile(
    style: ListTileStyle.drawer,
    contentPadding: const EdgeInsets.only(top: 15, left: 20),
    leading: const Icon(FontAwesomeIcons.apple, size: 20, color: Colors.black),
    title: Text(
      "Games",
      style: TextStyle(
          fontSize: setSize(context, 17), fontWeight: FontWeight.w400),
    ),
    onTap: () {
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ));
    },
  );
}

ListTile Activity(context) {
  return ListTile(
    style: ListTileStyle.drawer,
    contentPadding: const EdgeInsets.only(top: 15, left: 20),
    leading: const Icon(FontAwesomeIcons.faceGrinStars,
        size: 20, color: Colors.black),
    title: Text(
      "Activity",
      style: TextStyle(
          fontSize: setSize(context, 17), fontWeight: FontWeight.w400),
    ),
    onTap: () {
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ActivityHomeScreen(),
          ));
    },
  );
}
