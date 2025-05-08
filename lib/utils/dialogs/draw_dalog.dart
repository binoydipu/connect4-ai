import 'package:flutter/material.dart';

Future<void> showDrawDialog({
  required BuildContext context,
}) {
    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("IT'S A TIE"),
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