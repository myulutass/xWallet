import 'package:flutter/material.dart';
import 'package:xwallet/pages/Home%20Page/Action%20Buttons/receive_button.dart';
import 'package:xwallet/pages/Home%20Page/Action%20Buttons/send_button.dart';
import 'package:xwallet/pages/Home%20Page/Action%20Buttons/swap_button.dart';

class ActionButtons extends StatefulWidget {
  const ActionButtons({
    Key? key,
  }) : super(key: key);

  @override
  State<ActionButtons> createState() => _ActionButtonsState();
}

class _ActionButtonsState extends State<ActionButtons> {
  @override
  void initState() {
    super.initState();
  }

  final TextStyle myStyle = const TextStyle(
      fontSize: 13, fontWeight: FontWeight.w400, letterSpacing: 0.7);

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
                child: Text(
                  'Send',
                  style: myStyle,
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
                child: Text(
                  'Swap',
                  style: myStyle,
                ),
              ),
            ],
          ),
          Column(
            // RECEIVE BUTTON
            children: [
              const RecieveButton(),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * .02),
                child: Text(
                  'Receive',
                  style: myStyle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
