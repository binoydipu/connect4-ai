const boardSize = 42;
const infinity = 99999999;
const maxScore = 100000;
const maxDepth = 4;
const loss = 1;
const aiSymbol = 'Y';
const playerSymbol = 'R';

const Map<String, int> scores = {
  'Y': maxScore,
  'R': -maxScore,
  'tie': 0,
};