import 'package:flutter/material.dart';
import 'package:xwallet/pop_ups/coin_dropdown.dart';
import 'package:xwallet/theme/main_theme.dart';
import 'package:xwallet/theme/theme.dart';

import '../api/api.dart';

class Swap extends StatefulWidget {
  final Future<List<MarketAsset>>? topCurrenciesFuture;

  const Swap({Key? key, required this.topCurrenciesFuture}) : super(key: key);

  @override
  State<Swap> createState() => _SwapState();
}

class _SwapState extends State<Swap> {
  double _turns = 0.0;

  // Declare your selectedCoins as Strings initially to avoid checking for null later
  String selectedCoin1 = '';
  String selectedCoin2 = '';
  late Future<List<MarketAsset>> topCurrenciesFuture;

  @override
  void initState() {
    super.initState();
    topCurrenciesFuture = (widget.topCurrenciesFuture ?? Future.value([]));

    // Set the default values once the future completes
    topCurrenciesFuture.then((coins) {
      if (coins.isNotEmpty) {
        setState(() {
          selectedCoin1 = coins[0].name;
          selectedCoin2 = coins[1].name;
        });
      }
    });
  }

  void swapCoins() {
    // Combine all the state updates into one
    setState(() {
      final temp = selectedCoin1;
      selectedCoin1 = selectedCoin2;
      selectedCoin2 = temp;
      _turns += 0.5;
    });
  }

  Widget _buildSwapContainer(
      List<MarketAsset> coins, double width, double height) {
    return Center(
      child: Container(
        width: width * .85,
        height: height * .4,
        decoration: BoxDecoration(
          color: const Color.fromARGB(80, 47, 4, 90),
          border: Border.all(
            color: const Color.fromARGB(255, 116, 116, 116),
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: _buildSwapColumn(coins),
      ),
    );
  }

  Widget _buildSwapColumn(List<MarketAsset> coins) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CoinDropdownMenu(
          //COIN SELECTION 1
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
          curve: Curves.easeInOutBack,
          child: IconButton(
            //SWAP ICON BUTTON
            icon: const GradientIcon(
              icon: Icon(
                Icons.swap_calls,
                color: Colors.white,
                size: 30,
              ),
            ),
            onPressed: swapCoins,
          ),
        ),
        CoinDropdownMenu(
          //COIN SELECTION 2
          coins: coins,
          onChanged: (dynamic newValue) {
            setState(() {
              selectedCoin2 = newValue;
            });
          },
          selectedValue: selectedCoin2,
        ),
        // ...,
        ElevatedButton(
          //SWAP BUTTON
          style: secondaryButtonTheme(context),
          onPressed: swapCoins,
          child: const Text('Swap'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    if (widget.topCurrenciesFuture == null) {
      return const Center(
        child: Text('No data'),
      );
    }

    // Rest of the build method...

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(bottom: width * .3),
          child: FutureBuilder<List<MarketAsset>>(
            future: widget.topCurrenciesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: ElevatedButton(
                    child: const Text('Error occurred. Tap to retry.'),
                    onPressed: () {
                      // Insert retry logic here
                    },
                  ),
                );
              } else if (snapshot.hasData) {
                List<MarketAsset> coins = snapshot.data!;

                return _buildSwapContainer(coins, width, height);
              } else {
                return const Center(
                  child: Text('No data'),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
