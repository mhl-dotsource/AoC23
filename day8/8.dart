import 'dart:io';

final rDirection = new RegExp(r'\w{3}');

void main() {
  var input = File('input.txt').readAsLinesSync();
  var sumA = 0;
  var sumB = 0;

  final instructions = input[0].split('');
  final directions = getDirections(input.sublist(1));

  sumA = partA(directions, instructions);
  sumB = partB(directions, instructions);

  print('Part A: $sumA');
  print('Part B: $sumB');
}

int partA(
    Map<String, Map<String, String>> directions, List<String> instructions) {
  var currentNode = 'AAA';
  var steps = 0;
  while (currentNode != 'ZZZ') {
    final nextInstructions = instructions[steps % instructions.length];
    currentNode = directions[currentNode]![nextInstructions]!;
    steps++;
  }
  return steps;
}

int partB(
    Map<String, Map<String, String>> directions, List<String> instructions) {
  var currentNodes = getStartingNodes(directions);
  var steps = [];
  for (var node in currentNodes) {
    var currentSteps = 0;
    var currentNode = node;
    while (currentNode[2] != 'Z') {
      final nextInstructions = instructions[currentSteps % instructions.length];
      currentNode = directions[currentNode]![nextInstructions]!;
      currentSteps++;
    }
    steps.add(currentSteps);
  }
  print('Find LCM of $steps');
  return 0;
}

Map<String, Map<String, String>> getDirections(List<String> lines) {
  var result = <String, Map<String, String>>{};
  lines.forEach((line) {
    final directions = rDirection.allMatches(line).toList();

    if (directions.length == 3) {
      final start = directions[0][0]!;
      final L = directions[1][0]!;
      final R = directions[2][0]!;
      result.putIfAbsent(start, () => {'L': L, 'R': R});
    }
  });
  return result;
}

List<String> getStartingNodes(Map<String, Map<String, String>> directions) {
  return directions.keys
      .toList()
      .where((element) => element[2] == 'A')
      .toList();
}

bool allNodesEnded(List<String> nodes) {
  return nodes.every((element) => element[2] == 'Z');
}
