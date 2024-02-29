class ChartSampleData {
  ChartSampleData({
    this.x,
    this.open,
    this.close,
    this.low,
    this.high,
    this.volume,
  });


  final DateTime? x;
   double? open;
   double? close;
   double? low;
   double? high;
   double? volume;

  ChartSampleData.fromJson(List<dynamic> json)
      : x = DateTime.fromMillisecondsSinceEpoch(json[0]).toLocal(),

        high = double.parse(json[2]),
        low = double.parse(json[3]),
        open = double.parse(json[1]),
        close = double.parse(json[4]),
        volume = double.parse(json[5]);

  ChartSampleData.realTimeFromJson(Map<dynamic,dynamic> json)
      : x = DateTime.fromMillisecondsSinceEpoch(json['E']).toLocal(),

        high = double.parse(json['k']['h']),
        low = double.parse(json['k']['l']),
        open = double.parse(json['k']['o']),
        close = double.parse(json['k']['c']),
        volume = double.parse(json['k']['o']);
}
