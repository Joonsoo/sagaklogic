import 'package:sagaklogic/Board.dart';

class Samples {
  static Map<String, Quiz> get allQuizzes => {
        "metamong": metamong.createQuiz(),
        "octopus": octopus.createQuiz(),
        "deer": deer,
        "kakaodog": kakaodog,
        "moyashimon": moyashimon,
        "gagamel": gagamel,
        "tazza": tazza,
        "doll": doll,
        "lion": lion,
      };

  static Board metamong = Board.fromStrings([
    "...OOO....",
    "..OO..O.OO",
    ".O.O..OOO.",
    ".O..O.....",
    ".O.....O..",
    ".O.OO.....",
    "OO...OOOO.",
    "O.........",
    "OO........",
    ".OOO...OOO"
  ]);

  static Board octopus = Board.fromStrings([
    ".......OOOOOO..",
    "......OOOOOOOOO",
    "OOO..OOOOOOOOOO",
    "..OO.OOOOOOOOOO",
    "...O.OOOOOOOOOO",
//
    "...O.OOOOOOOOOO",
    "..OO.O..OO..OO.",
    ".OO..OO.OOO.OO.",
    "OO....OOOOOOO..",
    "OO..OOOOOOOO...",
//
    ".OO.....OOOOOO.",
    "..OO...OOOOOOOO",
    "O..OOOOOO.OOO.O",
    "OO...O..O.O.OO.",
    ".OOOOO.OO.OO.OO",
  ]);

  static Quiz deer = new Quiz(rows: [
    Chunks(counts: [5, 9]),
    Chunks(counts: [3, 3, 3, 1, 1, 3]),
    Chunks(counts: [2, 2, 2, 2, 2, 1, 1, 2]),
    Chunks(counts: [4, 6, 1, 6, 1, 1]),
    Chunks(counts: [4, 3, 1, 10, 2]),
    //
    Chunks(counts: [6, 3, 7, 2]),
    Chunks(counts: [5, 5, 9]),
    Chunks(counts: [5, 1, 1, 2, 4, 2, 2]),
    Chunks(counts: [1, 4, 1, 2, 2, 3, 5]),
    Chunks(counts: [2, 4, 3, 4, 1, 4]),
    //
    Chunks(counts: [2, 4, 4, 4, 1, 4]),
    Chunks(counts: [3, 4, 9, 2, 4]),
    Chunks(counts: [8, 5, 3, 7]),
    Chunks(counts: [7, 1, 2, 4, 3, 6]),
    Chunks(counts: [6, 3, 2, 4, 5]),
    //
    Chunks(counts: [3, 1, 1, 1, 6, 3]),
    Chunks(counts: [14]),
    Chunks(counts: [1, 10]),
    Chunks(counts: [14]),
    Chunks(counts: [1, 1, 14]),
    //
    Chunks(counts: [1, 1, 8, 5]),
    Chunks(counts: [2, 1, 7, 7]),
    Chunks(counts: [1, 2, 7, 3, 5]),
    Chunks(counts: [2, 2, 7, 8]),
    Chunks(counts: [1, 2, 7, 9]),
    //
    Chunks(counts: [2, 1, 2, 5, 12]),
    Chunks(counts: [1, 1, 3, 19]),
    Chunks(counts: [1, 3, 3, 12, 5]),
    Chunks(counts: [1, 2, 4, 13, 4]),
    Chunks(counts: [3, 3, 17]),
  ], cols: [
    Chunks(counts: [6, 1, 3]),
    Chunks(counts: [6, 4, 2, 1]),
    Chunks(counts: [5, 3, 2]),
    Chunks(counts: [5, 4, 3, 3]),
    Chunks(counts: [8, 5, 2, 1, 1, 1]),
    //
    Chunks(counts: [15, 1]),
    Chunks(counts: [2, 13]),
    Chunks(counts: [1, 1, 8, 1, 7]),
    Chunks(counts: [3, 2, 2, 2, 14]),
    Chunks(counts: [2, 2, 2, 3, 5, 4]),
    //
    Chunks(counts: [4, 2, 1, 7, 2]),
    Chunks(counts: [2, 1, 11]),
    Chunks(counts: [1, 1, 3, 13]),
    Chunks(counts: [1, 22]),
    Chunks(counts: [3, 8, 6, 7]),
    //
    Chunks(counts: [2, 3, 5, 6, 8]),
    Chunks(counts: [2, 4, 1, 3, 5, 4, 4]),
    Chunks(counts: [3, 3, 1, 2, 9, 5]),
    Chunks(counts: [1, 3, 2, 13, 7]),
    Chunks(counts: [2, 2, 24]),
    //
    Chunks(counts: [1, 4, 23]),
    Chunks(counts: [1, 7, 12]),
    Chunks(counts: [2, 4, 4, 9]),
    Chunks(counts: [1, 4, 7, 8]),
    Chunks(counts: [3, 3, 4, 4, 2]),
    //
    Chunks(counts: [1, 5, 5, 5, 1]),
    Chunks(counts: [3, 10, 6]),
    Chunks(counts: [1, 1, 1, 6, 5]),
    Chunks(counts: [10, 5]),
    Chunks(counts: [6, 4]),
    //
  ]);

