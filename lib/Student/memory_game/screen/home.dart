import 'package:flutter/material.dart';
import '../data/data.dart';
import '../model/title_model.dart';
import 'dart:async';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<TileModel> gridViewTiles = <TileModel>[];
  List<TileModel> questionPairs = <TileModel>[];

  Timer? _gameTimer;
  int _secondsRemaining = 0;
  bool _isGameInProgress = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reStart();
  }
  void reStart() {
    myPairs = getPairs();
    myPairs.shuffle();

    gridViewTiles = myPairs;
    setState(() {
      _secondsRemaining = 5; // Set the initial countdown time (5 seconds in your case)
      _isGameInProgress = true;
    });

    _startTimer();
  }

  void _startTimer() {
    _gameTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _gameTimer?.cancel(); // Stop the timer when the countdown reaches 0
          _isGameInProgress = false;
          questionPairs = getQuestionPairs();
          gridViewTiles = questionPairs;
          selected = false;
        }
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue[500]!,
          elevation: 0,

        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue,
                Colors.teal,
               // Colors.blue[900]!,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // SizedBox(
              //   height: 40,
              // ),
              points != 800 ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (_isGameInProgress)
                    Text(
                      'Time Left: $_secondsRemaining seconds',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  const Text(
                    "Your Points",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "$points / 800",
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                    ),
                  ),
                ],
              ) : Container(),
              const SizedBox(
                height: 20,
              ),
              points != 800 ? GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 10.0,
                  maxCrossAxisExtent: 100.0,
                ),
                itemCount: gridViewTiles.length,
                itemBuilder: (context, index) {
                  return Tile(
                    imagePathUrl: gridViewTiles[index].getImageAssetPath(),
                    tileIndex: index,
                    parent: this,
                  );
                },
              ): Container(
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            points = 0;
                            reStart();
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 200,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: const Text("Replay", style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w500
                          ),),
                        ),
                      ),
                      const SizedBox(height: 50,),
                    ],
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}


class Tile extends StatefulWidget {
  String? imagePathUrl;
  int? tileIndex;
  _HomeState? parent;

  Tile({this.imagePathUrl, this.tileIndex, this.parent});

  @override
  _TileState createState() => _TileState();
}

class _TileState extends State<Tile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!selected) {
          setState(() {
            myPairs[widget.tileIndex!].setIsSelected(true);
          });
          if (selectedTile != "") {
            /// testing if the selected tiles are same
            if (selectedTile == myPairs[widget.tileIndex!].getImageAssetPath()) {
              print("add point");
              points = points + 100;
              print(selectedTile + " thishis" + widget.imagePathUrl!);

              TileModel tileModel = TileModel();
              print(widget.tileIndex);
              selected = true;
              Future.delayed(const Duration(seconds: 2), () {
                tileModel.setImageAssetPath("");
                myPairs[widget.tileIndex!] = tileModel;
                print(selectedIndex);
                myPairs[selectedIndex!] = tileModel;
                this.widget.parent!.setState(() {});
                setState(() {
                  selected = false;
                });
                selectedTile = "";
              });
            } else {
              print(selectedTile +
                  " thishis " +
                  myPairs[widget.tileIndex!].getImageAssetPath()!);
              print("wrong choice");
              print(widget.tileIndex);
              print(selectedIndex);
              selected = true;
              Future.delayed(const Duration(seconds: 2), () {
                widget.parent!.setState(() {
                  myPairs[widget.tileIndex!].setIsSelected(false);
                  myPairs[selectedIndex!].setIsSelected(false);
                });
                setState(() {
                  selected = false;
                });
              });

              selectedTile = "";
            }
          } else {
            setState(() {
              selectedTile = myPairs[widget.tileIndex!].getImageAssetPath()!;
              selectedIndex = widget.tileIndex;
            });

            print(selectedTile);
            print(selectedIndex);
          }
        }
      },
      child: Container(
        margin: EdgeInsets.all(5),
        child: myPairs[widget.tileIndex!].getImageAssetPath() != ""
            ? ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.asset(myPairs[widget.tileIndex!].getIsSelected()!
              ? myPairs[widget.tileIndex!].getImageAssetPath()!
              : widget.imagePathUrl!,fit: BoxFit.fill,),
        )
            : Container(
          child: Image.asset("assets/images/check.png",fit: BoxFit.fitHeight,),
        ),
      ),
    );
  }
}
