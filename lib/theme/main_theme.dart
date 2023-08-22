import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'lightdark.dart';

class MainTheme {
  final ThemeProvider themeProvider;

  MainTheme(this.themeProvider);

  ThemeData getTheme() {
    final isLightDark = themeProvider.isLightDark;
    final buttonColor = isLightDark
        //PRIMARY BUTTON COLOR
        ? const Color.fromARGB(223, 80, 6, 177) // DARK
        : const Color.fromARGB(255, 173, 114, 255); // LIGHT
    final buttonAcvtiveColor = isLightDark
        //PRIMARY BUTTON PUSH COLOR

        ? const Color.fromRGBO(95, 15, 255, 1) // DARK
        : const Color.fromARGB(255, 142, 69, 244); // LIGHT

    final disabledButtonBorderColor = isLightDark
        ? const BorderSide(
            color: Color.fromARGB(164, 208, 207, 207), width: 0.5)
        : BorderSide.none;

    return ThemeData(
      scaffoldBackgroundColor: Colors.transparent,
      appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromARGB(15, 0, 0, 0),
      ),
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
            buttonAcvtiveColor,
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (states) {
              if (states.contains(MaterialState.disabled)) {
                return const Color.fromARGB(34, 0, 0, 0);
              }
              return buttonColor;
            },
          ),
          side: MaterialStateProperty.resolveWith<BorderSide>(
            (states) {
              if (states.contains(MaterialState.disabled)) {
                return disabledButtonBorderColor;
              }
              return BorderSide.none; // Default border
            },
          ),
        ),
      ),
      brightness: isLightDark ? Brightness.light : Brightness.dark,
    );
  }
}

ButtonStyle secondaryButtonTheme(BuildContext context) {
  // SECONDARY BUTTON THEME
  Size screenSize = MediaQuery.of(context).size;

  final theme = Theme.of(context);
  final isDarkMode = theme.brightness == Brightness.dark;

  return ButtonStyle(
    fixedSize: MaterialStateProperty.all<Size>(
      Size(
        MediaQuery.of(context).size.width * .4,
        MediaQuery.of(context).size.width * .1,
      ),
    ),
    backgroundColor: MaterialStateProperty.all<Color>(
      isDarkMode
          ? const Color.fromARGB(175, 170, 99, 232)
          : const Color.fromARGB(
              209, 80, 3, 135), // Set the background color based on theme mode
    ),
    overlayColor: MaterialStateProperty.all<Color>(
      isDarkMode
          ? const Color.fromARGB(174, 142, 30, 239)
          : const Color.fromARGB(
              209, 128, 6, 215), // Set the overlay color based on theme mode
    ),
    foregroundColor: MaterialStateProperty.all<Color>(
      isDarkMode
          ? const Color.fromARGB(255, 243, 238, 255)
          : Colors.white, // Set the text color based on theme mode
    ),
  );
}
