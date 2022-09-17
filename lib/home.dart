import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var textList = ["", "", "", "", "", "", "", "", ""]; //九宮格
  bool player = true; //player「O」=true , player「X」=false
  int countOnTap = 0; //計算點選次數
  String winner = ""; //贏家
  bool isWinner = true; //true 有贏家，false 平手

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
                  clearGV();
                });
              },
            ),
          ]),
      body: Column(
        children: <Widget>[_turnTo(), _ticTacToe(), _whoWin()],
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
                if (textList[index] == "") {
                  gvIndex(index);
                }
              },
              //九宮格
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
                style:
                    const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ]),
      ),
    );
  }

  //函式：九宮格
  void gvIndex(int index) {
    setState(() {
      if (textList[index].isEmpty) {
        if (player) {
          textList[index] = "O";
        }
        if (!player) {
          textList[index] = "X";
        }
        countOnTap += 1;
      }

      whoWin();

      if (!isWinner) {
        isWinner = !isWinner;
      }
    });

    player = !player;

    log('Tap: $countOnTap');
  }

  //函式：判斷贏家
  void whoWin() {
    //橫
    if (textList[0] == textList[1] && textList[1] == textList[2] && textList[0].isNotEmpty) {
      winner = textList[0];
    }
    if (textList[3] == textList[4] && textList[4] == textList[5] && textList[3].isNotEmpty) {
      winner = textList[3];
    }
    if (textList[6] == textList[7] && textList[7] == textList[8] && textList[6].isNotEmpty) {
      winner = textList[6];
    }

    //斜
    if (textList[0] == textList[4] &&
        textList[4] == textList[8] &&
        textList[0].isNotEmpty) {
      winner = textList[0];
    }
    if (textList[2] == textList[4] &&
        textList[4] == textList[6] &&
        textList[2].isNotEmpty) {
      winner = textList[2];
    }

    //直
    if (textList[0] == textList[3] &&
        textList[3] == textList[6] &&
        textList[0].isNotEmpty) {
      winner = textList[0];
    }
    if (textList[1] == textList[4] &&
        textList[4] == textList[7] &&
        textList[1].isNotEmpty) {
      winner = textList[1];
    }
    if (textList[2] == textList[5] &&
        textList[5] == textList[8] &&
        textList[2].isNotEmpty) {
      winner = textList[2];
    }

    if (countOnTap == 9 && winner == "") {
      winner = " Tie ";
      isWinner = !isWinner;
    }

    if (winner != "") {
      showWinnerToast();
    }

    log('Who Win: $winner');
    log('判斷: $isWinner');
  }

  //函式：清除紀錄
  void clearGV() {
    for (int i = 0; i <= 8; i++) {
      textList[i] = "";
      winner = "";
      countOnTap = 0;
    }

    log('clear！');
  }

  // 提示框
  void showWinnerToast() {
    Fluttertoast.showToast(
        msg: isWinner ? "$winner 贏了！" : "平手",
        toastLength: Toast.LENGTH_SHORT,  //顯示時間長短
        gravity: ToastGravity.CENTER,     //顯示位置
        timeInSecForIosWeb: 1,            //顯示秒數
        backgroundColor: const Color.fromRGBO(174, 158, 143, 1),  //背景
        textColor: Colors.black,
        fontSize: 16.0);
    clearGV();
  }
}
