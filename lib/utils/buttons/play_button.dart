// import 'package:flutter/material.dart';
// import 'package:tictactoeai/views/home_page.dart';

// class PlayButton extends StatefulWidget {
//   const PlayButton({super.key});

//   @override
//   State<PlayButton> createState() => _PlayButtonState();
// }

// class _PlayButtonState extends State<PlayButton> {
//   bool _isPressed = false;

//   void _onTapDown(TapDownDetails details) {
//     setState(() => _isPressed = true);
//   }

//   void _onTapUp(TapUpDetails details) {
//     setState(() => _isPressed = false);
//   }

//   void _onTapCancel() {
//     setState(() => _isPressed = false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTapDown: _onTapDown,
//       onTapUp: (details) {
//         _onTapUp(details);
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const HomePage()),
//         );
//       },
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const HomePage()),
//         );
//       },
//       onTapCancel: _onTapCancel,
//       child: AnimatedScale(
//         scale: _isPressed ? 0.96 : 1.0,
//         duration: const Duration(milliseconds: 100),
//         curve: Curves.easeInOut,
//         child: Material(
//           color: Colors.transparent,
//           child: InkWell(
//             borderRadius: BorderRadius.circular(12),
//             splashColor: Colors.white.withOpacity(0.2),
//             onTap: () {}, // Required for splash to work, even if empty
//             child: Container(
//               width: 250,
//               height: 70,
//               decoration: BoxDecoration(
//                 gradient: const LinearGradient(
//                   colors: [Color(0xFF00E676), Color(0xFF18FFFF)],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 borderRadius: BorderRadius.circular(12),
//                 boxShadow: [
//                   BoxShadow(
//                     color: const Color(0xFF00E676).withOpacity(0.5),
//                     blurRadius: 10,
//                     spreadRadius: 2,
//                   ),
//                 ],
//               ),
//               child: const Center(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Icons.play_arrow, color: Colors.black),
//                     SizedBox(width: 10),
//                     Text(
//                       'PLAY GAME',
//                       style: TextStyle(
//                         fontFamily: 'PressStart2P',
//                         fontSize: 18,
//                         color: Colors.black,
//                         letterSpacing: 2,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
