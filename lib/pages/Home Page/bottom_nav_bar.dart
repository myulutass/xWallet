import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../theme/theme.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const BottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DotNavigationBar(
      backgroundColor: const Color.fromARGB(22, 0, 0, 0),
      dotIndicatorColor: Colors.transparent,
      splashColor: const Color.fromARGB(255, 177, 11, 206),
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 0),
      enableFloatingNavBar: false,
      enablePaddingAnimation: false,
      currentIndex: selectedIndex,
      onTap: onTap,
      items: [
        // Home
        DotNavigationBarItem(
          icon: const Row(
            children: [
              GradientIcon(
                icon: Icon(LineIcons.wallet),
              ),
              SizedBox(
                width: 10,
              ),
              Text('Wallet'),
            ],
          ),
          selectedColor: Colors.pink,
        ),

        // Likes
        DotNavigationBarItem(
          icon: const Row(
            children: [
              GradientIcon(icon: Icon(LineIcons.shoppingBag)),
              SizedBox(
                width: 10,
              ),
              Text('Market'),
            ],
          ),
          selectedColor: Colors.pink,
        ),
      ],
    );
  }
}
