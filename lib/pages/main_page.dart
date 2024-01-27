import 'package:bordered_text/bordered_text.dart';
import 'package:firebase_authentication/auth.dart';
import 'package:firebase_authentication/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:metaballs/metaballs.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late Size screenSize;

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 34, 34, 34),
      body: Metaballs(
        color: const Color.fromARGB(255, 66, 133, 244),
        effect: MetaballsEffect.follow(
          growthFactor: 1,
          smoothing: 1,
          radius: 0.5,
        ),
        gradient: const LinearGradient(colors: [
          Color.fromARGB(255, 60, 105, 255),
          Color.fromARGB(255, 120, 255, 255),
        ], begin: Alignment.bottomRight, end: Alignment.topLeft),
        metaballs: 40,
        animationDuration: const Duration(milliseconds: 200),
        speedMultiplier: 2,
        bounceStiffness: 3,
        minBallRadius: 15,
        maxBallRadius: 40,
        glowRadius: 0.7,
        glowIntensity: 0.6,
        child: Center(
          child: SizedBox(
            height: screenSize.height * 0.18,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BorderedText(
                  strokeColor: Colors.black,
                  child: const Text(
                    "Firebase Authentication test",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                BorderedText(
                  strokeColor: Colors.black,
                  child: const Text(
                    "Helloworld",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: openSignInPage,
                  child: BorderedText(
                    strokeWidth: 1.5,
                    strokeColor: Colors.black,
                    child: const Text(
                      "◀ Back to login screen (sign off)",
                      style: TextStyle(
                        color: Color.fromARGB(255, 81, 252, 252),
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void openSignInPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );

    Auth.signOut();
  }
}
