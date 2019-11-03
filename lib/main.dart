import 'package:flutter/material.dart';
import 'package:sagaklogic/Board.dart';
import 'package:sagaklogic/samples.dart';

import 'SolveHelper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nemonemo',
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
      home: MyHomePage(title: 'Solver'),
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
    return _SolvingState.fromQuiz(quiz: Samples.octopus.createQuiz());
  }
}

class _SolvingState extends State<MyHomePage> {
  Board current;
  Board solution;
  Quiz quiz;
  int fontSize = 8;

  _SolvingState({this.solution}) {
    current = new Board(rows: solution.rows, cols: solution.cols);
    quiz = solution.createQuiz();
    quiz.prettyPrint();
  }

  _SolvingState.fromQuiz({this.quiz}) {
    setQuiz(quiz);
  }

  void setQuiz(Quiz newQuiz) {
    quiz = newQuiz;
    solution = new Board(rows: quiz.rows.length, cols: quiz.cols.length);
    current = new Board(rows: quiz.rows.length, cols: quiz.cols.length);
    quiz.prettyPrint();
  }

  void _showSolution() {
    setState(() {
      //solution.initRandom(Random.secure());
      // print(solution.configurationPrettyString());
      current.clearBoard();
//      current.configuration = solution.configuration;
//      quiz = solution.createQuiz();
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
    });
  }

  void hintOnVertical(int col) {
    var solvedLine =
        SolveStrategies(line: current.verticalView(col), chunks: quiz.cols[col])
            .solvedLine;
    current.updateVertical(col, solvedLine);
  }

  void hintOnHorizontal(int row) {
    var solvedLine = SolveStrategies(
            line: current.horizontalView(row), chunks: quiz.rows[row])
        .solvedLine;
    current.updateHorizontal(row, solvedLine);
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

    List<Widget> verticalHints = List(solution.cols);

    for (int i = 0; i < solution.cols; i++) {
      verticalHints[i] = InkWell(
          onTap: () {
            // vertical column hint 클릭시
            print("vertical $i hint clicked");
            setState(() {
              hintOnVertical(i);
            });
          },
          child: Text(quiz.cols[i].counts.join("\n"),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: fontSize.floorToDouble())));
    }

    var autoButton = FlatButton(
        onPressed: () {
          print("Auto one round!");
          setState(() {
            for (int col = 0; col < solution.cols; col++) hintOnVertical(col);
            for (int row = 0; row < solution.rows; row++) hintOnHorizontal(row);
          });
        },
        child: Text("Auto"));

    tableRows[0] = TableRow(children: <Widget>[autoButton] + verticalHints);
    for (int i = 0; i < solution.rows; i++) {
      var cells = new List<Widget>(solution.cols);
      for (var j = 0; j < solution.cols; j++) {
        var backColor = (current.configuration[i][j] == CellState.Filled)
            ? Colors.blue
            : Colors.transparent;
        var cellText = Text(Board.cellStateString(current.configuration[i][j]),
            textAlign: TextAlign.center,
            style: TextStyle(backgroundColor: backColor));
        cells[j] = InkWell(
            onTap: () {
              setState(() {
                var state = current.configuration[i][j];
                if (state == CellState.Empty) {
                  current.configuration[i][j] = CellState.Filled;
                } else if (state == CellState.Filled) {
                  current.configuration[i][j] = CellState.Never;
                } else {
                  current.configuration[i][j] = CellState.Empty;
                }
              });
            },
            child: cellText);
      }

      var hint = quiz.rows[i].counts.join(" ");

      tableRows[i + 1] = TableRow(
          children: <Widget>[
                InkWell(
                    onTap: () {
                      // horizontal row hint 클릭시
                      print("horizontal $i clicked");
                      setState(() {
                        hintOnHorizontal(i);
                      });
                    },
                    child: Text(hint,
                        style: TextStyle(fontSize: fontSize.floorToDouble()),
                        textAlign: TextAlign.right))
              ] +
              cells);
    }

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: <Widget>[
//          IconButton(
//            icon: Icon(Icons.developer_mode),
//            onPressed: () {
//              print(SolveStrategies(
//                  line: ConcreteLine.fromString("...O..O..O...."),
//                  chunks: Chunks(counts: [4, 1, 3])).solvedLine);
//            },
//          ),
          IconButton(
            icon: Icon(Icons.arrow_upward),
            onPressed: () {
              setState(() {
                if (fontSize < 20) fontSize += 1;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.arrow_downward),
            onPressed: () {
              setState(() {
                if (fontSize > 8) fontSize -= 1;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              setState(() {
                current.clearBoard();
              });
            },
          ),
          PopupMenuButton<Quiz>(
            onSelected: (Quiz newQuiz) {
              setState(() {
                setQuiz(newQuiz);
              });
            },
            itemBuilder: (BuildContext context) {
              return Samples.allQuizzes.entries
                  .map((p) =>
                      PopupMenuItem<Quiz>(value: p.value, child: Text(p.key)))
                  .toList();
            },
          )
        ],
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
            defaultColumnWidth: FixedColumnWidth(10),
            columnWidths: {0: IntrinsicColumnWidth()},
            children: tableRows),
      ),
    );
  }
}
