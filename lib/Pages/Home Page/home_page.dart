import 'package:flutter/material.dart';
import 'package:xwallet/Pages/Home%20Page/balance_view.dart';
import 'package:xwallet/components/Drawer/drawer.dart';
import '../../api/api.dart';
import '../market_page.dart';
import 'Action Buttons/action_buttons.dart';
import 'bottom_nav_bar.dart';
import 'user_assets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

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

  PreferredSizeWidget _buildHomePageAppBar() {
    return AppBar(
      // Consider defining the AppBar's style in your app theme instead.
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }

  Widget _buildHomePageBody() {
    return PageView(
      onPageChanged: (page) {
        setState(() {
          selectedIndex = page;
        });
        controller.animateToPage(
          page,
          duration: const Duration(milliseconds: 175),
          curve: Curves.linear,
        );
      },
      physics: const ScrollPhysics(),
      controller: controller,
      children: [
        Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.width * .05,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const BalanceView(
                value: 1654,
              ),
              const ActionButtons(),
              CryptoList(topCurrenciesFuture: topCurrenciesFuture),
            ],
          ),
        ),
        MarketPage(
          topCurrenciesFuture: topCurrenciesFuture,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEdgeDragWidth: MediaQuery.of(context).size.width * .1,
      resizeToAvoidBottomInset: false,
      appBar: _buildHomePageAppBar(),
      drawer: const SideDrawer(),
      body: _buildHomePageBody(),
      bottomNavigationBar: BottomNavBar(
          selectedIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
            controller.animateToPage(
              selectedIndex,
              duration: const Duration(milliseconds: 175),
              curve: Curves.linear,
            );
          }),
    );
  }
}
