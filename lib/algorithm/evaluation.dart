import 'dart:math';
import 'package:connect4/constants/game_constants.dart';

/// Evaluates the score for a certain depth (moves).
/// returns best score for smaller depth, i.e. min number of moves
int evaluate({
  required String? result,
  required int depth,
  required List<String> board,
}) {
  int score = 0;
  if (result != null) {
    score = scores[result]!;
  } else {
    // Depth limit reached. Get current board score using heuristic
    score = evaluateBoard(board);
  }

  if (score == 0) {
    return 0;
  } else if (score < 0) {
    return score + (depth * loss);
  } else {
    return score - (depth * loss);
  }
}

/// Evaluates currect board score in favour of AI
int evaluateBoard(List<String> board) {
  const winLength = 4;
  int score = 0;

  // Score lines in rows, columns, and diagonals
  for (int row = 0; row < 6; row++) {
    for (int col = 0; col < 7; col++) {
      score += _evaluateLine(board, row, col, 1, 0, winLength); 
      score += _evaluateLine(board, row, col, 0, 1, winLength); 
      score += _evaluateLine(board, row, col, 1, 1, winLength); 
      score += _evaluateLine(board, row, col, 1, -1, winLength); 
    }
  }
  // If in a line, Same player has move- then score
  // 1 in a row → 10
  // 2 in a row → 100
  // 3 in a row → 1000
  // 4 in a row = win
  return score;
}

int _evaluateLine(List<String> board, int row, int col, int dRow,
    int dCol, int winLength) {
  int aiCount = 0;
  int playerCount = 0;

  for (int i = 0; i < winLength; i++) {
    int r = row + i * dRow;
    int c = col + i * dCol;

    if (r < 0 || r >= 6 || c < 0 || c >= 7) return 0;

    String cell = board[r * 7 + c];
    if (cell == aiSymbol) {
      aiCount++;
    } else if (cell == playerSymbol) {
      playerCount++;
    }
  }

  if (aiCount > 0 && playerCount > 0) return 0; // Blocked line

  if (aiCount == winLength) return maxScore;
  if (playerCount == winLength) return -maxScore;

  // Heuristic scoring
  if (aiCount > 0) return pow(10, aiCount).toInt();
  if (playerCount > 0) return -pow(10, playerCount).toInt();

  // 1 in a row → 10
  // 2 in a row → 100
  // 3 in a row → 1000
  // 4 in a row = win

  return 0;
}
