import 'package:flutter/material.dart';

class GameActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color color;
  final String tooltip;

  const GameActionButton({
    required this.icon,
    required this.onPressed,
    required this.color,
    required this.tooltip,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: Colors.blueGrey[800],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: color.withOpacity(0.5),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 4,
                offset: const Offset(0, 2))
          ],
        ),
        child: IconButton(
          icon: Icon(icon, size: 22),
          color: color,
          splashColor: color.withOpacity(0.3),
          highlightColor: Colors.transparent,
          onPressed: onPressed,
        ),
      ),
    );
  }
}