  static Quiz kakaodog = new Quiz(rows: [
    Chunks(counts: [6]),
    Chunks(counts: [2, 2, 5]),
    Chunks(counts: [1, 1, 3, 3]),
    Chunks(counts: [1, 5, 2, 1]),
    Chunks(counts: [3, 2, 5, 2]),
    //
    Chunks(counts: [6, 5]),
    Chunks(counts: [4, 3, 3]),
    Chunks(counts: [6, 6, 2, 6]),
    Chunks(counts: [1, 7, 4, 9]),
    Chunks(counts: [1, 2, 1, 1, 2, 14]),
    //
    Chunks(counts: [7, 5, 5]),
    Chunks(counts: [1, 1, 3, 1]),
    Chunks(counts: [2, 1, 2]),
    Chunks(counts: [6, 3, 1]),
    Chunks(counts: [8, 9]),
    //
    Chunks(counts: [5, 1, 1, 2]),
    Chunks(counts: [5, 9, 2, 5]),
    Chunks(counts: [6, 2, 10]),
    Chunks(counts: [6, 2, 2, 2, 9]),
    Chunks(counts: [4, 2, 2, 1, 1, 8]),
    //
    Chunks(counts: [1, 3, 1, 2, 7]),
    Chunks(counts: [5, 1, 1, 1, 7]),
    Chunks(counts: [5, 2, 1, 1, 7]),
    Chunks(counts: [6, 13, 1]),
    Chunks(counts: [6, 13, 4]),
    //
    Chunks(counts: [6, 1, 2, 2, 1, 7]),
    Chunks(counts: [6, 1, 2, 2, 3, 7]),
    Chunks(counts: [8, 2, 2, 10]),
    Chunks(counts: [8, 2, 6]),
    Chunks(counts: [8, 5]),
    //
  ], cols: [
    Chunks(counts: [2, 8, 10]),
    Chunks(counts: [3, 7, 9]),
    Chunks(counts: [3, 7, 9]),
    Chunks(counts: [6, 7, 9]),
    Chunks(counts: [3, 20]),
    //
    Chunks(counts: [2, 4, 2, 4, 7]),
    Chunks(counts: [4, 4, 1, 3, 3]),
    Chunks(counts: [2, 2, 2, 3, 2, 8]),
    Chunks(counts: [1, 5, 1, 1, 2, 2]),
    Chunks(counts: [1, 1, 1, 2, 1, 1, 2]),
    //
    Chunks(counts: [1, 1, 1, 1, 1, 2]),
    Chunks(counts: [1, 1, 3, 1, 2, 2]),
    Chunks(counts: [2, 2, 1, 1, 1, 2, 5]),
    Chunks(counts: [4, 4, 2, 5]),
    Chunks(counts: [1, 4, 3, 2]),
    //
    Chunks(counts: [1, 2, 1, 3, 11]),
    Chunks(counts: [2, 4, 1, 6]),
    Chunks(counts: [2, 1, 1, 2]),
    Chunks(counts: [1, 1, 1, 1, 2, 2, 1]),
    Chunks(counts: [2, 1, 1, 1, 7]),
    //
    Chunks(counts: [1, 3, 1, 3, 1, 2]),
    Chunks(counts: [1, 1, 6, 1, 3, 1]),
    Chunks(counts: [1, 1, 3, 6, 1]),
    Chunks(counts: [2, 1, 3, 2, 11]),
    Chunks(counts: [1, 2, 4, 6, 5]),
    //
    Chunks(counts: [3, 4, 7, 6]),
    Chunks(counts: [3, 7, 6]),
    Chunks(counts: [4, 7, 5]),
    Chunks(counts: [4, 7, 5]),
    Chunks(counts: [4, 7, 5]),
    //
  ]);

