import 'dart:io';
import 'dart:math';

final rNumber = new RegExp(r'[\d]+');

void main() {
  var input = File('input.txt').readAsLinesSync();
  var sumA = 0;
  var sumB = 0;

  sumA = partA(input);
  sumB = partB(input);

  print('Part A: $sumA');
  print('Part B: $sumB');
}

int partA(List<String> lines) {
  List<int> numbers = [];
  final times =
      rNumber.allMatches(lines[0]).map((e) => int.parse(e[0]!)).toList();
  final distances =
      rNumber.allMatches(lines[1]).map((e) => int.parse(e[0]!)).toList();

  for (int i = 0; i < times.length; i++) {
    final time = times[i];
    var winningTimes = 0;
    for (int j = 0; j < time; j++) {
      if ((time - j) * j > distances[i]) {
        winningTimes++;
      }
    }
    numbers.add(winningTimes);
  }
  return numbers.fold(1, (previousValue, element) => previousValue * element);
}

int partB(List<String> lines) {
  lines[0] = lines[0].replaceAll(new RegExp(r"\s+"), "");
  lines[1] = lines[1].replaceAll(new RegExp(r"\s+"), "");
  final timeMatch = rNumber.firstMatch(lines[0]);
  final distanceMatch = rNumber.firstMatch(lines[1]);
  final time = int.parse(timeMatch![0]!);
  final distance = int.parse(distanceMatch![0]!);

  var winningTimes = 0;
  for (int j = 0; j < time; j++) {
    if ((time - j) * j > distance) {
      winningTimes++;
    }
  }
  return winningTimes;
}
