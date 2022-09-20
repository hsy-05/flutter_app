import "dart:math";
import 'package:flutter/material.dart';

class RandomHomePage extends StatefulWidget {
  const RandomHomePage({Key? key}) : super(key: key);

  @override
  State<RandomHomePage> createState() => _RandomHomePageState();
}

class _RandomHomePageState extends State<RandomHomePage> {

  final TextEditingController randomController = TextEditingController();
  String result = "";
  var lines =  <String>[];

  final _randomText = Random();
  String resultText = "";
  var resultArray = <String>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,  //防止鍵盤覆蓋內容
        appBar: AppBar(
            title: const Center(
              child: Text(
                "亂數",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            actions: <Widget>[
              //清除
              IconButton(
                icon: const Icon(Icons.settings_backup_restore),
                onPressed: () {
                  setState(() {});
                },
              ),
            ]),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextField(
                  decoration: const InputDecoration(
                    isDense: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.brown, width: 3.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange, width: 3.0),
                    ),
                    contentPadding: EdgeInsets.all(10),
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  controller: randomController,
                  style: const TextStyle(
                      fontSize: 26, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                    height: 50,
                    width: 100,
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            result = randomController.text;
                            logResult();
                            randomList();
                            pickRandomItems(3);
                            print(pickRandomItems(3));
                          });
                        },
                        child: const Text("確定"))),

                const SizedBox(
                  height: 50,
                ),

                    Text(
                      "亂數結果 : $resultText",
                      style: const TextStyle(
                          fontSize: 28, fontWeight: FontWeight.bold),
                    ),


              ],
            ),
          ),
        ));
  }

  void logResult() {

    lines = result.split('\n');
    print('送出的文字: $lines');

  }

  String randomList(){
    for(int i=0; i<=2; i++){
      resultText = lines[_randomText.nextInt(lines.length)];
      resultArray.add(resultText);
      print('_randomText: $_randomText');
    }

    return resultText;

  }

  List pickRandomItems(int count) {
    final list = List.from(lines);
    list.shuffle();                // 隨機排序
    return list.take(count).toList();       // 從0 - count 獲取元素
  }

}
