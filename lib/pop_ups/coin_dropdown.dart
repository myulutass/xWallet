import 'package:flutter/material.dart';
import '../Pages/market_page.dart';

class CoinDropdownMenu extends StatelessWidget {
  final List<MarketAsset> coins;
  final Function(dynamic) onChanged;
  final String? selectedValue;

  const CoinDropdownMenu({
    super.key,
    required this.coins,
    required this.onChanged,
    this.selectedValue,
  });

  @override
  Widget build(BuildContext context) {
    final items = coins.map<DropdownMenuItem<String>>((coin) {
      return DropdownMenuItem<String>(
        value: coin.name,
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * .68,
            decoration: BoxDecoration(
              color: const Color.fromARGB(25, 146, 141, 141),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(
              horizontalTitleGap: MediaQuery.of(context).size.width * .05,
              leading: CircleAvatar(
                backgroundImage: NetworkImage(coin.icon),
              ),
              title: Text(
                coin.name,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                ),
              ),
              subtitle: Text(coin.priceUsd.toStringAsFixed(2),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  )),
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
      );
    }).toList();

    return Center(
      child: DropdownButton<dynamic>(
        underline: Container(),
        dropdownColor: const Color.fromARGB(202, 42, 2, 46),
        itemHeight: 80,
        value: selectedValue,
        items: items,
        onChanged: onChanged,
      ),
    );
  }
}
