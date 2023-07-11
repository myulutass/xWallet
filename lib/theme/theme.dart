import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

// Background Theme
Decoration? mainTheme() {
  return const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      stops: [0.33, 0.66, 0.99],
      colors: [
        Color.fromARGB(255, 105, 57, 250),
        Color.fromARGB(167, 215, 73, 240),
        Color.fromARGB(255, 230, 216, 255),
      ],
    ),
  );
}

// Border Theme
GradientBoxBorder gradientBorder() {
  return const GradientBoxBorder(
    gradient: LinearGradient(
      colors: [
        Color.fromARGB(255, 235, 235, 235),
        Color.fromARGB(255, 227, 6, 80),
        Color.fromARGB(159, 211, 13, 188)
      ],
    ),
    width: 2,
  );
}

// Icon Theme

class GradientIcon extends StatelessWidget {
  final Icon icon;
  final double size;

  const GradientIcon({
    super.key,
    required this.icon,
    this.size = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return const LinearGradient(
          colors: [
            Color.fromARGB(255, 245, 58, 167),
            Colors.white,
            Color.fromARGB(255, 174, 63, 210),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(bounds);
      },
      blendMode: BlendMode.srcATop,
      child: icon,
    );
  }
}

// Custom Animated Divider

Widget customDivider() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
    child: AnimateGradient(
      primaryColors: const [
        Color.fromARGB(116, 134, 0, 120),
        Color.fromARGB(255, 197, 3, 251),
        Color.fromARGB(255, 50, 8, 177),
        Color.fromARGB(139, 225, 8, 109),
      ],
      secondaryColors: const [
        Color.fromARGB(116, 134, 0, 120),
        Color.fromARGB(255, 197, 3, 251),
        Color.fromARGB(255, 50, 8, 177),
        Color.fromARGB(139, 225, 8, 109),
      ],
      primaryBegin: Alignment.centerLeft,
      primaryEnd: Alignment.centerRight,
      secondaryBegin: Alignment.centerLeft,
      secondaryEnd: Alignment.center,
      duration: const Duration(seconds: 2),
      child: const SizedBox(
        height: 3,
        width: double.infinity,
      ),
    ),
  );
}

class GradientTxt extends StatelessWidget {
  final double fontsize;
  final String text;
  const GradientTxt({
    super.key,
    required this.text,
    required this.fontsize,
  });

  @override
  Widget build(BuildContext context) {
    return GradientText(
      text,
      style: GoogleFonts.getFont(
        'Gruppo',
        fontWeight: FontWeight.w600,
        fontSize: fontsize,
      ),
      gradientType: GradientType.linear,
      radius: 1.4,
      colors: const [
        Color.fromARGB(255, 114, 180, 218),
        Color.fromARGB(255, 225, 148, 239),
      ],
    );
  }
}
