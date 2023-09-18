import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_coinmarketcapapi_demo/Widget/interval_button.dart';
import 'package:flutter_coinmarketcapapi_demo/model/chart_sample_data.dart';
import 'package:flutter_coinmarketcapapi_demo/model/price_24h_data.dart';
import 'package:flutter_coinmarketcapapi_demo/util/get_data.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:web_socket_channel/io.dart';

class KlineChartPage extends StatefulWidget {
  const KlineChartPage({Key? key}) : super(key: key);

  @override
  _KlineChartPageState createState() => _KlineChartPageState();
}

class _KlineChartPageState extends State<KlineChartPage> {
  List<ChartSampleData>? _chartData;
  Price24H? _priceEntity;
  late TrackballBehavior _trackballBehavior;
  late ZoomPanBehavior _zoomPanBehavior;
  String baseWsUrl = 'wss://stream.binance.com:9443/ws/btcusdt@kline_';
  String wsInterval = '15m';
  final channel = IOWebSocketChannel.connect(
      'wss://stream.binance.com:9443/ws/btcusdt@kline_1s');
  final channel2 = IOWebSocketChannel.connect(
      'wss://stream.binance.com:9443/ws/btcusdt@kline_1m');
  String _highPrice = '0'; 
  String _lowPrice = '0'; 
  String _volumn = '0'; 
  String _btcPrice = '0';
  double _prePrice = 0;
  bool isGreen = true;
  int candleCount = 299;
  int index = 0;
  List<String> interval = [
    '1m',
    '15m',
    '1h',
    '4h',
    '1d',
  ];

