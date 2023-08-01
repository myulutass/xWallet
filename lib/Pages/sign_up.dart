import 'package:flutter/material.dart';
import 'package:xwallet/route/routes.dart' as route;
import 'package:xwallet/components/country_pick.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
    return Container(
      height: MediaQuery.of(context).size.height * .80,
      width: MediaQuery.of(context).size.width * .85,
      decoration: BoxDecoration(
        color: const Color.fromARGB(88, 224, 214, 214),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * .05),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Sign Up',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
              ),
            ),
            //USERNAME ENTRY
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'User Name',
              ),
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

            //MAIL ENTRY
            TextFormField(
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
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

            //PASSWORD ENTRY
            TextFormField(
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
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

            //PASSWORD VALIDATION
            TextFormField(
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                labelText: 'Confirm Password',
              ),
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

            //PHONE NUMBER ENTRY
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Phone Number',
              ),
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

            // COUNTRY SELECTION
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * .03),
              child: const CountryPickerButton(),
            ),

            // REGISTER BUTTON
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.transparent,
                ),
                overlayColor: MaterialStateProperty.all<Color>(
                  const Color.fromARGB(161, 236, 95, 224),
                ),
              ),
              onPressed: _name == (null) ||
                      _email == (null) ||
                      _password == (null) ||
                      _passwordConfirm == (null) ||
                      _phoneNumber == (null) ||
                      _name.isEmpty ||
                      _email.isEmpty ||
                      _password.isEmpty ||
                      _passwordConfirm.isEmpty ||
                      _phoneNumber.isEmpty
                  ? null
                  : _submitForm,
              child: Opacity(
                opacity: _name == (null) ||
                        _email == (null) ||
                        _password == (null) ||
                        _passwordConfirm == (null) ||
                        _phoneNumber == (null) ||
                        _name.isEmpty ||
                        _email.isEmpty ||
                        _password.isEmpty ||
                        _passwordConfirm.isEmpty ||
                        _phoneNumber.isEmpty
                    ? 0.8
                    : 1.0,
                child: const Text('Register'),
              ),
            ),
            ElevatedButton(
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
    );
  }
}
