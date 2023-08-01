import 'package:flutter/material.dart';
import 'package:xwallet/Pages/Home%20Page/balance_view.dart';
import 'package:xwallet/components/Drawer/drawer.dart';
import '../../api/api.dart';
import '../../theme/theme.dart';
import '../market_page.dart';
import 'Action Buttons/action_buttons.dart';
import 'user_assets.dart';
import 'package:line_icons/line_icons.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';

// Define HomePage StatefulWidget
class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
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
      backgroundColor: const Color.fromARGB(15, 0, 0, 0),
    );
  }

// Homepage Body Build

  Widget _buildHomePageBody() {
    return PageView(
      onPageChanged: (page) {
        setState(() {
          selectedIndex = page;
        });
        controller.animateToPage(page,
            duration: const Duration(milliseconds: 175), curve: Curves.linear);
      },
      physics: const ScrollPhysics(),
      controller: controller,
      children: [
        Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).size.width * .05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const BalanceView(),
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

// Bottom Navigation Bar Build

  Widget _buildBottomNavigationBar() {
    return DotNavigationBar(
      backgroundColor: const Color.fromARGB(22, 0, 0, 0),
      dotIndicatorColor: Colors.transparent,
      splashColor: const Color.fromARGB(255, 177, 11, 206),
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 0),
      enableFloatingNavBar: false,
      enablePaddingAnimation: false,
      currentIndex: selectedIndex,
      onTap: (index) {
        setState(() {
          selectedIndex = index;
        });
        controller.animateToPage(selectedIndex,
            duration: const Duration(milliseconds: 175), curve: Curves.linear);
      },
      items: [
        /// Home
        DotNavigationBarItem(
          icon: const Row(
            children: [
              GradientIcon(
                  icon: Icon(
                LineIcons.wallet,
              )),
              SizedBox(
                width: 10,
              ),
              Text('Wallet'),
            ],
          ),
          selectedColor: Colors.pink,
        ),

        /// Likes
        DotNavigationBarItem(
          icon: const Row(
            children: [
              GradientIcon(icon: Icon(LineIcons.shoppingBag)),
              SizedBox(
                width: 10,
              ),
              Text('Market'),
            ],
          ),
          selectedColor: Colors.pink,
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
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}
