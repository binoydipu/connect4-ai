import 'package:flutter/material.dart';

class GameBackButton extends StatelessWidget {
  const GameBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.blueGrey[800],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.blueGrey[400]!,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Icon(
          Icons.arrow_back,
          size: 22,
          color: Colors.white,
        ),
      ),
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}

