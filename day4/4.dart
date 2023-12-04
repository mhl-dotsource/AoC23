import 'dart:io';
import 'dart:math';

final rGame = new RegExp(r'\d+(?=:)');
final rNumber = new RegExp(r'[^\d+]');

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
  var sum = 0;
  lines.forEach((line) {
    final matches = getMatches(line);
    sum += pow(2, matches - 1).toInt();
  });
  return sum;
}

int partB(List<String> lines) {
  List<int> copies = List.filled(lines.length, 1);
  for (int i = 0; i < lines.length; i++) {
    final matches = getMatches(lines[i]);
    for (int j = 1; j <= matches; j++) {
      copies[i + j] += copies[i];
    }
  }
  return copies.fold(0, (previousValue, element) => previousValue + element);
}

int getMatches(String line) {
  final numbers = line.split(':')[1].split('|');
  final winningNumbers = numbers[0]
      .split(rNumber)
      .where((element) => element != "")
      .map((n) => int.parse(n))
      .toList();
  final ownNumbers = numbers[1]
      .split(rNumber)
      .where((element) => element != "")
      .map((n) => int.parse(n))
      .toList();
  return ownNumbers.where((number) => winningNumbers.contains(number)).length;
}
