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
  var textList = ["", "", "", "", "", "", "", "", ""];  //九宮格
  bool player = true;   //player「O」=true , player「X」=false
  int countOnTap = 0;   //計算點選次數
  String winner = "";   //贏家

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Center(
            child: Text(
              "  OO   Vs   XX",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ),
          actions: <Widget>[
            //重新開始
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
        children: <Widget>[
          _turnTo(),
          _ticTacToe(),
          _whoWin()],
      ),
    );
  }

  //顯示輪到誰
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

  //顯示九宮格
  Widget _ticTacToe() {
    return Expanded(
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, //每行三列
            childAspectRatio: 1.0, //顯示區域長寬相等
          ),
          itemCount: textList.length,
          itemBuilder: (BuildContext context, int index) {
            //偵測手勢
            return GestureDetector(
              onTap: () {
                gvIndex(index);
              },
              //九宮格
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.brown),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10.0), //
                    )
                ),
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

  //顯示贏家
  Widget _whoWin() {
    return Expanded(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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

  //函式：若點選次數為基數: player為「X」，否則為「O」
  Future<bool> whoTurn() async {
    if (countOnTap % 2 == 0) {
      player;
    } else if (countOnTap % 2 != 0) {
      !player;
    }
    return player;
  }

  //函式：九宮格
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

  //函式：判斷贏家
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
