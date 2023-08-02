import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:xwallet/Pages/sign_up.dart';
import 'package:xwallet/route/routes.dart' as route;
import 'package:country_picker/country_picker.dart';
import 'package:xwallet/theme/lightdark.dart';
import 'package:xwallet/theme/main_theme.dart';
import 'package:xwallet/theme/theme.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider<ThemeProvider>(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LightDark(
      child: MaterialApp(
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
        theme: MainTheme().getTheme(),
        home: AnimatedSplashScreen(
          // SPLASH SCREEN
          splash: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: const AssetImage('lib/assets/AppIcon.png'),
                width: MediaQuery.of(context).size.width * .35,
                filterQuality: FilterQuality.high,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * .05,
              ),
              const GradientTxt(
                text: 'xWallet',
                fontsize: 18,
              ),
            ],
          ),
          nextScreen: const RegisterScreen(),
          backgroundColor: const Color.fromARGB(255, 25, 24, 24),
          splashTransition: SplashTransition.fadeTransition,
          splashIconSize: double.infinity,
        ),
      ),
    );
  }
}

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: GradientTxt(
                fontsize: 50,
                text:
                    'Welcome to the world\'s coolest wallet app, Let\'s get you started!',
              ),
            ),
            const SignUp(),
            SizedBox(
              height: MediaQuery.of(context).size.width * .15,
            )
          ],
        ),
      ),
    );
  }
}
