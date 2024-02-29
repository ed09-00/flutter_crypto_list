import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoinListWidget extends StatefulWidget {
  const CoinListWidget({
    Key? key,
    this.id,
    this.symbol,
    this.name,
    this.price,
    this.priceList,
    required this.addOrDelete,
    this.notifyParent,
  }) : super(key: key);
  final int? id;
  final String? symbol;
  final String? name;
  final String? price;
  final List? priceList;
  final int addOrDelete;
  final Function? notifyParent;
  @override
  _CoinListWidgetState createState() => _CoinListWidgetState();
}

class _CoinListWidgetState extends State<CoinListWidget> {

  var coinUrl = 'https://s2.coinmarketcap.com/static/img/coins/64x64/';
  //id
  int? _id;
  //symbol
  String? _symbol;
  //價格
  String? _price;
  

  @override
  void initState() {
    super.initState();
    _id = widget.id;
    _symbol = widget.symbol;
    _price = widget.price;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        print('$_symbol被點了');
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: const Color.fromARGB(255, 39, 39, 39),
        margin: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 5,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              const SizedBox(
                height: 100,
              ),
              Column(
                children: [
                  //圖片
                  SizedBox(
                      width: 100,
                      height: 100,
                      child: CachedNetworkImage(
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        imageUrl: ("$coinUrl$_id.png").toLowerCase(),
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                      )),
                  Text(
                    '$_symbol/USDT',
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
              Text(
                '$_price  ',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
              const Text(
                'USDT',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              const Spacer(),
              CircleAvatar(
                child: IconButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    
                    List<String> list = prefs.getStringList("cryptoList")??[];

                    //add
                    if (widget.addOrDelete == 1) {
                      list.add(_symbol ?? "");
                    }

                    //remove
                    if (widget.addOrDelete == 0) {
                      list.remove(_symbol ?? "");
                      widget.notifyParent!();
                      
                    }
                    prefs.setStringList("cryptoList",list);
                    print('$_symbol被點了');

                  },
                  icon: widget.addOrDelete == 0
                      ? const Icon(Icons.delete)
                      : const Icon(Icons.add),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
