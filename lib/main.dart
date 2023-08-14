import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:xwallet/components/splash_screen.dart';
import 'package:xwallet/pages/sign_up.dart';
import 'package:xwallet/route/routes.dart' as route;
import 'package:country_picker/country_picker.dart';
import 'package:xwallet/theme/lightdark.dart';
import 'package:xwallet/theme/main_theme.dart';
import 'package:xwallet/theme/theme.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeProvider>(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return LightDark(
            child: Builder(
                builder: (context) => MaterialApp(
                      supportedLocales: const [
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
                      theme: MainTheme(themeProvider).getTheme(),
                      home: splashScreen(context),
                    )),
          );
        },
      ),
    );
  }
}
