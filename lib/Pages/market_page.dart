import 'package:flutter/material.dart';
import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'dart:async';

import '../api/api.dart';
import '../theme/svg_icons.dart';

Widget _buildMarketAssetTile(MarketAsset asset, int index) {
  return Container(
    color: index % 2 == 0 ? null : const Color.fromARGB(61, 32, 31, 31),
    child: ListTile(
      leading: getIcon(asset.symbol),
      title: Text(
        asset.name,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        asset.symbol.toUpperCase(),
        style: const TextStyle(
            fontSize: 11, fontWeight: FontWeight.w400, letterSpacing: 1),
      ),
      trailing: IntrinsicWidth(
        child: Row(
          children: [
            AnimatedFlipCounter(
              value: asset.priceUsd,
              fractionDigits: 2,
              thousandSeparator: '.',
              prefix: '\$',
              curve: Curves.easeInOut,
            ),
            const SizedBox(width: 8),
            Text(
              '${asset.priceChangePercentage24h.toStringAsFixed(2)}%',
              style: TextStyle(
                color: asset.priceChangePercentage24h > 0
                    ? Colors.green
                    : Colors.red,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class MarketPage extends StatefulWidget {
  final Future<List<MarketAsset>>? topCurrenciesFuture;

  const MarketPage({Key? key, required this.topCurrenciesFuture})
      : super(key: key);

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<MarketAsset>>(
        future: widget.topCurrenciesFuture,
        key: UniqueKey(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                final asset = snapshot.data![index];
                return _buildMarketAssetTile(
                  asset,
                  index,
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                '${snapshot.error}',
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
