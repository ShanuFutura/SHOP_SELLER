import 'package:flutter/material.dart';
import 'package:shop_seller/pages/shopkeeper/shop_dashboard.dart';
import 'package:shop_seller/testing.dart';
import '/pages/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      scrollBehavior: ScrollBehavior(
          androidOverscrollIndicator: AndroidOverscrollIndicator.stretch,),
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        canvasColor: Colors.white,
      ),
      home: const SimpleLoginScreen(),
      // home: const ShopDashboard(),
    );
  }
}
