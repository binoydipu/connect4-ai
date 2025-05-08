import 'package:flutter/material.dart';

Future<void> showWinDialog({
  required String winner,
  required BuildContext context,
}) {
  return showDialog<void>(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('WINNER IS: $winner'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Play Again!'),
          ),
        ],
      );
    },
  );
}
