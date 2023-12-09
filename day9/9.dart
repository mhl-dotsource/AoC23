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

int partA(List<String> lines) {
  var sum = 0;
  lines.forEach((line) {
    List<List<int>> numbers = getDifference(line);
    while (numbers.length > 1) {
      final lastLine = numbers.removeLast();
      numbers.last.add(numbers.last.last + lastLine.last);
    }
    sum += numbers.last.last;
    ;
  });
  return sum;
}

int partB(List<String> lines) {
  var sum = 0;
  lines.forEach((line) {
    List<List<int>> numbers = getDifference(line);
    while (numbers.length > 1) {
      final lastLine = numbers.removeLast();
      numbers.last.insert(0, (numbers.last.first - lastLine.first));
    }
    sum += numbers.first.first;
  });
  return sum;
}

List<List<int>> getDifference(String line) {
  List<List<int>> numbers = [];
  numbers.add(line.split(' ').map(int.parse).toList());
  while (!numbers.last.every((element) => element == 0)) {
    List<int> newLine = [];
    for (int i = 1; i < numbers.last.length; i++) {
      newLine.add(numbers.last[i] - numbers.last[i - 1]);
    }
    numbers.add(newLine);
  }
  return numbers;
}
