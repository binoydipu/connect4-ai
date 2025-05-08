  /// Finds the first available row in a given column from the bottom
  int getFirstEmptyRowInColumn(List<String> board, int col) {
    for (int row = 5; row >= 0; row--) {  // Start from the bottom row
      if (board[row * 7 + col] == '') {
        return row;
      }
    }
    return -1; // If the column is full
  }