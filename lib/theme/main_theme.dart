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
            fixedSize: MaterialStateProperty.all<Size>(
              const Size(50, 60),
            ),
            overlayColor: MaterialStateProperty.all<Color>(
              const Color.fromRGBO(95, 15, 255, 1),
            ),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return const Color.fromARGB(48, 22, 1,
                      49); // Semi-transparent when the button is disabled
                }
                return const Color.fromARGB(223, 80, 6, 177); // Default color
              },
            ),
            foregroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return Colors.white; // Text color when the button is disabled
                }
                return Colors.white; // Default color
              },
            ),
            side: MaterialStateProperty.resolveWith<BorderSide>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return const BorderSide(
                      color: Color.fromARGB(187, 208, 207, 207),
                      width: 1.0); // Border when the button is disabled
                }
                return BorderSide.none; // Default border
              },
            ),
          ),
        ),
        scaffoldBackgroundColor: Colors.transparent,
        primaryColor: Colors.white);
  }
}

secondaryButtonTheme(BuildContext context) {
  Size screenSize = MediaQuery.of(context).size; // Add this line

  return ButtonStyle(
    fixedSize: MaterialStateProperty.all<Size>(
      Size(
        MediaQuery.of(context).size.width * .4,
        MediaQuery.of(context).size.width * .1,
      ),
    ),
    backgroundColor: MaterialStateProperty.all<Color>(
      const Color.fromARGB(209, 80, 3, 135),
    ),
    overlayColor: MaterialStateProperty.all<Color>(
      const Color.fromARGB(209, 128, 6, 215),
    ),
  );
}
