import 'package:avatar_glow/avatar_glow.dart';
import 'package:connect4/constants/colors.dart';
import 'package:connect4/constants/const_texts.dart';
import 'package:connect4/views/home_page.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: backgroundDark,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 120.0),
                child: Text(
                  gameTitle,
                  style: TextStyle(
                    fontFamily: 'PressStart2P',
                    fontSize: 24,
                    color: textPrimary,
                    shadows: [
                      Shadow(
                        blurRadius: 24.0,
                        color: glow,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                ),
              ),
              AvatarGlow(
                duration: const Duration(seconds: 2),
                glowColor: logoCircle,
                repeat: true,
                startDelay: const Duration(seconds: 1),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(style: BorderStyle.none),
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    backgroundColor: backgroundDark,
                    radius: 90.0,
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                ),
                child: Container(
                  width: 250,
                  height: 70,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF00E676), Color(0xFF18FFFF)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF00E676).withOpacity(0.5),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.play_arrow, color: Colors.black),
                        SizedBox(width: 10),
                        Text(
                          'PLAY GAME',
                          style: TextStyle(
                            fontFamily: 'PressStart2P',
                            fontSize: 18,
                            color: Colors.black,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Footer text
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Column(
                  children: [
                    Text(
                      copyrightText,
                      style: TextStyle(
                        fontFamily: 'PressStart2P',
                        fontSize: 12,
                        color: Colors.blueGrey[400],
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'v1.0.0',
                      style: TextStyle(
                        fontFamily: 'PressStart2P',
                        fontSize: 10,
                        color: Colors.blueGrey[400],
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
