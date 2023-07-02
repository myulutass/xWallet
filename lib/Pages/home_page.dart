import 'package:flutter/material.dart';
import 'package:xwallet/components/balance_view.dart';
import 'package:xwallet/components/Drawer/drawer.dart';
import 'package:xwallet/env/env.dart';
import 'market_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../components/action_buttons.dart';
import '../components/user_assets.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';
import 'package:xwallet/theme/theme.dart';

Future<List<MarketAsset>> fetchTopCurrencies() async {
  try {
    final uri = Uri.parse(
        'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?start=1&limit=6&convert=USD');
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

// Define HomePage StatefulWidget
class HomePage extends StatefulWidget {
  final String? selectedCoin1;
  final String? selectedCoin2;
  final void Function(BuildContext) showSwapDialog;

  // Constructor for HomePage with optional named parameters
  const HomePage({
    Key? key,
    this.selectedCoin1,
    this.selectedCoin2,
    required this.showSwapDialog,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<MarketAsset>>? topCurrenciesFuture;
  @override
  void initState() {
    super.initState();
    topCurrenciesFuture = fetchTopCurrencies();
  }

  int selectedIndex = 0;
  final PageController controller = PageController();

// AppBar Build

  PreferredSizeWidget _buildHomePageAppBar() {
    return AppBar(
      title: Align(
        alignment: const Alignment(-0.17, 0),
        child: Transform.rotate(
          angle: 1.58,
          child: Image.asset(
            'lib/assets/[removal.ai]_520b09c7-11fe-4890-bb26-2ac9c98783b5.png',
            scale: 7,
            height: kToolbarHeight * 2,
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(22, 0, 0, 0),
    );
  }

// Homepage Body Build

  Widget _buildHomePageBody() {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: controller,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const BalanceView(),
                ActionButtons(topCurrenciesFuture: topCurrenciesFuture),
                CryptoList(topCurrenciesFuture: topCurrenciesFuture),
              ],
            ),
          ),
        ),
        MarketPage(
          topCurrenciesFuture: topCurrenciesFuture,
        ),
      ],
    );
  }

// Bottom Navigation Bar Build

  Widget _buildBottomNavigationBar() {
    return SlidingClippedNavBar(
      onButtonPressed: ((index) {
        setState(() {
          selectedIndex = index;
        });
        controller.animateToPage(selectedIndex,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOutQuad);
      }),
      selectedIndex: selectedIndex,
      activeColor: const Color.fromARGB(255, 222, 222, 222),
      iconSize: 30,
      backgroundColor: Color.fromARGB(255, 140, 53, 255),
      barItems: [
        BarItem(title: 'Wallet', icon: Icons.wallet),
        BarItem(title: 'Market', icon: Icons.shopping_cart)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: mainTheme(),
      child: Scaffold(
        appBar: _buildHomePageAppBar(),
        drawer: const SideDrawer(),
        body: _buildHomePageBody(),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }
}
