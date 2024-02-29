import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_coinmarketcapapi_demo/model/chart_sample_data_model.dart';
import 'package:flutter_coinmarketcapapi_demo/model/price_24h_data_model.dart';
import 'package:web_socket_channel/io.dart';
import '../model/coins_model.dart';
import '../service/wp_http.dart';
import 'index.dart';
//'/api/v3/ticker/24hr'
class GetDataFromJson{
  Future<Coins> fetchCryptoListData() async {

    //APivalue 測試用先放這，正式版會用envied外掛對apikey做加密 https://pub.dev/packages/envied
    const String apiKey =  'bce125e3-c148-45ef-84cc-5724bb11da39';
    const String apiValue = 'X-CMC_PRO_API_KEY';

    //取得CoinMarKetCap 的虛擬貨幣清單資料
    HttpService httpService = HttpService(
      apiKey: apiKey,apiValue: apiValue
    );

    BaseOptions options =BaseOptions();
    options.headers[apiValue] = apiKey;  
    final response = await httpService.get(coinMarketCapUrl);
    final jsonStr = json.encode(response.data);
    final result = coinFromJson(jsonStr);
    return result;
  }

  Future<List<ChartSampleData>> fetchKlineDataFromBinanceApi({String? symbol = "BTC",String? interval = "1m",int? limit = 300}) async {
    final String url = 'https://api.binance.com/api/v3/klines?symbol=${symbol}USDT&interval=$interval&limit=$limit';
    HttpService httpService = HttpService();

    final response = await httpService.get(url);
     var res = (response.data as List<dynamic>)
        .map((e) => ChartSampleData.fromJson(e))
        .toList();

    return res;
  }


  Future<Price24H> fetchKline24hDataFromBianaceApi({String? symbol = "BTC"}) async {
    final String url = 'https://api.binance.com/api/v3/ticker/24hr?symbol=${symbol}USDT';
    HttpService httpService = HttpService();

    final response = await httpService.get(url);
    final jsonStr = json.encode(response.data);
    final result = price24HFromJson(jsonStr);

    return result;
  }


  IOWebSocketChannel getRealTimePriceChannel({String? symbol, String? interval}){
    final channel = IOWebSocketChannel.connect(
      'wss://stream.binance.com:9443/ws/$symbol@kline_$interval');
    return channel;    
  }
}