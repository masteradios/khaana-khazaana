import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_project/Student/activityPage/activity2/score.dart';
import 'package:flutter_tts/flutter_tts.dart';

class LetterClickGameScreen extends StatefulWidget {
  @override
  _LetterClickGameScreenState createState() => _LetterClickGameScreenState();
}

class _LetterClickGameScreenState extends State<LetterClickGameScreen> {
  late Timer _timer;
  int _remainingTime = 60;
  int _score = 0;
  List<String> _letters = [];
  String _targetWord = '';
  String _yourWord = '';
  bool _isFirst = false;
  List<String> charList = [];
  List<String> _targetWordList = [];
  bool _isCharListInitialized = false;
  FlutterTts flutterTts = FlutterTts();
  @override
  void initState() {
    super.initState();
    flutterTts.isLanguageAvailable("en-IN").then((available) {
      checkLanguageAvailability(available);
    });
    _generateTargetWord();
    _generateLetters();
    _startGame();
  }

  Future<void> checkLanguageAvailability(bool available) async {
    if (!available) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Text-to-Speech Not Available'),
            content: Text(
                'Text-to-Speech functionality is not available on this device.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void _speak(String text) async {
    await flutterTts.setVolume(1.0);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setPitch(1.0);
    await flutterTts.setLanguage("en-IN");

    await flutterTts.speak(text);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startGame() {
    _resetGame();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        _timer.cancel();
        _navigateToScorePage();
      }
    });
  }

  void _resetGame() {
    _remainingTime = 60;
    _score = 0;
    _generateLetters();
  }

  void _generateLetters() {
    if (!_isCharListInitialized) {
      charList = _targetWord.split('');
      _isCharListInitialized = true;
    }

    _letters.clear();
    Random random = Random();
    int i = 0;
    while (_letters.length <= 8) {
      i++;
      int randomNumber = random.nextInt(6) + 1;
      if (i == randomNumber && !_letters.contains(charList[0])) {
        _letters.add(charList[0]);
      } else {
        String letter_live = String.fromCharCode(random.nextInt(26) + 65);
        if (!_letters.contains(letter_live)) {
          _letters.add(letter_live);
        }
      }
    }
  }

  void wait(Duration duration) {
    Future.delayed(duration, () {});
  }

  void _onLetterClicked(String letter) async {
    setState(() {
      if (charList[0] == letter) {
        _speak(letter);
      }
      _generateLetters();
    });

    // Perform asynchronous operations (including delay) outside setState
    await Future.delayed(Duration(milliseconds: 500));

    if (charList[0] == letter) {
      // Ensure correct logic execution
      _score++;
      for (int i = 0; i < charList.length - 1; i++) {
        charList[i] = charList[i + 1];
      }
      _yourWord += letter;
      if (_yourWord == _targetWord) {
        _speak(_yourWord);
        await Future.delayed(Duration(milliseconds: 500));
        _generateTargetWord();
        _yourWord = '';
        _isCharListInitialized = false;
      }
    }
  }

  void _navigateToScorePage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ScorePage(score: _score)),
    );
  }

  void _generateTargetWord() {
    List<String> words = [
      'APPLE',
      'BANANA',
      'CARROT',
      'DOG',
      'ELEPHANT',
      'FROG',
      'GIRAFFE',
      'HORSE',
      'IGLOO',
      'JUGGLE',
      'KITE',
      'LION',
      'MOUSE',
      'NURSE',
      'OWL',
      'PIZZA',
      'QUACK',
      'RABBIT',
      'SUN',
      'TIGER',
      'UMBRELLA',
      'VOLCANO',
      'WATERMELON',
      'XYLOPHONE',
      'YOYO',
      'ZEBRA'
    ];

    if (_isFirst == false) {
      _targetWord = words[Random().nextInt(words.length)];
    }
    while (_targetWordList.contains(_targetWord)) {
      _targetWord = words[Random().nextInt(words.length)];
    }
    _targetWordList.add(_targetWord);
    _targetWordList.add(_targetWord);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Letter Click Challenge'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Time: $_remainingTime s',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'CabinSketch')),
            SizedBox(height: 20),
            SizedBox(height: 20),
            Text('Target Word: $_targetWord',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'CabinSketch')),
            Text('Your Word: $_yourWord',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'CabinSketch')),
            SizedBox(height: 20),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              children: _letters.map((letter) {
                return GestureDetector(
                  onTap: () => _onLetterClicked(letter),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue, // Change color
                      border:
                          Border.all(color: Colors.white), // Add border color
                      borderRadius: BorderRadius.circular(8),
                    ),
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(16),
                    child: Center(
                      child: Text(
                        letter,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'CabinSketch'), // Change text color
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            GestureDetector(
              child: Column(
                children: [
                  Icon(
                    Icons.replay,
                    size: 70,
                    color: Colors.blue, // Change icon color
                  ),
                  Text('GET NEW LIST',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'CabinSketch')), // Change text color
                ],
              ),
              onTap: () {
                setState(() {
                  _generateLetters();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