  static Quiz moyashimon = new Quiz(rows: [
    Chunks(counts: [30]),
    Chunks(counts: [1, 2, 2, 1]),
    Chunks(counts: [3, 4, 1, 1, 1]),
    Chunks(counts: [1, 2, 4, 1, 1]),
    Chunks(counts: [2, 3, 1, 2, 3, 3]),
    //
    Chunks(counts: [2, 3, 4, 1, 1, 1, 1]),
    Chunks(counts: [1, 1, 1, 4, 1, 3, 1]),
    Chunks(counts: [8, 3, 2, 2, 1, 3]),
    Chunks(counts: [1, 2, 2, 2, 1, 1, 1, 3, 1]),
    Chunks(counts: [1, 1, 3, 10, 1, 4]),
    //
    Chunks(counts: [1, 1, 2, 2, 4, 1, 1]),
    Chunks(counts: [1, 1, 2, 2, 2, 2, 1]),
    Chunks(counts: [1, 1, 1, 3, 3, 1]),
    Chunks(counts: [1, 2, 1, 1, 1, 1, 1, 1]),
    Chunks(counts: [6, 1, 1, 1]),
    //
    Chunks(counts: [1, 2, 1, 1, 1, 1]),
    Chunks(counts: [1, 2, 1, 1, 1, 1]),
    Chunks(counts: [1, 2, 1, 1, 11, 1, 1]),
    Chunks(counts: [1, 1, 1, 1, 1, 1, 1, 1]),
    Chunks(counts: [1, 1, 1, 1, 1, 2, 4, 1]),
    //
    Chunks(counts: [1, 1, 1, 3, 9, 1, 3]),
    Chunks(counts: [8, 2, 2, 1, 1]),
    Chunks(counts: [1, 1, 17, 1]),
    Chunks(counts: [3, 1, 3, 1, 1, 4]),
    Chunks(counts: [1, 2, 1, 1, 1, 1, 1]),
    //
    Chunks(counts: [2, 5, 4, 1, 1, 3]),
    Chunks(counts: [1, 1, 3, 1, 1, 1, 1]),
    Chunks(counts: [5, 3, 1, 1, 1, 1]),
    Chunks(counts: [1, 1, 1, 1, 1]),
    Chunks(counts: [30]),
    //
  ], cols: [
    Chunks(counts: [1, 2, 2, 5, 1, 2, 1]),
    Chunks(counts: [1, 1, 2, 1, 4, 1, 4, 1, 1, 1, 1]),
    Chunks(counts: [1, 1, 2, 5, 1, 1, 1, 1]),
    Chunks(counts: [1, 1, 2, 15, 1, 1, 1, 1]),
    Chunks(counts: [1, 2, 1, 1, 1, 1, 1, 1]),
    //
    Chunks(counts: [9, 1, 18]),
    Chunks(counts: [1, 1, 5, 1, 1, 1]),
    Chunks(counts: [1, 1, 3, 1, 2, 3, 2, 1, 1]),
    Chunks(counts: [1, 2, 1, 2, 9, 2, 1, 1]),
    Chunks(counts: [1, 3, 2, 2, 2, 1, 2, 1]),
    //
    Chunks(counts: [1, 3, 2, 3, 1, 1]),
    Chunks(counts: [1, 4, 1, 3, 1, 2, 1]),
    Chunks(counts: [1, 1, 1, 1, 1, 1, 1]),
    Chunks(counts: [1, 1, 1, 1, 1, 1, 1]),
    Chunks(counts: [1, 3, 1, 1, 8]),
    //
    Chunks(counts: [1, 4, 1, 1, 1, 1, 1]),
    Chunks(counts: [1, 2, 1, 1, 1, 1, 1, 1]),
    Chunks(counts: [4, 1, 1, 1, 1, 1, 1]),
    Chunks(counts: [2, 1, 2, 1, 1, 1, 1, 1]),
    Chunks(counts: [1, 2, 3, 1, 1, 1, 6]),
    //
    Chunks(counts: [2, 3, 2, 1, 2, 1, 1]),
    Chunks(counts: [5, 1, 1, 3, 8]),
    Chunks(counts: [1, 1, 1, 1]),
    Chunks(counts: [1, 4, 2, 1]),
    Chunks(counts: [1, 1, 2, 4, 1]),
    //
    Chunks(counts: [1, 3, 8, 1, 1]),
    Chunks(counts: [1, 1, 1, 2, 1, 2, 1]),
    Chunks(counts: [1, 4, 3, 3, 3, 1]),
    Chunks(counts: [1, 1, 1, 1, 1, 1, 1, 1]),
    Chunks(counts: [30]),
    //
  ]);

