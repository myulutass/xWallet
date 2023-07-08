import 'package:flutter/material.dart';
import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'dart:async';

class MarketAsset {
  final String icon;
  final String name;
  final String symbol;
  final double priceUsd;
  final double priceChangePercentage24h;
  Map<String, dynamic> toMap() {
    return {
      'icon': symbol,
      'name': name,
      'USD': priceUsd,
    };
  }

  MarketAsset({
    required this.icon,
    required this.name,
    required this.symbol,
    required this.priceUsd,
    required this.priceChangePercentage24h,
  });
}

Widget _buildMarketAssetTile(MarketAsset asset, int index) {
  return Container(
    color: index % 2 == 0 ? null : const Color.fromARGB(61, 32, 31, 31),
    child: ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(asset.icon),
      ),
      title: Text(asset.name),
      subtitle: Text(
        asset.symbol.toUpperCase(),
      ),
      trailing: IntrinsicWidth(
        child: Row(
          children: [
            AnimatedFlipCounter(
              value: asset.priceUsd,
              fractionDigits: 2,
              suffix: '\$',
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
