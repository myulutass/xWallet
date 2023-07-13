import 'dart:ui';

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xwallet/theme/glass.dart';

class BalanceView extends StatefulWidget {
  const BalanceView({super.key});

  @override
  State<BalanceView> createState() => _BalanceViewState();
}

class _BalanceViewState extends State<BalanceView> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 91,
        sigmaY: 70,
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
              shaderCallback: (bounds) => const LinearGradient(
                colors: [
                  Color.fromARGB(255, 150, 64, 196),
                  Color.fromARGB(255, 95, 90, 192),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0, 1.0],
              ).createShader(bounds),
              child: AnimatedFlipCounter(
                value: 8567,
                prefix: "\$",
                fractionDigits: 2,
                duration: const Duration(milliseconds: 700),
                textStyle: GoogleFonts.getFont(
                  'Nunito',
                  fontSize: 40,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
