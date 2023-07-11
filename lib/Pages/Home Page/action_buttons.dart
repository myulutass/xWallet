import 'package:flutter/material.dart';
import 'package:xwallet/pop_ups/recieve.dart';
import 'package:xwallet/pop_ups/send.dart';
import 'package:xwallet/pop_ups/swap.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../theme/theme.dart';
import '../market_page.dart';
import '../../api/api.dart';

class ActionButtons extends StatefulWidget {
  final Future<List<MarketAsset>>? topCurrenciesFuture;

  const ActionButtons({
    Key? key,
    required this.topCurrenciesFuture,
  }) : super(key: key);

  @override
  State<ActionButtons> createState() => _ActionButtonsState();
}

class _ActionButtonsState extends State<ActionButtons> {
  double _turnSend = 0.0;
  double _turnSwap = 0.0;
  double _turnRecieve = 0.0;

  late Future<List<MarketAsset>>? topCurrenciesFuture;
  @override
  void initState() {
    super.initState();
    topCurrenciesFuture = fetchTopCurrencies();
  }

  void _showSwapDialog() {
    showAnimatedDialog(
        barrierColor: const Color.fromARGB(183, 0, 0, 0),
        context: context,
        builder: (BuildContext context) => Swap(
              topCurrenciesFuture: topCurrenciesFuture,
            ),
        animationType: DialogTransitionType.slideFromBottomFade,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutSine);
  }

  void _showSendDialog() {
    showAnimatedDialog(
        barrierColor: const Color.fromARGB(183, 0, 0, 0),
        context: context,
        builder: (BuildContext context) => Send(
              topCurrenciesFuture: topCurrenciesFuture,
            ),
        animationType: DialogTransitionType.slideFromBottomFade,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutSine);
  }

  _showRecieveDialog() {
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

  Widget _sendButton() {
    return AnimatedRotation(
      turns: _turnSend,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOutCubic,
      child: IconButton(
        onPressed: () {
          _showSendDialog();
          setState(() {
            _turnSend += -1;
          });
        },
        icon: SvgPicture.asset('lib/assets/SendIcon.svg'),
        iconSize: MediaQuery.of(context).size.width * .12,
      ),
    );
  }

  Widget _swapButton() {
    return AnimatedRotation(
      turns: _turnSwap,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOutCubic,
      child: IconButton(
        onPressed: () {
          _showSwapDialog();
          setState(() {
            _turnSwap += 1;
          });
        },
        icon: SvgPicture.asset('lib/assets/SwapIcon.svg'),
        iconSize: MediaQuery.of(context).size.width * .12,
      ),
    );
  }

  Widget _recieveButton() {
    return AnimatedRotation(
      turns: _turnRecieve,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOutCubic,
      child: IconButton(
        onPressed: () {
          setState(() {
            _turnRecieve += -0.1;
          });
          _showRecieveDialog().then((_) {
            setState(() {
              // Rotate the icon back when popup is closed
              _turnRecieve -= -0.1;
            });
          });
        },
        icon: SvgPicture.asset('lib/assets/RecieveIcon.svg'),
        iconSize: MediaQuery.of(context).size.width * .12,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.width * .04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              _sendButton(),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * .02),
                child: const GradientTxt(
                  text: 'Send',
                  fontsize: 17,
                ),
              ),
            ],
          ),
          Column(
            children: [
              _swapButton(),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * .02),
                child: const GradientTxt(
                  text: 'Swap',
                  fontsize: 17,
                ),
              ),
            ],
          ),
          Column(
            children: [
              _recieveButton(),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * .02),
                child: const GradientTxt(
                  text: 'Recieve',
                  fontsize: 17,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
