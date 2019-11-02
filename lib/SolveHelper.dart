import 'dart:ui';

import 'package:sagaklogic/Board.dart';

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
    log("SolveHelper $chunks ${line.toString()}");

    // init possiblePositions
    possiblePositions = List();
    int left = 0;
    int length = line.length() - 1;
    int rr = chunks.counts.fold(0, (a, b) => a + b) + chunks.counts.length - 1;
    for (int chunk in chunks.counts) {
      rr -= chunk + 1;
      int right = length - rr - chunk;
      log("$chunk $left $right");
      possiblePositions.add(range(left, right));
      left += chunk + 1;
    }
    assert(chunks.counts.length == possiblePositions.length);
    log(possiblePositions);

    solvedLine = MutableLine.fromLine(line);

    var lastVersion = solvedLine.version;
    // TODO solvedLine이나 possiblePositions가 converge할 때까지 반복
    for (int i = 0; i < 10; i++) {
      iteration();
    }
    if (lastVersion != solvedLine.version) {
      log("Updated!");
    }
  }

  void log(Object s) {
    // print(s);
  }

  final Line line;
  MutableLine solvedLine;
  final Chunks chunks;
  List<List<int>> possiblePositions;

  // 각 블럭별로, 해당 블럭을 가질 수 있는 청크의 id -> 겹치는 포지션들의 리스트
  List<Map<int, List<int>>> possibleOwners;

  void iteration() {
    removeNeverCells();
    log("removeNeverCells $possiblePositions");

    removeAdjacentFilledCells();
    log("removeAdjacentFilledCells $possiblePositions");

    removeNotInOrderPositions();
    log("removeNotInOrderPositions $possiblePositions");

    removeExclusives();
    log("removeExclusives $possiblePositions");

    markNondeterminedBlocks();
    log("markNondeterminedBlocks $solvedLine");

    markCertain();
    log("markCertain $solvedLine");

    markAlways();
    log("markAlways $solvedLine");

    markNevers();
    log("markNevers $solvedLine");
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
  void markCertain() {
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

  // 어떤 possiblePositions에 의해서든 점유될 가능성이 있는 cell에 O 표시
  void markAlways() {
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
  void markNevers() {
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

  void updatePossibleOwners() {
    // TODO 필요 없을때 안하기
    possibleOwners = List.generate(line.length(), (i) => Map());

    for (int i = 0; i < chunks.counts.length; i++) {
      for (int possiblePosition in possiblePositions[i]) {
        int right = possiblePosition + chunks.counts[i];
        for (int j = possiblePosition; j < right; j++) {
          if (!possibleOwners[j].containsKey(i)) {
            possibleOwners[j][i] = List();
          }
          possibleOwners[j][i].add(possiblePosition);
        }
      }
    }

    log(possibleOwners);
  }

  // 각 블럭을 "반드시" 포함해야하는 청크가 그 블럭을 포함하지 않은 possiblePositions 제거
  void removeExclusives() {
    updatePossibleOwners();

    for (int i = 0; i < line.length(); i++) {
      if (possibleOwners[i].isEmpty) {
        solvedLine[i] = CellState.Never;
      } else if (solvedLine[i] == CellState.Filled &&
          possibleOwners[i].keys.length == 1) {
        int owningChunk = possibleOwners[i].keys.last;
        possiblePositions[owningChunk] = possiblePositions[owningChunk]
            .where(
                (pos) => inRange(i, pos, pos + chunks.counts[owningChunk] - 1))
            .toList(growable: false);
      }
    }
  }

  void markNondeterminedBlocks() {
    updatePossibleOwners();
    PositionedChunks existingChunks = line.countPositionedChunks();
    log("existingChunks: $existingChunks");

    log("possiblePositions: $possiblePositions");
    for (int i = 0; i < possibleOwners.length; i++) {
      log("possibleOwners $i: ${possibleOwners[i]}");
    }

    for (int i = 0; i < existingChunks.chunks.length; i++) {
      ChunkPosition existing = existingChunks.chunks[i];
      Map<int, List<int>> possibleOwnersOfChunk = Map();

      for (int j = existing.start; j <= existing.end; j++) {
        for (var x in possibleOwners[j].entries) {
          if (!possibleOwnersOfChunk.containsKey(x.key)) {
            possibleOwnersOfChunk[x.key] = List();
          }
          possibleOwnersOfChunk[x.key] = possibleOwnersOfChunk[x.key] + x.value;
          possibleOwnersOfChunk[x.key] =
              possibleOwnersOfChunk[x.key].toSet().toList(growable: false);
        }
      }
      log("$existing -> $possibleOwnersOfChunk");

      Set<int> additionalCells = null;
      for (var pair in possibleOwnersOfChunk.entries) {
        var quizChunk = pair.key;
        var positions = pair.value;
        for (int position in positions) {
          var thisPosition =
              range(position, position + chunks.counts[quizChunk] - 1).toSet();
          if (additionalCells == null) {
            additionalCells = Set();
            additionalCells.addAll(thisPosition);
          } else {
            additionalCells = additionalCells.intersection(thisPosition);
          }
        }
      }
      log("additionalCells: $additionalCells");
      for (var additionalCell in additionalCells) {
        solvedLine[additionalCell] = CellState.Filled;
      }
    }
  }
}
