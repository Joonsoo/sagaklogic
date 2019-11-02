import 'package:sagaklogic/Board.dart';

abstract class Line {
  int length();

  CellState operator [](int index);

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
  ConcreteLine({this.line});

  ConcreteLine.fromString(String s) {
    line = s
        .split('')
        .map((e) => (e == "O")
            ? CellState.Filled
            : ((e == "X") ? CellState.Never : CellState.Empty))
        .toList(growable: false);
  }

  ConcreteLine.fromLine(Line other) {
    line = List(other.length());

    for (int i = 0; i < other.length(); i++) {
      line[i] = other[i];
    }
  }

  List<CellState> line;

  @override
  int length() => line.length;

  @override
  CellState operator [](int index) => line[index];
}

class MutableLine extends ConcreteLine {
  MutableLine(List<CellState> line) : super(line: line);

  MutableLine.fromLine(Line other) : super.fromLine(other);

  int version = 0;

  operator []=(int index, CellState newValue) {
    if (line[index] != newValue) {
      version += 1;
      this.line[index] = newValue;
    }
  }
}

List<int> range(int start, int end) =>
    Iterable<int>.generate(end - start + 1).map((i) => i + start).toList();

class SolveHelper {
  SolveHelper({this.line, this.chunks}) {
    print("SolveHelper $chunks ${line.toString()}");

    // init possiblePositions
    possiblePositions = List();
    int left = 0;
    int length = line.length() - 1;
    int rr = chunks.counts.fold(0, (a, b) => a + b) + chunks.counts.length - 1;
    for (int chunk in chunks.counts) {
      rr -= chunk + 1;
      int right = length - rr - chunk;
      print("$chunk $left $right");
      possiblePositions.add(range(left, right));
      left += chunk + 1;
    }
    assert(chunks.counts.length == possiblePositions.length);
    print(possiblePositions);

    solvedLine = MutableLine.fromLine(line);

    var lastVersion = solvedLine.version;
    // TODO solvedLine이나 possiblePositions가 converge할 때까지 반복
    for (int i = 0; i < 10; i++) {
      iteration();
    }
    if (lastVersion != solvedLine.version) {
      print("Updated!");
    }
  }

  final Line line;
  MutableLine solvedLine;
  final Chunks chunks;
  List<List<int>> possiblePositions;

  void iteration() {
    removeNeverCells();
    print("removeNeverCells $possiblePositions");

    removeAdjacentFilledCells();
    print("removeAdjacentFilledCells $possiblePositions");

    removeNotInOrderPositions();
    print("removeNotInOrderPositions $possiblePositions");

    removeExclusives();
    print("removeExclusives $possiblePositions");

    fillCertain();
    print("fillCertain $solvedLine");

    fillAlways();
    print("fillAlways $solvedLine");

    fillNevers();
    print("fillNevers $solvedLine");
  }

  bool hasNeverIn(int start, int end) {
    for (int i = start; i <= end; i++) {
      if (line[i] == CellState.Never) return true;
    }
    return false;
  }

  // X가 포함된 possiblePositions 제거
  void removeNeverCells() {
    for (int i = 0; i < chunks.counts.length; i++) {
      int count = chunks.counts[i];
      List<int> positions = possiblePositions[i];

      possiblePositions[i] = positions
          .where((pos) => !hasNeverIn(pos, pos + count - 1))
          .toList(growable: false);
    }
  }

  // 인접한 Filled가 있는 possiblePositions 제거
  void removeAdjacentFilledCells() {
    for (int i = 0; i < chunks.counts.length; i++) {
      int count = chunks.counts[i];

      possiblePositions[i] = possiblePositions[i]
          .where((pos) =>
              (pos == 0 || line[pos - 1] != CellState.Filled) &&
              (pos + count >= line.length() ||
                  line[pos + count] != CellState.Filled))
          .toList(growable: false);
    }
  }

  int min(List<int> list) => list.fold(list[0], (a, b) => (a < b) ? a : b);

  int max(List<int> list) => list.fold(list[0], (a, b) => (a > b) ? a : b);

