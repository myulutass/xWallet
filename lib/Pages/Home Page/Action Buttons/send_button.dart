import 'package:flutter/material.dart';
import 'package:xwallet/pop_ups/send.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../api/api.dart';
import '../../market_page.dart';

class SendButton extends StatefulWidget {
  const SendButton({super.key});

  @override
  State<SendButton> createState() => _SendButtonState();
}

class _SendButtonState extends State<SendButton> {
  late Future<List<MarketAsset>>? topCurrenciesFuture;
  @override
  void initState() {
    super.initState();
    topCurrenciesFuture = fetchTopCurrencies();
  }

  double _turnSend = 0.0;

  _showSendDialog() {
    // SEND POP UP
    return showAnimatedDialog(
        barrierColor: const Color.fromARGB(183, 0, 0, 0),
        context: context,
        builder: (BuildContext context) => Send(
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
        Future.delayed(const Duration(milliseconds: 300), () {
          _showSendDialog().then((_) {
            setState(() {
              // Rotate the icon back when popup is closed
              _turnSend -= 0.5;
            });
          });
        });
        setState(() {
          _turnSend += -0.5;
        });
      },
      icon: SvgPicture.asset('lib/assets/SendButton.svg'),
      iconSize: MediaQuery.of(context).size.width * .12,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedRotation(
      turns: _turnSend,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
      child: _iconButton(),
    );
  }
}
