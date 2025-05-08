import 'package:connect4/algorithm/minimax.dart';
import 'package:connect4/constants/colors.dart';
import 'package:connect4/constants/const_texts.dart';
import 'package:connect4/constants/game_constants.dart';
import 'package:connect4/utils/buttons/back_button.dart';
import 'package:connect4/utils/buttons/control_button.dart';
import 'package:connect4/utils/dialogs/reset_dialog.dart';
import 'package:connect4/utils/get_valid_row.dart';
import 'package:connect4/utils/winning_condition.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late bool isRedTurn;
  late List<String> board;
  late final TextStyle textStyle;
  late int scorePlayer;
  late int scoreAI;
  late bool isAiThinking;
  late bool isLocked;
  late String? isGameOver;
  late List<int> winningPositions;

  // audio
  late bool playSounds;
  late double soundVolume;

  @override
  void initState() {
    isRedTurn = true;
    board = List.filled(boardSize, '');
    textStyle = const TextStyle(color: Colors.white, fontSize: 30);
    scorePlayer = 0;
    scoreAI = 0;
    winningPositions = [];
    isAiThinking = false;
    isLocked = false;
    isGameOver = null;
    playSounds = true;
    soundVolume = 1.0;
    _resetGame();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundDark,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          gameTitle,
          style: TextStyle(
            fontFamily: 'PressStart2P',
            fontSize: 14,
            color: textPrimary,
            shadows: [
              Shadow(
                blurRadius: 7.0,
                color: glow,
                offset: Offset(0, 0),
              ),
            ],
          ),
        ),
        leading: const GameBackButton(),
      ),
      backgroundColor: backgroundDark,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              backgroundDark,
              backgroundDarkAc,
            ],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Score Board
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: backgroundMedium.withOpacity(0.7),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: border, width: 2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildPlayerScore('Human', scorePlayer, playerRed),
                  Container(
                    height: 50,
                    width: 2,
                    color: border,
                  ),
                  _buildPlayerScore('AI', scoreAI, playerYellow),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Game Board
            Expanded(
              flex: 3,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: shadow,
                      blurRadius: 10,
                      spreadRadius: 2,
                    )
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: boardSize,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          if (!isLocked &&
                              winningPositions.isEmpty &&
                              !isAiThinking) {
                            _tapped(index);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          child: AspectRatio(
                            aspectRatio: 1, // Make it square
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: winningPositions.contains(index)
                                      ? winCellBorder
                                      : cellBorder,
                                  width: 2.5,
                                ),
                                color: board[index] == playerSymbol
                                    ? playerRed
                                    : board[index] == aiSymbol
                                        ? playerYellow
                                        : backgroundMedium,
                                boxShadow: const [
                                  BoxShadow(
                                    color: shadow,
                                    blurRadius: 8,
                                    spreadRadius: 1,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            _aiThinkingWidget(),
            _gameResultMessage(isGameOver),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Show new game only when current game is over
                  if (isGameOver != null)
                    buildControlButton(
                      icon: Icons.refresh,
                      label: 'NEW GAME',
                      color: blueAccent, // Light blue
                      onPressed: () => _resetGame(),
                    ),
                  const SizedBox(height: 8),
                  buildControlButton(
                    icon: Icons.restart_alt,
                    label: 'RESET GAME',
                    color: playerYellow, // Amber
                    onPressed: () async {
                      bool confirmed =
                          await showResetConfirmationDialog(context: context);
                      scorePlayer = 0;
                      scoreAI = 0;
                      if (confirmed) {
                        _resetGame();
                      }
                    },
                  ),
                ],
              ),
            ),
            // Footer
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                copyrightText,
                style: TextStyle(
                  fontFamily: 'PressStart2P',
                  fontSize: 10,
                  color: textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerScore(String title, int score, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'PressStart2P',
            fontSize: 10,
            color: textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(0.2),
            border: Border.all(color: color, width: 2),
          ),
          child: Text(
            '$score',
            style: TextStyle(
              fontFamily: 'PressStart2P',
              fontSize: 16,
              color: color,
            ),
          ),
        ),
      ],
    );
  }

  void _tapped(int index) async {
    if (isLocked) return; // still animation showing

    isLocked = true; // LOCK
    int col = index % 7;
    int row = getFirstEmptyRowInColumn(board, col);
    if (row == -1) {
      isLocked = false;
      return; // If the column is full, do nothing
    }

    await _showDropAnimation(col, playerSymbol);
    setState(() {
      board[row * 7 + col] = playerSymbol;
      isAiThinking = true;
    });

    bool gameover = await _isGameOver();
    if (gameover) {
      setState(() {
        isAiThinking = false;
      });
      isLocked = false;
      return;
    }

    await Future.delayed(const Duration(milliseconds: 200));

    if (isBoardFull(board)) {
      _isGameOver();
      setState(() {
        isAiThinking = false;
      });
      isLocked = false;
      return;
    }

    int aiMove = await findBestMove(board: board);
    setState(() {
      isAiThinking = false;
    });

    await _showDropAnimation(aiMove % 7, aiSymbol);
    setState(() {
      isAiThinking = false;
      board[aiMove] = aiSymbol;
    });

    _isGameOver();
    isLocked = false; // UNLOCK
  }

  Future<void> _showDropAnimation(int col, String who) async {
    for (int r = 0; r < 6; r++) {
      int index = r * 7 + col;
      if (r > 0) {
        board[(r - 1) * 7 + col] = ''; // clear prev cell
      }
      board[index] = who;
      setState(() {}); // Trigger repaint
      await Future.delayed(const Duration(milliseconds: 200));

      // Stop if the cell below is already occupied (safety check)
      if (r + 1 == 6 || board[(r + 1) * 7 + col] != '') {
        if (playSounds) {
          FlameAudio.play('drop.wav', volume: soundVolume);
        }
        break;
      }
    }
    // Wait briefly on final cell
    await Future.delayed(const Duration(milliseconds: 200));
    setState(() {});
  }

  Widget _aiThinkingWidget() {
    return isAiThinking
        ? const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(
                    FontAwesomeIcons.robot,
                    size: 30,
                    color: playerYellow,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  "AI IS THINKING...",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'PressStart2P',
                    fontSize: 12,
                    color: playerYellow,
                    letterSpacing: 1,
                    shadows: [
                      Shadow(
                        blurRadius: 8.0,
                        color: glow,
                        offset: Offset(0, 0),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        : const SizedBox.shrink();
  }

  Widget _gameResultMessage(String? winner) {
    if (winner == null) return const SizedBox.shrink();
    String message;
    IconData icon;
    Color color;

    if (winner != 'tie') {
      winner = winner == playerSymbol ? 'Human' : 'AI';
      message = 'Winner is: $winner';
      icon = FontAwesomeIcons.trophy;
      color = winner == playerSymbol ? playerRed : playerYellow;
    } else {
      message = "It's a Tie!";
      icon = FontAwesomeIcons.handshake;
      color = blueAccent;
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(
              icon,
              size: 30,
              color: color,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            message,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'PressStart2P',
              fontSize: 12,
              color: color,
              letterSpacing: 1,
              shadows: const [
                Shadow(
                  blurRadius: 8.0,
                  color: glow,
                  offset: Offset(0, 0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> _isGameOver() async {
    String? result = checkWinner(board: board);
    if (result != null) {
      isGameOver = result;
      if (result == 'tie') {
        // await showDrawDialog(context: context);
      } else {
        result == playerSymbol ? scorePlayer++ : scoreAI++;
        // await showWinDialog(winner: result, context: context);
        winningPositions = getWinningPositions(board);
      }
      if (playSounds) {
        FlameAudio.play('win.wav', volume: soundVolume);
      }
      return true;
    }
    return false;
  }

  void _resetGame() {
    setState(() {
      isRedTurn = true;
      winningPositions = [];
      isGameOver = null;
      board = List.filled(boardSize, '');
    });
  }
}
