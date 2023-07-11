import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xwallet/Pages/sign_up.dart';
import 'package:xwallet/route/routes.dart' as route;
import 'package:country_picker/country_picker.dart';
import 'package:xwallet/theme/theme.dart';

void main() {
  runApp(const RegisterScreen());
}

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: const [
        Locale('el'),
        Locale('en'),
      ],
      localizationsDelegates: const [
        CountryLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      onGenerateRoute: route.controller,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          snackBarTheme: const SnackBarThemeData(
            backgroundColor: Color.fromARGB(121, 0, 0, 0),
          ),
          primaryTextTheme: GoogleFonts.nunitoTextTheme(
            Theme.of(context).textTheme.apply(
                  displayColor: Colors.white,
                  bodyColor: Colors.white,
                ),
          ),
          textTheme: GoogleFonts.nunitoTextTheme(
            Theme.of(context).textTheme.apply(
                  displayColor: Colors.white,
                  bodyColor: Colors.white,
                ),
          ).copyWith(
            bodyLarge: const TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
            bodyMedium: const TextStyle(
              fontWeight: FontWeight.w400,
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
          primaryColor: Colors.white),
      home: Container(
        decoration: mainTheme(),
        child: const Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: GradientTxt(
                    fontsize: 60,
                    text:
                        'Welcome to the world\'s coolest wallet app, Let\'s get you started!',
                  ),
                ),
                SignUp(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
