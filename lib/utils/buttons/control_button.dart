import 'package:connect4/constants/colors.dart';
import 'package:flutter/material.dart';

Widget buildControlButton({
  required IconData icon,
  required String label,
  required Color color,
  required VoidCallback onPressed,
}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: backgroundMedium,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.5), width: 2),
        boxShadow: const [
          BoxShadow(
            color: shadow,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'PressStart2P',
              fontSize: 10,
              color: color,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    ),
  );
}
