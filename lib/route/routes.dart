import 'package:flutter/material.dart';
import 'package:xwallet/Pages/feedback.dart';
import 'package:xwallet/Pages/help_center.dart';
import 'package:xwallet/components/forgot_password.dart';
import 'package:xwallet/Pages/Home%20Page/home_page.dart';
import 'package:xwallet/Pages/login_Page.dart';
import 'package:xwallet/main.dart';

// Route Names
const String loginPage = '/login/';
const String registerPage = '/register/';
const String passwordPage = '/password/';
const String homePage = '/home/';
const String feedbackPage = '/feedback/';
const String helpPage = '/help/';

// Control our page route flow

Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case homePage:
      return MaterialPageRoute(
        builder: (context) => const HomePage(),
      );
    case passwordPage:
      return MaterialPageRoute(
        builder: (context) => const ForgotPassword(),
      );
    case loginPage:
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );
    case registerPage:
      return MaterialPageRoute(
        builder: (context) => const RegisterScreen(),
      );
    case feedbackPage:
      return MaterialPageRoute(
        builder: (context) => const FeedbackPage(),
      );
    case helpPage:
      return MaterialPageRoute(
        builder: (context) => const HelpCenter(),
      );

    default:
      throw ('This route name doesnt exist');
  }
}
