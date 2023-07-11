import 'dart:ui';

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        child: Container(
          height: MediaQuery.of(context).size.height * .10,
          width: MediaQuery.of(context).size.width * .70,
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(255, 251, 251, 0.071),
                offset: Offset(0, 3),
                blurRadius: 3,
              ),
            ],
            gradient: LinearGradient(colors: [
              const Color.fromARGB(255, 189, 184, 184).withOpacity(0.5),
              const Color.fromARGB(255, 247, 237, 237).withOpacity(0.6)
            ], stops: const [
              0.0,
              1.0
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [
                Color.fromARGB(255, 131, 6, 198),
                Color.fromARGB(255, 83, 76, 205),
                Color.fromARGB(255, 166, 163, 208),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.2, 0.6, 1.0],
            ).createShader(bounds),
            child: AnimatedFlipCounter(
              value: 8567,
              prefix: "\$",
              fractionDigits: 2,
              duration: const Duration(milliseconds: 700),
              textStyle: GoogleFonts.getFont(
                'Nunito',
                fontSize: 40,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
