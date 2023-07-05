import 'package:flutter/material.dart';
import 'package:xwallet/Pages/market_page.dart';

import 'coin_dropdown.dart';

class Send extends StatefulWidget {
  final TextEditingController textController = TextEditingController();
  final Future<List<MarketAsset>>? topCurrenciesFuture;

  Send({Key? key, required this.topCurrenciesFuture}) : super(key: key);

  @override
  State<Send> createState() => _SendState();
}

class _SendState extends State<Send> {
  String? selectedCoin1;

  @override
  void initState() {
    super.initState();

    // Set the default values once the future completes
    widget.topCurrenciesFuture!.then((coins) {
      if (coins.isNotEmpty) {
        setState(() {
          selectedCoin1 = coins[0].name;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: FutureBuilder<List<MarketAsset>>(
                  future: widget.topCurrenciesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<MarketAsset> coins = snapshot.data!;

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 150),
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
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
                              CoinDropdownMenu(
                                coins: coins,
                                onChanged: (dynamic newValue) {
                                  setState(() {
                                    selectedCoin1 = newValue;
                                  });
                                },
                                selectedValue: selectedCoin1,
                              ),
                              const SizedBox(height: 15),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: TextField(
                                  autocorrect: false,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    filled: true,
                                    fillColor:
                                        const Color.fromARGB(58, 243, 239, 239),
                                    labelText: 'Choose Amount',
                                    labelStyle: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: TextField(
                                  autocorrect: false,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    filled: true,
                                    fillColor:
                                        const Color.fromARGB(58, 243, 239, 239),
                                    labelText: 'Paste Address',
                                    labelStyle: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {},
                                child: const Text('Send'),
                              ),
                            ],
                          ),
                        ),
                      );
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
            ],
          ),
        ),
      ),
    );
  }
}
