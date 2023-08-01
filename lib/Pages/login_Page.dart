import 'package:flutter/material.dart';
import 'package:xwallet/components/forgot_password.dart';
import 'package:xwallet/route/routes.dart' as route;

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
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(
                MediaQuery.of(context).size.width * .1,
              ),
              child: const Text(
                'Welcome back!',
                style: TextStyle(
                  fontSize: 50,
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
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                    ),
                    // EMAIL ENTRY
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

                    ElevatedButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, route.homePage),
                      child: const Text(
                        'Login',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, route.registerPage),
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
          ],
        ),
      ),
    );
  }
}
