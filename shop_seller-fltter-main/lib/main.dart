import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_seller/pages/customer/customer_dashboard.dart';
import 'package:shop_seller/pages/shopkeeper/shop_dashboard.dart';
import 'package:shop_seller/testing.dart';
import '/pages/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final spref = await SharedPreferences.getInstance();
  final user = spref.getString('user') ?? 'nop';
  runApp(MyApp(user));
}

class MyApp extends StatelessWidget {
  MyApp(String this.user, {Key? key}) : super(key: key);
  final String user;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: ScrollBehavior(
        androidOverscrollIndicator: AndroidOverscrollIndicator.stretch,
      ),
      title: 'Flutter Demo',
      theme: ThemeData(
        cardTheme: CardTheme(elevation: 10),
        // appBarTheme: AppBarTheme(foregroundColor: Colors.purple),
        useMaterial3: true,
        canvasColor: Colors.white,
        primarySwatch: Colors.purple,
        // canvasColor: Colors.white,
      ),
      home: user == 'nop'
          ? SimpleLoginScreen()
          : (user == 'seller' ? ShopDashboard() : CustomerDashboard()),
      // home: const ShopDashboard(),
    );
  }
}
