import 'dart:io';

// /(?<= )\d*(?= green)|(?<= )\d*(?= blue)|(?<=Game )\d*(?=:)
final rGame = new RegExp(r'(?<=Game )\d*(?=:)');
final rBlue = new RegExp(r'(?<= )\d*(?= blue)');
final rGreen = new RegExp(r'(?<= )\d*(?= green)');
final rRed = new RegExp(r'(?<= )\d*(?= red)');

void main() {
  var input = File('input.txt').readAsLinesSync();
  var sumA = 0;
  var sumB = 0;

  input.forEach((line) {
    sumA += validPartA(line);
    sumB += powerPartB(line);
  });
  print('Part A: $sumA');
  print('Part B: $sumB');
}

int validPartA(String line) {
  final maxBlue = 14;
  final maxGreen = 13;
  final maxRed = 12;

  var game = int.parse(rGame.firstMatch(line)?[0] ?? '0');
  var sets = line.split(';');

  var valid = sets.every((set) {
    final parsedSet = parseSet(set);
    final blue = parsedSet[0];
    final green = parsedSet[1];
    final red = parsedSet[2];

    if (blue > maxBlue || green > maxGreen || red > maxRed) {
      return false;
    }
    return true;
  });
  return valid ? game : 0;
}

int powerPartB(String line) {
  var sets = line.split(';');
  var minBlue = 0;
  var minGreen = 0;
  var minRed = 0;

  sets.forEach((set) {
    final parsedSet = parseSet(set);
    final blue = parsedSet[0];
    final green = parsedSet[1];
    final red = parsedSet[2];

    minBlue = blue > minBlue ? blue : minBlue;
    minGreen = green > minGreen ? green : minGreen;
    minRed = red > minRed ? red : minRed;
  });
  return minBlue * minGreen * minRed;
}

List parseSet(String set) {
  final blue = int.parse(rBlue.firstMatch(set)?[0] ?? '0');
  final green = int.parse(rGreen.firstMatch(set)?[0] ?? '0');
  final red = int.parse(rRed.firstMatch(set)?[0] ?? '0');

  return [blue, green, red];
}
