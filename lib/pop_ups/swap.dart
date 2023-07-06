import 'package:flutter/material.dart';
import 'package:xwallet/Pages/market_page.dart';
import 'package:xwallet/pop_ups/coin_dropdown.dart';

class Swap extends StatefulWidget {
  final Future<List<MarketAsset>>? topCurrenciesFuture;

  const Swap({Key? key, required this.topCurrenciesFuture}) : super(key: key);

  @override
  State<Swap> createState() => _SwapState();
}

class _SwapState extends State<Swap> {
  double _turns = 0.0;

  String? selectedCoin1;
  String? selectedCoin2;
  @override
  void initState() {
    super.initState();

    // Set the default values once the future completes
    widget.topCurrenciesFuture!.then((coins) {
      if (coins.isNotEmpty) {
        setState(() {
          selectedCoin1 = coins[0].name;
          selectedCoin2 = coins[1].name;
        });
      }
    });
  }

  Widget _buildSwapContainer(List<MarketAsset> coins) {
    return Container(
      width: MediaQuery.of(context).size.width * .85,
      height: MediaQuery.of(context).size.height * .4,
      decoration: BoxDecoration(
        color: const Color.fromARGB(80, 47, 4, 90),
        border: Border.all(
          color: const Color.fromARGB(255, 116, 116, 116),
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: _buildSwapColumn(coins),
    );
  }

  Widget _buildSwapColumn(List<MarketAsset> coins) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CoinDropdownMenu(
          coins: coins,
          onChanged: (dynamic newValue) {
            setState(() {
              selectedCoin1 = newValue;
            });
          },
          selectedValue: selectedCoin1,
        ),
        AnimatedRotation(
          turns: _turns,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutCubic,
          child: const Icon(
            Icons.swap_calls,
            color: Colors.white,
          ),
        ),
        CoinDropdownMenu(
          coins: coins,
          onChanged: (dynamic newValue) {
            setState(() {
              selectedCoin2 = newValue;
            });
          },
          selectedValue: selectedCoin2,
        ),
        ElevatedButton(
          onPressed: () {
            if (selectedCoin1 != null && selectedCoin2 != null) {
              // Handle swap logic here
              String temp = selectedCoin1!;
              setState(() {
                selectedCoin1 = selectedCoin2;
                selectedCoin2 = temp;
                _turns += 0.5;
              });
            }
          },
          child: const Text('Swap'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Scaffold(
        body: Center(
          child: FutureBuilder<List<MarketAsset>>(
            future: widget.topCurrenciesFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<MarketAsset> coins = snapshot.data!;

                return _buildSwapContainer(coins);
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
