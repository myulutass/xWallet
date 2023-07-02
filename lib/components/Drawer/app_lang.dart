import 'package:flutter/material.dart';

class AppLanguage extends StatefulWidget {
  const AppLanguage({
    Key? key,
  }) : super(key: key);

  @override
  State<AppLanguage> createState() => _AppLanguageState();
}

class _AppLanguageState extends State<AppLanguage> {
  late String _appLanguage;

  @override
  void initState() {
    super.initState();
    _appLanguage = 'English';
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      dropdownColor: Colors.transparent,
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