import 'package:flutter_svg/svg.dart';

SvgPicture getIcon(String symbol) {
  String assetName;
  switch (symbol.toLowerCase()) {
    case 'btc':
      assetName = "lib/assets/bitcoin-btc-logo.svg";
      break;
    case 'eth':
      assetName = "lib/assets/ethereum-eth-logo.svg";
      break;
    case 'usdt':
      assetName = "lib/assets/tether-usdt-logo.svg";
      break;
    case 'xrp':
      assetName = "lib/assets/xrp-xrp-logo.svg";
      break;
    case 'bnb':
      assetName = "lib/assets/bnb-bnb-logo.svg";
      break;
    case 'usdc':
      assetName = "lib/assets/usd-coin-usdc-logo.svg";
      break;
    case 'ada':
      assetName = "lib/assets/cardano-ada-logo.svg";
      break;
    case 'doge':
      assetName = "lib/assets/dogecoin-doge-logo.svg";
      break;
    case 'sol':
      assetName = "lib/assets/solana-sol-logo.svg";
      break;
    case 'trx':
      assetName = "lib/assets/tron-trx-logo.svg";
      break;
    case 'matic':
      assetName = "lib/assets/polygon-matic-logo.svg";
      break;
    case 'dot':
      assetName = "lib/assets/polkadot-new-dot-logo.svg";
      break;
    case 'avax':
      assetName = "lib/assets/avalanche-avax-logo.svg";
      break;
    case 'bch':
      assetName = "lib/assets/bitcoin-cash-bch-logo.svg";
      break;
    case 'wbtc':
      assetName = "lib/assets/wrapped-bitcoin-wbtc-logo.svg";
      break;
    case 'ton':
      assetName = "lib/assets/toncoin-ton-logo.svg";
      break;
    case 'dai':
      assetName = "lib/assets/multi-collateral-dai-dai-logo.svg";
      break;
    case 'shib':
      assetName = "lib/assets/shiba-inu-shib-logo.svg";
      break;
    case 'xlm':
      assetName = "lib/assets/stellar-xlm-logo.svg";
      break;
    case 'ltc':
      assetName = "lib/assets/litecoin-ltc-logo.svg";
      break;
    default:
      assetName = "lib/assets/bitcoin-btc-logo.svg";
      // Set a default icon for unsupported symbols.
      break;
  }

  return SvgPicture.asset(
    assetName,
    width: 30,
  );
}
