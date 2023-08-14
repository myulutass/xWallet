import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import '../pages/sign_up.dart';
import '../theme/theme.dart';

AnimatedSplashScreen splashScreen(BuildContext context) {
  return AnimatedSplashScreen(
    // SPLASH SCREEN
    splash: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'lib/assets/AppIcon.png',
          width: MediaQuery.of(context).size.width * .35,
          filterQuality: FilterQuality.high,
        ),
        SizedBox(height: MediaQuery.of(context).size.width * .05),
        const GradientTxt(
          text: 'xWallet',
          fontsize: 18,
        ),
      ],
    ),
    nextScreen: const RegisterScreen(),
    backgroundColor: const Color.fromARGB(107, 0, 0, 0),
    splashTransition: SplashTransition.fadeTransition,
    splashIconSize: double.infinity,
  );
}
