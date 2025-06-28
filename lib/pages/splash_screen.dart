import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:klasmeyt/pages/home_page.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return AnimatedSplashScreen(
      splash: Center(
        child: Lottie.asset(
          'assets/animatedSplash.json',
          width: 500,
          height: 500,
          fit: BoxFit.none,
        ),
      ),
      duration: 2500,
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: backgroundColor,
      nextScreen: const HomePage(),
    );
  }
}
