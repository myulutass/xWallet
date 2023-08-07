import 'dart:ui';

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:xwallet/theme/glass.dart';

class BalanceView extends StatefulWidget {
  final int value; // Add a parameter to make the value configurable

  const BalanceView({Key? key, required this.value}) : super(key: key);

  @override
  State<BalanceView> createState() => _BalanceViewState();
}

class _BalanceViewState extends State<BalanceView> {
  static const double blurSigmaX = 91.0;
  static const double blurSigmaY = 70.0;
  static const List<Color> gradienLightColors = [
    Color.fromARGB(255, 224, 40, 77),
    Color.fromARGB(255, 114, 107, 245),
  ];
  static const List<Color> gradienDarkColors = [
    Color.fromARGB(255, 104, 64, 196),
    Color.fromARGB(255, 95, 90, 192),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: blurSigmaX,
        sigmaY: blurSigmaY,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * .03,
          top: MediaQuery.of(context).size.height * .03,
        ),
        child: GlassMorphism(
          start: 0.4,
          end: 0.5,
          child: Container(
            height: MediaQuery.of(context).size.height * .10,
            width: MediaQuery.of(context).size.width * .70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: isDarkMode ? gradienLightColors : gradienDarkColors,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.0, 1.0],
              ).createShader(bounds),
              child: AnimatedFlipCounter(
                value: widget.value, // Use the provided value
                prefix: "\$",
                fractionDigits: 2,
                duration: const Duration(milliseconds: 700),
                textStyle: _flipCounterTextStyle,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // TextStyle for AnimatedFlipCounter
  static const TextStyle _flipCounterTextStyle = TextStyle(
    fontFamily: 'Nunito',
    fontSize: 40,
    fontWeight: FontWeight.w400,
  );
}
