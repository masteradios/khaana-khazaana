import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/studentProviders/studentProvider.dart';
import '../../reusableWidgets/Responsive.dart';
import '../../reusableWidgets/createColor.dart';
import '../../reusableWidgets/profileSection/getProfileInfo.dart';
import '../../reusableWidgets/profileSection/mainPage.dart';
import '../../reusableWidgets/profileSection/provider.dart';
import '../quizOfEachTeacher/quizFromEachFaculty.dart';

Widget cardWidget(validData, index, type) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Consumer2<StudentProvider, ProfilePageProvider>(
      builder: (context, studentProvider, profileProvider, child) {
        return InkWell(
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                // Create Column Widget of faculty Data to show in card........
                // These containers are defined below..........................
                type == "Grid"
                    ? Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        facultyNameContainer(
                          validData?[index]["name"],
                          context,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: headingContainer("About Faculty     :", context),
                            ),
                            Expanded(
                              flex: 2,
                              child: contentContainer(validData?[index]["about"], context),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: headingContainer("Experience of Faculty  :", context),
                            ),
                            Expanded(
                              flex: 2,
                              child: contentContainer(validData?[index]["experience"], context),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                )
                    : Column(
                  children: [
                    facultyNameContainer(
                      validData?[index]["name"],
                      context,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: headingContainer("About Faculty     :", context),
                        ),
                        Expanded(
                          flex: 2,
                          child: contentContainer(validData?[index]["about"], context),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: headingContainer("Experience of Faculty  :", context),
                        ),
                        Expanded(
                          flex: 2,
                          child: contentContainer(validData?[index]["experience"], context),
                        ),
                      ],
                    ),

                  ],
                ),
                SizedBox(height: 10),
                // Divider(
                //   color: Colors.black,
                //   thickness: 1.5,
                //   height: 0,
                // ),
                Container(
                  width: 320,
                  margin: EdgeInsets.only(bottom: 15, top: 2),
                  child:ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const QuizFromEachFaculty()
                          )
                      );
                      },
                    style: ElevatedButton.styleFrom(
                      elevation: 4, // Adjust the elevation as needed
                      primary: Colors.blue, // Set the button's background color
                    ),
                    child: Text(
                      "Tap to View",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white, // Set the text color
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ),
              ],
            ),
          ),
          onTap: () async {
            await getProfileInfo(profileProvider);
            if (profileProvider.qualification == "" || profileProvider.about == "") {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text(
                      "Alert",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    elevation: 20,
                    content: const Text(
                      "Kindly Update Profile Section to Participate in a Quiz",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Cancel",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProfilePage(),
                            ),
                          );
                        },
                        child: const Text(
                          "Update",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  );
                },
              );
            } else {
              // Set Faculty ID to Provider...............
              studentProvider.setFacultyEmail(validData?[index].id);
              studentProvider.setFacultyName(validData?[index]["name"]);
              // navigate to QuizfromFaculty() class to get list of quiz assigned by particular faculty........
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const QuizFromEachFaculty(),
                ),
              );
            }
          },
        );
      },
    ),
  );
}

// Container for faculty Name from snapshots.............................
Container facultyNameContainer(value, context) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
    decoration: BoxDecoration(
      color: Colors.green, // You can change the background color
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
    ),
    child: Text(
      value,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: setSize(context, 23),
        fontWeight: FontWeight.bold,
        color: Colors.white, // You can change the text color
        fontFamily: 'Montserrat',
      ),
    ),
  );
}



// Container of Heading.............................
Container headingContainer(value, context) {
  return Container(
    padding: const EdgeInsets.only(top: 10, bottom: 10, right: 20, left: 20),
    child: Text(
      value,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: setSize(context, 20),
        color: hexToColor("#14735b"),
        fontWeight: FontWeight.w800,
        overflow: TextOverflow.visible,
      ),
    ),
  );
}

// Container of Data from snapshots............................
Container contentContainer(value, context) {
  return Container(
    padding: const EdgeInsets.only(bottom: 10, right: 20),
    child: Text(
      value,
      textAlign: TextAlign.left,
      style: TextStyle(
        fontSize: setSize(context, 20),
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
