import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../Pages/market_page.dart';
import 'coin_dropdown.dart';

class Recieve extends StatefulWidget {
  final Future<List<MarketAsset>>? topCurrenciesFuture;

  const Recieve({Key? key, required this.topCurrenciesFuture})
      : super(key: key);

  @override
  State<Recieve> createState() => _RecieveState();
}

class _RecieveState extends State<Recieve> {
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

                      return Container(
                        width: MediaQuery.of(context).size.width * .8,
                        height: MediaQuery.of(context).size.height * .53,
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
                            QrImageView(
                              data: 'www.example.com',
                              version: QrVersions.auto,
                              size: 175,
                              eyeStyle: const QrEyeStyle(
                                eyeShape: QrEyeShape.square,
                                color: Color.fromARGB(255, 109, 13, 103),
                              ),
                              backgroundColor:
                                  const Color.fromARGB(105, 243, 240, 240),
                            ),
                            const SizedBox(height: 15),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                ' Only $selectedCoin1 can be sent to this address, otherwise all the assets will be permanently lost !',
                                style: const TextStyle(
                                    color: Color.fromARGB(224, 231, 213, 167),
                                    fontSize: 14,
                                    fontStyle: FontStyle.italic),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.copy,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const Text(
                                      'Copy Address',
                                      style: TextStyle(fontSize: 12),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.share,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const Text(
                                      'Share Address',
                                      style: TextStyle(fontSize: 12),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
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
