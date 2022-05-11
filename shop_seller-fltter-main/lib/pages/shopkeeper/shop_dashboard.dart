import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:shop_seller/pages/shopkeeper/view_feedback.dart';
import 'package:shop_seller/pages/shopkeeper/add_product.dart';
import 'package:shop_seller/pages/shopkeeper/view_orders.dart';

class ShopDashboard extends StatefulWidget {
  const ShopDashboard({Key? key}) : super(key: key);

  @override
  _ShopDashboardState createState() => _ShopDashboardState();
}

class _ShopDashboardState extends State<ShopDashboard> {
  final _tabs = [
    AddProduct(),
    const ViewFeedback(),
    ViewOrders(),
    // const Text("profile"),
  ];
  var _selectedIndex = 0;

  final _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _selectedIndex = index);
        },
        children: _tabs,
      ),
      bottomNavigationBar: DotNavigationBar(
        backgroundColor: Theme.of(context).primaryColorLight,
        currentIndex: _selectedIndex,
        onTap: _handleIndexChanged,
        // dotIndicatorColor: Colors.black,
        items: [
          /// add product
          DotNavigationBarItem(
            icon: const Icon(Icons.food_bank),
            selectedColor: Theme.of(context).drawerTheme.backgroundColor,
          ),

          /// view orders
          DotNavigationBarItem(
            icon: const Icon(Icons.feedback),
            selectedColor: Theme.of(context).drawerTheme.backgroundColor,
          ),

          /// feedback
          DotNavigationBarItem(
            icon: const Icon(Icons.inventory),
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
