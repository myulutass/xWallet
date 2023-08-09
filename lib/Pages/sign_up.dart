import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:xwallet/route/routes.dart' as route;
import 'package:xwallet/theme/glass.dart';
import 'package:xwallet/theme/main_theme.dart';
import 'package:xwallet/theme/theme.dart';

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

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  SizedBox emptySpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.width * .05,
    );
  }

  final _formKey = GlobalKey<FormState>();

  String _name = '';

  String _email = '';
  String _password = '';
  String _passwordConfirm = '';
  String _phoneNumber = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Do something with the form data, such as creating a new user
      // ...
      // After successful registration, navigate to the home screen
      Navigator.pushReplacementNamed(context, '/home/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GlassMorphism(
      start: 0.4,
      end: 0.6,
      child: Container(
        height: MediaQuery.of(context).size.height * .92,
        width: MediaQuery.of(context).size.width * .85,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * .05),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              const Text(
                //HEADER TEXT
                'Sign Up',
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    letterSpacing: -1,
                    decoration: TextDecoration.underline,
                    decorationColor: Color.fromARGB(180, 255, 255, 255)),
              ),

              emptySpace(),

              //USERNAME ENTRY
              TextFormField(
                textInputAction: TextInputAction.next,
                decoration: textFieldTheme('Username', const LineIcon.user()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _name = value;
                  });
                },
              ),

              emptySpace(),

              //MAIL ENTRY
              TextFormField(
                textInputAction: TextInputAction.next,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: textFieldTheme('Email', const LineIcon.at()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email address';
                  }
                  // Add more email validation rules if needed
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),

              emptySpace(),

              //PASSWORD ENTRY
              TextFormField(
                textInputAction: TextInputAction.next,
                enableSuggestions: false,
                autocorrect: false,
                decoration: textFieldTheme('Password', const LineIcon.key()),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  // Add more password validation rules if needed
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
              ),

              emptySpace(),

              //PASSWORD VALIDATION
              TextFormField(
                textInputAction: TextInputAction.next,
                enableSuggestions: false,
                autocorrect: false,
                decoration:
                    textFieldTheme('Confirm Password', const LineIcon.key()),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != _password) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _passwordConfirm = value;
                  });
                },
              ),

              emptySpace(),

              //PHONE NUMBER ENTRY
              TextFormField(
                textInputAction: TextInputAction.done,
                decoration:
                    textFieldTheme('Phone Number', const LineIcon.phone()),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  // Add more phone number validation rules if needed
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _phoneNumber = value;
                  });
                },
              ),

              emptySpace(),

              // REGISTER BUTTON
              ElevatedButton(
                onPressed: _phoneNumber == (null) || _phoneNumber.isEmpty
                    ? null
                    : _submitForm,
                child: const Text('Register'),
              ),
              ElevatedButton(
                style: secondaryButtonTheme(context),
                onPressed: () => Navigator.pushNamed(context, route.loginPage),
                child: const Text(
                  'Already have an account? click here to login',
                  style: TextStyle(
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
