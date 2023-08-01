import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:xwallet/Pages/sign_up.dart';
import 'package:xwallet/route/routes.dart' as route;
import 'package:country_picker/country_picker.dart';
import 'package:xwallet/theme/lightdark.dart';
import 'package:xwallet/theme/main_theme.dart';
import 'package:xwallet/theme/theme.dart';

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
        home: const RegisterScreen(),
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
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: GradientTxt(
                fontsize: 60,
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
