# flutter_sanmoku

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# 三目並べ

[手順](#手順)   
[どのような画面が必要かを考える](#どのような画面が必要かを考える)   
[ゲーム画面の構成](#ゲーム画面の構成)   
[スタート画面の構成](#スタート画面の構成)   
[ゲーム部分を作る](#)
ゲーム画面のStatefulWidgetを用意する
中央縦並びレイアウトにする
要素を配置する
マス目を作る
マス目を更新できるようにする
プレイヤーの順番を変える
勝敗判定をつける
ゲームの終了
スタート画面を作る
Webに公開する
ビルド
Netlifyを使って公開する
おしまい
流れと目標
目標: 三目並べを作ってWebで公開する


## 手順
* アプリの画面を設計する
* ゲーム部分を作る
* レイアウトとゲームのロジックを組む
* スタート画面を作る
* Webに公開する
* 完成時のプログラムは↓にあるので適宜参照のこと。


### アプリの画面を設計する
Webサイトやアプリを作る場合、プログラムを組む前に必要なのが「設計」という工程である。特に画面については、必要な機能を画面のどこに置くのかというのを予めデザインツールなので検討することが多い。

### どのような画面が必要かを考える
今回作るのは三目並べである。まずどのような画面が必要かを考えると、以下の2つが思い浮かぶ。

* スタート画面
  * メニューを表示する
* ゲーム画面
  * 三目並べで遊ぶ
  * 勝敗を表示する
それ以外にもクリア画面を分けたり、設定画面を追加したりなど工夫は可能だがシンプルな構成で作ってみよう。

### ゲーム画面の構成
三目並べのゲームで画面に必要なものを以下に挙げる。

* 手番を表示するテキスト
* 勝敗を表示するテキスト
* 3x3のマス目
* マス目を押すと手番のOXが置かれる
* ゲームをやめるためのボタン
シンプルにするために2つのテキストは1つで共用するようにしよう。これらを適当に並べると



要素が少ないので中央で縦に並べるのがまとまりがよい。

画面はできたので次はどのWidgetを組み合わせればこの画面が作れるのかを考えよう。



まず中央縦並びは、CenterとColumnを使って実現できる。
メッセージ部分はTextを置けばよい。
終了ボタンは目立つようにElevatedButtonを使おう。

マス目については9つのマスを3x3で正方形に配置する必要がある。この並べ方を実現するのには様々な方法があるが、一つ簡単なのはStackを親として、9つのマスを9箇所のAlignmentにそれぞれ置くようにすることである。
またマス自体はユーザが押せる必要があるので、TextButtonを使うことにする。

## スタート画面の構成
タイトルを表示したいのでスタート画面を作ろう。必要なのは

タイトル
ゲームを始めるためのボタン
の2つである。これも中央縦並びにしてしまおう。



同様にFlutterのWidgetの使い方を考えると、



配置はCenterとColumnt、タイトルはText、ボタンはElevatedButtonで実現できることがわかる。

## ゲーム部分を作る
まずはtic_tac_toeというプロジェクトを新しく作る



code [フォルダ]と打ち込むとそのフォルダをVSCodeで開いてくれたりする(PCによってはできないかもしれない)

### ゲーム画面のStatefulWidgetを用意する
lib/game_page.dartを作成し、以下のようにGamePageというStatefulWidgetを作る。

```
// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors, avoid_print, sized_box_for_whitespace

import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
```
最後のContainerの部分を置き換えて画面を作っていく。

また、GamePageを表示するためmain.dartのMyHomePageの呼び出し部を差し替える。
```
 import 'game_page.dart';

class MyApp extends StatelessWidget {
 const MyApp({Key? key}) : super(key: key);

 // This widget is the root of your application.
 @override
 Widget build(BuildContext context) {
   return MaterialApp(
     title: 'Flutter Demo',
     theme: ThemeData(
       // This is the theme of your application.
       //
       // Try running your application with "flutter run". You'll see the
       // application has a blue toolbar. Then, without quitting the app, try
       // changing the primarySwatch below to Colors.green and then invoke
       // "hot reload" (press "r" in the console where you ran "flutter run",
       // or simply save your changes to "hot reload" in a Flutter IDE).
       // Notice that the counter didn't reset back to zero; the application
       // is not restarted.
       primarySwatch: Colors.blue,
     ),
       home: const MyHomePage(title: 'Flutter Demo Home Page'),
       home: const GamePage()
   );
 }
}
```
flutter run -d chromeで画面を出しても真っ白である

### 中央縦並びレイアウトにする
Centerの中にColumnを置き、mainAxisSize属性をminにするとColumnの子らが中央縦並びになる。
```
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(
          width: 100,
          height: 100,
          color: Colors.green,
        ),
        Container(
          width: 100,
          height: 100,
          color: Colors.blue,
        ),
        Container(
          width: 100,
          height: 100,
          color: Colors.red,
        ),
      ]),
    ));
  }
```


### 要素を配置する
ゲーム画面に必要な要素は、メッセージ表示用テキスト、マス目と終了ボタンの3つである。

それらを先程のContainerの代わりに配置する。
```
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Xの手番です",
            style: TextStyle(fontSize: 40),
          ),
        ),
        Container(
          width: 300,
          height: 300,
          color: Colors.blue.shade100,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(onPressed: () {}, child: Text("やめる")),
        ),
      ]),
    ));
  }
```



### 青い四角にマス目を作っていく。

### マス目を作る
マスを置く土台をStackで作る
マス目はマスをStackの上にずらして置いていくことで実現する。そのため、300x300のContainerのとしてStackを追加する。
```
 Widget build(BuildContext context) {
   return Scaffold(
       body: Center(
     child: Column(mainAxisSize: MainAxisSize.min, children: [
       Padding(
         padding: const EdgeInsets.all(8.0),
         child: Text(
           "Xの手番です",
           style: TextStyle(fontSize: 40),
         ),
       ),
       Container(
         width: 300,
         height: 300,
         color: Colors.blue.shade100,
           child: Stack(
             children: []
           )
       ),
       Padding(
         padding: const EdgeInsets.all(8.0),
         child: ElevatedButton(onPressed: () {}, child: Text("やめる")),
       ),
     ]),
   ));
 }
```
このchildrenの配列に、マスを表現するWidgetを入れれば良い。

### マスを作る
それぞれのマスは以下のようなWidgetの組み合わせで作る。
```
Align(
  alignment: Alignment.topLeft,
  child: Container(
    width: 100.0,
    height: 100.0,
    color: Colors.black12,
    child: TextButton(
        onPressed: () {},
        child: Text(
          "00",
          style: TextStyle(fontSize: 50),
        )),
  ),
),
```
Align: マスがどの位置に置かれるかを指定
Container: マスのサイズと色を指定
TextButton: マスの押されたときの挙動を指定
Text: マスに表示する文字を指定
上の例のマスはalignmentがtopLeftであるため、左上のマスを定義していることがわかる。

テキストではとりあえず"00"というものを入れているが、これはマスを識別するためのIDである。左の数字が上から何番目にあるか、右が左から何番目にあるかを示している。

### マスを配置する
マスのWidgetの作り方は分かっているので、あとは適切な設定でStackに並べていくだけである。9つあるので上のalignmentと00、colorの部分を以下のように変更すれば良い。

マス目の区切りが見えるようにするため、交互に背景色をつけたりつけなかったりしている。
```
Alignment.topLeft: 00 + Colors.black12
Alignment.topCenter: 01
Alignment.topRight: 02 + Colors.black12
Alignment.centerLeft: 10
Alignment.center: 11 + Colors.black12
Alignment.centerRight: 12
Alignment.bottomLeft: 20 + Colors.black12
Alignment.bottomCenter: 21
Alignment.bottomRight: 22 + Colors.black12
Container(
  color: Colors.blue.shade100,
  width: 300,
  height: 300,
  child: Stack(
    children: [
      Align(
        alignment: Alignment.topLeft,
        child: Container(
          width: 100.0,
          height: 100.0,
          color: Colors.black12,
          child: TextButton(
              onPressed: () {},
              child: Text(
                "00",
                style: TextStyle(fontSize: 50),
              )),
        ),
      ),
      Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: 100.0,
          height: 100.0,
          child: TextButton(
              onPressed: () {},
              child: Text(
                "01",
                style: TextStyle(fontSize: 50),
              )),
        ),
      ),
      ...
      Align(
        alignment: Alignment.bottomRight,
        child: Container(
          width: 100.0,
          height: 100.0,
          color: Colors.black12,
          child: TextButton(
              onPressed: () {},
              child: Text(
                "22",
                style: TextStyle(fontSize: 50),
              )),
        ),
      ),
    ],
  ),
),
```



画像と同じ順番で番号が振られていれば正しく実装できている。

マス目を更新できるようにする
画面はとりあえずできたので、ロジックを作る。

ゲーム中、それぞれのマス目は自身に何が置かれているかという情報を保持しておく必要がある。これを、2次元配列+文字列という構造を使ってfieldという変数で管理しよう。

以下のようにListの中にListを入れると行列のような見た目でデータを管理することができる。
```
List<List<String>> field = [
  ["", "o", "o"],
  ["", "x", ""],
  ["x", "o", ""],
];
```
もし12というIDを持ったマス目にアクセスしたい場合は、field[1][2]とすることでその値を参照・書き換えることが可能。

また、このfieldを書き換えるためのupdateFieldというメソッドをGamePageStateに追加する。

初期状態のフィールドは何も置かれていないため、何もない状態を""(空文字)で表現する。

updateFieldメソッドは引数としてどのプレイヤーが置こうとしているのかと置く場所の位置を取る。もし既になにか置かれていればその行動は無視され、なにも無ければfieldが更新される。

fieldに代入する場面でsetStateが使われているが、これは第3回でやった通りこの関数を呼んで変数を更新すると、画面内で変数を使っている部分を更新してくれる。そのためfield変数が書き換えられたら同じように画面も書き換わるのである。
```
class _GamePageState extends State<GamePage> {
   List<List<String>> field = [
     ["", "", ""],
     ["", "", ""],
     ["", "", ""],
   ];

   void updateField(String player, int row, int column) {
     if (field[row][column] != "") return;
     setState(() {
       field[row][column] = player;
     });
   }

 ...
}
```
次に画面でfield変数を使うように変更する。以下のようにそれぞれのマスでボタンが押されたときにupdateFieldメソッドを呼び、Textではfieldの自身の場所の文字列を表示するようにする。それぞれで使う番号は表示したIDと同じである。

どちらのプレイヤーの手番かはまだ決まっていないので、とりあえずXであると決め打ちしておく。
```
Align(
 alignment: Alignment.topLeft,
 child: Container(
   width: 100.0,
   height: 100.0,
   color: Colors.black12,
   child: TextButton(
         onPressed: () {},
         onPressed: () {
           updateField("X", 0, 0);
         },
       child: Text(
           "00",
           field[0][0],
         style: TextStyle(fontSize: 50),
       )),
 ),
),
```


ここまで実装すると、マスをクリックすることでX印を置くことが可能になった。

### プレイヤーの順番を変える
今はまだ1人のプレイヤーしか置くことができないので、交互に手番が回ってくるように変更しよう。

currentPlayerという変数を追加してこれで現在のプレイヤーを保持することにする。
```
class _GamePageState extends State<GamePage> {
 List<List<String>> field = [
   ["", "", ""],
   ["", "", ""],
   ["", "", ""],
 ];
   String currentPlayer = "X";
```
現在のプレイヤーが変わるのはマスに印を置いた後なので、updateFieldにその処理を追加すれば良い。

変数の値を変えているのでsetState内でcurrentPlayerを入れ替えている。
```
 void updateField(String player, int row, int column) {
   if (field[row][column] != "") return;
   setState(() {
     field[row][column] = player;
       if (currentPlayer == "X") {
         currentPlayer = "O";
       } else {
         currentPlayer = "X";
       }
   });
 }
```
分かりやすいように現在の手番を更新するようにする。currentPlayerは前述の通りsetState内で値が変わるので、変数を含んだmessageという文字を表示すれば自動的に更新してくれる。
```
 Widget build(BuildContext context) {
     String message = "$currentPlayer の手番です";
   return Scaffold(
       body: Center(
     child: Column(mainAxisSize: MainAxisSize.min, children: [
       Padding(
         padding: const EdgeInsets.all(8.0),
         child: Text(
             "Xの手番です",
             message,
           style: TextStyle(fontSize: 40),
         ),
       ),
```
また押したときのプレイヤーをマスの実装で決め打ちしていたので、変数に修正する。

Align(
 alignment: Alignment.topLeft,
 child: Container(
   width: 100.0,
   height: 100.0,
   color: Colors.black12,
   child: TextButton(
       onPressed: () {
           updateField("X", 0, 0);
           updateField(currentPlayer, 0, 0);
       },
       child: Text(
         field[0][0],
         style: TextStyle(fontSize: 50),
       )),
 ),
),




交互に打てるようになった。

## 勝敗判定をつける
遊べるようにはなったが、ゲームである以上勝ち負けを表示してほしい。三目並べの勝敗条件は

先に3つ自分の印を直線状に並べる→勝ち
3つ揃わずに全てのマスが埋まる→引き分け
である。1つ目の直線状に並んだかどうかを判定する方法は様々だが、今回は泥臭く判定箇所のリストを保持しておき、プレイヤーが印を置くごとに判断するという形式を取る。

どの3つに同じ印が入っていたら勝ちかというリストをlineという変数に入れておく。
```
List<List<List<int>>> lines = [
  [[0, 0],[0, 1],[0, 2],], // 横向き
  [[1, 0],[1, 1],[1, 2],],
  [[2, 0],[2, 1],[2, 2],],
  [[0, 0],[1, 0],[2, 0],], // 縦向き
  [[0, 1],[1, 1],[2, 1],], 
  [[0, 2],[1, 2],[2, 2],],
  [[0, 0],[1, 1],[2, 2],], // 斜め
  [[0, 2],[1, 1],[2, 0],],
];
```
また、ゲームが決着しているか、勝者は誰かということを保持しておく変数を用意する。
```
class _GamePageState extends State<GamePage> {
 List<List<String>> field = [
   ["", "", ""],
   ["", "", ""],
   ["", "", ""],
 ];
 String currentPlayer = "X";
   bool finished = false;
   String winner = "";
```
そして、勝敗判定をかける関数としてcheckIfGameFinishedメソッドを用意して印が置かれる毎に呼び出すようにする。
```
 void updateField(String player, int row, int column) {
     if (finished) return;
   if (field[row][column] != "") return;
   setState(() {
     field[row][column] = player;
     if (currentPlayer == "X") {
       currentPlayer = "O";
     } else {
       currentPlayer = "X";
     }
   });
     checkIfGameFinished();
 }

   void checkIfGameFinished() {
     // 揃っている直線がないか探索する
     for (var line in lines) {
       String first = field[line[0][0]][line[0][1]];
       String second = field[line[1][0]][line[1][1]];
       String third = field[line[2][0]][line[2][1]];
       if (first != "" && first == second && second == third) {
         print("$first の勝ち！");
         finished = true;
         winner = first;
         return;
       }
     }
     
     // マスが全て埋まっているかどうか確認する
     bool isFilled = true;
     for (int row = 0; row < 3; row++) {
       for (int column = 0; column < 3; column++) {
         if (field[row][column] == "") {
           isFilled = false;
         }
       }
     }
     if (isFilled) {
       print("引き分け");
       finished = true;
       winner = "";
     }
   }
```
表示されるメッセージについても、決着がついた場合は結果を表示するように改変しよう。
```
 Widget build(BuildContext context) {
   String message = "$currentPlayer の手番です";
     if (finished) {
       if (winner == "") {
         message = "引き分け";
       } else {
         message = "$winner の勝ち！";
       }
     }
   return Scaffold(
```


勝敗が分かるようになった。

## ゲームの終了
少し気が早いが、ゲームが終わったら前の画面(スタート画面)に戻れるように、やめるボタンの処理を実装しておこう。

Navigator.of(context).pop()を呼ぶことで前の画面に戻ることができる。
```
Padding(
 padding: const EdgeInsets.all(8.0),
   child: ElevatedButton(onPressed: () {}, child: Text("やめる")),
   child: ElevatedButton(
       onPressed: () {
         Navigator.of(context).pop();
       },
       child: Text("やめる")),
)
```
現状は前の画面が存在しないため、押すと画面が真っ白になってしまう。

スタート画面を作る
スタート画面もレイアウトはゲーム画面とほぼ同じでCenterとColumnを組み合わせればよい。

lib/start_page.dartというファイルを作成して以下のように記述する。
```
// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';

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
              child: ElevatedButton(onPressed: () {}, child: Text("ゲームを始める")),
            ),
          ],
        ),
      ),
    );
  }
}
```
また、main関数からスタート画面を最初に表示するためmain.dartの記述を書き換える。
```
import 'package:flutter/material.dart';
 import 'game_page.dart';
 import 'start_page.dart';

void main() {
 runApp(const MyApp());
}

class MyApp extends StatelessWidget {
 const MyApp({Key? key}) : super(key: key);

 // This widget is the root of your application.
 @override
 Widget build(BuildContext context) {
   return MaterialApp(
       title: 'Flutter Demo',
       theme: ThemeData(
         // This is the theme of your application.
         //
         // Try running your application with "flutter run". You'll see the
         // application has a blue toolbar. Then, without quitting the app, try
         // changing the primarySwatch below to Colors.green and then invoke
         // "hot reload" (press "r" in the console where you ran "flutter run",
         // or simply save your changes to "hot reload" in a Flutter IDE).
         // Notice that the counter didn't reset back to zero; the application
         // is not restarted.
         primarySwatch: Colors.blue,
       ),
         home: const GamePage());
         home: const StartPage());
 }
}
```


ボタンを押すとゲーム画面に遷移できるようにNavigatorを実装すれば完成である。
```
import 'package:flutter/material.dart';
 import 'game_page.dart';

 Padding(
   padding: const EdgeInsets.all(8.0),
     child: ElevatedButton(onPressed: () {}, child: Text("ゲームを始める")),
     child: ElevatedButton(
         onPressed: () {
           Navigator.of(context)
               .push(MaterialPageRoute(builder: (_) => GamePage()));
         },
         child: Text("ゲームを始める")),
 ),
```
全体のコードはこちら↓


Webに公開する
ビルド
さて、自分で作ったWebアプリがflutter runでばっちり動くことを確認できたら次は他の人も遊べるようにしてみたいと思うかもしれない。
それをするためには、Flutter Webはビルドという作業が必要になる。

flutter runで動かしたときは開発者が動かしやすいように、バーチャルマシン上で動かしていたりデバッグ用の重いプログラムを一緒に動かしていたりする。一方アプリとして配布する場合は開発者を意識する必要はないため、いらないものを削除するなど様々な最適化をしてからパッケージングする。特にFlutter Webではどのブラウザでも動くようにDartで書かれた物をJavaScriptに変換(トランスパイル)する。この変換工程をビルドと呼ぶ。

ビルドしたい場合はコマンドでflutter build webを打ち込む。



ビルドが成功すると、プロジェクトのbuild/web/というフォルダにindex.htmlなどのファイルが生成される。このフォルダごと配信することで、Webアプリとして配布することが可能になっている。



Netlifyを使って公開する
実際にWebサイトを公開したい場合、サイトを置いておくためのサーバが必要である。しかしFlutter Webのような単純なWebアプリであればホスティングサービスというものを利用することで簡単に安く(多くの場合無料で)公開することが可能になっている。

今回は代表的なホスティングサービスの一つである、Netlifyを使ってみよう。

https://www.netlify.com/

上記のサイトでSign upすると、下のような画面が出てくる。



この下部、Drag and drop your site output folder here と書かれた部分に先程のbuild/web/フォルダをフォルダごとドラッグアンドドロップする。



しばらく待つと、URLが表示される。これで全世界に公開完了！

URLにPCなりスマホなりでアクセスすれば、三目並べで遊べることがわかる。



おしまい


# GitHub pagesにFlutterアプリを公開する
https://qiita.com/Shota-Abe/items/52309d410257bcc6548b