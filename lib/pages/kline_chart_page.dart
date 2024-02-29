import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_coinmarketcapapi_demo/Widget/interval_button_widget.dart';
import 'package:flutter_coinmarketcapapi_demo/model/chart_sample_data_model.dart';
import 'package:flutter_coinmarketcapapi_demo/model/price_24h_data_model.dart';
import 'package:flutter_coinmarketcapapi_demo/utils/get_data_util.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:web_socket_channel/io.dart';

class KlineChartPage extends StatefulWidget {
  const KlineChartPage({Key? key}) : super(key: key);

  @override
   _KlineChartPageState createState() => _KlineChartPageState();
}

class _KlineChartPageState extends State<KlineChartPage> {
  //要顯示的K線資料
  List<ChartSampleData>? _chartData;

  //24小時內的high, low, volumn 
  Price24H? _priceEntity;

  //圖表操作手勢
  late TrackballBehavior _trackballBehavior;
  late ZoomPanBehavior _zoomPanBehavior;

  //圖表預設時間週期web socket
  String baseWsUrl = 'wss://stream.binance.com:9443/ws/btcusdt@kline_';
  String wsInterval = '15m';
  final priceUpdateChannel = IOWebSocketChannel.connect(
      'wss://stream.binance.com:9443/ws/btcusdt@kline_1s');
  final kLineUpdateChannel2 = IOWebSocketChannel.connect(
      'wss://stream.binance.com:9443/ws/btcusdt@kline_1m');
  
  //圖表顯示參數
  String _highPrice = '0';
  String _lowPrice = '0';
  String _volumn = '0';
  String _btcPrice = '0';
  double _prePrice = 0;

  //判斷價格是否要變色，變高顯示綠色，變低顯示紅色。(參考美式蠟燭顏色，higher: 綠，lower:紅)
  bool isGreen = true;

  //蠟燭顯示數量
  int candleCount = 299;
  int index = 0;

  //時間週期
  List<String> interval = [
    '1m',
    '15m',
    '1h',
    '4h',
    '1d',
  ];

  @override
  void initState() {
    load24hPrice(symbol: "BTC");
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
    kLineUpdateChannel2.sink.close();
    priceUpdateChannel.sink.close();
  }

  //繪製蠟燭
  streamIntervalListener() {
    kLineUpdateChannel2.stream.listen((message) {
      Map newData = jsonDecode(message);
      //當前價格
      var newPrice =
          ChartSampleData.realTimeFromJson(newData as Map<String, dynamic>);
      bool isClosed = newData['k']['x'];

      //得到繪製K線的資料()
      if (mounted){
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
      }
      
    });
  }

  //每秒更新價格
  streamListener() {
    priceUpdateChannel.stream.listen((message) {
      Map newData = jsonDecode(message);
      //當前價格
      var newPrice =
          ChartSampleData.realTimeFromJson(newData as Map<String, dynamic>);

      var price = newPrice.high;

      //改變價格顏色
      isGreen = price! >= _prePrice ? true : false;
      //得到繪製K線的資料()
      if (mounted){
        setState(() {
        _btcPrice = price.toString();
      });
      }
      
      _prePrice = price.toDouble();
      
    });
  }

  Widget _buildTimePeriod() {
    return Row(
      children: [
        const SizedBox(
          width: 5,
        ),
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

  Widget _build24hPrice() {
    return Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('24h High'),
                  Text('24h Low'),
                  Text('24h Volumn'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
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
          // Row(
          //   children: [
          //     Expanded(
          //       child: Padding(
          //         padding: const EdgeInsetsDirectional.all(3),
          //         child: ElevatedButton(
          //           style:
          //               ElevatedButton.styleFrom(backgroundColor: Colors.green),
          //           onPressed: () {},
          //           child: const Text('buy'),
          //         ),
          //       ),
          //     ),
          //     const SizedBox(
          //       width: 10,
          //     ),
          //     Expanded(
          //       child: Padding(
          //         padding: const EdgeInsetsDirectional.all(3),
          //         child: ElevatedButton(
          //           style:
          //               ElevatedButton.styleFrom(backgroundColor: Colors.red),
          //           onPressed: () {},
          //           child: const Text('sell'),
          //         ),
          //       ),
          //     ),
          //   ],
          // )
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
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> load24hPrice({String? symbol = 'BTC'}) async {
    _priceEntity =
        await GetDataFromJson().fetchKline24hDataFromBianaceApi(symbol: symbol);
    /*
    _highPrice = _priceEntity!.highPrice;
    _lowPrice = _priceEntity!.lowPrice;
    _volumn = _priceEntity!.volume;
    */
    _highPrice =
        double.parse(_priceEntity!.highPrice).toStringAsFixed(2).toString();
    _lowPrice =
        double.parse(_priceEntity!.lowPrice).toStringAsFixed(2).toString();
    _volumn = double.parse(_priceEntity!.volume).toStringAsFixed(2).toString();

    if (mounted){
      
    setState(() {});
    }
  }
}
