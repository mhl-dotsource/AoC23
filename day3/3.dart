import 'dart:io';

void main() {
  var input = File('input.txt').readAsLinesSync();
  var sumA = 0;
  var sumB = 0;

  sumA = partA(input);
  sumB = partB(input);

  print('Part A: $sumA');
  print('Part B: $sumB');
}

final rValidChar = new RegExp(r'[^.\n]');
final rNumber = new RegExp(r'\d+');

int partA(List<String> lines) {
  var sum = 0;
  for (var i = 0; i < lines.length; i++) {
    final line = lines[i];
    final numbers = rNumber.allMatches(line);

    numbers.forEach((match) {
      var start = match.start;
      var end = match.end;

      var surrounding = '';

      if (start > 0) {
        surrounding += line.substring(start - 1, start);
      }
      if (end < line.length - 1) {
        surrounding += line.substring(end, end + 1);
      }

      start = start - 1 >= 0 ? start - 1 : 0;
      end = end + 1 <= line.length - 1 ? end + 1 : line.length - 1;

      if (i > 0) {
        surrounding += lines[i - 1].substring(start, end);
      }
      if (i < lines.length - 1) {
        surrounding += lines[i + 1].substring(start, end);
      }
      if (rValidChar.hasMatch(surrounding)) {
        sum += int.parse(match[0] ?? '0');
      }
    });
  }

  return sum;
}

int partB(List<String> lines) {
  final rGear = new RegExp(r'\*');
  int sum = 0;
  for (int i = 0; i < lines.length; i++) {
    final line = lines[i];
    final gears = rGear.allMatches(line);

    gears.forEach((gear) {
      List<int> surroundingNumbers = [];
      if (i > 0) {
        surroundingNumbers.addAll(getSurroundingNumbers(lines[i - 1], gear));
      }
      if (i < lines.length - 1) {
        surroundingNumbers.addAll(getSurroundingNumbers(lines[i + 1], gear));
      }
      surroundingNumbers.addAll(getSurroundingNumbers(line, gear));

      if (surroundingNumbers.length == 2) {
        sum += surroundingNumbers[0] * surroundingNumbers[1];
      }
    });
  }
  return sum;
}

List<int> getSurroundingNumbers(String line, RegExpMatch gear) {
  List<int> surroundingNumbers = [];

  var start = gear.start - 3 >= 0 ? gear.start - 3 : 0;
  var end = gear.end + 3 <= line.length - 3 ? gear.end + 3 : line.length - 1;

  rNumber.allMatches(line).forEach((number) {
    if (number.start <= gear.end && number.end >= gear.start) {
      surroundingNumbers.add(int.parse(number[0]!));
    }
  });

  return surroundingNumbers;
}
