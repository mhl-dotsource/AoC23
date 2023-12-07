import 'dart:io';

List<String> order = [
  'A',
  'K',
  'Q',
  'J',
  'T',
  '9',
  '8',
  '7',
  '6',
  '5',
  '4',
  '3',
  '2'
];

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
  List<Hand> hands = [];
  lines.forEach((line) {
    hands.add(Hand.parse(line, false));
  });
  hands.sort();
  for (int i = 0; i < hands.length; i++) {
    sum += (i + 1) * hands[i].bid;
  }
  return sum;
}

int partB(List<String> lines) {
  order = ['A', 'K', 'Q', 'T', '9', '8', '7', '6', '5', '4', '3', '2', 'J'];
  var sum = 0;
  List<Hand> hands = [];
  lines.forEach((line) {
    hands.add(Hand.parse(line, true));
  });
  hands.sort();
  for (int i = 0; i < hands.length; i++) {
    sum += (i + 1) * hands[i].bid;
  }
  return sum;
}

class Hand implements Comparable {
  final int bid;
  final int rank;
  final List<String> hand;

  Hand(this.bid, this.rank, this.hand);

  factory Hand.parse(String line, bool joker) {
    var bid = int.tryParse(line.split(' ')[1]) ?? 0;
    var hand = line.split(' ')[0].split('').toList();
    var rank = joker ? getBestRank(hand) : getRank(hand);
    return Hand(bid, rank, hand);
  }

  @override
  String toString() {
    return hand.join() + '|' + rank.toString() + '|' + bid.toString();
  }

  static int getRank(List<String> cards) {
    List<String> labels = List.from(cards);

    labels.sort((a, b) => order.indexOf(a) > order.indexOf(b) ? 1 : -1);
    if (labels.isFive()) {
      return 1;
    } else if (labels.isFour()) {
      return 2;
    } else if (labels.isFullHouse()) {
      return 3;
    } else if (labels.isThree()) {
      return 4;
    } else if (labels.pairs() == 2) {
      return 5;
    } else if (labels.pairs() == 1) {
      return 6;
    }
    return 7;
  }

  static int getBestRank(List<String> cards) {
    final possibleCards = [
      'A',
      'K',
      'Q',
      'T',
      '9',
      '8',
      '7',
      '6',
      '5',
      '4',
      '3',
      '2'
    ];
    var bestRank = 7;
    for (String card in possibleCards) {
      List<String> labels = List.from(cards);
      labels = labels.map((e) => e == 'J' ? card : e).toList();
      int r = getRank(labels);
      if (r < bestRank) {
        bestRank = r;
      }
    }
    return bestRank;
  }

  @override
  int compareTo(other) {
    if (this.rank < other.rank) {
      return 1;
    } else if (this.rank > other.rank) {
      return -1;
    } else {
      for (int i = 0; i < this.hand.length; i++) {
        if (order.indexOf(this.hand[i]) < order.indexOf(other.hand[i])) {
          return 1;
        } else if (order.indexOf(this.hand[i]) > order.indexOf(other.hand[i])) {
          return -1;
        }
      }
      return 0;
    }
  }
}

extension PokerParsing on List<String> {
  bool isFive() {
    return this.every((element) => element == this[0]);
  }

  bool isFour() {
    return (this[0] == this[3] || this[1] == this[4]);
  }

  bool isFullHouse() {
    return (this[0] == this[2] && this[3] == this[4]) ||
        (this[0] == this[1] && this[2] == this[4]);
  }

  bool isThree() {
    return (this[0] == this[2] || this[1] == this[3] || this[2] == this[4]);
  }

  int pairs() {
    var pairs = 0;
    for (int i = 0; i < this.length - 1; i++) {
      if (this[i] == this[i + 1]) {
        pairs++;
      }
    }
    return pairs;
  }
}
