//CoinMatketCap API URL
import 'package:flutter/material.dart';

//
const String coinMarketCapUrl ="https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest";

//APIkey
const String coinMarketCapApiKey = 'X-CMC_PRO_API_KEY';

//APivalue 測試用先放這，正式版會用envied外掛對apikey做加密 https://pub.dev/packages/envied
const String coinMarketCapValue = 'bce125e3-c148-45ef-84cc-5724bb11da39';

//幣安K線
const String binanceKlineApiUri = 'https://api.binance.com/api/v3/klines?';

//網格顏色
Color chartXYColor = Color.fromARGB(255, 189, 18, 18);