  static Quiz gagamel = new Quiz(rows: [
    Chunks(counts: [10]),
    Chunks(counts: [3, 7, 2]),
    Chunks(counts: [4, 2, 3, 3, 4]),
    Chunks(counts: [5, 1, 3, 3]),
    Chunks(counts: [7, 5, 3]),
    //
    Chunks(counts: [7, 1, 2, 3, 4]),
    Chunks(counts: [9, 1, 1, 1, 1]),
    Chunks(counts: [9, 1, 1, 1]),
    Chunks(counts: [11, 1, 2, 2, 1]),
    Chunks(counts: [3, 5, 2, 2, 2, 1]),
    //
    Chunks(counts: [2, 3, 5, 7]),
    Chunks(counts: [1, 2, 2, 1, 1, 3]),
    Chunks(counts: [1, 2, 1, 4, 4, 1]),
    Chunks(counts: [1, 2, 1, 1]),
    Chunks(counts: [1, 5, 3, 4, 3]),
    //
    Chunks(counts: [2, 2, 3, 5]),
    Chunks(counts: [4, 1, 2, 2, 1]),
    Chunks(counts: [6, 1, 2, 2, 1]),
    Chunks(counts: [3, 2, 3, 1]),
    Chunks(counts: [3, 3, 1, 1]),
    //
    Chunks(counts: [3, 1, 5, 1]),
    Chunks(counts: [4, 1, 5, 1]),
    Chunks(counts: [4, 2, 4, 1, 1]),
    Chunks(counts: [2, 2, 2, 2, 2]),
    Chunks(counts: [2, 3, 2, 4, 2]),
    //
    Chunks(counts: [3, 7, 2]),
    Chunks(counts: [3, 5, 2, 3]),
    Chunks(counts: [4, 3, 9]),
    Chunks(counts: [4, 4]),
    Chunks(counts: [4, 5]),
    //
  ], cols: [
    Chunks(counts: [20, 6]),
    Chunks(counts: [9, 8, 6]),
    Chunks(counts: [8, 8, 5]),
    Chunks(counts: [7, 1, 1, 2, 4, 3]),
    Chunks(counts: [8, 2, 1, 1, 3]),
    //
    Chunks(counts: [1, 5, 4, 1, 3, 6]),
    Chunks(counts: [2, 7, 3, 2, 5]),
    Chunks(counts: [1, 5, 1, 7]),
    Chunks(counts: [1, 7, 3, 2]),
    Chunks(counts: [1, 5, 1, 1]),
    //
    Chunks(counts: [1, 3, 2]),
    Chunks(counts: [1, 2]),
    Chunks(counts: [1, 1, 1, 1]),
    Chunks(counts: [3, 1, 1]),
    Chunks(counts: [2, 5, 1, 8, 1]),
    //
    Chunks(counts: [3, 2, 2, 1, 2, 6, 1]),
    Chunks(counts: [4, 1, 1, 3, 6, 1]),
    Chunks(counts: [5, 2, 1, 2, 3, 1, 1]),
    Chunks(counts: [1, 3, 3, 5, 1, 1]),
    Chunks(counts: [2, 3, 3, 3, 1, 2, 2]),
    //
    Chunks(counts: [1, 1, 1, 2, 2, 1]),
    Chunks(counts: [1, 3, 3, 1, 1, 2, 2]),
    Chunks(counts: [3, 3, 1, 3, 2]),
    Chunks(counts: [4, 1, 1, 2]),
    Chunks(counts: [3, 6, 9]),
    //
    Chunks(counts: [2, 1, 1]),
    Chunks(counts: [1, 2, 2]),
    Chunks(counts: [2, 1]),
    Chunks(counts: [4]),
    Chunks(counts: []),
    //
  ]);

