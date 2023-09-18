import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CoinListWidget extends StatefulWidget {
  const CoinListWidget({
    Key? key,
    this.id,
    this.symbol,
    this.name,
    this.price, this.priceList,
  }) : super(key: key);
  final int? id;
  final String? symbol;
  final String? name;
  final String? price;
  final List? priceList;
  @override
  _CoinListWidgetState createState() => _CoinListWidgetState();
}

class _CoinListWidgetState extends State<CoinListWidget> {
  var coinUrl =
      'https://s2.coinmarketcap.com/static/img/coins/64x64/';
  //id
  int? _id;
  //symbol
  String? _symbol;
  //名字
  String? _name;
  //價格
  String? _price;
  //
  List? _priceList;
  @override
  void initState() {
    super.initState();
    _id = widget.id;
    _symbol = widget.symbol;
    _name = widget.name;
    _price = widget.price;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('$_symbol被點了');
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color:const  Color.fromARGB(255, 39, 39, 39),
        margin: const  EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 5,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
             const  SizedBox(
                height: 100,
              ),
              Column(
                children: [
                  //crypto photo
    
                  SizedBox(
                      width: 100,
                      height: 100,
                      child: CachedNetworkImage(
                        errorWidget: (context, url, error) =>const  Icon(Icons.error),
                        imageUrl: ("$coinUrl$_id.png").toLowerCase(),
                        placeholder: (context, url) =>const CircularProgressIndicator(),
                        
                      )),
                  //CachedNetworkImage(imageUrl: ("$coinUrl$_symbol-$_name.png").toLowerCase()),
                  //price
                  Text(
                    '$_price',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Text('$_symbol/USD',style:const  TextStyle(color: Colors.white),),
              //KChartWidget(_priceList, chartStyle, chartColors, isTrendLine: isTrendLine);
            ],
          ),
        ),
      ),
    );
  }
}
