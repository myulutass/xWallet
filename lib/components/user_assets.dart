import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:xwallet/Pages/market_page.dart';
import 'package:animated_flip_counter/animated_flip_counter.dart';

class CryptoList extends StatefulWidget {
  final Future<List<MarketAsset>>? topCurrenciesFuture;

  const CryptoList({Key? key, required this.topCurrenciesFuture})
      : super(key: key);

  @override
  State<CryptoList> createState() => _CryptoListState();
}

class _CryptoListState extends State<CryptoList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .60,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: const Color.fromARGB(0, 32, 33, 33),
        borderRadius: BorderRadius.circular(20),
      ),
      child: FutureBuilder<List<MarketAsset>>(
        future: widget.topCurrenciesFuture,
        builder:
            (BuildContext context, AsyncSnapshot<List<MarketAsset>> snapshot) {
          if (snapshot.hasData) {
            var currencies = snapshot.data!;

            return ListView.builder(
              itemCount: currencies.length,
              itemBuilder: (BuildContext context, int index) {
                var currency = currencies[index];
                return Card(
                  color: Colors.transparent,
                  shadowColor: const Color.fromARGB(15, 214, 214, 214),
                  surfaceTintColor: Colors.transparent,
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 10,
                        sigmaY: 10,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color.fromARGB(255, 189, 184, 184)
                                  .withOpacity(0.5),
                              const Color.fromARGB(255, 247, 237, 237)
                                  .withOpacity(0.2)
                            ],
                            stops: const [0.0, 1.0],
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(currency.icon),
                          ),
                          title: Text(
                            currency.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          subtitle: Align(
                            alignment: Alignment.topLeft,
                            child: AnimatedFlipCounter(
                              fractionDigits: 2,
                              prefix: "\$",
                              value: currency.priceUsd,
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
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
