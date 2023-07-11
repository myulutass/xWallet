import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Pages/market_page.dart';

import '../env/env.dart';

Future<List<MarketAsset>> fetchTopCurrencies() async {
  try {
    final uri = Uri.parse(
        'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?start=1&limit=5&convert=USD');
    final response = await http.get(
      uri,
      headers: {
        'Accepts': 'application/json',
        'X-CMC_PRO_API_KEY': Env.apiKey,
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final data = jsonResponse['data'] as List<dynamic>;

      List<MarketAsset> marketAssets = [];
      for (var marketAsset in data) {
        final infoUri = Uri.parse(
            'https://pro-api.coinmarketcap.com/v1/cryptocurrency/info?id=${marketAsset['id']}');
        final infoResponse = await http.get(
          infoUri,
          headers: {
            'Accepts': 'application/json',
            'X-CMC_PRO_API_KEY': Env.apiKey,
          },
        );

        if (infoResponse.statusCode == 200) {
          final infoJsonResponse = json.decode(infoResponse.body);
          final assetInfo =
              infoJsonResponse['data'][marketAsset['id'].toString()];
          String logoUrl =
              assetInfo['logo']?.toString() ?? 'https://via.placeholder.com/64';

          marketAssets.add(MarketAsset(
            icon: logoUrl,
            name: marketAsset['name'],
            symbol: marketAsset['symbol'],
            priceUsd: marketAsset['quote']['USD']['price'].toDouble(),
            priceChangePercentage24h:
                marketAsset['quote']['USD']['percent_change_24h'].toDouble(),
          ));
        } else {
          throw Exception(
              'Failed to load currency info from CoinMarketCap API');
        }
      }
      return marketAssets;
    } else {
      throw Exception('Failed to load top currencies from CoinMarketCap API');
    }
  } on Exception {
    throw Exception('Failed to load data from CoinMarketCap API');
  }
}
