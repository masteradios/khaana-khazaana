import 'package:flutter/material.dart';
import 'main.dart';

class ScorePage extends StatelessWidget {
  final int score;

  ScorePage({required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Letter Click Challenge - Score',
            style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.w900,
                fontFamily: 'CabinSketch')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Congratulation!',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'CabinSketch'),
            ),
            SizedBox(height: 20),
            Text(
              'Your Score is $score',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'CabinSketch'),
            ),
            ElevatedButton(
                onPressed: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LetterClickGameScreen()),
                      ModalRoute.withName(
                          '/'), // Or your desired return route name
                    ),
                child: Text('Replay',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'CabinSketch')))
          ],
        ),
      ),
    );
  }
}