  static Quiz tazza = new Quiz(rows: [
    Chunks(counts: [9]),
    Chunks(counts: [5, 6]),
    Chunks(counts: [7, 6]),
    Chunks(counts: [9, 6]),
    Chunks(counts: [7, 2, 5]),
    //
    Chunks(counts: [9, 9]),
    Chunks(counts: [1, 10, 8]),
    Chunks(counts: [3, 8, 2, 6]),
    Chunks(counts: [1, 1, 9, 9]),
    Chunks(counts: [1, 1, 4, 4, 6]),
    //
    Chunks(counts: [1, 1, 4, 12]),
    Chunks(counts: [2, 1, 3, 9]),
    Chunks(counts: [2, 1, 2, 2, 4, 1]),
    Chunks(counts: [4, 1, 1, 1, 2, 2, 1]),
    Chunks(counts: [2, 1, 2, 1, 2, 2, 2, 1, 1]),
    //
    Chunks(counts: [2, 1, 2, 1, 4, 4]),
    Chunks(counts: [1, 1, 2, 2, 1, 1]),
    Chunks(counts: [2, 2, 1, 2, 1]),
    Chunks(counts: [1, 1, 1, 2, 2]),
    Chunks(counts: [1, 1, 1, 4, 3]),
    //
    Chunks(counts: [1, 1, 3, 4, 4]),
    Chunks(counts: [2, 2, 4, 1, 2, 4]),
    Chunks(counts: [7, 6, 3, 5]),
    Chunks(counts: [6, 7, 6]),
    Chunks(counts: [7, 9, 7]),
    //
    Chunks(counts: [8, 11, 8]),
    Chunks(counts: [8, 10, 7]),
    Chunks(counts: [20, 7]),
    Chunks(counts: [20, 7]),
    Chunks(counts: [20, 7]),
    //
  ], cols: [
    Chunks(counts: [2, 3]),
    Chunks(counts: [5, 5]),
    Chunks(counts: [2, 13]),
    Chunks(counts: [3, 9]),
    Chunks(counts: [5, 4, 8]),
    //
    Chunks(counts: [2, 8]),
    Chunks(counts: [8, 9]),
    Chunks(counts: [1, 13]),
    Chunks(counts: [1, 2, 1, 6]),
    Chunks(counts: [1, 2, 3]),
    //
    Chunks(counts: [4, 6]),
    Chunks(counts: [6, 8]),
    Chunks(counts: [12, 10]),
    Chunks(counts: [15, 10]),
    Chunks(counts: [11, 14]),
    //
    Chunks(counts: [9, 9]),
    Chunks(counts: [9, 2, 8]),
    Chunks(counts: [10, 2, 1, 7]),
    Chunks(counts: [11, 1, 3, 6]),
    Chunks(counts: [1, 2, 2, 4, 3, 4, 5]),
    //
    Chunks(counts: [2, 2, 2, 3, 2, 1, 1]),
    Chunks(counts: [3, 2, 2, 2, 1, 4]),
    Chunks(counts: [4, 2, 1, 2, 1, 2, 1]),
    Chunks(counts: [4, 2, 1, 2, 2, 6]),
    Chunks(counts: [12, 2, 7]),
    //
    Chunks(counts: [12, 8]),
    Chunks(counts: [12, 10]),
    Chunks(counts: [12, 11]),
    Chunks(counts: [7, 12]),
    Chunks(counts: [6, 3, 14]),
    //
  ]);

  static Quiz doll = new Quiz(rows: [
    Chunks(counts: [3]),
    Chunks(counts: [1, 1, 1]),
    Chunks(counts: [3, 3]),
    Chunks(counts: [7]),
    Chunks(counts: [2]),
    //
    Chunks(counts: [7]),
    Chunks(counts: [1]),
    Chunks(counts: [6]),
    Chunks(counts: [1, 2]),
    Chunks(counts: [4, 3]),
  ], cols: [
    Chunks(counts: [1]),
    Chunks(counts: [1]),
    Chunks(counts: [3, 1]),
    Chunks(counts: [1, 8]),
    Chunks(counts: [6, 1]),
    //
    Chunks(counts: [1, 1, 1]),
    Chunks(counts: [1, 1, 1]),
    Chunks(counts: [3, 1, 3]),
    Chunks(counts: [2, 1, 3]),
    Chunks(counts: [2, 1, 1]),
  ]);

