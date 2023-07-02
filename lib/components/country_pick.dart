import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';

class CountryPickerButton extends StatefulWidget {
  const CountryPickerButton({super.key});

  @override
  State<CountryPickerButton> createState() => _CountryPickerButtonState();
}

class _CountryPickerButtonState extends State<CountryPickerButton> {
  Country _selectedCountry = Country(
    phoneCode: '1',
    countryCode: 'US',
    e164Sc: 1,
    geographic: true,
    level: 0,
    name: 'United States',
    example: '555-123-4567',
    displayName: 'United States (1)',
    displayNameNoCountryCode: 'United States',
    e164Key: '1',
    fullExampleWithPlusSign: '+1-555-123-4567',
  );

  void _openCountryPicker() {
    showCountryPicker(
      showSearch: false,
      context: context,
      showPhoneCode: true,
      countryListTheme: const CountryListThemeData(
        backgroundColor: Color.fromARGB(134, 0, 0, 0),
      ),
      onSelect: (Country country) {
        setState(() {
          _selectedCountry = country;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          const Color.fromARGB(59, 153, 61, 206),
        ),
      ),
      onPressed: _openCountryPicker,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            _selectedCountry.flagEmoji,
            style: const TextStyle(fontSize: 22),
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            _selectedCountry.name,
          ),
        ],
      ),
    );
  }
}
