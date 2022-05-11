import 'package:flutter/material.dart';
import 'package:shop_seller/models/shop.dart';
import 'package:shop_seller/utils/network_service.dart';
import 'package:shop_seller/widget/my_gridview.dart';

class ViewShops extends StatefulWidget {
  const ViewShops({Key? key}) : super(key: key);

  @override
  _ViewShopsState createState() => _ViewShopsState();
}

class _ViewShopsState extends State<ViewShops> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: FutureBuilder(
            future: getShops(),
            builder: (context, AsyncSnapshot<List<Shop>> snapshot) {
              if (snapshot.hasData) {
                return ShopGrid(items: snapshot.data!);
              } else {
                return const Center(
                  child: Text("loading..."),
                );
              }
            }));
  }

  Future<List<Shop>> getShops() async {
    List jsonList = await getData("view_shop.php");
    print("fetchd shops $jsonList");
    return jsonList.map((json) => Shop.fromJson(json)).toList();
  }
}