  static Quiz lion = new Quiz(rows: [
    Chunks(counts: [5, 4, 3, 12]),
    Chunks(counts: [4, 3, 3, 2, 11]),
    Chunks(counts: [5, 3, 2, 1, 9]),
    Chunks(counts: [3, 4, 3, 2, 9]),
    Chunks(counts: [2, 2, 4, 10]),
    //
    Chunks(counts: [1, 5, 3, 11]),
    Chunks(counts: [1, 2, 4, 9]),
    Chunks(counts: [3, 2, 1, 3, 1, 8]),
    Chunks(counts: [1, 4, 1, 5, 9]),
    Chunks(counts: [2, 3, 1, 2, 1, 7]),
    //
    Chunks(counts: [1, 2, 1, 1, 6]),
    Chunks(counts: [3, 1, 2, 10]),
    Chunks(counts: [1, 2, 2, 2, 3, 5]),
    Chunks(counts: [2, 2, 3, 2, 1, 5]),
    Chunks(counts: [1, 2, 5, 2, 6]),
    //
    Chunks(counts: [1, 2, 1, 3, 11]),
    Chunks(counts: [1, 1, 1, 4, 3, 7]),
    Chunks(counts: [1, 3, 2, 1, 2, 6]),
    Chunks(counts: [1, 2, 2, 1, 2, 6]),
    Chunks(counts: [1, 2, 1, 1, 5, 1, 6]),
    //
    Chunks(counts: [1, 3, 5, 1, 6]),
    Chunks(counts: [2, 2, 2, 1, 1, 7]),
    Chunks(counts: [1, 1, 2, 1, 11]),
    Chunks(counts: [1, 2, 3, 1, 10]),
    Chunks(counts: [2, 3, 3, 1, 10]),
    //
    Chunks(counts: [3, 3, 3, 1, 10]),
    Chunks(counts: [2, 3, 4, 1, 11]),
    Chunks(counts: [3, 4, 2, 1, 12]),
    Chunks(counts: [1, 3, 3, 2, 14]),
    Chunks(counts: [2, 3, 4, 2, 15]),
    //
  ], cols: [
    Chunks(counts: [7, 3, 3, 8, 2]),
    Chunks(counts: [5, 2, 3, 1, 4, 1]),
    Chunks(counts: [4, 2, 3, 2, 4]),
    Chunks(counts: [3, 1, 2, 2, 3]),
    Chunks(counts: [1, 1, 3, 2, 2, 2, 2]),
    //
    Chunks(counts: [1, 5, 4, 1, 3, 1]),
    Chunks(counts: [1, 1, 3, 2, 3, 2, 3]),
    Chunks(counts: [1, 1, 3, 2, 3, 4]),
    Chunks(counts: [1, 1, 3, 5, 3, 3]),
    Chunks(counts: [1, 1, 3, 4, 7]),
    //
    Chunks(counts: [1, 1, 1, 8, 3, 1]),
    Chunks(counts: [2, 4, 2, 7, 3]),
    Chunks(counts: [2, 2, 1, 3, 4]),
    Chunks(counts: [3, 1, 2, 3, 2]),
    Chunks(counts: [1, 2, 1, 2, 2]),
    //
    Chunks(counts: [1, 2, 3, 1, 2, 1]),
    Chunks(counts: [3, 1, 3, 3, 3]),
    Chunks(counts: [4, 2, 1, 4, 2, 2]),
    Chunks(counts: [1, 2, 2, 2, 2, 2, 3]),
    Chunks(counts: [3, 1, 2, 3, 4]),
    //
    Chunks(counts: [2, 2, 1, 1, 2, 8]),
    Chunks(counts: [7, 1, 2, 2, 9]),
    Chunks(counts: [9, 5, 2, 8]),
    Chunks(counts: [10, 2, 2, 9]),
    Chunks(counts: [12, 16]),
    //
    Chunks(counts: [30]),
    Chunks(counts: [30]),
    Chunks(counts: [30]),
    Chunks(counts: [30]),
    Chunks(counts: [30]),
    //
  ]);
}