  // 왼쪽에 있는 block의 가능한 가장 왼쪽의 possible position보다 왼쪽에 있는 오른쪽 block의 possible position 제거. 반대방향도 제거
  void removeNotInOrderPositions() {
    if (chunks.counts.length == 0) return;

    int curr;

    // left to right
    curr = min(possiblePositions[0]) + chunks.counts[0] + 1;
    for (int i = 1; i < chunks.counts.length; i++) {
      possiblePositions[i] = possiblePositions[i]
          .where((pos) => pos >= curr)
          .toList(growable: false);
      curr = min(possiblePositions[i]) + chunks.counts[i] + 1;
    }

    // right to left
    curr = max(possiblePositions.last) - 1;
    for (int i = chunks.counts.length - 2; i >= 0; i--) {
      possiblePositions[i] = possiblePositions[i]
          .where((pos) => pos + chunks.counts[i] - 1 < curr)
          .toList(growable: false);
      curr = max(possiblePositions[i]) - 1;
    }
  }

  // possiblePositions가 딱 하나만 남은 블럭 표시
  void fillCertain() {
    for (int i = 0; i < chunks.counts.length; i++) {
      if (possiblePositions[i].length == 1) {
        int position = possiblePositions[i][0];
        for (int j = 0; j < chunks.counts[i]; j++) {
          solvedLine[position + j] = CellState.Filled;
        }
        if (position > 0) {
          solvedLine[position - 1] = CellState.Never;
        }
        if (position + chunks.counts[i] < line.length()) {
          solvedLine[position + chunks.counts[i]] = CellState.Never;
        }
      }
    }
  }

  // TODO 어떤 청크가 가져갈지는 모르지만 사이즈는 확정되었거나 사이즈의 lower bound는 알려진 경우 채워넣기
  void fillCertainSize() {}

  // 어떤 possiblePositions에 의해서든 점유될 가능성이 있는 cell에 O 표시
  void fillAlways() {
    for (int i = 0; i < chunks.counts.length; i++) {
      int left = max(possiblePositions[i]);
      int right = min(possiblePositions[i]) + chunks.counts[i] - 1;
      if (left <= right) {
        for (int j = left; j <= right; j++) {
          solvedLine[j] = CellState.Filled;
        }
      }
    }
  }

  // 어떤 possiblePositions에 의해서도 점유될 가능성이 없는 cell에 X 표시
  void fillNevers() {
    if (chunks.counts.length == 0) return;

    int nonemptyLeftmost = min(possiblePositions[0]);
    for (int i = 0; i < nonemptyLeftmost; i++) {
      solvedLine[i] = CellState.Never;
    }

    int nonemptyRightmost = max(possiblePositions.last) + chunks.counts.last;
    for (int i = nonemptyRightmost; i < line.length(); i++) {
      solvedLine[i] = CellState.Never;
    }

    for (int i = 1; i < chunks.counts.length; i++) {
      int left = max(possiblePositions[i - 1]) + chunks.counts[i - 1] - 1;
      int right = min(possiblePositions[i]);
      for (int j = left + 1; j < right; j++) {
        solvedLine[j] = CellState.Never;
      }
    }
  }

  bool inRange(int i, int min, int max) => min <= i && i <= max;

  // 각 블럭을 "반드시" 포함해야하는 청크가 그 블럭을 포함하지 않은 possiblePositions 제거
  void removeExclusives() {
    // 각 블럭별로, 해당 블럭을 가질 수 있는 청크의 id들의 리스트
    List<List<int>> possibleOwners =
        List.generate(line.length(), (i) => List());

    for (int i = 0; i < chunks.counts.length; i++) {
      int left = min(possiblePositions[i]);
      int right = max(possiblePositions[i]) + chunks.counts[i];
      for (int j = left; j < right; j++) {
        possibleOwners[j].add(i);
      }
    }

    print(possibleOwners);

    for (int i = 0; i < line.length(); i++) {
      if (possibleOwners[i].isEmpty) {
        solvedLine[i] = CellState.Never;
      } else if (solvedLine[i] == CellState.Filled &&
          possibleOwners[i].length == 1) {
        int owningChunk = possibleOwners[i][0];
        possiblePositions[owningChunk] = possiblePositions[owningChunk]
            .where(
                (pos) => inRange(i, pos, pos + chunks.counts[owningChunk] - 1))
            .toList(growable: false);
      }
    }
  }
}
