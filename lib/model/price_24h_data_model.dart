// To parse this JSON data, do
//
//     final price24H = price24HFromJson(jsonString);

import 'dart:convert';

Price24H price24HFromJson(String str) => Price24H.fromJson(json.decode(str));

String price24HToJson(Price24H data) => json.encode(data.toJson());

class Price24H {
    String symbol;
    String priceChange;
    String priceChangePercent;
    String weightedAvgPrice;
    String prevClosePrice;
    String lastPrice;
    String lastQty;
    String bidPrice;
    String bidQty;
    String askPrice;
    String askQty;
    String openPrice;
    String highPrice;
    String lowPrice;
    String volume;
    String quoteVolume;
    int openTime;
    int closeTime;
    int firstId;
    int lastId;
    int count;

    Price24H({
        required this.symbol,
        required this.priceChange,
        required this.priceChangePercent,
        required this.weightedAvgPrice,
        required this.prevClosePrice,
        required this.lastPrice,
        required this.lastQty,
        required this.bidPrice,
        required this.bidQty,
        required this.askPrice,
        required this.askQty,
        required this.openPrice,
        required this.highPrice,
        required this.lowPrice,
        required this.volume,
        required this.quoteVolume,
        required this.openTime,
        required this.closeTime,
        required this.firstId,
        required this.lastId,
        required this.count,
    });

    Price24H copyWith({
        String? symbol,
        String? priceChange,
        String? priceChangePercent,
        String? weightedAvgPrice,
        String? prevClosePrice,
        String? lastPrice,
        String? lastQty,
        String? bidPrice,
        String? bidQty,
        String? askPrice,
        String? askQty,
        String? openPrice,
        String? highPrice,
        String? lowPrice,
        String? volume,
        String? quoteVolume,
        int? openTime,
        int? closeTime,
        int? firstId,
        int? lastId,
        int? count,
    }) => 
        Price24H(
            symbol: symbol ?? this.symbol,
            priceChange: priceChange ?? this.priceChange,
            priceChangePercent: priceChangePercent ?? this.priceChangePercent,
            weightedAvgPrice: weightedAvgPrice ?? this.weightedAvgPrice,
            prevClosePrice: prevClosePrice ?? this.prevClosePrice,
            lastPrice: lastPrice ?? this.lastPrice,
            lastQty: lastQty ?? this.lastQty,
            bidPrice: bidPrice ?? this.bidPrice,
            bidQty: bidQty ?? this.bidQty,
            askPrice: askPrice ?? this.askPrice,
            askQty: askQty ?? this.askQty,
            openPrice: openPrice ?? this.openPrice,
            highPrice: highPrice ?? this.highPrice,
            lowPrice: lowPrice ?? this.lowPrice,
            volume: volume ?? this.volume,
            quoteVolume: quoteVolume ?? this.quoteVolume,
            openTime: openTime ?? this.openTime,
            closeTime: closeTime ?? this.closeTime,
            firstId: firstId ?? this.firstId,
            lastId: lastId ?? this.lastId,
            count: count ?? this.count,
        );

    factory Price24H.fromJson(Map<String, dynamic> json) => Price24H(
        symbol: json["symbol"],
        priceChange: json["priceChange"],
        priceChangePercent: json["priceChangePercent"],
        weightedAvgPrice: json["weightedAvgPrice"],
        prevClosePrice: json["prevClosePrice"],
        lastPrice: json["lastPrice"],
        lastQty: json["lastQty"],
        bidPrice: json["bidPrice"],
        bidQty: json["bidQty"],
        askPrice: json["askPrice"],
        askQty: json["askQty"],
        openPrice: json["openPrice"],
        highPrice: json["highPrice"],
        lowPrice: json["lowPrice"],
        volume: json["volume"],
        quoteVolume: json["quoteVolume"],
        openTime: json["openTime"],
        closeTime: json["closeTime"],
        firstId: json["firstId"],
        lastId: json["lastId"],
        count: json["count"],
    );

    Map<String, dynamic> toJson() => {
        "symbol": symbol,
        "priceChange": priceChange,
        "priceChangePercent": priceChangePercent,
        "weightedAvgPrice": weightedAvgPrice,
        "prevClosePrice": prevClosePrice,
        "lastPrice": lastPrice,
        "lastQty": lastQty,
        "bidPrice": bidPrice,
        "bidQty": bidQty,
        "askPrice": askPrice,
        "askQty": askQty,
        "openPrice": openPrice,
        "highPrice": highPrice,
        "lowPrice": lowPrice,
        "volume": volume,
        "quoteVolume": quoteVolume,
        "openTime": openTime,
        "closeTime": closeTime,
        "firstId": firstId,
        "lastId": lastId,
        "count": count,
    };
}
