import 'dart:convert';
import 'package:http/http.dart' as http;

import '../cache/base_cache.dart';
import 'package:flutter_svg/svg.dart';

class MarketAsset {
  String name;
  String symbol;
  double priceUsd;
  double priceChangePercentage24h;

  MarketAsset({
    required this.name,
    required this.symbol,
    required this.priceUsd,
    required this.priceChangePercentage24h,
  });

  factory MarketAsset.fromJson(Map<String, dynamic> json) {
    return MarketAsset(
      name: json['name'],
      symbol: json['symbol'],
      priceUsd: json['quote']['USD']['price'] != null
          ? double.parse(json['quote']['USD']['price'].toString())
          : 0.0,
      priceChangePercentage24h: json['quote']['USD']['percent_change_24h'] !=
              null
          ? double.parse(json['quote']['USD']['percent_change_24h'].toString())
          : 0.0,
    );
  }
}

var memoryCache = MemoryCache();

Future<List<MarketAsset>> fetchTopCurrencies() async {
  var url =
      'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?start=1&limit=20&convert=USD';

  try {
    var data = await memoryCache.get(url, () async {
      var response = await http.get(
        Uri.parse(url),
        headers: {
          'Accepts': 'application/json',
          'X-CMC_PRO_API_KEY': '3ae194e9-47fd-4519-8d68-191170428708',
        },
      );

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        var data = json['data'] as List;

        List<MarketAsset> marketAssets =
            data.map((dynamic item) => MarketAsset.fromJson(item)).toList();

        return marketAssets;
      } else {
        throw Exception('Failed to load data');
      }
    });

    return data; // Don't need to map data to MarketAsset again here
  } catch (e) {
    throw Exception('Failed to load top currencies data. Cause: $e');
  }
}
