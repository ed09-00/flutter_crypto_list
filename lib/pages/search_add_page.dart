import 'package:flutter/material.dart';
import 'package:flutter_coinmarketcapapi_demo/model/coins_model.dart';

import '../Widget/coin_list_widget.dart';

class SearchAddPage extends StatefulWidget {
  const SearchAddPage(
      {Key? key, required this.cryptoListData, required this.cryptoSymbol})
      : super(key: key);

  final List<Data> cryptoListData;
  final List<String> cryptoSymbol;
  @override
  _SearchAddPageState createState() => _SearchAddPageState();
}

class _SearchAddPageState extends State<SearchAddPage> {
  late List<String> cryptoList;
  List<String> visited = [];
  List<Data> suggestionList = [];
  List list = [1, 2, 3];
  bool isDark = false;
  List printDatas = [];
  Widget _buildSearchBar(context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SearchAnchor(
              builder: (BuildContext context, SearchController controller) {
            return Row(
              children: [
                Expanded(
                  child: SearchBar(
                    controller: controller,
                    padding: const MaterialStatePropertyAll<EdgeInsets>(
                        EdgeInsets.symmetric(horizontal: 16.0)),
                    onTap: () {
                      controller.openView();
                    },
                    onChanged: (_) {
                      controller.openView();
                    },
                    leading: const Icon(Icons.search),
                  ),
                ),
              ],
            );
          }, suggestionsBuilder:
                  (BuildContext context, SearchController controller) {
            List<String> visited = [];
            List<Data> suggestionList = [];
            visited.clear();
            suggestionList.clear();

            widget.cryptoListData.forEach((coin) {
              if (controller.text.contains(coin.symbol ?? "") &&
                  !visited.contains(coin.symbol)) {
                visited.add(coin.symbol ?? "");
                suggestionList.add(coin);
              }
            });
            print(suggestionList.length);
            return List<CoinListWidget>.generate(
              suggestionList.length,
              (int index) {
                return CoinListWidget(
                  id: suggestionList[index].id,
                  symbol: suggestionList[index].symbol,
                  name: suggestionList[index].name,
                  price: suggestionList[index]
                      .quote
                      ?.uSD
                      ?.price
                      ?.toStringAsFixed(2),
                      addOrDelete: 1,
                );
              },
            );
          }),
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: printDatas.length,
          //     itemBuilder: (context, index) {
          //       return CoinListWidget(
          //          id: printDatas[index].id,
          //           symbol: printDatas[index].symbol,
          //           name:  printDatas[index].name,
          //           price:  printDatas[index].quote?.uSD?.price?.toStringAsFixed(2),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("加入自選"),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context,);
          },
          icon: Icon(Icons.arrow_back_ios_new_outlined),
        ),
      ),
      body: SafeArea(
        child: _buildSearchBar(context),
      ),
    );
  }
}
