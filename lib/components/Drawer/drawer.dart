import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xwallet/components/Drawer/app_lang.dart';
import 'package:xwallet/components/Drawer/lock_method.dart';
import 'package:xwallet/route/routes.dart' as route;
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

// Currency Selection Build

  Widget _buildCurrencyDropdown() {
    return DropdownButton<String>(
      underline: const SizedBox(),
      dropdownColor: Colors.transparent,
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
        icon: Icon(Icons.help),
      ),
      title: const Text('Help Center'),
      onTap: () => Navigator.pushNamed(context, route.helpPage),
    );
  }

// Feedback Build

  Widget _buildFeedbackListTile() {
    return ListTile(
      leading: const GradientIcon(
        icon: Icon(Icons.feedback),
      ),
      title: const Text('Give Feedback'),
      onTap: () => Navigator.pushNamed(context, route.feedbackPage),
    );
  }

// Log Out Build

  Widget _buildLogOutListTile() {
    return ListTile(
      leading: const GradientIcon(
        icon: Icon(Icons.logout, opticalSize: 25),
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
        icon: Icon(Icons.security),
      ),
      title: const Text('Security'),
      children: [
        const ListTile(
          title: Text('Change Password'),
        ),
        ListTile(
          title: const Text('AppLock'),
          trailing: CupertinoSwitch(
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
          child: const ListTile(
            title: Text('Lock Method'),
            trailing: LockMethod(),
          ),
        )
      ],
    );
  }

  // Preferences Build

  Widget _buildPreferencesExpansionTile() {
    return ExpansionTile(
      leading: const GradientIcon(
        icon: Icon(Icons.settings),
      ),
      title: const Text('Preferences'),
      children: [
        ListTile(
          title: const Text('Currency'),
          trailing: _buildCurrencyDropdown(),
        ),
        const ListTile(
          title: Text('App Languge'),
          trailing: AppLanguage(),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(83, 0, 0, 0),
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