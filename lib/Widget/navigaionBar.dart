import 'package:flutter/material.dart';
import 'package:flutter_coinmarketcapapi_demo/pages/crypto_list.dart';
import 'package:flutter_coinmarketcapapi_demo/pages/kline_chart.dart';
import 'package:flutter_coinmarketcapapi_demo/pages/ws.dart';

class NavigationBarPage extends StatefulWidget {
  const NavigationBarPage({super.key});

  @override
  State<NavigationBarPage> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationBarPage> {
  int currentPageIndex = 0;
  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        height: 70,
        indicatorShape: const CircleBorder(),
        indicatorColor: Colors.amber[800],
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            //selectedIcon:  Icon(Icons.currency_bitcoin),
            //icon: Icon(Icons.home_outlined)
            icon: Icon(Icons.currency_bitcoin),
            label: 'list',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_chart ),
            label: 'chart',
          ),
          NavigationDestination(
            //selectedIcon: Icon(Icons.school),
            icon: Icon(Icons.currency_exchange),
            label: 'trade',
          ),
          NavigationDestination(
            //selectedIcon: Icon(Icons.school),
            icon: Icon(Icons.settings),
            label: 'setting',
          ),
        ],
      ),
      body: <Widget>[
        CryptolistPage(),
        KlineChartPage(),
        WsPage(),
        Container(
          color: Colors.blue,
          alignment: Alignment.center,
          child: const Text('setting'),
        ),
      ][currentPageIndex],
    );
  }
}