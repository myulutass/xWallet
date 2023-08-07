import 'package:flutter/material.dart';

Future<void> newPassword(BuildContext context) async {
  TextEditingController? password;
  final formKey = GlobalKey<FormState>(); // Key for the form

  Widget emptySpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .03,
    );
  }

  await showModalBottomSheet<void>(
    barrierColor: const Color.fromARGB(226, 0, 0, 0),
    isScrollControlled: true,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(89, 70, 3, 97),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: AnimatedPadding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          duration: const Duration(milliseconds: 50),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * .1),
              child: Column(
                children: [
                  emptySpace(),
                  const Text(
                    'Configure New Password',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      letterSpacing: 1,
                      wordSpacing: 2,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  emptySpace(),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: password,
                          enableSuggestions: false,
                          autocorrect: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your current password';
                            }
                            // You can also add more email validation logic here
                            return null;
                          },
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(92, 247, 239, 239),
                            label: Text(
                              'Current Password',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Color.fromARGB(181, 242, 233, 233),
                              ),
                            ),
                          ),
                        ),
                        emptySpace(),
                        TextFormField(
                          controller: password,
                          enableSuggestions: false,
                          autocorrect: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your new password';
                            }
                            // You can also add more email validation logic here
                            return null;
                          },
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(92, 247, 239, 239),
                            label: Text(
                              'New Password',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Color.fromARGB(181, 242, 233, 233),
                              ),
                            ),
                          ),
                        ),
                        emptySpace(),
                        TextFormField(
                          controller: password,
                          enableSuggestions: false,
                          autocorrect: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your new password';
                            }
                            // You can also add more email validation logic here
                            return null;
                          },
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(92, 247, 239, 239),
                            label: Text(
                              'New Password Validation',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Color.fromARGB(181, 242, 233, 233),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  emptySpace(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .4,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          // Call your password reset API here with emailController.text
                          // For example: await sendResetLink(emailController.text);
                          Navigator.pop(
                              context); // Close the bottom sheet after sending reset link
                        }
                      },
                      child: const Text(
                        'Change Password',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ),
                  ),
                  emptySpace(),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
