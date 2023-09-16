// english_page.dart
import 'package:flutter/material.dart';

class EnglishPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('English Page'),
      ),
      body: Center(
        child: Text('English content goes here'),
      ),
    );
  }
}