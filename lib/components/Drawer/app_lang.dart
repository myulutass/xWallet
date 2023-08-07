import 'package:flutter/material.dart';

class AppLanguage extends StatefulWidget {
  const AppLanguage({
    Key? key,
  }) : super(key: key);

  @override
  State<AppLanguage> createState() => _AppLanguageState();
}

class _AppLanguageState extends State<AppLanguage> {
  String _appLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      dropdownColor: const Color.fromARGB(136, 0, 0, 0),
      borderRadius: BorderRadius.circular(5),
      value: _appLanguage,
      onChanged: (String? newValue) {
        setState(() {
          _appLanguage = newValue!;
        });
      },
      items: <String>[
        'English',
        'Turkish',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
