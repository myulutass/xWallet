import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Pages/market_page.dart';

import '../cache/base_cache.dart';

var memoryCache = MemoryCache();

Future<List<MarketAsset>> fetchTopCurrencies() async {
  var url =
      'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?start=1&limit=12&convert=USD';

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
        return jsonDecode(response.body)['data'] as List;
      } else {
        throw Exception('Failed to load data');
      }
    });

    List<Future<MarketAsset>> marketAssetsFutures = [];
    for (var marketAsset in data) {
      marketAssetsFutures.add(fetchMarketAsset(marketAsset));
    }

    return await Future.wait(marketAssetsFutures);
  } catch (e) {
    throw Exception('Failed to load top currencies data. Cause: $e');
  }
}

Future<MarketAsset> fetchMarketAsset(marketAsset) async {
  final url =
      'https://pro-api.coinmarketcap.com/v1/cryptocurrency/info?id=${marketAsset['id']}';

  var assetInfo = await memoryCache.get(url, () async {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Accepts': 'application/json',
        'X-CMC_PRO_API_KEY': '3ae194e9-47fd-4519-8d68-191170428708',
      },
    ).timeout(
      const Duration(seconds: 10),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'][marketAsset['id'].toString()];
    } else {
      throw Exception(
          'Failed to load currency info from CoinMarketCap API  ${response.statusCode}');
    }
  });

  String logoUrl =
      assetInfo['logo']?.toString() ?? 'https://via.placeholder.com/64';

  return MarketAsset(
    icon: logoUrl,
    name: marketAsset['name'],
    symbol: marketAsset['symbol'],
    priceUsd: marketAsset['quote']['USD']['price'].toDouble(),
    priceChangePercentage24h:
        marketAsset['quote']['USD']['percent_change_24h'].toDouble(),
  );
}
