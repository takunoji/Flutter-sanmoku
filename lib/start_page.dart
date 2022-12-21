// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'game_page.dart';
class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "三目並べ",
              style: TextStyle(fontSize: 100, color: Colors.blue),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              // child: ElevatedButton(onPressed: () {}, child: Text("ゲームを始める")),
    child: ElevatedButton(
         onPressed: () {
           Navigator.of(context)
               .push(MaterialPageRoute(builder: (_) => GamePage()));
         },
         child: Text("ゲームを始める")),            ),
          ],
        ),
      ),
    );
  }
}