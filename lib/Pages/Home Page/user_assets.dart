import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:xwallet/theme/glass.dart';

import '../../api/api.dart';
import '../../theme/svg_icons.dart';

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
      height: MediaQuery.of(context).size.height * .35,
      width: MediaQuery.of(context).size.width * .85,
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
                  surfaceTintColor: Colors.transparent,
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 10,
                        sigmaY: 10,
                      ),
                      child: GlassMorphism(
                        start: 0.4,
                        end: 0.5,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: ListTile(
                            leading: getIcon(currency.symbol),
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
