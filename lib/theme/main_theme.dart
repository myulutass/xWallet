import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainTheme {
  ThemeData getTheme() {
    return ThemeData(
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: Color.fromARGB(121, 0, 0, 0),
        ),
        primaryTextTheme: GoogleFonts.nunitoTextTheme(
          ThemeData().textTheme.apply(
                displayColor: Colors.white,
                bodyColor: Colors.white,
              ),
        ),
        textTheme: GoogleFonts.ptSansTextTheme(
          ThemeData().textTheme.apply(
                displayColor: Colors.white,
                bodyColor: Colors.white,
              ),
        ).copyWith(
          bodyLarge: const TextStyle(
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
          bodyMedium: const TextStyle(
            color: Colors.white,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            maximumSize: MaterialStateProperty.all<Size>(
              const Size(80, 80),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(
              Colors.transparent,
            ),
            overlayColor: MaterialStateProperty.all<Color>(
              const Color.fromARGB(161, 236, 95, 224),
            ),
          ),
        ),
        scaffoldBackgroundColor: Colors.transparent,
        primaryColor: Colors.white);
  }
}
