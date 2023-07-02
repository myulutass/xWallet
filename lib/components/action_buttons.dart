import 'package:flutter/material.dart';
import 'package:xwallet/Pages/home_page.dart';
import 'package:xwallet/pop_ups/recieve.dart';
import 'package:xwallet/pop_ups/send.dart';
import 'package:xwallet/pop_ups/swap.dart';

import '../Pages/market_page.dart';

class ActionButtons extends StatefulWidget {
  final Future<List<MarketAsset>>? topCurrenciesFuture;

  const ActionButtons({Key? key, required this.topCurrenciesFuture})
      : super(key: key);

  @override
  State<ActionButtons> createState() => _ActionButtonsState();
}

class _ActionButtonsState extends State<ActionButtons> {
  late Future<List<MarketAsset>>? topCurrenciesFuture;

  @override
  void initState() {
    super.initState();
    topCurrenciesFuture = fetchTopCurrencies();
  }

  void _showSwapDialog() {
    showDialog(
      barrierColor: const Color.fromARGB(183, 0, 0, 0),
      context: context,
      builder: (BuildContext context) => Swap(
        topCurrenciesFuture: topCurrenciesFuture,
      ),
    );
  }

  void _showSendDialog() {
    showDialog(
      barrierColor: const Color.fromARGB(183, 0, 0, 0),
      context: context,
      builder: (BuildContext context) => Send(
        topCurrenciesFuture: topCurrenciesFuture,
      ),
    );
  }

  void _showRecieveDialog() {
    showDialog(
        barrierColor: const Color.fromARGB(183, 0, 0, 0),
        context: context,
        builder: (BuildContext context) => Recieve(
              topCurrenciesFuture: topCurrenciesFuture,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30, top: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              FloatingActionButton(
                heroTag: 'send',
                onPressed: () {
                  _showSendDialog();
                },
                backgroundColor: const Color.fromARGB(27, 255, 255, 255),
                child: const Icon(Icons.send),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 15),
                child: Text('Send'),
              ),
            ],
          ),
          Column(
            children: [
              FloatingActionButton(
                heroTag: 'swap',
                onPressed: () {
                  _showSwapDialog();
                },
                backgroundColor: const Color.fromARGB(27, 255, 255, 255),
                child: const Icon(Icons.swap_calls),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 15),
                child: Text('Swap'),
              ),
            ],
          ),
          Column(
            children: [
              FloatingActionButton(
                heroTag: 'receive',
                onPressed: () {
                  _showRecieveDialog();
                },
                backgroundColor: const Color.fromARGB(27, 255, 255, 255),
                child: const Icon(Icons.call_received_outlined),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 15),
                child: Text('Receive'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
