import 'package:flutter/material.dart';
import 'package:sagaklogic2/board.dart';
import 'package:sagaklogic2/samples.dart';
import 'package:sagaklogic2/solver.dart';

class SolvingView extends StatefulWidget {
  final String title;

  const SolvingView({Key? key, required this.title}) : super(key: key);

  @override
  State<SolvingView> createState() =>
      _SolvingViewState.fromQuiz(quiz: Samples.soyo2_247);
}

class _SolvingViewState extends State<SolvingView> {
  Board current;
  Board solution;
  Quiz quiz;
  int fontSize = 8;

  _SolvingViewState({required this.solution})
      : current = Board(rows: solution.rows, cols: solution.cols),
        quiz = solution.createQuiz() {
    quiz.prettyPrint();
  }

  _SolvingViewState.fromQuiz({required this.quiz})
      : solution = Board(rows: quiz.rows.length, cols: quiz.cols.length),
        current = Board(rows: quiz.rows.length, cols: quiz.cols.length) {
    quiz.prettyPrint();
  }

  void setQuiz(Quiz newQuiz) {
    quiz = newQuiz;
    solution = Board(rows: quiz.rows.length, cols: quiz.cols.length);
    current = Board(rows: quiz.rows.length, cols: quiz.cols.length);
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
    List<Widget> verticalHints = List.generate(
        current.cols,
        (i) => InkWell(
            onTap: () {
              // vertical column hint 클릭시
              print("vertical $i hint clicked");
              setState(() {
                hintOnVertical(i);
              });
            },
            child: Text(quiz.cols[i].counts.join("\n"),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: fontSize.floorToDouble()))));

    var autoButton = FlatButton(
        onPressed: () {
          print("Auto one round!");
          setState(() {
            for (int col = 0; col < current.cols; col++) hintOnVertical(col);
            for (int row = 0; row < current.rows; row++) hintOnHorizontal(row);
          });
        },
        child: Text("Auto"));

    List<TableRow> tableRows = List.generate(current.rows + 1, (i0) {
      if (i0 == 0) {
        return TableRow(children: <Widget>[autoButton] + verticalHints);
      } else {
        var i = i0 - 1;
        var cells = List.generate(current.cols, (j) {
          var backColor = (current.configuration[i][j] == CellState.Filled)
              ? Colors.blue
              : Colors.transparent;
          var cellText = Text(
              Board.cellStateString(current.configuration[i][j]),
              textAlign: TextAlign.center,
              style: TextStyle(backgroundColor: backColor));
          return InkWell(
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
        });

        var hint = quiz.rows[i].counts.join(" ");

        return TableRow(
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
    });

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
