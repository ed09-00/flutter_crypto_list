import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';


class WsPage extends StatefulWidget {
  const WsPage({Key? key}) : super(key: key);

  @override
  _WsPageState createState() => _WsPageState();
}

class _WsPageState extends State<WsPage> {
  String btcPrice = '0';
  final channel = IOWebSocketChannel.connect(
      'wss://stream.binance.com:9443/ws/btcusdt@kline_1s');

  @override
  void initState() {
    super.initState();
    streamListener();
  }

  @override
  void dispose() {
    super.dispose();
    channel.sink.close();
  }

  streamListener() {
    channel.stream.listen((message) {
      print(message);
      Map newData = jsonDecode(message);
      var price = double.parse(newData['k']['h']).toStringAsFixed(2);

      setState(() {
        btcPrice = price;
      });
    });
  }
//   Future<void> ws() async {
//   final wsUrl = Uri.parse('ws://localhost:1234');
//   var channel = WebSocketChannel.connect(wsUrl);

//   channel.stream.listen((message) {
//     channel.sink.add('received!');
//     channel.sink.close(status.goingAway);
//   });
// }
  Widget _mainView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('price'),
          Text(btcPrice),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _mainView());
  }
}
