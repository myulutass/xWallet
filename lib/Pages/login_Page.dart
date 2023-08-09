import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:xwallet/components/forgot_password.dart';
import 'package:xwallet/route/routes.dart' as route;
import 'package:xwallet/theme/glass.dart';
import 'package:xwallet/theme/main_theme.dart';
import 'package:xwallet/theme/theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  SizedBox emptySpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.width * .05,
    );
  }

  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Do something with the form data, such as logging in the user
      // ...
      // After successful login, navigate to the home screen
      Navigator.pushReplacementNamed(context, '/home/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(
                MediaQuery.of(context).size.width * .1,
              ),
              child: const GradientTxt(
                text: 'Welcome back!',
                fontsize: 55,
              ),
            ),
            GlassMorphism(
              start: 0.4,
              end: 0.6,
              child: Container(
                height: MediaQuery.of(context).size.height * .65,
                width: MediaQuery.of(context).size.width * .85,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: EdgeInsets.all(
                  MediaQuery.of(context).size.width * .05,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      const Text(
                        'Log In',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          letterSpacing: -1,
                          decoration: TextDecoration.underline,
                          decorationColor: Color.fromARGB(180, 255, 255, 255),
                        ),
                      ),

                      emptySpace(),
                      // EMAIL ENTRY
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: _email,
                        enableSuggestions: false,
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration:
                            textFieldTheme('Email', const LineIcon.at()),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an email address';
                          }
                          // Add more email validation rules if needed
                          return null;
                        },
                      ),
                      emptySpace(),

                      // PASSWORD ENTRY
                      TextFormField(
                        textInputAction: TextInputAction.done,
                        controller: _password,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration:
                            textFieldTheme('Password', const LineIcon.key()),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          }
                          // Add more password validation rules if needed
                          return null;
                        },
                      ),
                      emptySpace(),

                      // Forgot Password Button

                      TextButton(
                        onPressed: () => passwordReset(context),
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                      emptySpace(),

                      ElevatedButton(
                        //LOGIN BUTTON
                        onPressed: () =>
                            Navigator.pushNamed(context, route.homePage),
                        child: const Text(
                          'Login',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      emptySpace(),

                      ElevatedButton(
                        //GO REGISTER BUTTON
                        onPressed: () =>
                            Navigator.pushNamed(context, route.registerPage),
                        style: secondaryButtonTheme(context),
                        child: const Text(
                          'Don\'t  have an account? click here to register',
                          style: TextStyle(
                              fontSize: 11, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
