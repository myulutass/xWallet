import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_svg/svg.dart';

import '../../../api/api.dart';
import '../../../pop_ups/recieve.dart';

class RecieveButton extends StatefulWidget {
  const RecieveButton({Key? key}) : super(key: key);

  @override
  State<RecieveButton> createState() => _ReceiveButtonState();
}

class _ReceiveButtonState extends State<RecieveButton> {
  late Future<List<MarketAsset>>? topCurrenciesFuture;
  double _turnRecieve = 0.0;

  @override
  void initState() {
    super.initState();
    topCurrenciesFuture = fetchTopCurrencies();
  }

  Future<void> _showRecieveDialog() async {
    await showAnimatedDialog(
      barrierColor: const Color.fromARGB(183, 0, 0, 0),
      context: context,
      builder: (BuildContext context) => Recieve(
        topCurrenciesFuture: topCurrenciesFuture,
      ),
      animationType: DialogTransitionType.slideFromBottomFade,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOutSine,
    );

    setState(() {
      // Rotate the icon back when popup is closed
      _turnRecieve = -0.0;
    });
  }

  Widget _iconButton() {
    //ICON BUILD
    return IconButton(
      onPressed: () {
        setState(() {
          _turnRecieve -= 0.1;
        });
        _showRecieveDialog();
      },
      icon: SvgPicture.asset('lib/assets/RecieveButton.svg'),
      iconSize: MediaQuery.of(context).size.width * .12,
    );
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
