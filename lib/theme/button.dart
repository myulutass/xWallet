import 'package:flutter/material.dart';

class SkewButton extends StatefulWidget {
  const SkewButton({super.key});

  @override
  _SkewButtonState createState() => _SkewButtonState();
}

class _SkewButtonState extends State<SkewButton> {
  Color _currentColor = Colors.black;
  Color _currentBgColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        setState(() {
          _currentColor = Colors.purple;
          _currentBgColor = Colors.grey[800]!;
        });
      },
      onTapUp: (TapUpDetails details) {
        setState(() {
          _currentColor = Colors.black;
          _currentBgColor = Colors.white;
        });
      },
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.skewX(-0.3), // This is equivalent to 21 degree skew
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: 120,
          decoration: BoxDecoration(
            color: _currentBgColor,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              'Button',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: _currentColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
