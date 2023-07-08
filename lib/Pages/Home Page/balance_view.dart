import 'dart:ui';

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';

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
            color: const Color.fromARGB(34, 32, 33, 33),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const AnimatedFlipCounter(
            value: 23,
            prefix: "\$",
            fractionDigits: 2,
            duration: Duration(milliseconds: 700),
            textStyle: TextStyle(
              fontSize: 35,
            ),
          ),
        ),
      ),
    );
  }
}