  @override
  void initState() {
    load24hPrice();
    loadCandle();
    streamIntervalListener();
    streamListener();
    super.initState();

    _trackballBehavior = TrackballBehavior(
        enable: true, activationMode: ActivationMode.longPress);
    _zoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
      enablePanning: true,
    );
  }

  @override
  void dispose() {
    super.dispose();
    channel2.sink.close();
    channel.sink.close();
  }

  //繪製蠟燭
  streamIntervalListener() {
    channel2.stream.listen((message) {
      Map newData = jsonDecode(message);
      //當前價格
      var newPrice =
          ChartSampleData.realTimeFromJson(newData as Map<String, dynamic>);
      bool isClosed = newData['k']['x'];

      //得到繪製K線的資料()
      setState(() {
        if (isClosed) {
          loadCandle(interval: interval[index]);
          isClosed = !isClosed;
        } else {
          _chartData?[candleCount].high =
              newPrice.high! > _chartData![candleCount].high!
                  ? newPrice.high
                  : _chartData![candleCount].high!;
          _chartData?[candleCount].low =
              newPrice.low! < _chartData![candleCount].low!
                  ? newPrice.low
                  : _chartData?[candleCount].low;
          _chartData?[candleCount].close = newPrice.close;
          _chartData = _chartData;
        }
      });
    });
  }

  //每秒更新價格
  streamListener() {
    channel.stream.listen((message) {
      Map newData = jsonDecode(message);
      //當前價格
      var newPrice =
          ChartSampleData.realTimeFromJson(newData as Map<String, dynamic>);

      var price = newPrice.high;

      //改變價格顏色
      isGreen = price! > _prePrice ? true : false;
      //得到繪製K線的資料()
      setState(() {
        _btcPrice = price.toString();
      });
      _prePrice = price.toDouble();
    });
  }

  Widget _buildTimePeriod() {
    return Row(
      children: [
        const SizedBox(width: 5,),
        IntervalButtonWidget(
          text: '1m',
          onTap: () {
            index = 0;

            loadCandle(interval: interval[index]);
          },
        ),
        IntervalButtonWidget(
          text: '15m',
          onTap: () {
            index = 1;

            loadCandle(interval: interval[index]);
          },
        ),
        IntervalButtonWidget(
          text: '1h',
          onTap: () {
            index = 2;

            loadCandle(interval: interval[index]);
          },
        ),
        IntervalButtonWidget(
          text: '4h',
          onTap: () {
            index = 3;

            loadCandle(interval: interval[index]);
          },
        ),
        IntervalButtonWidget(
          text: '1d',
          onTap: () {
            index = 4;
            loadCandle(interval: interval[index]);
          },
        ),
      ],
    );
  }
  Widget _build24hPrice(){
    return Column(
      
      children: [
        SizedBox(height: 50,),
        Row(
          children: [
            const Padding(
              padding:  EdgeInsets.only(left: 30),
              child:  Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children: [
                  Text('24h High'),
                  Text('24h Low'),
                  Text('24h Volumn'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:20),
              child: Column(                                
                children: [
                  Text(_highPrice),
                  Text(_lowPrice),
                  Text(_volumn),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
  Widget _mainView() {
    return SafeArea(
      child: Column(
        children: [
          Column(
            
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment:CrossAxisAlignment.start,
                      children: [
                        //價格標題
                        const Padding(
                          padding: EdgeInsets.only(left: 8, top: 8),
                          child: Text(
                            'BTCUSDT',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),

                        //及時價格顯示
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            _btcPrice,
                            style: TextStyle(
                              color: isGreen ? Colors.green : Colors.red,
                              fontSize: 30,
                            ),
                          ),
                        ),
                        
                        //時間週期切換
                        _buildTimePeriod(),
                      ],
                    ),
                  ),
                  Expanded(child: _build24hPrice()),
                  
                ],
                
              ),
            ],
          ),
          Expanded(
            child: SfCartesianChart(
              //legend: Legend(isVisible: true),
              indicators: <TechnicalIndicators<ChartSampleData, DateTime>>[
                SmaIndicator<ChartSampleData, DateTime>(
                  period: 14,
                  signalLineColor: Colors.red,
                  valueField: 'close',
                  seriesName: 'BTC',
                ),
                SmaIndicator<ChartSampleData, DateTime>(
                  period: 28,
                  signalLineColor: Colors.amber,
                  valueField: 'close',
                  seriesName: 'BTC',
                )
              ],
              // //title: ChartTitle(text: 'BTCUSDT - 2023'),
              //legend: Legend(isVisible: true,position: LegendPosition.bottom),
              trackballBehavior: _trackballBehavior,
              zoomPanBehavior: _zoomPanBehavior,
              //backgroundColor: Colors.white,

              series: <CandleSeries>[
                CandleSeries<ChartSampleData, DateTime>(
                  dataSource: _chartData ?? [],
                  name: 'BTC',
                  xValueMapper: (ChartSampleData sales, _) => sales.x,
                  lowValueMapper: (ChartSampleData sales, _) => sales.low,
                  highValueMapper: (ChartSampleData sales, _) => sales.high,
                  openValueMapper: (ChartSampleData sales, _) => sales.open,
                  closeValueMapper: (ChartSampleData sales, _) => sales.close,
                )
              ],
              //x軸
              primaryXAxis: DateTimeAxis(
                rangePadding: ChartRangePadding.additional,
                labelAlignment: LabelAlignment.end,
                dateFormat: DateFormat(DateFormat.HOUR24_MINUTE),
                interval: 2,
                maximumLabels: 20,
                majorGridLines: const MajorGridLines(color: Colors.transparent),
              ),
              //y軸
              primaryYAxis: NumericAxis(
                //crossesAt: double.infinity,
                opposedPosition: true,
                anchorRangeToVisiblePoints: false,
                labelAlignment: LabelAlignment.start,
                // minimum: 24800,
                // maximum: 26700,
                //interval: 100,
                numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0),
                majorGridLines: const MajorGridLines(color: Colors.transparent),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.all(3),
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () {},
                    child: const Text('buy'),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.all(3),
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () {},
                    child: const Text('sell'),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _mainView(),
      backgroundColor: Colors.black,
    );
  }

  Future<void> resetChart() async {
    setState(() {});
  }

  Future<void> loadCandle(
      {String? symbol = 'BTC', String? interval = '1m'}) async {
    _chartData = await GetDataFromJson()
        .fetchKlineDataFromBinanceApi(symbol: symbol, interval: interval);
    setState(() {});
  }

  Future<void> load24hPrice({String? symbol = 'BTC'}) async {
    _priceEntity =
        await GetDataFromJson().fetchKline24hDataFromBianaceApi(symbol: symbol);
    /*
    _highPrice = _priceEntity!.highPrice;
    _lowPrice = _priceEntity!.lowPrice;
    _volumn = _priceEntity!.volume;
    */ 
    _highPrice = double.parse(_priceEntity!.highPrice).toStringAsFixed(2).toString();
    _lowPrice =double.parse(_priceEntity!.lowPrice).toStringAsFixed(2).toString();
    _volumn = double.parse(_priceEntity!.volume).toStringAsFixed(2).toString();
   
    
    setState(() {});
  }
}
