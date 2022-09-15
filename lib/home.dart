import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var textList = ["", "", "", "", "", "", "", "", ""];
  bool player = true; //player1=true ,player2=false
  int countOnTap = 0;
  String winner = "";

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: const Center(
            child: Text(
              "  OO   Vs   XX",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.settings_backup_restore),
              onPressed: () {
                setState(() {
                  textList = ["", "", "", "", "", "", "", "", ""];
                  winner = "";
                });
              },
            )
          ]),
      body: Column(
        children: <Widget>[_turnTo(), _ticTacToe(), _whoWin()],
      ),
    );
  }

  Widget _turnTo() {
    return Expanded(
      child: Center(
        child: Text(
          player ? "Turn to O" : "Turn to X",
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _ticTacToe() {
    return Expanded(
      flex: 3,
      child: Padding(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.

        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, //每行三列
            childAspectRatio: 1.0, //显示区域宽高相等
          ),
          itemCount: textList.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                gvIndex(index);
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.brown),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10.0), //
                    )),
                child: Center(
                  child: Text(
                    textList[index],
                    style: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _whoWin() {
    return Expanded(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
          crossAxisAlignment: CrossAxisAlignment.center, //Center Row contents vertically,
            children: [
          const Text(
            "Winner : ",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          Text(
            winner,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ]),
      ),
    );
  }

  Future<bool> whoTurn() async {
    if (countOnTap % 2 == 0) {
      player;
    } else if (countOnTap % 2 != 0) {
      !player;
    }
    return player;
  }

  void gvIndex(int index) {
    setState(() {
      if (textList[index] == "" && player) {
        textList[index] = "O";
      } else if (textList[index] == "" && !player) {
        textList[index] = "X";
      }
      whoWin();
    });
    if (winner != "") {
      textList = ["", "", "", "", "", "", "", "", ""];
    }
    player = !player;
    countOnTap += 1;
  }

  Future<String> whoWin() async {
    if (textList[0] == textList[1] && textList[1] == textList[2]) {
      winner = textList[0];
    }
    if (textList[3] == textList[4] && textList[4] == textList[5]) {
      winner = textList[3];
    }
    if (textList[6] == textList[7] && textList[7] == textList[8]) {
      winner = textList[6];
    }
    if (textList[0] == textList[4] && textList[4] == textList[8]) {
      winner = textList[0];
    }
    if (textList[2] == textList[4] && textList[4] == textList[6]) {
      winner = textList[2];
    }
    log('whoWin: $winner');
    return winner;
  }
}
