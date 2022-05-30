import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_seller/pages/customer/add_feedback.dart';
import 'package:shop_seller/pages/customer/cart.dart';
import 'package:shop_seller/pages/customer/fav.dart';
import 'package:shop_seller/pages/customer/nearby_shops.dart';
import 'package:shop_seller/pages/customer/order_history.dart';
import 'package:shop_seller/pages/customer/view_products.dart';
import 'package:shop_seller/pages/customer/view_shops.dart';
import 'package:shop_seller/pages/login.dart';

class CustomerDashboard extends StatefulWidget {
  const CustomerDashboard({Key? key}) : super(key: key);

  @override
  _CustomerDashboardState createState() => _CustomerDashboardState();
}

class _CustomerDashboardState extends State<CustomerDashboard> {
  final _tabs = [
    const ViewShops(),
    const OrderHistory(),
    const Cart(),
    // const Text("profile"),
  ];
  var _selectedIndex = 0;

  final _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("ShopSeller"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => NearbyShops())));
              },
              icon: Icon(Icons.place)),
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Fav()),
                );
              },
              icon: const Icon(Icons.favorite)),
          IconButton(
              onPressed: () async {
                final spref = await SharedPreferences.getInstance();
                spref.clear();
                Route route = MaterialPageRoute(
                    builder: (context) => SimpleLoginScreen());
                Navigator.pushReplacement(context, route);
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _selectedIndex = index);
        },
        children: _tabs,
      ),
      bottomNavigationBar: DotNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _handleIndexChanged,
        // dotIndicatorColor: Colors.black,
        items: [
          /// add product
          DotNavigationBarItem(
            icon: const Icon(Icons.shop),
            selectedColor: Theme.of(context).drawerTheme.backgroundColor,
          ),

          /// view orders
          DotNavigationBarItem(
            icon: const Icon(Icons.view_agenda),
            selectedColor: Theme.of(context).drawerTheme.backgroundColor,
          ),

          /// feedback
          DotNavigationBarItem(
            icon: const Icon(Icons.shopping_cart),
            selectedColor: Theme.of(context).drawerTheme.backgroundColor,
          ),

          /// Profile
          // DotNavigationBarItem(
          //   icon: const Icon(Icons.person),
          //   selectedColor: Colors.teal,
          // ),
        ],
      ),
    );
  }

  _handleIndexChanged(int selected) {
    setState(() {
      _selectedIndex = selected;
      _pageController.jumpToPage(selected);
    });
  }
}
