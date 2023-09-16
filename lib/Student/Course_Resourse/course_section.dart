import 'package:flutter/material.dart';

import 'English.dart';
import 'Evs.dart';
import 'Math.dart';


class CourseSection extends StatefulWidget {
  const CourseSection({Key? key}) : super(key: key);

  @override
  State<CourseSection> createState() => _CourseSectionState();
}

class _CourseSectionState extends State<CourseSection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text('Course_Section'),
        centerTitle: true,
        elevation: 10,
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      // drawer: navigationDrawerStudent(context),
       body: SingleChildScrollView(
         child: Column(
           children: [
             // English card
             InkWell(
               onTap: () {
                 Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) => EnglishPage()),
                 );
               },
               child: const Card(
                 child: ListTile(
                   title: Text('English'),
                   subtitle: Text('Tap to view English content'),
                 ),
               ),
             ),
             // EVS card
             InkWell(
               onTap: () {
                 Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) => EvsPage()),
                 );
               },
               child: const Card(
                 child: ListTile(
                   title: Text('EVS (Environmental Studies)'),
                   subtitle: Text('Tap to view EVS content'),
                 ),
               ),
             ),
             // Maths card
             InkWell(
               onTap: () {
                 Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) => MathsPage()),
                 );
               },
               child: Card(
                 child: ListTile(
                   title: Text('Maths'),
                   subtitle: Text('Tap to view Maths content'),
                 ),
               ),
             ),
           ],
         ),
       ),
    );
  }
}
