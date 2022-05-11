import 'package:flutter/material.dart';
import 'package:shop_seller/models/product.dart';
import 'package:shop_seller/utils/constant.dart';
import 'package:shop_seller/utils/network_service.dart';
import 'package:shop_seller/widget/product_grid.dart';

class Fav extends StatefulWidget {
  Fav({Key? key}) : super(key: key);

  @override
  _FavState createState() => _FavState();
}

class _FavState extends State<Fav> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Products"),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: getProducts(),
          builder: (context, AsyncSnapshot<List<Product>> snapshot) {
            if (snapshot.hasData) {
              return ProductGrid(items: snapshot.data!);
            } else {
              return const Center(
                child: Text("loading..."),
              );
            }
          },
        ),
      ),
    );
  }

  Future<List<Product>> getProducts() async {
    String userId = await Constants.getUserId();
    List json =
        await getData("view_favourites.php", params: {"user_id": userId});
    return json.map((e) => Product.fromJson(e)).toList();
  }
}
