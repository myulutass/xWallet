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
    return FutureBuilder<List<MarketAsset>>(
      //TAKING THE DATA FOR ASSETS
      future: widget.topCurrenciesFuture,
      builder:
          (BuildContext context, AsyncSnapshot<List<MarketAsset>> snapshot) {
        if (snapshot.hasData) {
          var currencies = snapshot.data!;
          return _CurrencyListView(
              currencies: currencies,
              topCurrenciesFuture: widget.topCurrenciesFuture);
        }
        if (snapshot.hasError) {
          return Center(child: Text('${snapshot.error}'));
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class _CurrencyListView extends StatelessWidget {
  final List<MarketAsset> currencies;
  final Future<List<MarketAsset>>? topCurrenciesFuture;

  const _CurrencyListView(
      {required this.currencies, required this.topCurrenciesFuture});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * .05,
          vertical: MediaQuery.of(context).size.width * .01,
        ),
        child: ListView.builder(
          //LIST BUILD
          itemCount: currencies.length,
          itemBuilder: (context, index) {
            var currency = currencies[index];

            return Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.width * 0.01,
              ),
              child: _CardItem(currency: currency),
            );
          },
        ),
      ),
    );
  }
}

class _CardItem extends StatelessWidget {
  final MarketAsset currency;

  const _CardItem({required this.currency});

  @override
  Widget build(BuildContext context) {
    return Card(
      //CARD BUILD
      color: Colors.transparent,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: GlassMorphism(
            start: 0.4,
            end: 0.5,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * .05,
              child: ListTile(
                leading: getIcon(currency.symbol),
                title: Text(
                  currency.name,
                  style: const TextStyle(fontWeight: FontWeight.normal),
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
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w300),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
