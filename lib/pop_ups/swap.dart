import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:xwallet/Pages/market_page.dart';

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

  Widget _buildDropdownMenu(List<MarketAsset> coins,
      Function(dynamic) onChanged, String? selectedValue) {
    final items = coins.map<DropdownMenuItem<String>>((coin) {
      return DropdownMenuItem<String>(
          value: coin.name,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: ListTile(
                dense: true,
                horizontalTitleGap: 30,
                textColor: Colors.white,
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(coin.icon),
                ),
                title: Text(
                  coin.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                  ),
                ),
                subtitle: Align(
                  alignment: Alignment.topLeft,
                  child: AnimatedFlipCounter(
                    fractionDigits: 2,
                    prefix: "\$",
                    value: coin.priceUsd,
                    duration: const Duration(milliseconds: 500),
                    thousandSeparator: '.',
                    textStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                trailing: const SizedBox(
                  width: 50, // Adjust the width according to your needs
                  child: Row(children: [
                    Text(
                      '0',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ));
    }).toList();

    return DropdownButton<dynamic>(
      borderRadius: BorderRadius.circular(20),
      underline: Container(),
      dropdownColor: const Color.fromARGB(202, 42, 2, 46),
      iconSize: 14,
      itemHeight: 60,
      value: selectedValue,
      items: items,
      onChanged: onChanged,
    );
  }

  Widget _buildSwapContainer(List<MarketAsset> coins) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 225),
      child: Container(
        width: MediaQuery.of(context).size.width * .8,
        height: MediaQuery.of(context).size.height * .4,
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
      children: [
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
              color: const Color.fromARGB(58, 243, 239, 239),
              borderRadius: BorderRadius.circular(20)),
          child: _buildDropdownMenu(coins, (dynamic newValue) {
            setState(() {
              selectedCoin1 = newValue;
            });
          }, selectedCoin1),
        ),
        const SizedBox(height: 15),
        AnimatedRotation(
          turns: _turns,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutCubic,
          child: const Icon(
            Icons.swap_calls,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 15),
        Container(
          decoration: BoxDecoration(
              color: const Color.fromARGB(58, 243, 239, 239),
              borderRadius: BorderRadius.circular(20)),
          child: _buildDropdownMenu(coins, (dynamic newValue) {
            setState(() {
              selectedCoin2 = newValue;
            });
          }, selectedCoin2),
        ),
        const SizedBox(height: 20),
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
