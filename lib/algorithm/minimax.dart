import 'dart:math';

import 'package:connect4/algorithm/evaluation.dart';
import 'package:connect4/constants/game_constants.dart';
import 'package:connect4/utils/get_valid_row.dart';
import 'package:connect4/utils/winning_condition.dart';

Future<int> findBestMove({
  required List<String> board,
}) {
  int bestScore = -infinity;
  int bestMove = -1;
  for (int col = 0; col < 7; col++) {
    int row = getFirstEmptyRowInColumn(board, col);
    if (row != -1) {
      board[row * 7 + col] = aiSymbol; // Try the move
      int score = minimax(board, false, 0, -infinity, infinity);
      board[row * 7 + col] = ''; // Undo the move

      if (score > bestScore) {
        bestScore = score;
        bestMove = row * 7 + col; // Store the best move
      }
    }
  }
  return Future.value(bestMove);
}

int minimax(List<String> board, bool isMaxTurn, int depth, int alpha, int beta) {
  String? result = checkWinner(board: board);
  if (result != null || depth >= maxDepth) {
    return evaluate(
      result: result,
      depth: depth,
      board: board,
    );
  }

  if (isMaxTurn) {
    int bestScore = -infinity;
    for (int col = 0; col < 7; col++) {
      int row = getFirstEmptyRowInColumn(board, col);
      if (row != -1) {
        board[row * 7 + col] = aiSymbol;
        int score = minimax(board, false, depth + 1, alpha, beta);
        bestScore = max(bestScore, score);
        board[row * 7 + col] = ''; // Undo move

        alpha = max(alpha, bestScore);
        if (beta <= alpha) {
          break; // Beta cut-off
        }
      }
    }
    return bestScore;
  } else {
    int bestScore = infinity;
    for (int col = 0; col < 7; col++) {
      int row = getFirstEmptyRowInColumn(board, col);
      if (row != -1) {
        board[row * 7 + col] = playerSymbol;
        int score = minimax(board, true, depth + 1, alpha, beta);
        bestScore = min(bestScore, score);
        board[row * 7 + col] = ''; // Undo move

        beta = min(beta, bestScore);
        if (beta <= alpha) {
          break; // Alpha cut-off
        }
      }
    }
    return bestScore;
  }
}
