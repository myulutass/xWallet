import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LightDark extends StatelessWidget {
  final Widget child;

  const LightDark({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: const [0.33, 0.66, 0.99],
          colors: themeProvider.isLightDark
              ? themeProvider.darkColors
              : themeProvider.lightColors,
        ),
      ),
      child: child,
    );
  }
}

class ThemeProvider with ChangeNotifier {
  bool _isLightDark = true;
  bool get isLightDark => _isLightDark;

  List<Color> get lightColors => const [
        Color(0xFFF848B4),
        Color(0xFFCF3FD9),
        Color(0xFFBA51F0),
      ];

  List<Color> get darkColors => const [
        Color.fromARGB(97, 93, 72, 248),
        Color.fromARGB(85, 123, 63, 217),
        Color.fromARGB(94, 186, 81, 240),
      ];

  void toggleTheme() {
    _isLightDark = !_isLightDark;
    notifyListeners();
  }
}
