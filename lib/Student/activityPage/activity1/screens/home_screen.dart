import 'package:flutter/material.dart';
import '../widgets/category_card.dart';
import 'alphabet_en_screen.dart';
import 'animal_screen.dart';
import 'birds_screen.dart';
import 'color_screen.dart';
import 'numeric_en_screen.dart';
import 'shape_screen.dart';
import 'story_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> categories = [
      CategoryCard(
        title: 'Animals',
        primaryColor: Colors.purpleAccent[100]!,
        secondaryColor: Colors.purple,
        screen: AnimalScreen(
          title: 'Animals',
          primaryColor: Colors.purpleAccent[100]!,
          secondaryColor: Colors.purple,
        ),
      ),
      CategoryCard(
        title: 'Birds',
        primaryColor: Colors.purpleAccent[100]!,
        secondaryColor: Colors.purple,
        screen: BirdsScreen(
          title: 'Birds',
          primaryColor: Colors.purpleAccent[100]!,
          secondaryColor: Colors.purple,
        ),
      ),
      CategoryCard(
        title: 'Colors',
        primaryColor: Colors.orangeAccent[100]!,
        secondaryColor: Colors.orange,
        screen: ColorScreen(
          title: 'Colors',
          primaryColor: Colors.orangeAccent[100]!,
          secondaryColor: Colors.orange,
        ),
      ),
      CategoryCard(
        title: '123',
        primaryColor: Colors.greenAccent[100]!,
        secondaryColor: Colors.green,
        screen: NumericEnScreen(
          title: '123',
          primaryColor: Colors.greenAccent[100]!,
          secondaryColor: Colors.green,
        ),
      ),
      CategoryCard(
        title: 'ABC',
        primaryColor: Colors.purpleAccent[100]!,
        secondaryColor: Colors.purple,
        screen: AlphabetEnScreen(
          title: 'ABC',
          primaryColor: Colors.purpleAccent[100]!,
          secondaryColor: Colors.purple,
        ),
      ),
    ];

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey[50],
          image: const DecorationImage(
            image: AssetImage('assets/images/bg-bottom.png'),
            alignment: Alignment.bottomCenter,
          ),
        ),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 150.0,
              backgroundColor: Colors.grey[50],
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  'assets/images/activity1.jpg',
                  fit: BoxFit.fitHeight,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(categories),
            ),
          ],
        ),
      ),
    );
  }
}
