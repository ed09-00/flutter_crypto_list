import 'package:flutter/material.dart';
import 'package:flutter_coinmarketcapapi_demo/Widget/navigation_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        //useMaterial3: true,
      ),
      home: const NavigationBarPage(),
      //home: CryptolistPage(),
    );
  }
  
}