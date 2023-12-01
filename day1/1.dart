import 'dart:io';

void main() {
  var input = File('input.txt').readAsLinesSync();
  var sum = 0;
  input.forEach((element) {
    var n = getFirstDigit(element) * 10 + getLastDigit(element);
    sum += n;
  });
  print(sum);
}

bool isDigit(String s, int idx) => (s.codeUnitAt(idx) ^ 0x30) <= 9;

const nums = {
  '1': 1,
  '2': 2,
  '3': 3,
  '4': 4,
  '5': 5,
  '6': 6,
  '7': 7,
  '8': 8,
  '9': 9,
  'one': 1,
  'two': 2,
  'three': 3,
  'four': 4,
  'five': 5,
  'six': 6,
  'seven': 7,
  'eight': 8,
  'nine': 9
};

int getFirstDigit(String s) {
  var index = s.length;
  var number = '';

  nums.keys.forEach((element) {
    if (s.contains(element) && s.indexOf(element) < index) {
      index = s.indexOf(element);
      number = element;
    }
  });
  return nums[number] ?? 0;
}

int getLastDigit(String s) {
  var index = -1;
  var number = '';

  nums.keys.forEach((element) {
    if (s.contains(element) && s.lastIndexOf(element) > index) {
      index = s.lastIndexOf(element);
      number = element;
    }
  });
  return nums[number] ?? 0;
}
