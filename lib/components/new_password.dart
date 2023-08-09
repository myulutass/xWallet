import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';

import '../theme/theme.dart';

Future<void> newPassword(BuildContext context) async {
  TextEditingController? password;
  final formKey = GlobalKey<FormState>();

  final currentPassword = FocusNode();
  final newPassword = FocusNode();
  final newPasswordVal = FocusNode();

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
          color: Color.fromARGB(67, 131, 87, 233),
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
                    // TITLE
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
                          // CURRENT PASSWORD ENTRY
                          controller: password,
                          focusNode: currentPassword,
                          textInputAction: TextInputAction.next,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your current password';
                            }
                            return null;
                          },
                          decoration: textFieldTheme(
                              'Current Password', const LineIcon.key()),
                        ),
                        emptySpace(),
                        TextFormField(
                          // NEW PASSWORD ENTRY
                          controller: password,
                          focusNode: newPassword,
                          textInputAction: TextInputAction.next,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your new password';
                            }
                            return null;
                          },
                          decoration: textFieldTheme(
                              'New Password', const LineIcon.key()),
                        ),
                        emptySpace(),
                        TextFormField(
                          // NEW PASSWORD VALIDATION
                          controller: password,
                          focusNode: newPasswordVal,
                          textInputAction: TextInputAction.done,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your new password';
                            }
                            return null;
                          },
                          decoration: textFieldTheme(
                              'New Password Validation', const LineIcon.key()),
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
