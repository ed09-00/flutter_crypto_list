import 'package:flutter/material.dart';
import 'package:flutter_coinmarketcapapi_demo/Widget/coin_list_widget.dart';
import 'package:flutter_coinmarketcapapi_demo/pages/search_add_page.dart';
import 'package:flutter_coinmarketcapapi_demo/utils/get_data_util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/coins_model.dart';

class CryptolistPage extends StatefulWidget {
  const CryptolistPage({Key? key}) : super(key: key);

  @override
  _CryptolistPageState createState() => _CryptolistPageState();
}

class _CryptolistPageState extends State<CryptolistPage> {
  Future<Coins> coinList = GetDataFromJson().fetchCryptoListData();
  //從local storage讀取自選紀錄
  late List<String> cryptoList;
  List<String> cryptoSymbols = [];
  List<Data> printList = [];
  List<Data> allCrypto = [];
  @override
  void initState() {
    super.initState();
    printList.clear();
    cryptoSymbols.clear();
    getStorageCryptoList();
  }

  void getStorageCryptoList() async {
    final prefs = SharedPreferences.getInstance();
    cryptoList = await prefs.then((value) {
      return value.getStringList('cryptoList') ?? [];
    });
    if (mounted) {
      setState(() {});
    }
  }

  Widget _buildListView(Coins coins) {
    allCrypto = coins.data!.toList();
    coins.data?.forEach((coin) {
      cryptoSymbols.add(coin.symbol ?? "");
      if (cryptoList.contains(coin.symbol)) {
        printList.add(coin);
      }
    });

    if (printList.isNotEmpty) {
      return ListView.builder(
        itemCount: printList.length,
        itemBuilder: (context, index) {
          final coin = printList[index];
          return CoinListWidget(
            id: coin.id,
            symbol: coin.symbol,
            name: coin.name,
            price: coin.quote?.uSD?.price?.toStringAsFixed(2),
            addOrDelete: 0,
            notifyParent: listRefresh,
          );
        },
      );
    } else {
      return const Center(child: Text("No data"));
    }
  }

  Widget _mainView() {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text('crypto list')),
      body: Stack(
        children: [
          FutureBuilder<Coins>(
            future: GetDataFromJson().fetchCryptoListData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                final coins = snapshot.data!;
                return _buildListView(coins);
              } else {
                return const Text("No data available");
              }
            },
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchAddPage(
                        cryptoListData: allCrypto,
                        cryptoSymbol: cryptoSymbols,
                      ),
                    ),
                  ).then((value) {
                    listRefresh();
                  });
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(20),
                ),
                child: const Text(
                  '+',
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _mainView();
  }

  listRefresh() {
    printList.clear();
    cryptoSymbols.clear();
    getStorageCryptoList();
  }
}
