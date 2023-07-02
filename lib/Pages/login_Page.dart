import 'package:flutter/material.dart';
import 'package:xwallet/route/routes.dart' as route;
import 'package:xwallet/theme/theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
    return Container(
      decoration: mainTheme(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Text(
                  'Welcome back!',
                  style: TextStyle(
                    fontSize: 60,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * .55,
                width: MediaQuery.of(context).size.width * .85,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(88, 224, 214, 214),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const Text(
                        'Log In',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      // EMAIL ENTRY
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: _email,
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
                      ),

                      // PASSWORD ENTRY
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: _password,
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
                      ),

                      //...

                      TextButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, route.passwordPage),
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),

                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, route.homePage),
                        child: const Text('Login'),
                      ),
                      ElevatedButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, route.registerPage),
                        child: const Text(
                          'Don\'t  have an account? click here to register',
                          style: TextStyle(
                            fontSize: 11,
                          ),
                        ),
                      )
                    ],
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
