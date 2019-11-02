import 'dart:math';

import 'package:sagaklogic/SolveHelper.dart';

enum CellState { Empty, Filled, Never }

class Board {
  Board({this.rows, this.cols}) {
    configuration = new List<List<CellState>>(rows);
    for (int i = 0; i < rows; i++) {
      configuration[i] = new List<CellState>(cols);
    }
    clearBoard();
  }

  Board.fromConfiguration({this.configuration}) {
    rows = configuration.length;
    for (int i = 0; i < rows; i++) {
      if (configuration[i] == null)
        throw new Exception("Null row in the configuration");
    }
    cols = configuration[0].length;
    for (int i = 1; i < rows; i++) {
      if (configuration[i].length != cols)
        throw new Exception("Non-square configuration");
    }
  }

  Board.fromStrings(List<String> board) {
    rows = board.length;
    cols = board[0].length;
    configuration = List<List<CellState>>(rows);
    for (int i = 0; i < rows; i++) {
      if (board[i].length != cols) throw Exception("Invalid board");
      configuration[i] = ConcreteLine.fromString(board[i]).line;
    }
  }

  int rows, cols;
  List<List<CellState>> configuration;

  void clearBoard() {
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        configuration[i][j] = CellState.Empty;
      }
    }
  }

  void initRandom(Random random) {
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        configuration[i][j] =
            random.nextBool() ? CellState.Filled : CellState.Empty;
      }
    }
  }

  Quiz createQuiz() {
    List<Chunks> rowChunks = new List<Chunks>(rows);
    List<Chunks> colChunks = new List<Chunks>(cols);

    for (int i = 0; i < rows; i++) {
      rowChunks[i] = countChunksInRow(i);
    }
    for (int i = 0; i < cols; i++) {
      colChunks[i] = countChunksInCol(i);
    }
    return new Quiz(rows: rowChunks, cols: colChunks);
  }

  Chunks countChunksInRow(int row) {
    List<int> counts = [];
    int countSoFar = 0;
    for (int i = 0; i < cols; i++) {
      if (configuration[row][i] == CellState.Filled) {
        countSoFar += 1;
      } else {
        if (countSoFar > 0) {
          counts.add(countSoFar);
        }
        countSoFar = 0;
      }
    }
    if (countSoFar > 0) {
      counts.add(countSoFar);
    }
    return new Chunks(counts: counts);
  }

  Chunks countChunksInCol(int col) {
    List<int> counts = [];
    int countSoFar = 0;
    for (int i = 0; i < rows; i++) {
      if (configuration[i][col] == CellState.Filled) {
        countSoFar += 1;
      } else {
        if (countSoFar > 0) {
          counts.add(countSoFar);
        }
        countSoFar = 0;
      }
    }
    if (countSoFar > 0) {
      counts.add(countSoFar);
    }
    return new Chunks(counts: counts);
  }

  static String cellStateString(CellState state) {
    switch (state) {
      case CellState.Filled:
        return "O";
      case CellState.Empty:
        return ".";
      case CellState.Never:
        return "X";
    }
    return "";
  }

  List<String> configurationRowStrings() {
    return configuration
        .map((row) => row.map(cellStateString).join())
        .toList(growable: false);
  }

  String configurationShortString(String rowDelim) {
    return configurationRowStrings().join(rowDelim);
  }

  String configurationPrettyString() {
    List<String> rowStrings = configurationRowStrings();
    for (int i = 0; i < rowStrings.length; i++) {
      rowStrings[i] = i.toString().padLeft(2) + " | " + rowStrings[i];
    }
    return rowStrings.join("\n");
  }

  Line verticalView(int col) => VerticalView(board: this, col: col);

  Line horizontalView(int row) => HorizontalView(board: this, row: row);

  void updateVertical(int col, Line line) {
    assert(line.length() == rows);
    for (int i = 0; i < rows; i++) {
      configuration[i][col] = line[i];
    }
  }

  void updateHorizontal(int row, Line line) {
    assert(line.length() == cols);
    for (int i = 0; i < cols; i++) {
      configuration[row][i] = line[i];
    }
  }
}

class VerticalView extends Line {
  VerticalView({this.board, this.col});

  Board board;
  int col;

  @override
  CellState operator [](int index) => board.configuration[index][col];

  @override
  int length() => board.rows;
}

class HorizontalView extends Line {
  HorizontalView({this.board, this.row});

  Board board;
  int row;

  @override
  CellState operator [](int index) => board.configuration[row][index];

  @override
  int length() => board.cols;
}

class Quiz {
  Quiz({this.rows, this.cols});

  List<Chunks> rows, cols;

  String prettyPrint() {
    List<String> rowStrings =
        rows.map((r) => r.toString()).toList(growable: false);
    List<String> colStrings =
        cols.map((r) => r.toString()).toList(growable: false);

    for (int i = 0; i < rowStrings.length; i++) {
      rowStrings[i] = "Row " + i.toString().padLeft(2) + " | " + rowStrings[i];
      print(rowStrings[i]);
    }
    for (int i = 0; i < colStrings.length; i++) {
      colStrings[i] = "Col " + i.toString().padLeft(2) + " | " + colStrings[i];
      print(colStrings[i]);
    }
  }
}

class Chunks {
  Chunks({this.counts});

  List<int> counts;

  String toString() {
    return counts.join(" ");
  }
}
