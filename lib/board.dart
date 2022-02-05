import 'dart:math';

enum CellState { Empty, Filled, Never }

class Board {
  final int rows, cols;
  List<List<CellState>> configuration;

  Board({required this.rows, required this.cols})
      : configuration = List.generate(
            rows, (index) => List.generate(cols, (index) => CellState.Empty));

  Board.fromConfiguration({required this.configuration})
      : rows = configuration.length,
        cols = configuration[0].length;

  Board.fromStrings(List<String> board)
      : rows = board.length,
        cols = board[0].length,
        configuration = List.generate(
            board.length, (i) => ConcreteLine.fromString(board[i]).line);

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
    List<Chunks> rowChunks = List.generate(rows, (i) => countChunksInRow(i));
    List<Chunks> colChunks = List.generate(cols, (i) => countChunksInCol(i));

    return Quiz(rows: rowChunks, cols: colChunks);
  }

  Chunks countChunksInRow(int row) {
    return horizontalView(row).countChunks();
  }

  Chunks countChunksInCol(int col) {
    return verticalView(col).countChunks();
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

abstract class Line {
  int length();

  CellState operator [](int index);

  Chunks countChunks() {
    List<int> counts = [];
    int countSoFar = 0;
    for (int i = 0; i < length(); i++) {
      if (this[i] == CellState.Filled) {
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

  PositionedChunks countPositionedChunks() {
    List<ChunkPosition> chunks = [];
    int countStart = -1;
    int countSoFar = 0;
    for (int i = 0; i < length(); i++) {
      if (this[i] == CellState.Filled) {
        if (countSoFar == 0) countStart = i;
        countSoFar += 1;
      } else {
        if (countSoFar > 0) {
          chunks.add(ChunkPosition(start: countStart, size: countSoFar));
        }
        countSoFar = 0;
      }
    }
    if (countSoFar > 0) {
      chunks.add(ChunkPosition(start: countStart, size: countSoFar));
    }
    return new PositionedChunks(chunks: chunks);
  }

  String toString() {
    String s = "";
    for (int i = 0; i < length(); i++) {
      var c = this[i];
      s += (c == CellState.Filled) ? "O" : ((c == CellState.Never) ? "X" : ".");
    }
    return s;
  }
}

class ConcreteLine extends Line {
  List<CellState> line;

  ConcreteLine({required this.line});

  ConcreteLine.fromString(String s)
      : line = s
            .split('')
            .map((e) => (e == "O")
                ? CellState.Filled
                : ((e == "X") ? CellState.Never : CellState.Empty))
            .toList(growable: false);

  ConcreteLine.fromLine(Line other)
      : line = List.generate(other.length(), (i) => other[i]);

  @override
  int length() => line.length;

  @override
  CellState operator [](int index) => line[index];
}

class VerticalView extends Line {
  Board board;
  int col;

  VerticalView({required this.board, required this.col});

  @override
  CellState operator [](int index) => board.configuration[index][col];

  @override
  int length() => board.rows;
}

class HorizontalView extends Line {
  Board board;
  int row;

  HorizontalView({required this.board, required this.row});

  @override
  CellState operator [](int index) => board.configuration[row][index];

  @override
  int length() => board.cols;
}

class Quiz {
  List<Chunks> rows, cols;

  Quiz({required this.rows, required this.cols}) {
    int sum(List<int> list) => list.fold(0, (a, b) => a + b);
    var rowsSum = rows.fold<int>(0, (a, b) => a + sum(b.counts));
    var colsSum = cols.fold<int>(0, (a, b) => a + sum(b.counts));
    if (rowsSum != colsSum) {
      throw Exception("Invalid quiz!");
    }
  }

  prettyPrint() {
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
  List<int> counts;

  Chunks({required this.counts});

  String toString() {
    return counts.join(" ");
  }
}

class ChunkPosition {
  final int start;
  final int size;

  const ChunkPosition({required this.start, required this.size});

  int get end => start + size - 1;

  String toString() => "($start+$size,$start~$end)";
}

class PositionedChunks {
  List<ChunkPosition> chunks;

  PositionedChunks({required this.chunks});

  String toString() => chunks.toString();
}
