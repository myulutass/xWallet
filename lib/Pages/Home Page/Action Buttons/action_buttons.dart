import 'package:flutter/material.dart';
import 'package:xwallet/Pages/Home%20Page/Action%20Buttons/receive_button.dart';
import 'package:xwallet/Pages/Home%20Page/Action%20Buttons/send_button.dart';
import 'package:xwallet/Pages/Home%20Page/Action%20Buttons/swap_button.dart';

import '../../market_page.dart';

class ActionButtons extends StatefulWidget {
  const ActionButtons({
    Key? key,
  }) : super(key: key);

  @override
  State<ActionButtons> createState() => _ActionButtonsState();
}

class _ActionButtonsState extends State<ActionButtons> {
  late Future<List<MarketAsset>>? topCurrenciesFuture;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.width * .04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            // SEND BUTTON
            children: [
              const SendButton(),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * .02),
                child: const Text(
                  'Send',
                ),
              ),
            ],
          ),
          Column(
            //SWAP BUTTON
            children: [
              const SwapButton(),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * .008),
                child: const Text(
                  'Swap',
                ),
              ),
            ],
          ),
          Column(
            // RECIEVE BUTTON
            children: [
              const RecieveButton(),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * .02),
                child: const Text(
                  'Receieve',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
