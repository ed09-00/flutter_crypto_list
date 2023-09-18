import 'package:flutter/material.dart';
import 'package:flutter_coinmarketcapapi_demo/Widget/coinListWidget.dart';
import 'package:flutter_coinmarketcapapi_demo/util/get_data.dart';
import '../model/coin.dart';

class CryptolistPage extends StatefulWidget {
  const CryptolistPage({Key? key}) : super(key: key);

  @override
  _CryptolistPageState createState() => _CryptolistPageState();
}


class _CryptolistPageState extends State<CryptolistPage> {

  // //這段要封裝
  // Future<Coins> fetchData() async {
  //   //取得CoinMarKetCap 的虛擬貨幣清單資料
  //   HttpService httpService = HttpService(
  //   );
  
  //   final response = await httpService.get(coinMarketCapUrl);
  //   final jsonStr = json.encode(response.data);
  //   final result = coinFromJson(jsonStr);
  //   //print(result.data[0].symbol);
  //   return result;
  // }

  @override
  void initState() {
    super.initState();
    GetDataFromJson().fetchCryptoListData();
  }

  Widget _buildListView(Coins coins) {
    return ListView.builder(
      itemCount: coins.data.length,
      itemBuilder: (context, index) {
        final coin = coins.data[index];
        return CoinListWidget(
          id: coin.id,
          symbol: coin.symbol,
          name: coin.name,
          price: coin.quote.usd.price.toStringAsFixed(2),
        );
      },
    );
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
                return const CircularProgressIndicator();
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
                
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(20),
                  
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
}
