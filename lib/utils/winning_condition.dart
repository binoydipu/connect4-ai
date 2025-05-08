String? checkWinner({
  required List<String> board,
}) {
  const int rows = 6;
  const int cols = 7;

  String cell(int row, int col) =>
      (row >= 0 && row < rows && col >= 0 && col < cols)
          ? board[row * cols + col]
          : '';

  for (int row = 0; row < rows; row++) {
    for (int col = 0; col < cols; col++) {
      String current = cell(row, col);
      if (current == '') continue;

      // Horizontal (right)
      if (col + 3 < cols &&
          current == cell(row, col + 1) &&
          current == cell(row, col + 2) &&
          current == cell(row, col + 3)) {
        return current;
      }

      // Vertical (down)
      if (row + 3 < rows &&
          current == cell(row + 1, col) &&
          current == cell(row + 2, col) &&
          current == cell(row + 3, col)) {
        return current;
      }

      // Diagonal down-right
      if (row + 3 < rows && col + 3 < cols &&
          current == cell(row + 1, col + 1) &&
          current == cell(row + 2, col + 2) &&
          current == cell(row + 3, col + 3)) {
        return current;
      }

      // Diagonal down-left
      if (row + 3 < rows && col - 3 >= 0 &&
          current == cell(row + 1, col - 1) &&
          current == cell(row + 2, col - 2) &&
          current == cell(row + 3, col - 3)) {
        return current;
      }
    }
  }

  if (isBoardFull(board)) return 'tie';

  return null;
}

bool isBoardFull(List<String> board) => !board.contains('');

List<int> getWinningPositions(List<String> board) {
  // Check all possible directions: horizontal, vertical, diagonal (\), diagonal (/)
  for (int row = 0; row < 6; row++) {
    for (int col = 0; col < 7; col++) {
      if (board[row * 7 + col] != '') {
        String symbol = board[row * 7 + col];
        
        // Check horizontal (right)
        if (col + 3 < 7 &&
            board[row * 7 + col] == symbol &&
            board[row * 7 + col + 1] == symbol &&
            board[row * 7 + col + 2] == symbol &&
            board[row * 7 + col + 3] == symbol) {
          return [row * 7 + col, row * 7 + col + 1, row * 7 + col + 2, row * 7 + col + 3];
        }
        
        // Check vertical (down)
        if (row + 3 < 6 &&
            board[row * 7 + col] == symbol &&
            board[(row + 1) * 7 + col] == symbol &&
            board[(row + 2) * 7 + col] == symbol &&
            board[(row + 3) * 7 + col] == symbol) {
          return [row * 7 + col, (row + 1) * 7 + col, (row + 2) * 7 + col, (row + 3) * 7 + col];
        }
        
        // Check diagonal (\)
        if (row + 3 < 6 && col + 3 < 7 &&
            board[row * 7 + col] == symbol &&
            board[(row + 1) * 7 + col + 1] == symbol &&
            board[(row + 2) * 7 + col + 2] == symbol &&
            board[(row + 3) * 7 + col + 3] == symbol) {
          return [row * 7 + col, (row + 1) * 7 + col + 1, (row + 2) * 7 + col + 2, (row + 3) * 7 + col + 3];
        }

        // Check diagonal (/)
        if (row - 3 >= 0 && col + 3 < 7 &&
            board[row * 7 + col] == symbol &&
            board[(row - 1) * 7 + col + 1] == symbol &&
            board[(row - 2) * 7 + col + 2] == symbol &&
            board[(row - 3) * 7 + col + 3] == symbol) {
          return [row * 7 + col, (row - 1) * 7 + col + 1, (row - 2) * 7 + col + 2, (row - 3) * 7 + col + 3];
        }
      }
    }
  }
  
  return []; // No winning positions
}
