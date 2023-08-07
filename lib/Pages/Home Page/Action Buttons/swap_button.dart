import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_svg/svg.dart';

import '../../../api/api.dart';
import '../../../pop_ups/swap.dart';

class SwapButton extends StatefulWidget {
  const SwapButton({Key? key}) : super(key: key);

  @override
  State<SwapButton> createState() => _SwapButtonState();
}

class _SwapButtonState extends State<SwapButton> {
  late Future<List<MarketAsset>>? topCurrenciesFuture;

  @override
  void initState() {
    super.initState();
    topCurrenciesFuture = fetchTopCurrencies();
  }

  double _turn = 0.0;

  Future<void> _showSwapDialog() async {
    await showAnimatedDialog(
      barrierColor: const Color.fromARGB(183, 0, 0, 0),
      context: context,
      builder: (BuildContext context) => Swap(
        topCurrenciesFuture: topCurrenciesFuture,
      ),
      animationType: DialogTransitionType.slideFromBottomFade,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOutSine,
    );

    setState(() {
      // Rotate the icon back when popup is closed
      _turn = 0.0;
    });
  }

  Widget _iconButton() {
    return IconButton(
      onPressed: () {
        setState(() {
          _turn -= -0.25;
        });
        _showSwapDialog();
      },
      icon: SvgPicture.asset('lib/assets/SwapButton.svg'),
      iconSize: MediaQuery.of(context).size.width * .14,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedRotation(
      turns: _turn,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
      child: _iconButton(),
    );
  }
}
