import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:xwallet/Pages/market_page.dart';

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
                trailing: const Text(
                  '0',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w300,
                  ),
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
                              Container(
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(58, 243, 239, 239),
                                    borderRadius: BorderRadius.circular(20)),
                                child: _buildDropdownMenu(coins,
                                    (dynamic newValue) {
                                  setState(() {
                                    selectedCoin1 = newValue;
                                  });
                                }, selectedCoin1),
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
