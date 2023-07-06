import 'package:flutter/material.dart';

class LockMethod extends StatefulWidget {
  const LockMethod({
    Key? key,
  }) : super(key: key);

  @override
  State<LockMethod> createState() => _LockMethodState();
}

class _LockMethodState extends State<LockMethod> {
  late String _lockMethod;

  @override
  void initState() {
    super.initState();
    _lockMethod = 'Passcode&TouchID';
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      dropdownColor: const Color.fromARGB(136, 0, 0, 0),
      borderRadius: BorderRadius.circular(5),
      value: _lockMethod,
      onChanged: (String? newValue) {
        setState(() {
          _lockMethod = newValue!;
        });
      },
      items: <String>[
        'Passcode&TouchID',
        'Passcode',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
