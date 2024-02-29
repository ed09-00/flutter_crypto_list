import 'dart:convert';
  Coins coinFromJson(String str) => Coins.fromJson(json.decode(str));

String coinToJson(Coins data) => json.encode(data.toJson());
class Coins {
  Status? status;
  List<Data>? data;



  Coins({this.status, this.data});

  Coins.fromJson(Map<String, dynamic> json) {
    status =
        json['status'] != null ? Status.fromJson(json['status']) : null;
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (status != null) {
      data['status'] = status!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Status {
  String? timestamp;
  int? errorCode;
  Null errorMessage;
  int? elapsed;
  int? creditCount;
  Null notice;
  int? totalCount;

  Status(
      {this.timestamp,
      this.errorCode,
      this.errorMessage,
      this.elapsed,
      this.creditCount,
      this.notice,
      this.totalCount});

  Status.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    errorCode = json['error_code'];
    errorMessage = json['error_message'];
    elapsed = json['elapsed'];
    creditCount = json['credit_count'];
    notice = json['notice'];
    totalCount = json['total_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['timestamp'] = timestamp;
    data['error_code'] = errorCode;
    data['error_message'] = errorMessage;
    data['elapsed'] = elapsed;
    data['credit_count'] = creditCount;
    data['notice'] = notice;
    data['total_count'] = totalCount;
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? symbol;
  String? dateAdded;
  Platform? platform;
  int? cmcRank;
  String? lastUpdated;
  Quote? quote;

  Data(
      {this.id,
      this.name,
      this.symbol,
      this.dateAdded,
      this.platform,
      this.cmcRank,
      this.lastUpdated,
      this.quote});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    symbol = json['symbol'];
    dateAdded = json['date_added'];
    platform = json['platform'] != null
        ? Platform.fromJson(json['platform'])
        : null;
    cmcRank = json['cmc_rank'];
    lastUpdated = json['last_updated'];
    quote = json['quote'] != null ? Quote.fromJson(json['quote']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['symbol'] = symbol;
    data['date_added'] = dateAdded;
    if (platform != null) {
      data['platform'] = platform!.toJson();
    }
    data['cmc_rank'] = cmcRank;
    data['last_updated'] = lastUpdated;
    if (quote != null) {
      data['quote'] = quote!.toJson();
    }
    return data;
  }
}

class Platform {
  int? id;
  String? name;
  String? symbol;
  String? slug;
  String? tokenAddress;

  Platform({this.id, this.name, this.symbol, this.slug, this.tokenAddress});

  Platform.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    symbol = json['symbol'];
    slug = json['slug'];
    tokenAddress = json['token_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['symbol'] = symbol;
    data['slug'] = slug;
    data['token_address'] = tokenAddress;
    return data;
  }
}

class Quote {
  USD? uSD;

  Quote({this.uSD});

  Quote.fromJson(Map<String, dynamic> json) {
    uSD = json['USD'] != null ? USD.fromJson(json['USD']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (uSD != null) {
      data['USD'] = uSD!.toJson();
    }
    return data;
  }
}

class USD {
  double? price;
  double? volume24h;
  num? volumeChange24h;
  double? percentChange24h;
  String? lastUpdated;

  USD(
      {this.price,
      this.volume24h,
      this.volumeChange24h,
      this.percentChange24h,
      this.lastUpdated});

  USD.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    volume24h = json['volume_24h'];
    volumeChange24h = json['volume_change_24h'];
    percentChange24h = json['percent_change_24h'];
    lastUpdated = json['last_updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['price'] = price;
    data['volume_24h'] = volume24h;
    data['volume_change_24h'] = volumeChange24h;
    data['percent_change_24h'] = percentChange24h;
    data['last_updated'] = lastUpdated;
    return data;
  }
}
