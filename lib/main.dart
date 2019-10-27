import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sagaklogic/Board.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _SolvingState createState() {
    var board = new Board(rows: 15, cols: 15);
    board.initRandom(Random.secure());
    print(board.configurationPrettyString());

    return _SolvingState(solution: board);
  }
}

class _SolvingState extends State<MyHomePage> {
  Board current;
  Board solution;
  Quiz quiz;

  _SolvingState({this.solution}) {
    current = new Board(rows: solution.rows, cols: solution.cols);
    quiz = solution.createQuiz();
    quiz.prettyPrint();
  }

  void _incrementCounter() {
    setState(() {
      solution.initRandom(Random.secure());
      print(solution.configurationPrettyString());
      current.clearBoard();
      quiz = solution.createQuiz();
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    List<TableRow> tableRows = List(solution.rows + 1);
    tableRows[0] = TableRow(
        children: <Widget>[Text("")] +
            quiz.cols
                .map((c) => Text(
                      c.counts.join("\n"),
                      textAlign: TextAlign.center,
                    ))
                .toList(growable: false));
    for (int i = 0; i < solution.rows; i++) {
      var cells = new List<Widget>(solution.cols);
      for (var j = 0; j < solution.cols; j++) {
        cells[j] = InkWell(
            onTap: () {
              setState(() {
                var state = current.configuration[i][j];
                if (state == CellState.Filled) {
                  current.configuration[i][j] = CellState.Empty;
                } else {
                  current.configuration[i][j] = CellState.Filled;
                }
              });
            },
            child: Text(Board.cellStateString(current.configuration[i][j]),
                textAlign: TextAlign.center));
      }

      var hint = quiz.rows[i].counts.join(" ");

      tableRows[i + 1] = TableRow(
          children: <Widget>[Text(hint, textAlign: TextAlign.right)] + cells);
    }

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
            defaultColumnWidth: FixedColumnWidth(20),
            columnWidths: {0: IntrinsicColumnWidth()},
            children: tableRows),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
