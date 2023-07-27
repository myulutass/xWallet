import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_svg/svg.dart';

import '../../../api/api.dart';
import '../../../pop_ups/recieve.dart';

class RecieveButton extends StatefulWidget {
  const RecieveButton({super.key});

  @override
  State<RecieveButton> createState() => _ReceiveButtonState();
}

class _ReceiveButtonState extends State<RecieveButton> {
  double _turnRecieve = 0.0;

  late Future<List<MarketAsset>>? topCurrenciesFuture;

  _showRecieveDialog() {
    //RECIEVE POP UP
    return showAnimatedDialog(
        barrierColor: const Color.fromARGB(183, 0, 0, 0),
        context: context,
        builder: (BuildContext context) => Recieve(
              topCurrenciesFuture: topCurrenciesFuture,
            ),
        animationType: DialogTransitionType.slideFromBottomFade,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutSine);
  }

  Widget _iconButton() {
    //ICON BUILD
    return IconButton(
      onPressed: () {
        setState(() {
          _turnRecieve += -0.1;
        });
        Future.delayed(const Duration(milliseconds: 300), () {
          _showRecieveDialog().then((_) {
            setState(() {
              // Rotate the icon back when popup is closed
              _turnRecieve -= -0.1;
            });
          });
        });
      },
      icon: SvgPicture.asset('lib/assets/RecieveButton.svg'),
      iconSize: MediaQuery.of(context).size.width * .12,
    );
  }

  @override
  void initState() {
    super.initState();
    topCurrenciesFuture = fetchTopCurrencies();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedRotation(
      turns: _turnRecieve,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
      child: _iconButton(),
    );
  }
}
