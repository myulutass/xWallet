import 'package:flutter/material.dart';

Future passwordReset(BuildContext context) {
  final TextEditingController email =
      TextEditingController(); // Initialize _email here

  return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        var keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
        return Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(89, 70, 3, 97),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: AnimatedPadding(
            padding: EdgeInsets.only(bottom: keyboardHeight),
            duration: const Duration(milliseconds: 50),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width) *
                    .1,
                child: Column(
                  children: [
                    SizedBox(
                      //LABEL TEXT
                      height: MediaQuery.of(context).size.height * .03,
                    ),
                    const Text(
                      'Please enter your email address to receive a password reset link',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        letterSpacing: 1,
                        wordSpacing: 2,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .03,
                    ),
                    //EMAIL ENTRY
                    TextFormField(
                      controller: email,
                      enableSuggestions: false,
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(92, 247, 239, 239),
                        label: Text(
                          'Email',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Color.fromARGB(181, 242, 233, 233),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .03,
                    ),
                    SizedBox(
                      //SEND BUTTON
                      width: MediaQuery.of(context).size.width * .4,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text(
                          'Send a reset link',
                          style: TextStyle(
                              fontWeight: FontWeight.w400, letterSpacing: 0.6),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .03,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
}
