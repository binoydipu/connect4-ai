import 'package:flutter/material.dart';

Future<bool> showResetConfirmationDialog({
  required BuildContext context,
}) {
  return showDialog<bool>(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Reset Game?'),
        content: const Text('Scores will be reset.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text('Reset'),
          ),
        ],
      );
    },
  ).then((value) => value ?? false);
}
