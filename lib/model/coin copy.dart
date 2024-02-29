// To parse this JSON data, do
//
//     final coin = coinFromJson(jsonString);

import 'dart:convert';

Coins coinFromJson(String str) => Coins.fromJson(json.decode(str));

String coinToJson(Coins data) => json.encode(data.toJson());

class Coins {
    List<Datum> data;

    Coins({
        required this.data,
    });

    Coins copyWith({
        List<Datum>? data,
    }) => 
        Coins(
            data: data ?? this.data,
        );

    factory Coins.fromJson(Map<String, dynamic> json) => Coins(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    int id;
    String name;
    String symbol;
    String slug;
    int numMarketPairs;
    DateTime dateAdded;
    List<String> tags;
    int? maxSupply;
    double circulatingSupply;
    double totalSupply;
    bool infiniteSupply;
    Platform? platform;
    int cmcRank;
    double? selfReportedCirculatingSupply;
    double? selfReportedMarketCap;
    double? tvlRatio;
    DateTime lastUpdated;
    Quote quote;

    Datum({
        required this.id,
        required this.name,
        required this.symbol,
        required this.slug,
        required this.numMarketPairs,
        required this.dateAdded,
        required this.tags,
        required this.maxSupply,
        required this.circulatingSupply,
        required this.totalSupply,
        required this.infiniteSupply,
        required this.platform,
        required this.cmcRank,
        required this.selfReportedCirculatingSupply,
        required this.selfReportedMarketCap,
        required this.tvlRatio,
        required this.lastUpdated,
        required this.quote,
    });

    Datum copyWith({
        int? id,
        String? name,
        String? symbol,
        String? slug,
        int? numMarketPairs,
        DateTime? dateAdded,
        List<String>? tags,
        int? maxSupply,
        double? circulatingSupply,
        double? totalSupply,
        bool? infiniteSupply,
        Platform? platform,
        int? cmcRank,
        double? selfReportedCirculatingSupply,
        double? selfReportedMarketCap,
        double? tvlRatio,
        DateTime? lastUpdated,
        Quote? quote,
    }) => 
        Datum(
            id: id ?? this.id,
            name: name ?? this.name,
            symbol: symbol ?? this.symbol,
            slug: slug ?? this.slug,
            numMarketPairs: numMarketPairs ?? this.numMarketPairs,
            dateAdded: dateAdded ?? this.dateAdded,
            tags: tags ?? this.tags,
            maxSupply: maxSupply ?? this.maxSupply,
            circulatingSupply: circulatingSupply ?? this.circulatingSupply,
            totalSupply: totalSupply ?? this.totalSupply,
            infiniteSupply: infiniteSupply ?? this.infiniteSupply,
            platform: platform ?? this.platform,
            cmcRank: cmcRank ?? this.cmcRank,
            selfReportedCirculatingSupply: selfReportedCirculatingSupply ?? this.selfReportedCirculatingSupply,
            selfReportedMarketCap: selfReportedMarketCap ?? this.selfReportedMarketCap,
            tvlRatio: tvlRatio ?? this.tvlRatio,
            lastUpdated: lastUpdated ?? this.lastUpdated,
            quote: quote ?? this.quote,
        );

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        symbol: json["symbol"],
        slug: json["slug"],
        numMarketPairs: json["num_market_pairs"],
        dateAdded: DateTime.parse(json["date_added"]),
        tags: List<String>.from(json["tags"].map((x) => x)),
        maxSupply: json["max_supply"],
        circulatingSupply: json["circulating_supply"]?.toDouble(),
        totalSupply: json["total_supply"]?.toDouble(),
        infiniteSupply: json["infinite_supply"],
        platform: json["platform"] == null ? null : Platform.fromJson(json["platform"]),
        cmcRank: json["cmc_rank"],
        selfReportedCirculatingSupply: json["self_reported_circulating_supply"]?.toDouble(),
        selfReportedMarketCap: json["self_reported_market_cap"]?.toDouble(),
        tvlRatio: json["tvl_ratio"]?.toDouble(),
        lastUpdated: DateTime.parse(json["last_updated"]),
        quote: Quote.fromJson(json["quote"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "symbol": symbol,
        "slug": slug,
        "num_market_pairs": numMarketPairs,
        "date_added": dateAdded.toIso8601String(),
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "max_supply": maxSupply,
        "circulating_supply": circulatingSupply,
        "total_supply": totalSupply,
        "infinite_supply": infiniteSupply,
        "platform": platform?.toJson(),
        "cmc_rank": cmcRank,
        "self_reported_circulating_supply": selfReportedCirculatingSupply,
        "self_reported_market_cap": selfReportedMarketCap,
        "tvl_ratio": tvlRatio,
        "last_updated": lastUpdated.toIso8601String(),
        "quote": quote.toJson(),
    };
}

class Platform {
    int id;
    Name name;
    Symbol symbol;
    Slug slug;
    String tokenAddress;

    Platform({
        required this.id,
        required this.name,
        required this.symbol,
        required this.slug,
        required this.tokenAddress,
    });

    Platform copyWith({
        int? id,
        Name? name,
        Symbol? symbol,
        Slug? slug,
        String? tokenAddress,
    }) => 
        Platform(
            id: id ?? this.id,
            name: name ?? this.name,
            symbol: symbol ?? this.symbol,
            slug: slug ?? this.slug,
            tokenAddress: tokenAddress ?? this.tokenAddress,
        );

    factory Platform.fromJson(Map<String, dynamic> json) => Platform(
        id: json["id"],
        name: nameValues.map[json["name"]]== null? "":json["name"],
        symbol: symbolValues.map[json["symbol"]]!,
        slug: slugValues.map[json["slug"]]!,
        tokenAddress: json["token_address"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": nameValues.reverse[name],
        "symbol": symbolValues.reverse[symbol],
        "slug": slugValues.reverse[slug],
        "token_address": tokenAddress,
    };
}

enum Name {
    ARBITRUM,
    BNB_BEACON_CHAIN_BEP2,
    BNB_SMART_CHAIN_BEP20,
    ETHEREUM,
    OPTIMISM,
    SUI,
    TRON20
}

final nameValues = EnumValues({
    "Arbitrum": Name.ARBITRUM,
    "BNB Beacon Chain (BEP2)": Name.BNB_BEACON_CHAIN_BEP2,
    "BNB Smart Chain (BEP20)": Name.BNB_SMART_CHAIN_BEP20,
    "Ethereum": Name.ETHEREUM,
    "Optimism": Name.OPTIMISM,
    "SUI": Name.SUI,
    "Tron20": Name.TRON20
});

enum Slug {
    ARBITRUM,
    BNB,
    ETHEREUM,
    OPTIMISM_ETHEREUM,
    SUI,
    TRON
}

final slugValues = EnumValues({
    "arbitrum": Slug.ARBITRUM,
    "bnb": Slug.BNB,
    "ethereum": Slug.ETHEREUM,
    "optimism-ethereum": Slug.OPTIMISM_ETHEREUM,
    "sui": Slug.SUI,
    "tron": Slug.TRON
});

enum Symbol {
    ARB,
    BNB,
    ETH,
    OP,
    SUI,
    TRX
}

final symbolValues = EnumValues({
    "ARB": Symbol.ARB,
    "BNB": Symbol.BNB,
    "ETH": Symbol.ETH,
    "OP": Symbol.OP,
    "SUI": Symbol.SUI,
    "TRX": Symbol.TRX
});

class Quote {
    Usd usd;

    Quote({
        required this.usd,
    });

    Quote copyWith({
        Usd? usd,
    }) => 
        Quote(
            usd: usd ?? this.usd,
        );

    factory Quote.fromJson(Map<String, dynamic> json) => Quote(
        usd: Usd.fromJson(json["USD"]),
    );

    Map<String, dynamic> toJson() => {
        "USD": usd.toJson(),
    };
}

class Usd {
    double price;
    double volume24H;
    double volumeChange24H;
    double percentChange1H;
    double percentChange24H;
    double percentChange7D;
    double percentChange30D;
    double percentChange60D;
    double percentChange90D;
    double marketCap;
    double marketCapDominance;
    double fullyDilutedMarketCap;
    double? tvl;
    DateTime lastUpdated;

    Usd({
        required this.price,
        required this.volume24H,
        required this.volumeChange24H,
        required this.percentChange1H,
        required this.percentChange24H,
        required this.percentChange7D,
        required this.percentChange30D,
        required this.percentChange60D,
        required this.percentChange90D,
        required this.marketCap,
        required this.marketCapDominance,
        required this.fullyDilutedMarketCap,
        required this.tvl,
        required this.lastUpdated,
    });

    Usd copyWith({
        double? price,
        double? volume24H,
        double? volumeChange24H,
        double? percentChange1H,
        double? percentChange24H,
        double? percentChange7D,
        double? percentChange30D,
        double? percentChange60D,
        double? percentChange90D,
        double? marketCap,
        double? marketCapDominance,
        double? fullyDilutedMarketCap,
        double? tvl,
        DateTime? lastUpdated,
    }) => 
        Usd(
            price: price ?? this.price,
            volume24H: volume24H ?? this.volume24H,
            volumeChange24H: volumeChange24H ?? this.volumeChange24H,
            percentChange1H: percentChange1H ?? this.percentChange1H,
            percentChange24H: percentChange24H ?? this.percentChange24H,
            percentChange7D: percentChange7D ?? this.percentChange7D,
            percentChange30D: percentChange30D ?? this.percentChange30D,
            percentChange60D: percentChange60D ?? this.percentChange60D,
            percentChange90D: percentChange90D ?? this.percentChange90D,
            marketCap: marketCap ?? this.marketCap,
            marketCapDominance: marketCapDominance ?? this.marketCapDominance,
            fullyDilutedMarketCap: fullyDilutedMarketCap ?? this.fullyDilutedMarketCap,
            tvl: tvl ?? this.tvl,
            lastUpdated: lastUpdated ?? this.lastUpdated,
        );

    factory Usd.fromJson(Map<String, dynamic> json) => Usd(
        price: json["price"]?.toDouble(),
        volume24H: json["volume_24h"]?.toDouble(),
        volumeChange24H: json["volume_change_24h"]?.toDouble(),
        percentChange1H: json["percent_change_1h"]?.toDouble(),
        percentChange24H: json["percent_change_24h"]?.toDouble(),
        percentChange7D: json["percent_change_7d"]?.toDouble(),
        percentChange30D: json["percent_change_30d"]?.toDouble(),
        percentChange60D: json["percent_change_60d"]?.toDouble(),
        percentChange90D: json["percent_change_90d"]?.toDouble(),
        marketCap: json["market_cap"]?.toDouble(),
        marketCapDominance: json["market_cap_dominance"]?.toDouble(),
        fullyDilutedMarketCap: json["fully_diluted_market_cap"]?.toDouble(),
        tvl: json["tvl"]?.toDouble(),
        lastUpdated: DateTime.parse(json["last_updated"]),
    );

    Map<String, dynamic> toJson() => {
        "price": price,
        "volume_24h": volume24H,
        "volume_change_24h": volumeChange24H,
        "percent_change_1h": percentChange1H,
        "percent_change_24h": percentChange24H,
        "percent_change_7d": percentChange7D,
        "percent_change_30d": percentChange30D,
        "percent_change_60d": percentChange60D,
        "percent_change_90d": percentChange90D,
        "market_cap": marketCap,
        "market_cap_dominance": marketCapDominance,
        "fully_diluted_market_cap": fullyDilutedMarketCap,
        "tvl": tvl,
        "last_updated": lastUpdated.toIso8601String(),
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
