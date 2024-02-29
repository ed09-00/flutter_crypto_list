import 'package:flutter/material.dart';
import 'package:flutter_coinmarketcapapi_demo/pages/crypto_list_page.dart';
import 'package:flutter_coinmarketcapapi_demo/pages/kline_chart_page.dart';

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
            icon: Icon(Icons.currency_bitcoin),
            label: 'list',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_chart ),
            label: 'chart',
          ),
        ],
      ),
      body: <Widget>[
        const CryptolistPage(),
        const KlineChartPage(),
      ][currentPageIndex],
    );
  }
}