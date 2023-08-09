import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:xwallet/components/Drawer/app_lang.dart';
import 'package:xwallet/components/Drawer/lock_method.dart';
import 'package:xwallet/components/new_password.dart';
import 'package:xwallet/route/routes.dart' as route;
import 'package:xwallet/theme/lightdark.dart';
import 'package:xwallet/theme/theme.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({Key? key}) : super(key: key);

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  String _selectedCurrency = 'USD';
  bool _appLock = false;
  bool _appLockActivated = false;

  Widget _lightDarkSwitch(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) => Switch(
        value: themeProvider.isLightDark, // Check the current theme status
        onChanged: (value) {
          themeProvider.toggleTheme(); // Toggle when switch state changes
        },
      ),
    );
  }

// Currency Selection Build

  Widget _buildCurrencyDropdown() {
    return DropdownButton<String>(
      underline: const SizedBox(),
      dropdownColor: const Color.fromARGB(136, 0, 0, 0),
      borderRadius: BorderRadius.circular(5),
      value: _selectedCurrency,
      onChanged: (String? newValue) {
        setState(() {
          _selectedCurrency = newValue!;
        });
      },
      items: <String>['USD', 'EUR', 'TRY']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

// Help Center Build

  Widget _buildHelpCenterListTile() {
    return ListTile(
      leading: const GradientIcon(
        icon: Icon(LineIcons.questionCircle),
      ),
      title: const Text('Help Center'),
      onTap: () => Navigator.pushNamed(context, route.helpPage),
    );
  }

// Feedback Build

  Widget _buildFeedbackListTile() {
    return ListTile(
      leading: const GradientIcon(
        icon: Icon(LineIcons.helpingHands),
      ),
      title: const Text('Give Feedback'),
      onTap: () => Navigator.pushNamed(context, route.feedbackPage),
    );
  }

// Log Out Build

  Widget _buildLogOutListTile() {
    return ListTile(
      leading: const GradientIcon(
        icon: Icon(LineIcons.doorOpen),
      ),
      title: const Text(
        'Log Out',
        style: TextStyle(
          color: Color.fromARGB(255, 201, 45, 45),
        ),
      ),
      onTap: () => Navigator.pushNamed(context, route.loginPage),
    );
  }

// Security Build

  Widget _buildSecurityExpansionTile() {
    return ExpansionTile(
      leading: const GradientIcon(
        icon: Icon(LineIcons.alternateShield),
      ),
      title: const Text('Security'),
      children: [
        ListTile(
          title: Text(
            'Change Password',
            style: subText(),
          ),
          onTap: () => newPassword(context),
        ),
        ListTile(
          title: Text(
            'AppLock',
            style: subText(),
          ),
          trailing: Switch(
            value: _appLock,
            onChanged: (bool value) {
              setState(
                () {
                  _appLock = value;
                  _appLockActivated = value;
                },
              );
            },
          ),
        ),
        Visibility(
          visible: _appLockActivated,
          maintainState: true,
          maintainAnimation: true,
          child: ListTile(
            title: Text(
              'Lock Method',
              style: subText(),
            ),
            trailing: const LockMethod(),
          ),
        )
      ],
    );
  }

  // Preferences Build

  Widget _buildPreferencesExpansionTile() {
    return ExpansionTile(
      leading: const GradientIcon(
        icon: Icon(LineIcons.edit),
      ),
      title: const Text('Preferences'),
      children: [
        ListTile(
          title: Text(
            'Currency',
            style: subText(),
          ),
          trailing: _buildCurrencyDropdown(),
        ),
        ListTile(
          title: Text(
            'App Languge',
            style: subText(),
          ),
          trailing: const AppLanguage(),
        ),
        ListTile(
          title: Text(
            'Dark Theme',
            style: subText(),
          ),
          trailing: _lightDarkSwitch(context),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(189, 0, 0, 0),
      child: ListView(
        padding: const EdgeInsets.only(top: 100),
        children: [
          // HelpCenter Section
          _buildHelpCenterListTile(),
          customDivider(),

          // Feedback Section
          _buildFeedbackListTile(),
          customDivider(),

          // Security Section
          _buildSecurityExpansionTile(),
          customDivider(),
          // Prefrences Section
          _buildPreferencesExpansionTile(),
          customDivider(),

          // Log Out Section
          _buildLogOutListTile(),
        ],
      ),
    );
  }
}
