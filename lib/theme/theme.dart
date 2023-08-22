import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

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
  //HEADER GRADIENT TEXT THEME
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
        letterSpacing: -1.2,
        wordSpacing: 3,
      ),
      gradientType: GradientType.linear,
      textAlign: TextAlign.center,
      radius: 1.4,
      colors: const [
        Color.fromARGB(255, 114, 180, 218),
        Color.fromARGB(255, 225, 148, 239),
      ],
    );
  }
}

InputDecoration textFieldTheme(
    String labelText, Icon icon, BuildContext context) {
  final theme = Theme.of(context);
  final isDarkMode = theme.brightness == Brightness.dark;
  return InputDecoration(
    //TEXT INPUT THEME
    prefixIcon: GradientIcon(icon: icon),
    labelText: labelText,
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7), borderSide: BorderSide.none),
    labelStyle: const TextStyle(
        color: Color.fromARGB(255, 232, 228, 228),
        fontWeight: FontWeight.w100,
        fontSize: 12),
    filled: true,
    fillColor: isDarkMode
        ? const Color.fromARGB(255, 232, 117, 207)
        : const Color.fromARGB(158, 69, 33, 145),
  );
}

TextStyle subText() {
  return const TextStyle(fontWeight: FontWeight.w300, letterSpacing: 0.6);
}
